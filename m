From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/7] completion: make the 'basic' test more
 tester-friendly
Date: Sat, 17 Nov 2012 15:00:22 -0800
Message-ID: <20121117230022.GA3815@elie.Belkin>
References: <1353150353-29874-1-git-send-email-szeder@ira.uka.de>
 <1353150353-29874-2-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sun Nov 18 00:00:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZrNV-0000U5-EI
	for gcvg-git-2@plane.gmane.org; Sun, 18 Nov 2012 00:00:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752384Ab2KQXAb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Nov 2012 18:00:31 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:45443 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752303Ab2KQXAa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Nov 2012 18:00:30 -0500
Received: by mail-pa0-f46.google.com with SMTP id hz1so2602765pad.19
        for <git@vger.kernel.org>; Sat, 17 Nov 2012 15:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4OdXFgD3DU5K7Nv4QssyHQb94VxLe4U42kag2LhMCm8=;
        b=Ako47a9U3QmGPFiFbH78ct6+7sfAyCLOBA9w2iBEiGbZKXVJjFJxSg3g3s+cKNF9pn
         h6wHyt3U25hZUC0nNd6IK6+Ppzo3rBy6SI9oJx5uE2Iv6W67NTDs5rEMmbGfHnRip1xl
         /s8HAqF6NS//5oRi29/pQrQJxBztBIIJoHTS6p0jCVkMiXYpVkhWbuoJ94CICOJeUCq4
         8nqfA7LrsBeAj0JGetEJ6aCxHjl+8BFOGmRd/I3YCM+jAm21VOXT1eJi2k9XM2fsUnuE
         hKBCXSRcZmmUCKBHkP1MbU/EuN7+A+QGBIdvwCSqbfuFIr64P6H21YcaOOGgTBJzbVu1
         rdHA==
Received: by 10.66.75.165 with SMTP id d5mr24621493paw.39.1353193230402;
        Sat, 17 Nov 2012 15:00:30 -0800 (PST)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id bc8sm3436609pab.5.2012.11.17.15.00.28
        (version=SSLv3 cipher=OTHER);
        Sat, 17 Nov 2012 15:00:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1353150353-29874-2-git-send-email-szeder@ira.uka.de>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209983>

SZEDER G=C3=A1bor wrote:

> The 'basic' test uses 'grep -q' to filter the resulting possible
> completion words while looking for the presence or absence of certain
> git commands, and relies on grep's exit status to indicate a failure.
[...]
> To make testers' life easier provide some output about the failed
> condition: store the results of the filtering in a file and compare
> its contents to the expected results by the good old test_cmp helper.

Looks good.  I wonder if this points to the need for a test_grep
helper more generally.

[...]
>  	run_completion "git f" &&
> -	! grep -q -v "^f" out
> +	>expected &&
> +	sed -n "/^[^f]/p" out >out2 &&
> +	test_cmp expected out2

=46unctional change: before, this would fail if "out" contained a blank
line, while afterward it does not.  I doubt that matters, though.

Thanks and hope that helps,
Jonathan
