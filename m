From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t9600: require cvsps 2.1 to perform tests
Date: Mon, 03 Dec 2007 21:37:54 -0800
Message-ID: <7v1wa3aukt.fsf@gitster.siamese.dyndns.org>
References: <4752A53E.4030000@gmail.com>
	<20071202163426.GA29781@coredump.intra.peff.net>
	<47533D75.1090002@gmail.com>
	<Pine.LNX.4.64.0712022340250.27959@racer.site>
	<20071203015954.GB8322@coredump.intra.peff.net>
	<47548CEC.6010701@gmail.com>
	<7vir3fe54c.fsf@gitster.siamese.dyndns.org>
	<20071204014145.GA20145@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitzilla@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 04 06:38:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzQUF-0003cT-OB
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 06:38:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbXLDFiE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2007 00:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbXLDFiE
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 00:38:04 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:33348 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751380AbXLDFiD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 00:38:03 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 464602F0;
	Tue,  4 Dec 2007 00:38:23 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id A74D29A674;
	Tue,  4 Dec 2007 00:38:18 -0500 (EST)
In-Reply-To: <20071204014145.GA20145@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 3 Dec 2007 20:41:45 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67003>

Jeff King <peff@peff.net> writes:

> +cvsps_version=`cvsps -h 2>&1 | sed -ne 's/cvsps version //p'`
> +case "$cvsps_version" in
> +2.1)
> +	;;
> +'')
> +	say 'skipping cvsimport tests, cvsps not found'
> +	test_done
> +	exit
> +	;;
> +*)
> +	say 'skipping cvsimport tests, cvsps too old'
> +	test_done
> +	exit
> +	;;
> +esac
> +

I wonder if it is better to grep for ' [-A] ' instead, like:

cvsps_supports_A=$(cvsps -h 2>&1 | sed -ne '/\[-A\]/p')
case "$cvsps_supports_A" in
'')
	say 'skipping cvsimport tests, lacking cvsps that supports -A option'
	test_done
        exit
esac
