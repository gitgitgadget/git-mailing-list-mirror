Return-Path: <SRS0=+MKA=Z6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171EAC43603
	for <git@archiver.kernel.org>; Sun,  8 Dec 2019 10:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D045206F4
	for <git@archiver.kernel.org>; Sun,  8 Dec 2019 10:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nadavsinai-com.20150623.gappssmtp.com header.i=@nadavsinai-com.20150623.gappssmtp.com header.b="MVJu0GNn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbfLHKbB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Dec 2019 05:31:01 -0500
Received: from mail-lf1-f42.google.com ([209.85.167.42]:43628 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbfLHKbB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Dec 2019 05:31:01 -0500
Received: by mail-lf1-f42.google.com with SMTP id 9so8465468lfq.10
        for <git@vger.kernel.org>; Sun, 08 Dec 2019 02:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nadavsinai-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=M3L6KxL6i/gbin+k/dS/FwrPK2xEK+FNftxkL4SmtY4=;
        b=MVJu0GNnGHNqCqTrUscWLmOvuykTbV/ub6gUwcij7dhVR/yhhnvtFwxvDdHfCA/ZE7
         3FOK9WQNhciWDUdp9a0A/T2bDG+sEFBeGDA3R7TYqmSpDgkPK42FRsee/azMtfMY+vGn
         aurpYnmN9PwxQd2Ga1TYst/e8lP0GKSVKb702acJ7YuZnD3afz85Eef02879aRv1R+qA
         zJOWFfOFM2a55h6Th+LDO7+bgsLmLnvMQC0Wb2PLqy5KAgp3939AX1BIVM8OeCilb4nq
         vrnQMxmxCR6pyZdZfuUB0SduAetT9x5AORG7b4dX/MYk2IQhAfWfRJ+f0mtKABS9WfnH
         3zRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=M3L6KxL6i/gbin+k/dS/FwrPK2xEK+FNftxkL4SmtY4=;
        b=GAkDPbWhkBu0JFQHuUW2lmxnbdaACzAvisfN1B7bDrFMs+DBO3eCnhnMvEsg5p/CH+
         5onaV9OGgfeZYMoU/DK+udhuwrfgJv+fJSfyai7G5IBqv0nIr82BJUpfphM+GVyXdrf2
         R4vZPt15JSRQK8Erhtndmjh+4vxIivfwvmhiZ2ZgZ9Zn4+LNnT3H7gfqyDIAXDLIANd/
         TZE+P62xFxDOcN/KQIBvtS7CmEP7whZoGRFcSnIxjxh8oagXIbSNFLPOvPDf6ju9Wn1K
         JDcbQi5bND584beDqCvNC9r6Wxt/H87kHwLKxi9GMnTtxO+snynyKII+yil5R2UUGwlr
         ldVA==
X-Gm-Message-State: APjAAAUIzbRPToA9WNZxynKhx4nPELXTsOvxaCTpbuDqPlxyfyToi6IS
        XGKe4RPMTr6rcMXM0+vpv7TfSNpDA4YZg7WMvh7rBQ==
X-Google-Smtp-Source: APXvYqwQ3z7X3UZVgeKJPoT8sBeY816eAL9Ze92DgPPQ29Kvo4nchG5BoWbhtdd7rglsTjCjir8p9ZkPuWcl3iOanFs=
X-Received: by 2002:a19:888:: with SMTP id 130mr12605094lfi.167.1575801059357;
 Sun, 08 Dec 2019 02:30:59 -0800 (PST)
MIME-Version: 1.0
From:   Nadav SInai <ns@nadavsinai.com>
Date:   Sun, 8 Dec 2019 12:30:48 +0200
Message-ID: <CANxxO2MGJ2Wo6Y-33KzzPXz6vktRACk0Oi2Y6o_s-cDFRhG7+Q@mail.gmail.com>
Subject: RE: Regression in git-subtree.sh, introduced in 2.20.1, after 315a84f9aa0e2e629b0680068646b0032518ebed
To:     roger.strain@swri.org
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        marc@msys.ch, pclouds@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, I'm curious if any of you had any luck in preventing that
seg-fault in git-subtree script
I'm encountering it myself using git 2.24.0.windows.2., seg-fault is
in the same while loop (currently on line 757)
When I tried your suggestion of adding the ($parents) ($rev) to the
progress print I see that the last commit have only one revision
printed
like this:

259/290 (523) [271] (843dd34090d36dfabd6a2e3e8459a4887427313b)
(a69ee056f66acf66c63f89f55d26c0cc17036623)
259/290 (525) [273] (f5eea1a3cbe1e16acba53e8a9fe07b6525a8b97c)
(843dd34090d36dfabd6a2e3e8459a4887427313b)
259/290 (527) [275] (82303752a428cf1d789ac9f156008adb2798b7b5)
(f5eea1a3cbe1e16acba53e8a9fe07b6525a8b97c)
259/290 (528) [276]
(7187897883c9fb4d33d4c87a02b876f8603728ff05f0945ae2ce9f98a35135)
259/290 (529) [277]
(a00a3665343439a426671958dd90ed0407a22cad9ac9f156008adb2798b7b5)
259/290 (530) [278]
(90beb94ebd331c457d79d05341453f5829a50bfcd4c87a02b876f8603728ff)
259/290 (531) [279]
(9582e0acbed1910173564e250f350b5cc4291a7f671958dd90ed0407a22cad)
259/290 (532) [280]
(f183930d6fabd3dccdddc5ec35d754ad28caf3b879d05341453f5829a50bfc)
259/290 (533) [281]
(c9309f3a38c41f7991d9e78ddb47f7e85b8521eb564e250f350b5cc4291a7f)
259/290 (534) [282]
(3bcf08f63a0e2b93ecc376bd679a16c80e99e7b1ddc5ec35d754ad28caf3b8)
259/290 (535) [283]
(134621bb55a0470cdf6519ce08d6909af43ce0e5d9e78ddb47f7e85b8521eb)
259/290 (536) [284]
(edb3471fbba29748f9784d29b3cee1dee2df4b37c376bd679a16c80e99e7b1)
259/290 (537) [285]
(dd947a095df07a32dfd56666a395a7c42b25ca116519ce08d6909af43ce0e5)
259/290 (538) [286]
(a639e09d2cbe1ea1149c080c1c95b8b018340ae2784d29b3cee1dee2df4b37)
C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line 757:
8853 Done                    eval "$grl"
      8854 Segmentation fault      (core dumped) | while read rev parents; do
    process_split_commit "$rev" "$parents" 0;
done

I downgraded git to 2.19.0-windows.1 and it works now.


I'm thankful for your insights
Nadav Sinai
Web Tech lead
Philips-Algotec
