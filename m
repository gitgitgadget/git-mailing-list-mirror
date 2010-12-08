From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] imap-send: link against libcrypto for HMAC and others
Date: Tue, 07 Dec 2010 18:12:00 -0800
Message-ID: <7vd3pdm2rz.fsf@alter.siamese.dyndns.org>
References: <7vwro2sd83.fsf@alter.siamese.dyndns.org>
 <1290629033-20566-1-git-send-email-flameeyes@gmail.com>
 <1291613304.3339.12.camel@fixed-disk>
 <1291613978.4756.157.camel@yamato.local>
 <7v39qbtoq9.fsf@alter.siamese.dyndns.org>
 <20101208015144.GA4868@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Diego Elio =?utf-8?Q?Petten=C3=B2?= <flameeyes@gmail.com>
To: Jared Hance <jaredhance@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 08 03:13:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ9X0-00075E-2N
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 03:13:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756219Ab0LHCNA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Dec 2010 21:13:00 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47656 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756143Ab0LHCM7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Dec 2010 21:12:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 286AD2AD6;
	Tue,  7 Dec 2010 21:13:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:cc
	:subject:references:from:date:in-reply-to:message-id
	:mime-version:content-type; s=sasl; bh=b5uLhh67GBXIs5utOaZK9n1AN
	Jw=; b=Buuxn6Z751sksPmeq1PN4yZSg/Yj4dQcBpXZkv5ggTfg4wtceg699xlj6
	J7s+ETZsRx/CRNDYG1s9KF05b2YRG47QfaHYkQVgV6LxSEMN+tSeVcAUN5vSKdpi
	/0+Pai35sgUvzVknr+9uNR2Cncg5omnFCeU4ApiTLsaB+8b1Wk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:cc
	:subject:references:from:date:in-reply-to:message-id
	:mime-version:content-type; q=dns; s=sasl; b=Jp/6i0T4iZkK1lJMH7A
	9R/svRGLFg+YuOo7gNQcMB+QC0tkCgJN1PmLZz1z8DGWeR/aUQ359WOm+lT6jY+f
	kd+C7gqrPMbHiRnDuN5EYn75LXcHOFxPbqOD6bTDdejnNqQvIYXKem89EquNo74n
	6+3KkzSnNWedQXERBJawHahs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D78F62ACE;
	Tue,  7 Dec 2010 21:13:16 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 162542ABA; Tue,  7 Dec 2010
 21:12:29 -0500 (EST)
Cc: Anders Kaseorg <andersk@MIT.EDU>, git@vger.kernel.org
In-Reply-To: <20101208015144.GA4868@localhost.localdomain> (Jared Hance's
 message of "Tue\, 7 Dec 2010 20\:51\:44 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B80ADB58-0270-11E0-8847-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163160>

Jared Hance <jaredhance@gmail.com> writes:

>> You are both correct; the point of NO_OPENSSL is not to link with anything
>> from openssl suite, so we need a separate mechanism to address this.
>> 
>> Anders, wouldn't this be a better fix for NO_OPENSSL build, than reverting
>> a fix for an incorrect ld invocation?
>
> Could we get this fixup patch into master? Leaving the original patch
> in without it doesn't seem like a good idea when it breaks the build.

That depends on what Diego and Anders would say/report, and that is why
their address were on To/Cc in the message you are replying to.  Why did
you cull Cc from your message?

One thing I do not like about it is that the "fixup" is ugly.  It makes
people expect to add $(LIB_4_CRYPTO) on their linker command line to get a
correct linking with -lcrypto library, when all it does is _not_ to link
with -lcrypto at all, so whatever program that uses it needs to know about
NO_OPENSSL and refrain from using the symbols from that library.
