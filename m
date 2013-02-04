From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add contrib/credentials/netrc with GPG support, try #2
Date: Mon, 04 Feb 2013 15:40:32 -0800
Message-ID: <7vy5f3zlzj.fsf@alter.siamese.dyndns.org>
References: <87ehgvua6h.fsf@lifelogs.com>
 <20130204211726.GB13186@sigill.intra.peff.net>
 <87mwvjsqjc.fsf_-_@lifelogs.com> <7vd2wf1yex.fsf@alter.siamese.dyndns.org>
 <87bobzslke.fsf@lifelogs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Ted Zlatanov <tzz@lifelogs.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 00:40:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2Vek-0003Yb-6S
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 00:40:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755033Ab3BDXkf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2013 18:40:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34336 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754652Ab3BDXkf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2013 18:40:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E772B79F;
	Mon,  4 Feb 2013 18:40:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fCyLz0oAfVOkdhf7cLTHJGmDzns=; b=PbZZSU
	mX5kmdzTcfLbsg+y+r5S+gEbgW6AgJkZAPPRAfvqoqutpAomTCI6VegqdKIH1+vi
	paLerpLCJ28dDhQFMS8nqIhlLeFoF6tvBGYOtcC7z/hHkRR7H+iGDh7/tBMVdEb1
	OEi5sth823slI3xX8dBcPq6CohMob8DNkn18M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a0ebCwNE2fbie1JbC+iOVoggjvTAIWRM
	re7OxKpEQNEqsaiBz6RGPXjia1EzQaVda7oC4LUxlP9rEPNr1y+O0NKk2frqjsju
	mcVYs5hSGWpaX+eTciRURjCpKgs+M7UigDtHfC9tJ6ceqJDWG8ByZsMh3a4n8973
	iSE5v0h5vhw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7FB76B79E;
	Mon,  4 Feb 2013 18:40:34 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D76D1B79C; Mon,  4 Feb 2013
 18:40:33 -0500 (EST)
In-Reply-To: <87bobzslke.fsf@lifelogs.com> (Ted Zlatanov's message of "Mon,
 04 Feb 2013 18:31:29 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 44D634B6-6F24-11E2-96DE-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215433>

Ted Zlatanov <tzz@lifelogs.com> writes:

>>> +my $mode = shift @ARGV;
>>> +
>>> +# credentials may get 'get', 'store', or 'erase' as parameters but
>>> +# only acknowledge 'get'
>>> +die "Syntax: $0 [-f AUTHFILE] [-d] get" unless defined $mode;
>>> +
>>> +# only support 'get' mode
>>> +exit unless $mode eq 'get';
>
> JCH> The above looks strange.  Why does the invoker get the error message
> JCH> only when it runs this without arguments?  Did you mean to say more
> JCH> like this?
>
> JCH> 	unless (defined $mode && $mode eq 'get') {
> JCH> 		die "...";
> JCH> 	}
>
> I mean:
>
> - if the mode is not given, exit badly (since it's required)
>
> - if the mode is given but we don't support it, exit pleasantly
>
> I thought that was the right thing, according to my reading of the
> credentials API.  If not, I'll be glad to change it.

As Peff noted, I mistead what the code was doing, especially with
somewhat cryptic "only support x mode" comment, as if it is
rejecting other modes.

>>> +	print STDERR "Sorry, we could not load data from [$file]\n" if $debug;
>>> +	exit;
>
> JCH> Is this really an error?  The file perhaps was empty.  Shouldn't
> JCH> that case treated the same way as the case where no entry that
> JCH> matches the criteria invoker gave you was found?
>
> exit(0) is not an error, so the behavior is exactly the same, we just
> don't print anything to STDOUT because there was no data, with a nicer
> error message.  I think that's what we want?

"Sorry we couldn't" sounded like an error messag to me.  If this is
a normal exit, then please make sure it is a normal exit.

The review cycle is not like reviewers give you instructions and
designs and you blindly implement them.  It is a creative process
where you show the design and a clear implementation of that design.

Thanks.
