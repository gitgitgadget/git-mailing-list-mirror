From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] merge-file: consider core.crlf when writing merge
 markers
Date: Fri, 22 Jan 2016 14:50:15 -0500
Message-ID: <20160122195015.GA5897@flurp.local>
References: <cover.1453482052.git.johannes.schindelin@gmx.de>
 <c0c775ea7a9ba3244748b784241de685cefc73b1.1453482052.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Beat Bolli <dev+git@drbeat.li>,
	git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 22 20:50:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMhj2-0002E3-Gx
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jan 2016 20:50:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752669AbcAVTuZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2016 14:50:25 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:34130 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752140AbcAVTuX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2016 14:50:23 -0500
Received: by mail-io0-f195.google.com with SMTP id k127so8399638iok.1
        for <git@vger.kernel.org>; Fri, 22 Jan 2016 11:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=0khqhKeEHjekVT7G2FqRE2Yw2TcXt3X1UEifcWGIedI=;
        b=Hk6uHU1eKGafFy2hgCS3q+vBzGAaPKY0AwtJuVEFG5KrZyw1ddELtPo2V8fXW0Fv1x
         2/Obgz6VQ8K+mGq2rKt4bXmEatfrAA76VBI+qGKROHAdhS3O9zRpodgUo1RCAD/+Lj2V
         zzPbwOMOcj79QVnhuiEUs0njCSwUfTkr3FyyK9RrRHis6XjeJMZTtoga0lYdvFFmJIF5
         CvJVY4WBhWIN3sI5ZqdrA9DgGcDXdJqIJYpWhURWB0lxKS0MUn3n4UfoWOk5s4qR0i/V
         ZNV+WZmBtKvsnuNToO+fqgsUKZvpO5sgU1SsC7vl4ziyfr0YDG4K/eK14tSELKaMjsX1
         m1pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=0khqhKeEHjekVT7G2FqRE2Yw2TcXt3X1UEifcWGIedI=;
        b=brMRVADIxf/xSkIZHoHsQl/u56nlXVYWJojTsnKsZtc8nPMe9j5DFudse+CNxgVBbL
         S4W/UV7g82hyvAoD44zJzyVoZ52XCJRyBW8g2W3OG6bR1p8aYz6EGDRur6fTzt+YAR/J
         moQFgqgmFSytamr1NHS+ktlRVt1wPk28lbv7tbjQwsNDuKyDXEVZj5RnlV4MSWJjlW9c
         jd3P9VI86iEA82V34vthi8pvSF9xQAU0xYsfQFaChjwNH9oBTWz1LZYvSQWm/IeHijyY
         BaZohzAEtZsrCIzLqYVh+FMsGsZUBufWuOMDOhu4DMRBGENwYqEbb6PV/pP+/LGGzTtP
         OdBQ==
X-Gm-Message-State: AG10YOS3iUrQiLIRRF8l4NZ13/KBfFyyd/cGb2brBsGAWqjjGgIaXKE2wJyYBdL7QCDxlw==
X-Received: by 10.107.19.160 with SMTP id 32mr5363517iot.104.1453492222612;
        Fri, 22 Jan 2016 11:50:22 -0800 (PST)
Received: from flurp.local (user-12l3c5v.cable.mindspring.com. [69.81.176.191])
        by smtp.gmail.com with ESMTPSA id 95sm3588993iop.35.2016.01.22.11.50.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 22 Jan 2016 11:50:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <c0c775ea7a9ba3244748b784241de685cefc73b1.1453482052.git.johannes.schindelin@gmx.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284587>

On Fri, Jan 22, 2016 at 06:01:25PM +0100, Johannes Schindelin wrote:
> When merging files in repos with core.eol = crlf, git merge-file inserts
> just a LF at the end of the merge markers. Files with mixed line endings
> cause trouble in Windows editors and e.g. contrib/git-jump, where an
> unmerged file in a run of "git jump merge" is reported as simply "binary
> file matches".
> [...]
> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/t/t6023-merge-file.sh b/t/t6023-merge-file.sh
> @@ -346,4 +346,18 @@ test_expect_success 'conflict at EOF without LF resolved by --union' \
> +test_expect_success 'conflict markers contain CRLF when core.eol=crlf' '
> +	test_must_fail git -c core.eol=crlf merge-file -p \
> +		nolf-diff1.txt nolf-orig.txt nolf-diff2.txt >output.txt &&
> +	test $(sed -n "/\.txt\r$/p" output.txt | wc -l) = 3

The "\r" isn't recognized by 'sed' on Mac OS X or BSD. Perhaps use
instead:

    test $(cat output.txt | tr "\015" Q | sed -n "/\.txtQ$/p" | wc -l) = 3

which works on Linux, Mac OS X, and BSD (in my tests).

Or, implement a cr_to_q() to complement the existing q_to_cr() in
t/test-lib-functions.sh.

> +'
> +
> +test_expect_success 'conflict markers heed gitattributes over core.eol=crlf' '
> +	git config core.eol crlf &&
> +	echo "*.txt eol=lf" >>.gitattributes &&
> +	test_must_fail git -c core.eol=crlf merge-file -p \
> +		nolf-diff1.txt nolf-orig.txt nolf-diff2.txt >output.txt &&
> +	test $(sed -n "/\.txt\r$/p" output.txt | wc -l) = 0

Ditto.

> +'
