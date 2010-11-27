From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] cvsimport: fix the parsing of uppercase config
 options
Date: Fri, 26 Nov 2010 22:38:14 -0800
Message-ID: <7vwrnznueh.fsf@alter.siamese.dyndns.org>
References: <939dff25f5a58b6f37cf21bf490b2782f6e96f39.1290697830.git.git@drmicha.warpmail.net> <ad36bc3f6a00c5f7bc643be3f97aa2bcfda990ff.1290697830.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat Nov 27 07:38:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMEQX-00060v-Nj
	for gcvg-git-2@lo.gmane.org; Sat, 27 Nov 2010 07:38:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089Ab0K0GiW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Nov 2010 01:38:22 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49443 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750939Ab0K0GiV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Nov 2010 01:38:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 70CC437DF;
	Sat, 27 Nov 2010 01:38:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=xQuoLWR4Ru5QbOgd7td7RAsGBs0=; b=CYD2SlKpUC5hhoRRmzldNVX
	o+HiK1VkXeG/K8U7QNbM0LJFq5ay3c/TK6R7E2FlqlmoQIxil0nhnKI4lCHbbXVR
	X/kvkFqXNbj+AxGrgN3aSfcct5EUnc/mie/KOv3xiXnxYbcTurRl7mNtuaep8n2T
	D3e4eeVMLBrOCaRviOho=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=yguuOy4rfLXh14yp1DQMH521c5X+iTKPHKoT8/JuOPeKvxnyS
	VjE7tjBIsYdjMmNk5sPdL54vdOkG9FTYgt7fpsH6vT53h+Un96NfJRN37pNY4Thb
	SGqE08B1jb/e83V65VdcFzybn/j/IkP/O5r49gct/I1U2hGojBnRyNcUIc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4EFC137DE;
	Sat, 27 Nov 2010 01:38:35 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7A1F337DC; Sat, 27 Nov 2010
 01:38:32 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F5A12B26-F9F0-11DF-8F72-DF8536391E49-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162302>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> The current code leads to
>
> fatal: bad config value for 'cvsimport.r' in .git/config
>
> for a standard use case with cvsimport.r set:
>
> cvsimport sets internal variables by checking the config for each
> possible command line option. The problem is that config items are case
> insensitive, so config.r and config.R are the same. The ugly error is
> due to that fact that cvsimport expects a bool for -R (and thus
> config.R) but a remote name for -r (and thus config.r).
>
> Fix this by making cvsimport expect the config item "cvsimport.RR"
> for the command line option "-R" etc.

I do not think this is "fixing" per-se.  Isn't it more like "We didn't
have a way to use the configuration file to specify uppercase option; now
we do thanks to this patch, and here is how"?

And the "here is how" workaround, while it may be a reasonable way out, is
so obscure that it needs to be documented, no?  Ahh, that is what [3/3] is.

The $ckey change from 1/3 needs to be done here, I think.
