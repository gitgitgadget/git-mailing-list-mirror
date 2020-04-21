Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A51F2C54FCC
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 13:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81DE120775
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 13:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9kfGJnZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbgDUNMd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 09:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726018AbgDUNMc (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 21 Apr 2020 09:12:32 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D739BC061A10
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 06:12:32 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id t11so6745220pgg.2
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 06:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QsnCnjLS8eQURncea4tgKI6ED2XRjRS6coNC79gbTZ4=;
        b=W9kfGJnZSeDvLImnCTVg9tntKlGWqR0FG4LQ0cYcE1GPXNk8TEk3VevGtgsae3HFXX
         fekV0KWv1Zto7vpYB06TzSv9NLQcszJZwK4M9Ds7KwT8fJyxVfNW7Pgh4pp5UkvGyaNW
         JnmviDBNl++n3BmqlAMN9y5sBzbA1oWx9ohntWXZNT1JTDgHnv6NGjfJuC28arccmcC2
         o3tVeho3SInrzZK7CSvnWyANDY7UCZsjNssz1ZTOtzL3rNk3d8ZiFbTRWyK2ibngMUbT
         BLM9F410EALtEsvH4JBF4wG+57I1XbccKYhfQHhO+EeO/768ShFaUW9eslFL6OWOunnY
         5+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QsnCnjLS8eQURncea4tgKI6ED2XRjRS6coNC79gbTZ4=;
        b=BMJUi+S88b6LjjmQi+qLDqD0Bkdu2G6bgT6/9OHX2fv0p8x3QuJBLJyqgOwPYHTlon
         LXLfzR41y+63pzWRK76/QdtzBPJf4KynEs2xOHtHPUhDrcc25N2VqR0/kba2LV8woIvw
         d0k5FNTfsyaVGov1FTsNXOkwTexjndy5b6aubM0pI6CIrb5Gpu2A2dthti6smoc3QZR2
         fSvdiQ8DS1VqYJlb8lNU284GdRicelmPEvZjI5PkXo/y8i8lmCKCtHZIgo7WeFou4kpV
         R8eDPC4Oi2U8Gop7PoCIaWRh89Y7tONWyz44U4LiexnS4M4YCV2JMPBkrrPksVvJNqQA
         Q6rw==
X-Gm-Message-State: AGi0PubshbB7eeRLTeTYPXBLT2+SwqVdcOMmpzG6v4dVp6fhHPOfOy56
        HKQCHA8QHzF4ocniTlzA2H4FF14IOIs=
X-Google-Smtp-Source: APiQypLinWjGtfgga/mfOyWpX2XeTPR/BiyVw8pjn05vfw2DjwuKchAawipW3G3nvcR9OxNhWWwrBw==
X-Received: by 2002:a63:5112:: with SMTP id f18mr2857835pgb.356.1587474751860;
        Tue, 21 Apr 2020 06:12:31 -0700 (PDT)
Received: from konoha.iitr.ac.in ([103.37.201.175])
        by smtp.gmail.com with ESMTPSA id g2sm2451492pjd.9.2020.04.21.06.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 06:12:31 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [PATCH v3 0/4] gitfaq: add issues in the 'Common Issues' section
Date:   Tue, 21 Apr 2020 18:42:19 +0530
Message-Id: <20200421131223.29337-1-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the third version of addition of issues in the 'Common Issues' section.
In this version I have:
	1. Changed column wrapping from 90 col. to ~70 col.
	2. Removed the issues: 'rebasing-and-merging' & 'checking-out'
	3. Added issue: 'shallow-cloning'
	4. Separated the issues in individual commits.
	5. Corrected spelling and grammatical mistakes.

I decided to drop the issues mentioned in (2) because of the lack of clarity
in them. As Junio advised, it would be better to improve their respective
documentations rather than adding them in the FAQ.

I really appreciate Junio and Brian for reviewing my patch in such great detail :)

Regards,
Shourya Shukla

Shourya Shukla (4):
  gitfaq: files in .gitignore are tracked
  gitfaq: changing the remote of a repository
  gitfaq: shallow cloning a repository
  gitfaq: fetching and pulling a repository

 Documentation/gitfaq.txt | 86 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

-- 
2.20.1

