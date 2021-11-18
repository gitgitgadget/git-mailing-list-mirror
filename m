Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C74C433EF
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 09:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B70561B5F
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 09:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245057AbhKRJJW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 04:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244984AbhKRJIx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 04:08:53 -0500
Received: from vuizook.err.no (vuizook.err.no [IPv6:2a02:20c8:2640::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04681C061570
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 01:05:52 -0800 (PST)
Received: from [2400:4160:1877:2b00:29f9:f15d:e50b:8944] (helo=glandium.org)
        by vuizook.err.no with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mh@glandium.org>)
        id 1mndMa-009Vej-Oy; Thu, 18 Nov 2021 09:05:49 +0000
Received: from glandium by goemon.lan with local (Exim 4.94.2)
        (envelope-from <mh@glandium.org>)
        id 1mndMU-00ADSY-GA; Thu, 18 Nov 2021 18:05:42 +0900
Date:   Thu, 18 Nov 2021 18:05:42 +0900
From:   Mike Hommey <mh@glandium.org>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH] Use mingw.h declarations for gmtime_r/localtime_r on
 msys2
Message-ID: <20211118090542.rcaggue6zpd7r3ht@glandium.org>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
References: <20211005063936.588874-1-mh@glandium.org>
 <CAPUEspgLwLxavP3bC9OEJQTphoemQ+jxv+9Nkcvbf51uaBEpww@mail.gmail.com>
 <20211118030255.jscp2zda4p2ewact@glandium.org>
 <CAPUEspg-5+YdfTJ6zi9hdDqF=KV2LJFCtqmECSss9Kfpn6sGrQ@mail.gmail.com>
 <20211118053415.4axljmr4s6kmqmms@glandium.org>
 <CAPUEsphf0d90HGg64j=jZnt-Xuhs_bwmeOyoUnmzesp_k2c4JA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPUEsphf0d90HGg64j=jZnt-Xuhs_bwmeOyoUnmzesp_k2c4JA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 17, 2021 at 11:58:00PM -0800, Carlo Arenas wrote:
> On Wed, Nov 17, 2021 at 9:34 PM Mike Hommey <mh@glandium.org> wrote:
> > On Wed, Nov 17, 2021 at 08:51:06PM -0800, Carlo Arenas wrote:
> > > It is not in 2.34; only in the git for windows fork, but agree is
> > > needed if you are building master with a newish mingw
> >
> > Err, I did mean 2.34.0.windows.1. My working workaround is to build with
> > -D_POSIX_THREAD_SAFE_FUNCTIONS=200112L.
> 
> that is strange, building main/2.34.0.windows.1 works for me both in a
> mingw64 shell and the git for windows sdk, and the PR[1] worked as
> well when applied to 2.34/master that uses a git for windows sdk for
> building it and that would had failed without it as you reported.
> 
> what version `pacman -q | grep pthread` of the winpthreads library do
> you have?, anything else peculiar about your build environment that
> you could think of?
> 
> that define and the setting in git-compat-util.h should have
> equivalent effect in your mingw headers; what does the relevant
> (almost at the bottom, where the problematic functions are defined)
> part of /mingw64/x86_64-w64-mingw32/include/time.h say?

Oh my bad, I overlooked an important part of the build log: it was a
mingw32 build, not minwg64. Mingw64 builds fine without
-D_POSIX_THREAD_SAFE_FUNCTIONS=200112L. Mingw32 requires it (because
the ifdefs are for mingw64)

Mike
