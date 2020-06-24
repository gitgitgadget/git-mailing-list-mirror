Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBE1C433DF
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 22:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 101E12076E
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 22:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="WEdoljF0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389097AbgFXW3r (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 18:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388711AbgFXW3q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 18:29:46 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B24C061573
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 15:29:46 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id g139so2122872lfd.10
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 15:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=h31suH5VzV56vmRzujXaPsWjAOGE/57fRCeqJynKLfY=;
        b=WEdoljF0yYSbecgI/pIhdjchN6+5EVSUZmoVwlPWWK9IlVjDpkIPA3ykLnJCHO0cUC
         360v2EuwrASWHLOJY+OCeENTqedMsuhEPdTZ0WxhsHR3fHeAiU5Kcr10ckbb5w/+H6sP
         FVx+HjvIkplEW1ox83scyilNRcwI2CsKM6lrSuCJNYIHkhkM32zZ2Y8/ydNb2fjWKS3k
         j15Zuh0+sRvYPYy3uV9HJ+MbP3xn0aN8Mg+n8qOWhGq1cMBnlpMqs1PjW1Dc9KSHnvcu
         OLqrwJizWYR4RkbSw/vCHZVizJUATfWWdaJu0sppvFkiRLLGCF9WbYXnd4MQF5z37iQx
         dYBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=h31suH5VzV56vmRzujXaPsWjAOGE/57fRCeqJynKLfY=;
        b=MhGsswgIaRMSWF8E5nfMb/alEN0KTElfplNNGQeXeEUrkETIEPcaSYhNqEJLrJE5jV
         Rrlrb8dFRj++r9pKOHiggcDFLomN/64pXqh+7FUn9WeiHMH8s5hTiAogkINA/NRuAm1h
         dkVr1Nk7OmxWjZiajJCQ5Ogxaf0qpkTi47UxBxoAz6Jt50MTZRnT3t4eYOyfWVr5RatF
         IVt1wLYqYnBfdRHL+YLGKPDTlXWX17XlKRja8SF+75hVAQy8Tc+kM4ZhHAO67qeet+/y
         Ts6SyMQ1QYsezFsMGnfbI79ZwyiS8obr2p1EIer2xRClFAUOuDs4oAMi8guTiULi5rnW
         CoKQ==
X-Gm-Message-State: AOAM532cgEj4JVPbquJtjrrYQLP5WSelc3mrAUQrPNk3KDcOc21+xwSm
        xDGKuuSxUge1FnbW8ixjmchUvF/cr/SCYAteyFg/9lYUXbc=
X-Google-Smtp-Source: ABdhPJxa+bykUsPpLuwZPdD+Bl1S3v1Z4/kz/miCLjMGSJr5a0DOsKWj/+nQVGqJBdA4xAJbUC8FUyrWKRpwPLeDBgs=
X-Received: by 2002:a19:11:: with SMTP id 17mr16868196lfa.125.1593037783843;
 Wed, 24 Jun 2020 15:29:43 -0700 (PDT)
MIME-Version: 1.0
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Wed, 24 Jun 2020 19:29:32 -0300
Message-ID: <CAHd-oW5zh=BG29O0Z-M7R26Lgd=RHECMV2+qByF+vU6PmrEn_Q@mail.gmail.com>
Subject: [RFC] Thread safety in some low-level functions
To:     git <git@vger.kernel.org>
Cc:     Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I'm working with threads in unpack-trees and noticed that
[warning|error]_errno() uses strerror(), which is not thread-safe. We
could try to avoid calling these functions in threaded code, but they
are sometimes too deep in the call stack to be noticed... (or even
avoided). The same happens with oid_to_hex(), which writes to a static
buffer.

I don't think I've ever seen a bug report involving these functions
being called racily, but this possibility is not currently excluded in
our codebase. For example, see grep_source_load_file(), which is
called by multiple threads concurrently and might call the
thread-unsafe error_errno(). (Although, I admit, the chance of a race
here must be very low...)

I still haven't been able to come up with a simple / easy change that
could make these functions thread safe, but here are my thoughts so
far:

- For strerror(), there is a thread-safe variant: strerror_r().
However IIUC, this variant is not present on Windows (although there
is strerror_s() which *seems* to be somewhat similar). Also, there are
two versions of strerror_r() on Linux: one is XSI-compliant and the
other is GNU-specific. I don't know what the situation is in other
OSes...

- Regarding, oid_to_hex(), a patch from 2010 [1] proposed a solution
using thread-local storage and pthread_once(). But as Hannes pointed
out in this other thread [2] , implementing a Windows equivalence for
pthread_once() could be tricky and voluminous. Since this thread dates
from 7 years ago, I was wondering if we would be able to implement it
nowadays with InitOnceExecuteOnce() [3].

Finally, leaving these functions thread-unsafe is also a
possibility... As I mentioned earlier, they don't seem to be causing
problems out there for now (at least not reported). But if we can find
a feasible solution to introduce thread-safety, I think it would be
great. The codebase would be more robust and we would be able to work
with threads with much more confidence.

Any thoughts?

Thanks,
Matheus

[1] https://lore.kernel.org/git/20100323173130.GC4218@fredrik-laptop/
[2] https://lore.kernel.org/git/516D5CA4.7000500@viscovery.net/
[3]: https://docs.microsoft.com/en-us/windows/win32/sync/using-one-time-initialization
