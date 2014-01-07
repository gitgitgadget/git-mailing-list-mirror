From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] sha1_name: don't resolve refs when core.warnambiguousrefs is false
Date: Tue, 07 Jan 2014 12:31:57 -0800
Message-ID: <xmqqd2k3cz42.fsf@gitster.dls.corp.google.com>
References: <1389065521-46331-1-git-send-email-brodie@sf.io>
	<CAEfQM484kqLSVeyjhYtg7GfXOQkQNjaO1FV2_U3uAqO=Nargdg@mail.gmail.com>
	<20140107171307.GA19482@sigill.intra.peff.net>
	<xmqqzjn7el4k.fsf@gitster.dls.corp.google.com>
	<20140107175241.GA20415@sigill.intra.peff.net>
	<xmqqppo3d1lk.fsf@gitster.dls.corp.google.com>
	<20140107195844.GA21812@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brodie Rao <brodie@sf.io>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eQ==?= =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?= Duy 
	<pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 07 21:32:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0dJt-00024B-FT
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 21:32:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753158AbaAGUcJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 15:32:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47495 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750892AbaAGUcH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 15:32:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CE05161418;
	Tue,  7 Jan 2014 15:32:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vd4UiPv4GRI94ZUkarXsHwVc1qc=; b=A6uePh
	XxQtMljsLVyacrO4vLq+l0Dgim4XiaZU3DnvQ/JmEjbmKb/4KD4XdhjLr0igLjLN
	w7x2xZ4LYCLcMnUY8zBLexAq5BJdbUv689t1Pugg85hsoFdpFfTyMkUqcO1zBvTx
	QEBQAKeuvDGFqi8iJ9Hv1Qf+OkjAlZ9lUwGsM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uZxlmlkI5KcZQLnOiX/migktJPgqENQ/
	hdZNU1dLxFpAlaEvd2xj5p/hWKbMuCALPrFFLMb3VZEphWPH9yf1+Suf6Pbbh9WM
	nx7sEJ+mL8atEbe6gSnn/fcqOYOiocY/ChuJC/1VJPJIsmv3sIJoDuOSY0Dm8n6o
	mu7X0V5rFGw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B06FE61417;
	Tue,  7 Jan 2014 15:32:06 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DD0CA61412;
	Tue,  7 Jan 2014 15:31:59 -0500 (EST)
In-Reply-To: <20140107195844.GA21812@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 7 Jan 2014 14:58:44 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C263FE80-77DA-11E3-A9E5-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240146>

Jeff King <peff@peff.net> writes:

> On Tue, Jan 07, 2014 at 11:38:15AM -0800, Junio C Hamano wrote:
>
>> >> > Alternatively, I guess "cat-file
>> >> > --batch" could just turn off warn_ambiguous_refs itself.
>> >> 
>> >> Sounds like a sensible way to go, perhaps on top of this change?
>> >
>> > The downside is that we would not warn about ambiguous refs anymore,
>> > even if the user was expecting it to. I don't know if that matters much.
>> 
>> That is true already with or without Brodie's change, isn't it?
>> With warn_on_object_refname_ambiguity, "cat-file --batch" makes us
>> ignore core.warnambigousrefs setting.  If we redo 25fba78d
>> (cat-file: disable object/refname ambiguity check for batch mode,
>> 2013-07-12) to unconditionally disable warn_ambiguous_refs in
>> "cat-file --batch" and get rid of warn_on_object_refname_ambiguity,
>> the end result would be the same, no?
>
> No, I don't think the end effect is the same (or maybe we are not
> talking about the same thing. :) ).
>
> There are two ambiguity situations:
>
>   1. Ambiguous non-fully-qualified refs (e.g., same tag and head name).
>
>   2. 40-hex sha1 object names which might also be unqualified ref names.
>
> Prior to 25ffba78d, cat-file checked both (like all the rest of git).
> But checking (2) is very expensive,...

Ahh, of course.  Sorry for forgetting about 1.

> The two options I was musing over earlier today were (all on top of
> Brodie's patch):
>
>   a. Revert 25ffba78d. With Brodie's patch, core.warnAmbiguousRefs
>      disables _both_ warnings. So we default to safe-but-slow, but
>      people who care about performance can turn off ambiguity warnings.
>      The downside is that you have to know to turn it off manually (and
>      it's a global config flag, so you end up turning it off
>      _everywhere_, not just in big queries where it matters).

Or "git -c core.warnambiguousrefs=false cat-file --batch", but I
think a more important point is that it is no longer automatic for
known-to-be-heavy operations, and I agree with you that it is a
downside.

>   b. Revert 25ffba78d, but then on top of it just turn off
>      warn_ambiguous_refs unconditionally in "cat-file --batch-check".
>      The downside is that we drop the safety from (1). The upside is
>      that the code is a little simpler, as we drop the extra flag.
>
> And obviously:
>
>   c. Just leave it at Brodie's patch with nothing else on top.
>
> My thinking in favor of (b) was basically "does anybody actually care
> about ambiguous refs in this situation anyway?". If they do, then I
> think (c) is my preferred choice.

OK.  I agree with that line of thinking.  Let's take it one step at
a time, i.e. do c. and also use warn_on_object_refname_ambiguity in
"rev-list --stdin" first and leave the simplification (i.e. b.) for
later.

>> > I kind of feel in the --batch situation that it is somewhat useless (I
>> > wonder if "rev-list --stdin" should turn it off, too).
>> 
>> I think doing the same as "cat-file --batch" in "rev-list --stdin"
>> makes sense.  Both interfaces are designed to grok extended SHA-1s,
>> and full 40-hex object names could be ambiguous and we are missing
>> the warning for them.
>
> I'm not sure I understand what you are saying. We _do_ have the warning
> for "rev-list --stdin" currently. We do _not_ have the warning for
> "cat-file --batch", since my 25ffba78d.

What I wanted to say was that we would be discarding the safety for
"rev-list --stdin" with the same argument as we did for "cat-file
--batch".  If the argument for the earlier "cat-file --batch" were
"this interface only takes raw 40-hex object names", then the
situation would have been different, but that is not the case.

> I was wondering if rev-list should go the same way as 25ffba78d,
> for efficiency reasons (e.g., think piping to "rev-list --no-walk
> --stdin").

Yes, and I was trying to agree with that, but apparently I failed
;-)
