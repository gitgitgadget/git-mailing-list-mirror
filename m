From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] write_index: optionally allow broken null sha1s
Date: Mon, 26 Aug 2013 09:02:46 -0700
Message-ID: <xmqq38pwjv89.fsf@gitster.dls.corp.google.com>
References: <20130824013310.GA9343@sigill.intra.peff.net>
	<20130825061500.GR2882@elie.Belkin>
	<20130825095818.GA12556@sigill.intra.peff.net>
	<20130825195412.GA2752@elie.Belkin>
	<xmqqob8lj8dx.fsf@gitster.dls.corp.google.com>
	<20130826143135.GB14858@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 26 18:03:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDzFr-0001ka-Ts
	for gcvg-git-2@plane.gmane.org; Mon, 26 Aug 2013 18:03:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751978Ab3HZQCw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 12:02:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52003 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751808Ab3HZQCv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 12:02:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F99F3C48F;
	Mon, 26 Aug 2013 16:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ejed+8nq/KRrJZTqvyiWg6d3VZI=; b=rYnMDi
	pI2OofPTznMwPr0LtSWBJpH936vynZekmgZSzHQhfyB3F1I55vdj8Ol7xJ/5Mj+q
	QzwnFpgbpE+PBspmUMb0v1YSkgw3s3HOEwEf6UoywaJsylcunQ0a2jlvy8+yYnP9
	QIiLvLppHibH57FHxhNY/4sdX8CZEngiG1XBI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BHOgCfmorA+BAAld7rKti1C0Yrjb9AgK
	tCaVApVP985XG5N6zXHj2kbdSZiBaGNt4VsPSqt0zl7wo2SsgzMpgvhNQiQ6ltSE
	d1LIEtlmqRsN5GGqje3UQfOMHHTY1xoSMNyL88mEy3RcEd6dnfOZUvWO6EeVt89s
	Rw+1FJdwv2A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 619A73C48E;
	Mon, 26 Aug 2013 16:02:50 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DF8503C487;
	Mon, 26 Aug 2013 16:02:48 +0000 (UTC)
In-Reply-To: <20130826143135.GB14858@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 26 Aug 2013 10:31:35 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F44BF91A-0E68-11E3-8AB3-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232997>

Jeff King <peff@peff.net> writes:

>> I found this version more readable than Peff's (albeit slightly).
>
> OK. Do you want to apply with Jonathan's wording, then?

I can do that, as it seems all of us are in agreement.

> There's one subtle thing I didn't mention in the "it is already on stack
> overflow". If you have a version of git which complains about the null
> sha1, then the SO advice is already broken. But if the SO works, then
> you do not have a version of git which complains. So why do you care?
>
> And the answer is: you may be pushing to a remote with a version of git
> that complains, and which has receive.fsckObjects set (and in many
> cases, that remote is GitHub, since we have had that check on for a
> while).
>
> I don't know if it is worth spelling that out or not.

Probably not.

You could aim to correct each and every wrong suggestions on a site
where misguided leads other misguided, but it is a hopeless task.

>> > After this patch, do you think (in a separate change) it would make
>> > sense for cache-tree.c::update_one() to check for null sha1 and error
>> > out unless GIT_ALLOW_NULL_SHA1 is true?  That would let us get rid of
>> > the caveat from the last paragraph.
>> 
>> Hmm, interesting thought.
>
> I think it is worth doing. The main reason I put the original check on
> writing to the index is that it more clearly pinpoints the source of the
> error. If we just died during git-write-tree, then you know somebody
> broke your index, but you don't know which command.
>
> But checking in both places would add extra protection, and would make
> possible the "relax on read, strict on write" policy that filter-branch
> wants to do.

Yeah, I agree with all of the above.
