From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/3] Make test "using invalid commit with -C" more strict
Date: Sat, 24 Aug 2013 13:01:28 -0700
Message-ID: <20130824200128.GB2960@elie.Belkin>
References: <1377316906-70338-1-git-send-email-draenog@pld-linux.org>
 <1377316906-70338-2-git-send-email-draenog@pld-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kacper Kornet <draenog@pld-linux.org>
X-From: git-owner@vger.kernel.org Sat Aug 24 22:01:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDK1h-00076M-Lf
	for gcvg-git-2@plane.gmane.org; Sat, 24 Aug 2013 22:01:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754892Ab3HXUBd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Aug 2013 16:01:33 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:37224 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754540Ab3HXUBd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Aug 2013 16:01:33 -0400
Received: by mail-pb0-f45.google.com with SMTP id mc17so1932311pbc.18
        for <git@vger.kernel.org>; Sat, 24 Aug 2013 13:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=UNNuqAbcGKKxuQo+PtbjnQir7WGVDBhruaMIUDZr3x0=;
        b=0pdTSK/JTnv63hOnrCwlSvq8MIvBve2DXV2fvbI+0EsMKHsxHNgpf8j22sj+kmU1qh
         u479LDNgM/MThyFDIoU/PGlk+mPPE0bfFgByWvtnHRPpyDDVJ3ieea0d3WDQ8F491MNN
         mw1Cv+LPxTHw3n5vjuMokaBtBPwZH1Q93gxUP3qa2GDngQQoRslGotH9aMZm+W2qtEq0
         QpHOLkdgbffV1vVbQHPpWUBGUQHuFG15KGcKQEdj50ztu4Nte3Lt6QnTdpQUBcoXk7iO
         ywTyt9VrbiOkuhiqTrXAhJnx0X1eH3XuUc98qs9yfEQI6jqc0TH4m86DevXtv4yQyLU4
         +g4g==
X-Received: by 10.68.136.7 with SMTP id pw7mr6403001pbb.106.1377374492551;
        Sat, 24 Aug 2013 13:01:32 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id om2sm7815327pbb.34.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 24 Aug 2013 13:01:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1377316906-70338-2-git-send-email-draenog@pld-linux.org>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232889>

Kacper Kornet wrote:

> In the test 'using invalid commit with -C' git-commit would have failed
> even if the -C option  had been given the correct commit, as there was
> nothing to commit.

Good catch.

[...]
> --- a/t/t7501-commit.sh
> +++ b/t/t7501-commit.sh
> @@ -53,7 +53,10 @@ test_expect_success PERL 'can use paths with --interactive' '
>  '
>  
>  test_expect_success 'using invalid commit with -C' '
> -	test_must_fail git commit -C bogus
> +	echo bong >file &&
> +	git add file &&
> +	test_must_fail git commit -C bogus &&
> +	git reset

I guess to be pedantic this should say

	echo bong >file &&
	git add file &&
	test_when_finished "git reset --hard" &&
	test_must_fail git commit -C bogus

to avoid interfering with later tests even when this one fails and
the && prevents the 'git reset' from being executed.

With or without that change,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
