Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A424C1F744
	for <e@80x24.org>; Tue, 21 Jun 2016 10:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbcFUKED (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 06:04:03 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:33333 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750835AbcFUKD6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Jun 2016 06:03:58 -0400
Received: by mail-lb0-f169.google.com with SMTP id xp5so7406086lbb.0
        for <git@vger.kernel.org>; Tue, 21 Jun 2016 03:03:57 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=yRAgvUvrmtCC4hK0hDBWkEMKBTAzawRmv2ly3JQIQ6g=;
        b=wLGjMZvS6k3ZawIFjW5YXrCtzb9l2rh3CBx0fdN4CRFVZTuxYbk/kXq563mqfl6gIl
         fFLPFCvgcEaFueQ3rE7TgdRz1Wlu5RvgZbX7dhknc79TEZBV/qR4K4oEo59ceObTPy8V
         6eoRDL0HQDS+h2bAU7X6lZbonjdwtKZSa+eGjUgvrLo971ouUQd/i+4UbK6WTuJftK0O
         NsBwkRmitqI/K92WOAiGDX3FAQSTCzd1rL5rURFCi99KoCGHbxuYfrqGOyiiPUiSuF1j
         zMIOJSMwLjQrRnc6h+1rPfzBfqRJyuOwkOjLd+NG8WssU2eAVT/Ncht725BvPJiE2Shu
         Fo/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=yRAgvUvrmtCC4hK0hDBWkEMKBTAzawRmv2ly3JQIQ6g=;
        b=AwKGf2Xs54AIb/vEmsrga+1sHSU5hQQUxnXVbT0QhxUy+pN0ou0u5qvJrnvSc+1kaN
         iTzUv2w8aD98DbI0IZx1K1u0ANBz6CyEOwTxuXl+9FtBj6tlaadFz2M11zUtF4GkE3zf
         axvEPQYO1lR+FH0Mw1O8hwc4fNj9y4gSkGsmkZw+3gs8FkWIzY0BoRv7ed73r6YL73AH
         3ma7nsXfG9AO8sjilC7ZHQUrubm2sGANZFm/1vRI6c2e+qvqmA/XoJriMrrbyjp/J/P9
         Hy5/ma2VgHrWrzX1me7NOiOGQ++L9qHKta3rAA8uCb/l+5aiuf+KTLPsGKXQCzBpex4+
         Dh2g==
X-Gm-Message-State: ALyK8tLOpZTPIUOb3O5g3lD8dlrsuc8d9XBWkD7LPR5ypkp97f1pGYVaQa7MOEnyiVbXiQ==
X-Received: by 10.194.165.233 with SMTP id zb9mr20225274wjb.172.1466501800629;
        Tue, 21 Jun 2016 02:36:40 -0700 (PDT)
Received: from par3bztk12.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id el4sm35121649wjd.23.2016.06.21.02.36.39
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 Jun 2016 02:36:40 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Filters should be parallelized if needed
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <ABCC694798EF214E91DB2ACCA61703690BBADA33@MMXDC2642.hermes.si.socgen>
Date:	Tue, 21 Jun 2016 11:36:37 +0200
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <A61012AD-BC22-4640-AE99-000D99D7375F@gmail.com>
References: <ABCC694798EF214E91DB2ACCA61703690BBADA33@MMXDC2642.hermes.si.socgen>
To:	"LUCAS Thomas (EXT)" <thomas.lucas-ext@sgcib.com>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 21 Jun 2016, at 09:50, LUCAS Thomas (EXT) <thomas.lucas-ext@sgcib.com> wrote:
> 
> Setup:
> - 2.9.0.windows.1 x64 on a windows 7 16g ram, ssd
> - No particular installation settings, default.
> 
> Details:
> - Running git from either a cmd or GitExtensions,  I encountered an issue while staging or checkout of lfs files. I am processing 3000 files for a total of 500MB.
> Files are proccessed sequentially which is too slow for this amount of files, while lfs offer in some cases a way to run it from the command line in parallel, I think the git filters should be run in parallel. I think there is no need (or I am forgetting something) to run it sequentially.
> 
> If I were to use a filter processing files in a parallel way, I would have my time to checkout these files be reduced from 1h30min to 1min30s.
> 
> What actually happened instead?
> - This is a no go for our enterprise to use git-lfs because this is too slow.
> 
> I can't give you my repository because it is confidential.
> 
> Anyway, I hope you can do something about it.

Hi Lucas,

this is a known issue and there are a few ideas how to improve the situation:
https://github.com/github/git-lfs/issues/1059
https://github.com/github/git-lfs/issues/931#issuecomment-172939381

I am not sure if anyone is working on the batch/parallel smudge filter processing
already (I might have some time for that later this year). AFAIK this is not
a trivial change.

That being said, I think the Git mailing list is the wrong place to discuss GitLFS
issues as these two projects are separate. I recommend to raise an issue here:
https://github.com/github/git-lfs/issues

Cheers,
Lars

