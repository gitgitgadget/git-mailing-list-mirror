Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DD0C433EF
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 03:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiCWDtl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 23:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbiCWDtc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 23:49:32 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3894B2ACA
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 20:48:02 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id w4so296846wrg.12
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 20:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LIofy36mS8k/LVED2zflpPYGLAx9o1i0N6UZLh7KWlU=;
        b=NwA/kB5SAa1jWI3QD7E4RvetCK+p2az+AgehaI8oFSQ0xBpd55aO17ElH+TojwmXm/
         Fj+ry7y5+U7venNXFE0gOkkXvDP/JWxc9+EUgCTVVHTTTvwdk3R3JlcXozssuikOJWoy
         fwKZllcQY2meUyUb02MhuzIst9xT68BmSBQhRmtL53yEkN1egm/a4yzTPKhewAINzpCl
         KH7SdbjE5s7nc55SKxeMeKZVyyfsehm6+HcZ3p3BRb9U66Ds/ZOqtRznhw2tkwIh29TA
         dooKzZospRYBh4d/qM5ZEwgaVu3FVlCzTfjKoJDJe2H8xG8TEf28hi59/odAbW+S5MMG
         ttiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LIofy36mS8k/LVED2zflpPYGLAx9o1i0N6UZLh7KWlU=;
        b=h6QrdsiNQTVKHygO4Mf/XN/06m/EOEoTrJvOI8CEcscjS2EkZTN8jFd35B/86w2v3D
         N1uWDvnIJ3CDeui9t7FE3B31sJ3MRV9EzbdqWIPKQc88EgGTOAhgP8U7ijeLpwbmZ2Zt
         KykOaVIrP8vrpsza0erFnoJ0Oz4NNR5+IbsaE/4OA91C8BMefDl32VyM5Db5j4oAWLWo
         WMAFkTS3kLALhdKV3TrgKTExIGV202M1jODBRkVuszW8vR5W47vbu6/BDKJEcZe3OHCo
         qUWclWDa7Y4+fysyrFeSChVyXzplwV5SEC75642BQoINix3NAqK1ZeeqjWKmKLkgHKSC
         wfzA==
X-Gm-Message-State: AOAM531zfKvwSkwSf87gqZkt5M6S2078a2/q9brRfCBQCfsyuE6k1SnO
        zpdszPBfrg9p6rD7nIVfmNS2wY/LUEs=
X-Google-Smtp-Source: ABdhPJy10OEH68YGhLrXP77acKZCgCRZpQqBJeMYmGDk+iwM/fO+4+X7KenHb+QtBzWTF8mxUBza2w==
X-Received: by 2002:a5d:6092:0:b0:203:f860:a84 with SMTP id w18-20020a5d6092000000b00203f8600a84mr18612154wrt.160.1648007279332;
        Tue, 22 Mar 2022 20:47:59 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o16-20020a05600c511000b0038c6d836935sm3028830wms.16.2022.03.22.20.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 20:47:58 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Neeraj Singh <nksingh85@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Patrick Steinhardt <ps@pks.im>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <neerajsi@microsoft.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 0/7] bottom-up ns/batched-fsync & "plugging" in object-file.c
Date:   Wed, 23 Mar 2022 04:47:29 +0100
Message-Id: <RFC-cover-0.7-00000000000-20220323T033928Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1428.g1c1a0152d61
In-Reply-To: <CANQDOde2OG8fVSM1hQE3FBmzWy5FkgQCWAUYhFztB8UGFyJELg@mail.gmail.com>
References: <CANQDOde2OG8fVSM1hQE3FBmzWy5FkgQCWAUYhFztB8UGFyJELg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This RFC series is a continuation of the thread at
https://lore.kernel.org/git/CANQDOde2OG8fVSM1hQE3FBmzWy5FkgQCWAUYhFztB8UGFyJELg@mail.gmail.com/;
More details in individual commit messages.

I'd suggested (upthread of) there pass new object flags down to the
object machinery instead of the {un,}plug_bulk_checkin() API
route. This has advantages described in more details in individual
patches.

This also shows that the not-using tmpdir approach can be
significantly faster than using it, and per my understanding just as
safe fsync-wise for those willing to deal with the caveat of possibly
having truncated *unreachable* objects.

I thought that showing some working code with what I was suggesting
was more productive than continuing the current back & forth :)

Ævar Arnfjörð Bjarmason (7):
  write-or-die.c: remove unused fsync_component() function
  unpack-objects: add skeleton HASH_N_OBJECTS{,_{FIRST,LAST}} flags
  object-file: pass down unpack-objects.c flags for "bulk" checkin
  update-index: use a utility function for stdin consumption
  update-index: pass down an "oflags" argument
  update-index: rename "buf" to "line"
  update-index: make use of HASH_N_OBJECTS{,_{FIRST,LAST}} flags

 builtin/add.c            |  3 --
 builtin/unpack-objects.c | 62 ++++++++++++++------------
 builtin/update-index.c   | 96 ++++++++++++++++++++++++++--------------
 bulk-checkin.c           | 86 -----------------------------------
 bulk-checkin.h           |  6 ---
 cache.h                  |  9 ++--
 object-file.c            | 39 +++++++++++-----
 t/t1050-large.sh         |  3 ++
 write-or-die.c           |  7 ---
 9 files changed, 131 insertions(+), 180 deletions(-)

-- 
2.35.1.1428.g1c1a0152d61

