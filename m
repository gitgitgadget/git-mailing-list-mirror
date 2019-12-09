Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAB7C43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 14:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A91CA207FD
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 14:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfLIOgw convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 9 Dec 2019 09:36:52 -0500
Received: from smtp.msys.ch ([46.175.8.2]:29786 "EHLO sleipnir.msys.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727403AbfLIOgv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 09:36:51 -0500
Received: from mail.msys.ch (smtp.msys.ch [46.175.8.2])
        by sleipnir.msys.ch (8.14.3/8.14.3) with ESMTP id xB9F6xfp008536
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 9 Dec 2019 15:07:00 GMT
Received: from [46.175.8.181] ([46.175.8.181])
        (authenticated bits=0)
        by mail.msys.ch (8.14.3/8.14.3) with ESMTP id xB9F6x1a016647
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 9 Dec 2019 15:06:59 GMT
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: Regression in git-subtree.sh, introduced in 2.20.1, after
 315a84f9aa0e2e629b0680068646b0032518ebed
From:   Marc Balmer <marc@msys.ch>
In-Reply-To: <3b9408a9bd87ea488c4a6b9bc2583aba56ce3949.camel@swri.org>
Date:   Mon, 9 Dec 2019 15:13:47 +0100
Cc:     "ns@nadavsinai.com" <ns@nadavsinai.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "Johannes.Schindelin@gmx.de" <Johannes.Schindelin@gmx.de>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <E8FC0E5F-DD83-4470-B068-21865ECA84D2@msys.ch>
References: <CANxxO2MGJ2Wo6Y-33KzzPXz6vktRACk0Oi2Y6o_s-cDFRhG7+Q@mail.gmail.com>
 <3b9408a9bd87ea488c4a6b9bc2583aba56ce3949.camel@swri.org>
To:     "Strain, Roger L." <roger.strain@swri.org>
X-Mailer: Apple Mail (2.3601.0.10)
X-SMTP-Vilter-Version: 1.3.6
X-Spamd-Symbols: BAYES_00,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Roger,

I am all for reverting it. if that does not cause any other regressions or headaches (or both...)

- Marc


> Am 09.12.2019 um 15:11 schrieb Strain, Roger L. <roger.strain@swri.org>:
> 
> I haven't been able to find anything relating to the issue, but I also
> haven't had a repo that exposes the problem to test more thoroughly
> against. If this happens to be a public repo somewhere, I'd be more
> than happy to take a second look.
> 
> That being said, if the community feels it would be better to revert
> the changes that were introduced, I won't object. I've had to further
> customize the script for our internal use, and those changes aren't
> something that would be useful for the public at large. (A few changes relate to the presence/absence of a specific file, which I certainly wouldn't expect anyone else to have.) Short story is we're going to have to use a custom script going forward, so keeping or reverting the changes here make no difference to us. I still feel that the changes which were made make the script more correct, but clearly there's some undiagnosed logic error somewhere.
> 
> Honestly, I'm surprised we didn't see this particular issue show up on
> our own repo; it's ridiculously large and complex. At least if it had,
> I'd be able to troubleshoot it more reliably.
> 
> --  
> Roger Strain
> 
> -----Original Message-----
> From: Nadav SInai <ns@nadavsinai.com>
> To: roger.strain@swri.org
> Cc: Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
> marc@msys.ch, pclouds@gmail.com
> Subject: RE: Regression in git-subtree.sh, introduced in 2.20.1, after
> 315a84f9aa0e2e629b0680068646b0032518ebed
> Date: Sun, 08 Dec 2019 12:30:48 +0200
> 
> [EXTERNAL EMAIL]
> 
> Hi, I'm curious if any of you had any luck in preventing that
> seg-fault in git-subtree script
> I'm encountering it myself using git 2.24.0.windows.2., seg-fault is
> in the same while loop (currently on line 757)
> When I tried your suggestion of adding the ($parents) ($rev) to the
> progress print I see that the last commit have only one revision
> printed
> like this:
> 
> 259/290 (523) [271] (843dd34090d36dfabd6a2e3e8459a4887427313b)
> (a69ee056f66acf66c63f89f55d26c0cc17036623)
> 259/290 (525) [273] (f5eea1a3cbe1e16acba53e8a9fe07b6525a8b97c)
> (843dd34090d36dfabd6a2e3e8459a4887427313b)
> 259/290 (527) [275] (82303752a428cf1d789ac9f156008adb2798b7b5)
> (f5eea1a3cbe1e16acba53e8a9fe07b6525a8b97c)
> 259/290 (528) [276]
> (7187897883c9fb4d33d4c87a02b876f8603728ff05f0945ae2ce9f98a35135)
> 259/290 (529) [277]
> (a00a3665343439a426671958dd90ed0407a22cad9ac9f156008adb2798b7b5)
> 259/290 (530) [278]
> (90beb94ebd331c457d79d05341453f5829a50bfcd4c87a02b876f8603728ff)
> 259/290 (531) [279]
> (9582e0acbed1910173564e250f350b5cc4291a7f671958dd90ed0407a22cad)
> 259/290 (532) [280]
> (f183930d6fabd3dccdddc5ec35d754ad28caf3b879d05341453f5829a50bfc)
> 259/290 (533) [281]
> (c9309f3a38c41f7991d9e78ddb47f7e85b8521eb564e250f350b5cc4291a7f)
> 259/290 (534) [282]
> (3bcf08f63a0e2b93ecc376bd679a16c80e99e7b1ddc5ec35d754ad28caf3b8)
> 259/290 (535) [283]
> (134621bb55a0470cdf6519ce08d6909af43ce0e5d9e78ddb47f7e85b8521eb)
> 259/290 (536) [284]
> (edb3471fbba29748f9784d29b3cee1dee2df4b37c376bd679a16c80e99e7b1)
> 259/290 (537) [285]
> (dd947a095df07a32dfd56666a395a7c42b25ca116519ce08d6909af43ce0e5)
> 259/290 (538) [286]
> (a639e09d2cbe1ea1149c080c1c95b8b018340ae2784d29b3cee1dee2df4b37)
> C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line 757:
> 8853 Done                    eval "$grl"
>      8854 Segmentation fault      (core dumped) | while read rev
> parents; do
>    process_split_commit "$rev" "$parents" 0;
> done
> 
> I downgraded git to 2.19.0-windows.1 and it works now.
> 
> 
> I'm thankful for your insights
> Nadav Sinai
> Web Tech lead
> Philips-Algotec
> 
> 

