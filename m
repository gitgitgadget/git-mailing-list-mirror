Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B08DE202A0
	for <e@80x24.org>; Sun, 19 Nov 2017 14:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753030AbdKSO4D (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Nov 2017 09:56:03 -0500
Received: from mail-wr0-f170.google.com ([209.85.128.170]:45238 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752519AbdKSO4C (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Nov 2017 09:56:02 -0500
Received: by mail-wr0-f170.google.com with SMTP id a63so5874336wrc.12
        for <git@vger.kernel.org>; Sun, 19 Nov 2017 06:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=pVojwOCxhTfH2RDtR3/NjIzIsfWjBnxOrnLeJOJW01s=;
        b=PBIkRERjU5t0czpJRk+ZGwS4ehVFSxdz16hs1/APqLe8TrVvCKUMNZ2s2tDP4Eb9UI
         a5U+8LS2cH8Oh0zoI57ygxQI/wRRa4KIfOGfgdwC4N1IDRtMbIQsXEbWmLZiNjuyhUXk
         t9yeSINIl4Cgdmnnb7rnx65Cg7ceBFhRtqJugwu6kz1G4/jsf4ahzWd6hS5ovc4GctwS
         Uc+PCJIJgczzO/VxxWaz2rpR35ULP8CRyRa8DoYsgZda5oHXPDw6LuBM+x8arQRDp1Z+
         GNA91Ht+dH4G8ZnpYiYZ2/um4px3bfh5DYe0vD9QM5JjimzrKa0sfZUh4yDUDVyeuoG2
         tgYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=pVojwOCxhTfH2RDtR3/NjIzIsfWjBnxOrnLeJOJW01s=;
        b=giqP012GN28vPUDIlJ71pVA1cVnlMJSruGHdAaJO1sDqmwRANra2sF5hXUAK9TWFQU
         6NFBzXucGC8IQ51LuzZy6fl7sgj2TwVgkSYmxiwAzqMjdKB8HrvIoLUkOE/UPHWFvHv1
         C/86FPdCnWKQ8WuqKQ7c5UMa+r6YDNptebIj+vOBCrNERQnNtWnBknmors3Ix7MfXjeb
         9LGixYjzdqXzaqHp4B+5liF9dudIRO1L1fZWENDsDQcPOIg25BakHhvwVyMJS7qLvSRu
         4kuDlNIHyHNZmogLVDjoRVeGGBPezLgHNY4b9bUWEhoFb1aGuOqcGljq3FCVzWUqiOdc
         zArw==
X-Gm-Message-State: AJaThX5uF8nMaDh3EftmLtiHRo9/iw4LFadisbLnZ+nAoc6obqjgULpK
        EINbYLwGuACmt7j3DGkOWgBy7CjNNGYuLgvop1KAnQ==
X-Google-Smtp-Source: AGs4zMYFU4Ao7vPjq+5jr9ShzpFT9MGpymQ7ovBo/CQLxguIxjkS2zp4zyTcnk7vlf8I+wsjX5YJbAzkn7R7h30eR5k=
X-Received: by 10.223.128.170 with SMTP id 39mr8935848wrl.236.1511103360586;
 Sun, 19 Nov 2017 06:56:00 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.201.3 with HTTP; Sun, 19 Nov 2017 06:55:40 -0800 (PST)
From:   Ilya Kantor <iliakan@gmail.com>
Date:   Sun, 19 Nov 2017 17:55:40 +0300
Message-ID: <CAFU8umg-utVnUZadvkp-6pA7Oj+-z2pBdfUR64BnyBnprVzoyw@mail.gmail.com>
Subject: Why gc --auto is called so rarely?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I tried to find places where git gc --auto is called, and found that
there's only a few.

First, in *some* merges. That is, if there was a conflict during the
merge, that is resolved, then it's not called.

Then in
* receive-pack
* fetch
* am

Is there any logic in such assignments? Why there?

In particular, gc --auto was called in commits earlier, but not in the
recent versions of git.

---
Best Regards,
Ilya Kantor
