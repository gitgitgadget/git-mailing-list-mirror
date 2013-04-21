From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t6200: avoid path mangling issue on Windows
Date: Sun, 21 Apr 2013 00:12:12 -0700
Message-ID: <7vli8cwe5v.fsf@alter.siamese.dyndns.org>
References: <1365348344-1648-1-git-send-email-ralf.thielow@gmail.com>
	<1365348344-1648-2-git-send-email-ralf.thielow@gmail.com>
	<516F95D1.5070209@viscovery.net>
	<7v38un93br.fsf@alter.siamese.dyndns.org>
	<5170DA96.9000300@viscovery.net>
	<7vr4i632fp.fsf@alter.siamese.dyndns.org> <51719F18.3020508@kdbg.org>
	<7va9ouz04y.fsf@alter.siamese.dyndns.org>
	<20130421000522.GB10043@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>,
	Ralf Thielow <ralf.thielow@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 21 09:12:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UToRq-0005Hs-BB
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 09:12:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752104Ab3DUHMQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 03:12:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56586 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751459Ab3DUHMP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 03:12:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B7C6613B4F;
	Sun, 21 Apr 2013 07:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=em8XczPRruumYSYPPHyA5sfh+/E=; b=M7bzKr
	SR4Pf+rNMV3co+aCZpedVTGEPCjhvtxoASG7VZ7b9+fNQV4EFGE9Xie0vCEnwBin
	Gq6t2clw5kd5myh6HN0hsPn8dbQPdio/NElI4Z0wevWA+Qsi1s9UD1Qg7EfR1dgr
	Nj7dgrNAHiWTVCG92qoRzkqqRYTATe80efdwY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=e7nEi1J+9vhGe1O2WzXL2brwEWyj3CwZ
	HGffu1gdNTSzBkDsySNAOG7rIHHRRdHKoz0LmNZntZn4aBwD4INYlwtLcqnim8Cc
	G+/3PDeVQZFcHqANo5tLIg33PsDudYkrNrCd9JYeJ2pRR6rB5fVugkTpFxSAW2QI
	zPv4PtBeT/k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB72613B4E;
	Sun, 21 Apr 2013 07:12:14 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2A98913B4C;
	Sun, 21 Apr 2013 07:12:14 +0000 (UTC)
In-Reply-To: <20130421000522.GB10043@elie.Belkin> (Jonathan Nieder's message
	of "Sat, 20 Apr 2013 17:05:22 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CADA23F6-AA52-11E2-9D02-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221901>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>
>> But a _real user_ who wants to use a slash there has no way of doing
>> so.
>
> Doesn't foo=// do that in the msys world?

"that" refers to...?  Do you mean:

    $ value=/; mycmd key="$value"

    breaks msys, but you can say

    $ value=//; mycmd key="$value"

    instead to pass a value that is a single slash.

then that is not a valid workaround; it would work differently
between Windows (passes one slash?) and everybody else (passes two
slashes).

I do not mean to say the "'' (empty string) and what you want to say
and '' (empty string) concatenated together" I suggested in the
previous message is a workable (let alone the best) proposition, but
if

    $ value=/; mycmd key=''"$value"''

worked as a way to temporarily turn off the path mangling, it at
least would be a usable workaround that would work the same way
between Windows and everybody else.
