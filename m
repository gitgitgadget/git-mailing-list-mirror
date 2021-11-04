Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5FAC433F5
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 09:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7D42610E7
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 09:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhKDJsj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 05:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbhKDJsi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Nov 2021 05:48:38 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07443C061714
        for <git@vger.kernel.org>; Thu,  4 Nov 2021 02:46:01 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id r4so18692116edi.5
        for <git@vger.kernel.org>; Thu, 04 Nov 2021 02:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=l/LzQpHV4m51MPZSWtLQ0T2oqMFHer7iK/bQCUn2YqI=;
        b=MdKliKBqnJmiA552tzEgncg2FVMRjTsqIvWa0GbUsJolqcGftyXBBXdT2fUZ4UoHZO
         oBDwEKFXUEdpod16WGa8JnyRFrJOsTUbax+FBwu3pwb4wCGjwV/E3NUtHEElFq+M7kt/
         3wl7yBMpyWPEFas8ODrzxjclnIgeO+foDmW9sfuXAcTMCAy5ya53A8tfSqnfcdho5pJ6
         n1Jg8gpNRe96p6MOFJTIAbgRb836vsBeG1yNU+poUc29Gr0T/d9HcXgmb1wQxkVWgX2t
         Y9hofc7bFS4yeOuJ/5ONXkSLyunpFWwX76g0gEzWLIrmfzu6dSYOU2xoqo8QSdxKSA3s
         tHCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=l/LzQpHV4m51MPZSWtLQ0T2oqMFHer7iK/bQCUn2YqI=;
        b=IGlWd8qw0K3pCDOod/Y65Aah6mDzR1A6BnhHqrSzXxvlLHHgwk3FFwL3RRRzFI07pl
         szwaXR7AN+03i2M1owci/+N+zxXeeGhZhwwVgpRcBiuKfdAsxIyoD+p2q6IQtdm7V1M+
         oG0tBPR+8y2i6v3LYRQdZnik3GXk7LYCcs04ZD7LJMNrh8pvU5svEp2A1fzpxDnJtGNJ
         vsOLZz2+sG/R6V41GVMRvgBrTVEWLM5Cc6ojQsakPnoxsos1x9KL4WxGHhA6PIA+pDMf
         umNA1YaNjJaNPc2oMAqA1KoTd6tFrLdfUJtxqARI0hKaTDTeeg2eytasgePE4fG3qruL
         x3QA==
X-Gm-Message-State: AOAM533YbSefcYjlojyr8E7IhwnEdAJ6jlqw9eWjnxV/kGKGZLTx3cWp
        9BrXMJxybANDHtqlVGN+PTpyHaA/+dTpzg==
X-Google-Smtp-Source: ABdhPJyUltvzXcFavIgmUhmUFx08NT3bv0MPal3Hxe+pfRSvkfH/rqK9hIHM4DGI3msOJSwSZcbx+A==
X-Received: by 2002:a17:906:730c:: with SMTP id di12mr59133660ejc.184.1636019158449;
        Thu, 04 Nov 2021 02:45:58 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id m1sm2348387ejn.121.2021.11.04.02.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 02:45:58 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1miZJk-0006kH-K6;
        Thu, 04 Nov 2021 10:45:56 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, philipoakley@iee.email,
        eschwartz@archlinux.org, Carlo Arenas <carenas@gmail.com>,
        Jeff King <peff@peff.net>, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v2] async_die_is_recursing: work around GCC v11.x issue
 on Fedora
Date:   Thu, 04 Nov 2021 10:42:13 +0100
References: <pull.1072.git.1635990465854.gitgitgadget@gmail.com>
 <pull.1072.v2.git.1635998463474.gitgitgadget@gmail.com>
 <xmqqzgqk2zsl.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <xmqqzgqk2zsl.fsf@gitster.g>
Message-ID: <211104.86v918i78r.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 03 2021, Junio C Hamano wrote:

> "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Victoria Dye <vdye@github.com>
>>
>> This fix corrects an issue found in the `dockerized(pedantic, fedora)` CI
>> build, first appearing after the introduction of a new version of the Fedora
>> docker image version. This image includes a version of `glibc` with the
>> attribute `__attr_access_none` added to `pthread_setspecific` [1], the
>> implementation of which only exists for GCC 11.X - the version included in
>> the Fedora image. The attribute requires that the pointer provided in the
>> second argument of `pthread_getspecific` must, if not NULL, be a pointer to
>> a valid object. In the usage in `async_die_is_recursing`, `(void *)1` is not
>> valid, causing the error.
>>
>> This fix imitates a workaround added in SELinux [2] by using the pointer to
>> the static `async_die_counter` itself as the second argument to
>> `pthread_setspecific`. This guaranteed non-NULL, valid pointer matches the
>> intent of the current usage while not triggering the build error.
>>
>> [1] https://sourceware.org/git/?p=glibc.git;a=commitdiff;h=a1561c3bbe8
>> [2] https://lore.kernel.org/all/20211021140519.6593-1-cgzones@googlemail.com/
>>
>> Co-authored-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> Signed-off-by: Victoria Dye <vdye@github.com>
>> ---
>
> Looks like they timed their update to disrupt us most effectively,
> but we are gifted with watchful eyes and competent hands ;-).
>
> Thanks for coming up with a clearly written description and a clean
> fix so quickly.
>
> Will apply.

I don't know what this would be for the "fedora" and other images, but
it seems to me like the below is something we should do. This replaces
"latest" with whatever "latest" currently maps onto.

I.e. I don't think it's a good thing that the carpet gets swept from
under you as far as these CI images go. We could subscribe to some feed
of when these images are bumped to see when to update, but having our
base change from under us just leads to a waste of time for a bunch of
people wondering why their CI is failing, which now they'll need to
rebase on some on-list or only-in-upstream-master patch to have it
"pass".

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 6ed6a9e8076..6b7dab01269 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -7,7 +7,7 @@ env:
 
 jobs:
   ci-config:
-    runs-on: ubuntu-latest
+    runs-on: ubuntu-20.04
     outputs:
       enabled: ${{ steps.check-ref.outputs.enabled }}${{ steps.skip-if-redundant.outputs.enabled }}
     steps:
@@ -79,7 +79,7 @@ jobs:
   windows-build:
     needs: ci-config
     if: needs.ci-config.outputs.enabled == 'yes'
-    runs-on: windows-latest
+    runs-on: windows-2019
     steps:
     - uses: actions/checkout@v2
     - uses: git-for-windows/setup-git-for-windows-sdk@v1
@@ -97,7 +97,7 @@ jobs:
         name: windows-artifacts
         path: artifacts
   windows-test:
-    runs-on: windows-latest
+    runs-on: windows-2019
     needs: [windows-build]
     strategy:
       fail-fast: false
@@ -132,7 +132,7 @@ jobs:
     env:
       NO_PERL: 1
       GIT_CONFIG_PARAMETERS: "'user.name=CI' 'user.email=ci@git'"
-    runs-on: windows-latest
+    runs-on: windows-2019
     steps:
     - uses: actions/checkout@v2
     - uses: git-for-windows/setup-git-for-windows-sdk@v1
@@ -178,7 +178,7 @@ jobs:
         name: vs-artifacts
         path: artifacts
   vs-test:
-    runs-on: windows-latest
+    runs-on: windows-2019
     needs: vs-build
     strategy:
       fail-fast: false
@@ -218,22 +218,22 @@ jobs:
         vector:
           - jobname: linux-clang
             cc: clang
-            pool: ubuntu-latest
+            pool: ubuntu-20.04
           - jobname: linux-gcc
             cc: gcc
-            pool: ubuntu-latest
+            pool: ubuntu-20.04
           - jobname: osx-clang
             cc: clang
-            pool: macos-latest
+            pool: macos-10.15
           - jobname: osx-gcc
             cc: gcc
-            pool: macos-latest
+            pool: macos-10.15
           - jobname: linux-gcc-default
             cc: gcc
-            pool: ubuntu-latest
+            pool: ubuntu-20.04
           - jobname: linux-leaks
             cc: gcc
-            pool: ubuntu-latest
+            pool: ubuntu-20.04
     env:
       CC: ${{matrix.vector.cc}}
       jobname: ${{matrix.vector.jobname}}
@@ -265,7 +265,7 @@ jobs:
           image: fedora
     env:
       jobname: ${{matrix.vector.jobname}}
-    runs-on: ubuntu-latest
+    runs-on: ubuntu-20.04
     container: ${{matrix.vector.image}}
     steps:
     - uses: actions/checkout@v1
@@ -314,7 +314,7 @@ jobs:
     if: needs.ci-config.outputs.enabled == 'yes'
     env:
       jobname: Documentation
-    runs-on: ubuntu-latest
+    runs-on: ubuntu-20.04
     steps:
     - uses: actions/checkout@v2
     - run: ci/install-dependencies.sh
