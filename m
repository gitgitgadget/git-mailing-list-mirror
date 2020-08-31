Return-Path: <SRS0=A5vO=CJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D127C433E6
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 04:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 784F020738
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 04:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVuMBfbT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbgHaE40 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Aug 2020 00:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgHaE4Z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Aug 2020 00:56:25 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392AEC061573
        for <git@vger.kernel.org>; Sun, 30 Aug 2020 21:56:23 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id s13so4118235wmh.4
        for <git@vger.kernel.org>; Sun, 30 Aug 2020 21:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=6xY2Mmy3LZhUL6VaZyiubG8ZoGUQYuqzORky6UZ85bc=;
        b=XVuMBfbTmkthVYwVB7bFbG0RMw4z+5cQhNyasTtD5F6KyshyPK4ItzdSKiu0ysFA3E
         kjSAKye1yia0tQ8yQWt35myg1ALBrAtRnB0wkPE42cn+XeTk4fwgKkYV7ob89wgfqP4Q
         ULJ/2tJ96VZ32WQRr1i43yc8YlVOQz0FrPTDfNPr3gBuX9wex4ZT4JlnTa2Ju5EeKkdf
         3Vjx66eappF8o/uCjlrwt9lOjSEO0AYvITNTJ6fZF/rFmTVmWpvgCoWUJJF0k/3Svyz5
         wdjsNJhdzudIcLvjLiUA6AWKxk5HmxJmMJ6b2lAJDIoR9KBDZdFIemkGX2+4zdvbJVj3
         vgJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=6xY2Mmy3LZhUL6VaZyiubG8ZoGUQYuqzORky6UZ85bc=;
        b=aajMPAhhhHkz4B2jLs0zqhvLxgUdWImFf69lZNjGk006FEavaziUdvjlBvoeDt59Q9
         5298AsehClqaFNhZD3ZtGAkFo74zLxh/xq5oli2wQ0HS+SIOqg2NtVIemUqcL6q6mCqW
         zgfi3bf4PDji7aCaEAT3q4OCv3+KBHmE43SVBGqse6oyxXk7tTOjc9YzTt98TWP9Ovhy
         ppxBGSY/DbLb5uMNYnQE5OtPn64ccw1fWdMzUpbxBIl5QjiRDSFR20yGvU3SIouJhaOq
         9jbZI+7zsqA0TR7qQgIWV7aF2ruwb2Uc3Fx+0Xyb4PEM5KG7kPLAYUi9PJrZ/vmAv4BS
         YOCw==
X-Gm-Message-State: AOAM530DBHN7MJxc5KUKX0f8ebZ6sJup23Ze4sMMMLDORopPGdCxiSeE
        7HmF1GLX5EIdQ4CddqkXJem58GPo9nc=
X-Google-Smtp-Source: ABdhPJwLuptfcI8+Ihx8dXHDbjh7h2/09zxygQ7SuJPHmnkc1ZWrKKRHMX0NcxeHYw9cuTXS/JLBAQ==
X-Received: by 2002:a1c:f204:: with SMTP id s4mr9817256wmc.9.1598849781572;
        Sun, 30 Aug 2020 21:56:21 -0700 (PDT)
Received: from debian1 (88-144-199-94.host.pobb.as13285.net. [88.144.199.94])
        by smtp.gmail.com with ESMTPSA id 70sm10387581wme.15.2020.08.30.21.56.20
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2020 21:56:21 -0700 (PDT)
Message-ID: <2c70fba16d78eee09ea4f1107502b41370a79ada.camel@gmail.com>
Subject: [gitk] broken search box text cutting
From:   Lyndon Brown <jnqnfe@gmail.com>
To:     git@vger.kernel.org
Date:   Mon, 31 Aug 2020 05:56:20 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

If I cut some text in the gitk search boxes, a U+0018 character is
placed into it in place of the cut text, and the text is not actually
placed into the clipboard.

I'm a Debian Linux user, running version 1:2.28.0-1.

