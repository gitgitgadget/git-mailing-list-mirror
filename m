Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5201CC433F5
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 03:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C95E61B3B
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 03:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242591AbhKRDGG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 22:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241265AbhKRDGG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 22:06:06 -0500
Received: from vuizook.err.no (vuizook.err.no [IPv6:2a02:20c8:2640::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95987C061570
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 19:03:06 -0800 (PST)
Received: from [2400:4160:1877:2b00:29f9:f15d:e50b:8944] (helo=glandium.org)
        by vuizook.err.no with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mh@glandium.org>)
        id 1mnXhV-008gvI-7b; Thu, 18 Nov 2021 03:03:01 +0000
Received: from glandium by goemon.lan with local (Exim 4.94.2)
        (envelope-from <mh@glandium.org>)
        id 1mnXhP-00A4wg-8y; Thu, 18 Nov 2021 12:02:55 +0900
Date:   Thu, 18 Nov 2021 12:02:55 +0900
From:   Mike Hommey <mh@glandium.org>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH] Use mingw.h declarations for gmtime_r/localtime_r on
 msys2
Message-ID: <20211118030255.jscp2zda4p2ewact@glandium.org>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
References: <20211005063936.588874-1-mh@glandium.org>
 <CAPUEspgLwLxavP3bC9OEJQTphoemQ+jxv+9Nkcvbf51uaBEpww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPUEspgLwLxavP3bC9OEJQTphoemQ+jxv+9Nkcvbf51uaBEpww@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 05, 2021 at 12:12:12AM -0700, Carlo Arenas wrote:
> On Mon, Oct 4, 2021 at 11:57 PM Mike Hommey <mh@glandium.org> wrote:
> > A possible alternative fix would be to e.g. add `#define _POSIX_C_SOURCE
> > 200112L` to git-compat-util.h and add `ifndef __MINGW64_VERSION_MAJOR`
> > around the definitions of `gmtime_r` and `localtime_r` in
> > compat/mingw.c, since, after all, they are available there.
> 
> something like that was merged to "main"[1] a few months ago, would
> that work for you?
> 
> Carlo
> 
> [1] https://github.com/git-for-windows/git/commit/9e52042d4a4ee2d91808dda71e7f2fdf74c83862

Since this reached 2.34, I gave it a try, and it turns out this didn't
fix it:
date.c:70:9: error: implicit declaration of function 'gmtime_r'; did you mean 'gmtime_s'? [-Werror=implicit-function-declaration]
date.c:76:9: error: implicit declaration of function 'localtime_r'; did you mean 'localtime_s'? [-Werror=implicit-function-declaration]

(presumably because _POSIX_C_SOURCE is not defined)
