Return-Path: <SRS0=o5qA=2U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84451C2D0C3
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 20:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C00F206DB
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 20:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tjp7Zx9y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbfL3Uaf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Dec 2019 15:30:35 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42514 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727695AbfL3Uaf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Dec 2019 15:30:35 -0500
Received: by mail-lj1-f195.google.com with SMTP id y4so20127871ljj.9
        for <git@vger.kernel.org>; Mon, 30 Dec 2019 12:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=rcH4z7vKiaOT6KK0zD5EzWDa5vQUYo4id4xm7vOSD3Y=;
        b=tjp7Zx9yrj3bH7/0vjDUqA56ekFZt5QWFPE2fCux3LG3eMILMBEmgeedsVzXfceB69
         8fc5AOr+GPVuZwLBwElGYN/Ai9hnngS8zVAdi81p/zgOD95NTFrwHcWpygA6pbrxS1CK
         GOe7PayTal2qga/0NMpfgVC7+4YZS2hEbolmYZODlUXXbz1PaAVAMXdeDzrlYPiG/Gmp
         nZRBJEW3RmlRDYVECQhP7H+NebNsyg59s0cSWiM+UH4kEMnpuJPqWnLdKp/5to0oXvtf
         o479lBYnaGXd1H3ie2DkcnTJsEfJ3h/MaEUlycNUDK/01WF19teBen2bo2nbT5I+sNIa
         B/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=rcH4z7vKiaOT6KK0zD5EzWDa5vQUYo4id4xm7vOSD3Y=;
        b=gKDxvt12Y5P3FWEfY/2r5DxXv/jaE3UC7ZUFuKLRZCqMZvI6oZDs9Jj8Y6VaFsGZCU
         BexkaxkpaZYlBDcz3LqBjv4Chddwjc+w2kUtS+gwdo/6kgk+xDlvmFHHXTmB0NFKmf0h
         5Pz5FfBBntsZLyza4+9a1ik+s9GoH9NRcAWgOGg2TRJsB0g9ZBQ3Xi+PTHvc+6Yn1cau
         VzTpBGKqoE38WTPAXZGxgQ30fOcgQk7yr+g52mPGXSACdIlXMSFg3BI+tXp0mdb/a8ra
         +lG788NHfNGYguqrEbtEPVtlHGW+r3PsQVkjm0UHW3hcjKf52M+dR0rOy+4XG+Dz9P4F
         +mTw==
X-Gm-Message-State: APjAAAXoePH2SgXCR1ftTpe7ESedbvG9TL69Z3nOIST3wMVj6qU2YIJv
        z8eKmrNy7jrR3DgDMSCNzLy+WDgjFc0=
X-Google-Smtp-Source: APXvYqx1cjDYYpkIofCOpOE4rKmJB66/vW3DAdpTlDp2D3E4HwKfIyg+9J3SYmYGLl6YDju6bic21w==
X-Received: by 2002:a2e:5304:: with SMTP id h4mr41187016ljb.75.1577737833192;
        Mon, 30 Dec 2019 12:30:33 -0800 (PST)
Received: from Laptop-Acer-Aspire-F15 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id z11sm15463676ljc.97.2019.12.30.12.30.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Dec 2019 12:30:32 -0800 (PST)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 03/16] t2018: use test_must_fail for failing git commands
References: <cover.1577454401.git.liu.denton@gmail.com>
        <c584c9a52b492db2128846e86afb0aadddd6f2de.1577454401.git.liu.denton@gmail.com>
Date:   Mon, 30 Dec 2019 21:30:30 +0100
In-Reply-To: <c584c9a52b492db2128846e86afb0aadddd6f2de.1577454401.git.liu.denton@gmail.com>
        (Denton Liu's message of "Fri, 27 Dec 2019 08:47:12 -0500")
Message-ID: <86lfqt36ah.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> While we're at it, remove redirections to /dev/null since output is
> silenced when running without `-v` and debugging output is useful with
> `-v`, remove redirections to /dev/null as it is not useful.
     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Very minor nit: The underlined part (after last comma) duplicates what
already has been said.

--=20
Jakub Nar=C4=99bski
