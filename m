From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jan 2016, #02; Mon, 11)
Date: Wed, 13 Jan 2016 15:07:13 -0800
Message-ID: <xmqqtwmhkrj2.fsf@gitster.mtv.corp.google.com>
References: <xmqqlh7vvfxc.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1601120939270.2964@virtualbox>
	<xmqqtwmitz2a.fsf@gitster.mtv.corp.google.com>
	<20160112214909.GD2841@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 14 00:07:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJUVe-00034T-PE
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 00:07:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752192AbcAMXHS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 18:07:18 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60870 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750946AbcAMXHP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 18:07:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B8C963C0A4;
	Wed, 13 Jan 2016 18:07:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oWBMwN+7uKYvIu0lHmF6x2p5cpk=; b=J4l4pw
	EcJ8cc1KcCRA/E7RliaIcjsMn0DNecA2T1BxNe0st20CD+xsWroxn3yZec9od78E
	tbkfeLJwn5jFEczotMrf5AGPwVMz+ghFZgollQnH0awr1WbeNPTaFvrGsO5zeHok
	hbOj8uDLGqOTl1JW28L9zetX/Z7yUn9nnb00c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B1cdDirULWlDKdFHFrRdCoTv6TDeRFvh
	cwIu3sIGjoVUGlMW712kH4t8EAYec84my/r+Mz3h7BycUx+8nE06vdFBUxzwCKAC
	9KR3ej5C9P33OkMMemH6R+DJOR78F6Xohzqy73wnsPhHznwGIifRTpV6etx5oWfz
	p2f1zDr48B4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AF1BB3C0A3;
	Wed, 13 Jan 2016 18:07:14 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 333843C0A2;
	Wed, 13 Jan 2016 18:07:14 -0500 (EST)
In-Reply-To: <20160112214909.GD2841@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 12 Jan 2016 16:49:09 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 622E4C14-BA4A-11E5-B1D6-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283994>

Jeff King <peff@peff.net> writes:

> On Tue, Jan 12, 2016 at 10:47:25AM -0800, Junio C Hamano wrote:
>
>> I think strbuf_getline() that handles the payload as "text" without
>> having _crlf() suffix is an ideal endgame in the longer term, but I
>> do not think it is a good idea to do that as a flag-day change.  So
>> I am inclined not to change the function names around that feature
>> in this series.  Others can do the wholesale rename as a separate
>> follow-up topic when the tree is quiescent.
>
> Yeah, I think we would want to catch topics in flight. Should the end of
> this series then be to _remove_ strbuf_getline()? Callers should be
> using strbuf_getline_crlf() if they want text lines, and
> strbuf_getdelim() if they do not.
>
> Topics in flight will need fixed up, but that's OK; the breakage (and
> the fix) will be obvious.
>
> And then after a quiet period we can drop the "_crlf()" and have
> strbuf_getline() back.

Actually, I think a patch that

 - renames strbuf_getline() to strbuf_getdelim(); and
 - renames strbuf_getline_crlf() to strbuf_getline() 

on top of the series we already have is sufficient to bring the
endgame state to us.  The new strbuf_getline() has a different
function signature from the traditional one, so any topic in flight
that is unaware of this series can easily be caught, and we can do
this without a quiet period.

A more interesting question is if strbuf_getdelim() should take an
arbitrary byte as its third parameter.  As I said elsewhere, the
only reason why it is not a "do we use LF or do we use NUL?"
boolean is because I wrote these codepaths anticipating that there
might be a value other than NUL and LF that could be useful when I
introduced line_termination long time ago, but no useful caller that
uses other useful value has emerged, so I think the interface was
too broad and too general for its own good.

It becomes very tempting not to do strbuf_getdelim() at all, but
instead rewrite the current calls to strbuf_getline() to call one of
two functions, i.e. strbuf_getline_lf() and strbuf_getline_nul(),
when we rename strbuf_getline_crlf() to strbuf_getline().

By going that route, those who want to help CRLF situation further
can then concentrate on output from "git grep strbuf_getline_lf()",
identify the ones that can be safely turned into strbuf_getline(),
and do the conversion.
