Return-Path: <SRS0=kv1d=5J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E003EC10DCE
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 03:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC3E0205ED
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 03:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9SjKmus"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbgCXDkw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 23:40:52 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35815 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727060AbgCXDkw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 23:40:52 -0400
Received: by mail-pf1-f194.google.com with SMTP id u68so8607291pfb.2
        for <git@vger.kernel.org>; Mon, 23 Mar 2020 20:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=96WXuGm6p1TH5uIVqNhR9gwN/djj147nRK4K1xMF7M8=;
        b=D9SjKmusiYHg5i+B/zguTeaJrbAF6miniZsTCo65BBx0YqBL3LTQSnUP7Fd7xLUOvi
         lghsEOMYsnxT8TT8iEx/KJozxWDRw/u3HSV7k+e43XQFcj65K+tG2AVz2UZyDtjiTr5Q
         Gy86dB784qz3pYa1GHvq0kQ0VExDtZOOqR+rf6mlV9NcFARRmMS5h28A/c0gBnEa5Qej
         Ycl+zkOHaPU7K6BsVR7+59Q/oe/oMvqr76op/TlNCFU+5g8KBodf42nUObqjlAeof6Ae
         F0Yaw2iCu4ZLYpdedh2U812vEZ9u5GdCy5kZ3XSCXPlVHeCsDSeglAUAADCx+NXJWLbQ
         oDAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=96WXuGm6p1TH5uIVqNhR9gwN/djj147nRK4K1xMF7M8=;
        b=MaMb9vVKc8LPJzX1oG+33Omg+N4i2UulRraRdDHt0+RGTA++9zxn5oziaN3URTmZS/
         zxWO3MQVd0SuWNzCXhFP34hEqDyj+8r3f/45U7vd7CH9YyQ1EWHodyLFlz+2rjg9uZyd
         wyy3LgJQGQrFYBJ2pjZ5sfPjfkvt16VYN3x7Z7ASUuKVNBuRgd/hIFFiGqzHLPGrJ7ci
         Cp0e2Qfidr0rWHwQvsGeGS9X8bKZyHCeEHIib28CzhKpZPzJ618lzzWFKkjGVhJBpJwd
         IZEbEHfj1Ngzwr77l3wYG9oZnwMWBNURGZ/8YnpvT72TulkvuhgMfPtU12tg50fvKhaA
         fF0w==
X-Gm-Message-State: ANhLgQ1sPcbLXqpO/YTLYhLVJHxWbv72eixQdsrYMBYsAeChSk8rDyIM
        81OhmWjZU15m1WGJGJ913z3CLnDG
X-Google-Smtp-Source: ADFU+vtHkCX50w6fV77sdPVy/oxU03ctnWLG2NtODfT4cRG6GTOwTZxLXYd6kQjer/3biQPGzke5Nw==
X-Received: by 2002:a63:cc47:: with SMTP id q7mr8681351pgi.213.1585021251518;
        Mon, 23 Mar 2020 20:40:51 -0700 (PDT)
Received: from localhost ([2402:800:6375:576b:56ff:d97c:a505:3e0c])
        by smtp.gmail.com with ESMTPSA id k4sm15443328pfh.0.2020.03.23.20.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 20:40:50 -0700 (PDT)
Date:   Tue, 24 Mar 2020 10:40:48 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 7/8] t4124: fix test for non-compliant diff(1)
Message-ID: <20200324034025.GE11801@danh.dev>
References: <cover.1584838148.git.congdanhqx@gmail.com>
 <10f39c3d30d13e9141f081f985a0620954cc7493.1584838148.git.congdanhqx@gmail.com>
 <nycvar.QRO.7.76.6.2003231456200.46@tvgsbejvaqbjf.bet>
 <20200323150449.GC11801@danh.dev>
 <xmqq8sjq4wyf.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8sjq4wyf.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-03-23 13:50:48-0700, Junio C Hamano <gitster@pobox.com> wrote:
> Danh Doan <congdanhqx@gmail.com> writes:
> 
> > A comment in test-lib-functions::test_cmp mentions that
> > there _is_ a diff out there that doesn't understand "-u".
> 
> That came from 82ebb0b6 (add test_cmp function for test scripts,
> 2008-03-12).
> 
> The change history at the end of the page:
> 
>   https://pubs.opengroup.org/onlinepubs/9699919799/utilities/diff.html
> 
> suggests that POSIX did not require "diff -u" until Issue 7, so it
> is not surprising that the lack of "diff -u" to cause test_cmp to
> fail was of real concern back in March 2008, as the application of
> the errata have been only an year and half old, according to:
> 
>   https://www.opengroup.org/austin/docs/austin_325.txt
> 
> I vaguely recall that some open source projects only took the copied
> context diffs and not unified ones the last time I checked, but
> admittedly (1) that "last time" was a long time ago and (2) our
> popularity and the fact that we do not understand copied context
> [*1*] may have forced people to move away from "-c" and adopt "-u"
> at the same time.  
> 
> So it might be OK to write off any system that does not understand
> "diff -u" as an unusable trash these days ;-)

From the setting in "config.mak.uname", it's likely those systems
don't understand "diff -u":

- Solaris 5.6, 5.7, 5.8, 5.9: both of them are un-supported version
  by their vendor
- AIX, only AIX 5.3 doesn't understand "-u",
  the end-of-support AIX 6.1's diff(1) understand "-u" (1)
- HP-UX: From what I can collect, HP-UX still conforms to UNIX-03, and
  its diff(1) doesn't understand "-u"

Hence, if we're going to drop support for system that doesn't
understand "diff -u", we're going to:
- remove support for those variables:
  + GIT_TEST_CMP_USE_COPIED_CONTEXT
  + GIT_TEST_CMP
- drop support for:
  + Solaris 5.{6,7,8,} and AIX 5.3, which will be fine
  + HP-UX: which needs to be discussed

[1]: https://public.dhe.ibm.com/systems/power/docs/aix/61/aixcmds2_pdf.pdf page 133(143)

-- 
Danh
