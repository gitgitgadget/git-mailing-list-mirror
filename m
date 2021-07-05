Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA66DC07E9B
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 15:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7D696196C
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 15:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbhGEPbG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 11:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbhGEPbD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 11:31:03 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D879C061762
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 08:28:26 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id k1-20020a0568200161b029024bef8a628bso4541209ood.7
        for <git@vger.kernel.org>; Mon, 05 Jul 2021 08:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:subject:mime-version
         :content-transfer-encoding;
        bh=X3HkvAY+O4eMw0qP5hmj2gJH+kHCc9yBTrMfg7G+aMg=;
        b=peM/lHrSHMgbAF4LWe359Wy3r/Q9XcZvUXV2Y95H6ZeYN6KDj+BgwDfhbMGnrog41z
         rVVtiCblg0By+LoqFAXTR3pcRO9ZtxfcdKx4lFA3Xjl7DUZyW2k5MDBxOrH+Y+9R8qCy
         lTvugcls4C7VjHNaRNWDPcZ5OKZnafkz2zed/Y8q9cdQN1FmXwPgazXxrPXoIgJeZ4Ax
         YLRWWHUX6q5/EURLzSHqL0jFnmgKLTNs/Ho7MTjD51g3y2rHrMaT6UwBBSHtLMZYXN9f
         AgAHLOJ9NdevfntmTnd7CKbP2/Sawk/8PI0HtaMHlIGWqVZbxfnsJrTHuv8zUoy/HMem
         r1kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:subject:mime-version
         :content-transfer-encoding;
        bh=X3HkvAY+O4eMw0qP5hmj2gJH+kHCc9yBTrMfg7G+aMg=;
        b=tBVcLvUll286O1nbvLxVQ0Gxl/Td/5aG6SlvKghbk1A3orgPz6O23BthTzSd5QIVTW
         APHvrqbFA4phFCenId1XFjB1KTQiPgkPiDh5MwY/Hmn9+8M7R70h8S2ieke4h5qbN31x
         lLNB5LMToMT3XajPta4PJYYbl7hgAtcwlhUdlzTyhzFAh6pjJrwc/ymL47EPWIMNtY+O
         xkblAZgne7TRX9pvBkbsUl+WBLnGVnT+6lVi3IE1Ndb8EtuTiZEDUM/gThlR3yo74+yJ
         9KdPK9Dj6UN+9OrqsPq6KO2eZU4JNbGsrXPMV9+aDHc+1eUCOHRrQ7JbRD/r80bma4mL
         9O1w==
X-Gm-Message-State: AOAM533ZLXko03IkCNMXNNHEfV+YFgN+6xbXWnuvEOkxHYssrmc4C9sN
        5oLrsI+AW0vODNGCOIzWtCoH/zUpaLU=
X-Google-Smtp-Source: ABdhPJyRJOQHky/j9kmC7BsZrLEDOhnFUtx2j3Yq9nHhAGX5458qIg08bBl3Xqa+QgtQp15YZuW9hQ==
X-Received: by 2002:a4a:9c2:: with SMTP id 185mr10341679ooa.93.1625498905248;
        Mon, 05 Jul 2021 08:28:25 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id o26sm2707688oic.12.2021.07.05.08.28.24
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 08:28:24 -0700 (PDT)
Date:   Mon, 05 Jul 2021 10:28:23 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Message-ID: <60e325175e689_1baed32081c@natae.notmuch>
Subject: Blog post: git update: the odyssey for a sensible git pull
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

As I mentioned in my `git update` patch series [1], I spent several days
re-reading old threads looking for anything related to `git pull` and
fast-forward throughout the entire history of the git mailing list.

I documented everything that I found of interest, and the result is a
pretty lengthy article.

Long story short: a new `git update` command fixes all the issues people
have been reporting for almost a decade now.

Even if it's not a particularly interesting read, it's a good reference
that records all the attempts that have been made, along with many ideas
and proposals.

https://felipec.wordpress.com/2021/07/05/git-update/

[1] https://lore.kernel.org/git/20210705123209.1808663-1-felipe.contreras@gmail.com/

-- 
Felipe Contreras
