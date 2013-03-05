From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] push: --follow-tag
Date: Tue, 05 Mar 2013 07:58:45 -0800
Message-ID: <7vlia1vnwq.fsf@alter.siamese.dyndns.org>
References: <7vd2vewu24.fsf@alter.siamese.dyndns.org>
 <7v6216wtrk.fsf@alter.siamese.dyndns.org>
 <20130305082204.GB13552@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 05 16:59:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCuGr-00069S-Jn
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 16:59:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755542Ab3CEP6u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Mar 2013 10:58:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37028 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752611Ab3CEP6t (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Mar 2013 10:58:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E3977BF7F;
	Tue,  5 Mar 2013 10:58:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1lM2sbLvw+1/BXaa4WmFmNy7duU=; b=FaiQZ3
	TL0dAgl1AIf8nycY2xxG0RGPw5AVqXleEzxCCpTcL0y56r8nMzG0tz4fxwJrr92p
	nr3/SFmgKkWuNdbeuGMoKZI2feJjjbyEaAKXd8Xx2+/BfMy5MZRPdN14ou+OoLt3
	8mahA08fE0uSMp10gw1FeAMZAcWkwM1ptsex8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yg7Rfp8pc99lNfs/CVE/ELvpXEGerZkY
	v7FhSojKIHBdXJb7OzeUX89lsS/8y9sWXd+ukk7rxVRZUH+puTv9Z0CJOm6wJjj6
	Y6wixpEZIjJtKh5D0b9XeUsTIxOPucgMg2uTU/82MJAxAWc1UDXdy3kwGlJNpMDe
	Vfmr5qspwR8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D8EB8BF7D;
	Tue,  5 Mar 2013 10:58:48 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CE9D4BF76; Tue,  5 Mar 2013
 10:58:47 -0500 (EST)
In-Reply-To: <20130305082204.GB13552@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 5 Mar 2013 03:22:04 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 90BAED82-85AD-11E2-BE10-2F862E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217456>

Jeff King <peff@peff.net> writes:

> Should this be called "--follow-tags"? That makes more sense to me, as
> you are catching all tags.

Perhaps.  We are sending all zero-or-more relevant tags, so I agree
that plural form is more appropriate.  I have a doubt about
"follow", though; inertia made me use "follow", but I am not sure
what we are following.  We certainly are not following tags.  If
anything, we are making tags to piggy back on the history being
pushed.

> For consistency, should this match the naming of git-fetch's
> options (or vice versa)? There we have:
>
>   <default>: auto-follow tags
>
>   --tags: fetch all of refs/heads/tags
>
>   --no-tags: do not auto-follow
>
> I think that naming has caused some confusion in the past.

"--tags" does not belong in the discussion of "auto following".  It
does not have to do with any "auto"-ness.  Renaming "--no-tags" to
"--no-follow-tags" does make sense, though.

> And there is no way to explicitly specify the default behavior. I
> wonder if both should support:
>
>   --follow-tags: auto-follow tags
>
>   --no-follow-tags: do not auto-follow tags

Yup, I like that.  Perhaps make "--no-tags" a deprecated synonym to
the latter.

>   --tags: fetch/push all of refs/heads/tags
>
>   --no-tags: turn off auto-following, and cancel any previous --tags

Sounds sensible.

> The default for push should probably keep auto-follow off, though.
>
>> +--follow-tag::
>> +	Push all the refs that would be pushed without this option,
>> +	and also push the refs under `refs/tags` that are missing
>> +	from the remote but are reachable from the refs that would
>> +	be pushed without this option.
>> +
>
> This reads OK to me, though it is a little confusing in that there are
> two sets of refs being discussed, and "the refs that would be pushed
> without this option" is quite a long noun phrase (that gets used twice).

Yes, exactly why I said I do not like the phrasing of this one.

> This will find anything under refs/tags, including annotated and
> non-annotated tags. I wonder if it is worth making a distinction. In
> many workflows, unannotated tags should not be leaked out to public
> repos. But because this feature finds any reachable tags, it will push a
> tag you made a long time ago as a bookmarker on some part of the history
> unrelated to the release you are making now.

What does the auto-follow feature of "git fetch" do currently?
Whatever we do here on the "git push" side should match it.

If somebody wants to add some form of filtering mechanism based on
the tagname (e.g. '--auto-follow-tags=v[0-9]*'), I would not have a
strong objection to it, but I think that is something we should do
on top and consistently between fetch and push.  I am not thrilled
by the idea of conflating annotated-ness and the public-ness of
tags.

Thanks.
