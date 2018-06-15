Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 287021F403
	for <e@80x24.org>; Fri, 15 Jun 2018 06:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755691AbeFOG6I (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Jun 2018 02:58:08 -0400
Received: from zucker2.schokokeks.org ([178.63.68.90]:45279 "EHLO
        zucker2.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755645AbeFOG6H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jun 2018 02:58:07 -0400
Received: from localhost (localhost [::1])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
  by zucker.schokokeks.org with ESMTPSA; Fri, 15 Jun 2018 08:59:14 +0200
  id 000000000000006A.000000005B2363C2.000039EF
Date:   Fri, 15 Jun 2018 08:58:05 +0200
From:   Simon Ruderich <simon@ruderich.org>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Mahmoud Al-Qudsi <mqudsi@neosmart.net>
Subject: Re: [PATCH] Makefile: make NO_ICONV really mean "no iconv"
Message-ID: <20180615065805.GA15146@ruderich.org>
References: <CACcTrKePbgyCbXneN5NZ+cS-tiDyYe_dkdwttXpP0CUeEicvHw@mail.gmail.com>
 <20180615022503.34111-1-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20180615022503.34111-1-sunshine@sunshineco.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 14, 2018 at 10:25:03PM -0400, Eric Sunshine wrote:
> The Makefile tweak NO_ICONV is meant to allow Git to be built without
> iconv in case iconv is not installed or is otherwise dysfunctional.
> However, NO_ICONV's disabling of iconv is incomplete and can incorrectly
> allow "-liconv" to slip into the linker flags when NEEDS_LIBICONV is
> defined, which breaks the build when iconv is not installed.
>
> On some platforms, iconv lives directly in libc, whereas, on others it
> resides in libiconv. For the latter case, NEEDS_LIBICONV instructs the
> Makefile to add "-liconv" to the linker flags. config.mak.uname
> automatically defines NEEDS_LIBICONV for platforms which require it.
> The adding of "-liconv" is done unconditionally, despite NO_ICONV.
>
> Work around this problem by making NO_ICONV take precedence over
> NEEDS_LIBICONV.
>
> Reported by: Mahmoud Al-Qudsi <mqudsi@neosmart.net>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>
> This patch is extra noisy due to the indentation change. Viewing it with
> "git diff -w" helps. An alternative to re-indenting would have been to
> "undefine NEEDS_LIBICONV", however, 'undefine' was added to GNU make in
> 3.82 but MacOS is stuck on 3.81 (from 2006) so 'undefine' was avoided.

Should we put the part about MacOS's make into the commit
message? Seems like relevant information for future readers.

Regards
Simon
-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
