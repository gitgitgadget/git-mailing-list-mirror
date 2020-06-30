Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85AABC433DF
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 11:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C61320759
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 11:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoom.us header.i=@zoom.us header.b="Iy8/6+Wq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733025AbgF3Lh7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 07:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731518AbgF3Lh6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jun 2020 07:37:58 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB84C061755
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 04:37:58 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id g13so15245940qtv.8
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 04:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zoom.us; s=google;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=GnRHlNZ/HwugrSBGK5JsnRSWOAAtnQ+lSKsqkPJaLXk=;
        b=Iy8/6+WqW4oyvXXfw4bOo/x79/dI871n/MAPYR+sgKCW6gy3anOpny847Gj3vmPb+6
         VfZrVhXAPTrG2SRVP8uzCqC9OVwaEYHPvO3JG3nfEiSFNsIy5rxgjdzu4RR7rOSpZEmx
         Qjp4cy3uO2SlqilQTj8kqg5/nX9ks1e3IDvK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=GnRHlNZ/HwugrSBGK5JsnRSWOAAtnQ+lSKsqkPJaLXk=;
        b=f2IbW0bkNCxdsQ+3zYMjhha5rR7g1EmYfIeBQyaR1882LyzsUS9/V6+l1Y3zzysXUS
         F1FyLEytMZodeVqOc/leUTeWGdEuPLBUdEc3pyNgGwg5q/9KEAYvZFPXciY12RO7FSGU
         86PbMj9R7T6xHgr43RQpfko3x8XuGOkpVc0qd+NjSryuvrKfKVjwVaMBRnObEqJK091F
         Xs17CyEl01sUguiMnw8q2f2LKDzYJIeidZbzvJ0RuMZU3bwc8oDyJz/Knn4GAR+/BAFW
         n5eyYrlLaPKCkDMpd1dlVaSzqFHE+TK6+MeieHARVINAcivwdcqreQ/+HhxzLi+9fcmD
         Ap+Q==
X-Gm-Message-State: AOAM530nWZR1LQD0dF8KXg9YpSs0rgoAaNOCZu6VzY9KFdRr73cdPPHn
        mqnxMmbf8+sqVlhVd5pacu1jeA==
X-Google-Smtp-Source: ABdhPJxOZ5mjbgAoK9NoR/dWUBbtqh+t+LxpaASW3Wob/H9p9R5iMlElAJddiM5uY2CFRrKWfYwsRw==
X-Received: by 2002:ac8:7a90:: with SMTP id x16mr20199198qtr.233.1593517077847;
        Tue, 30 Jun 2020 04:37:57 -0700 (PDT)
Received: from DESKTOPLINSUN ([38.99.100.2])
        by smtp.gmail.com with ESMTPSA id u1sm2618802qkf.49.2020.06.30.04.37.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jun 2020 04:37:57 -0700 (PDT)
From:   <lin.sun@zoom.us>
To:     "'David Aguilar'" <davvid@gmail.com>,
        "'Junio C Hamano'" <gitster@pobox.com>
Cc:     "'sunlin via GitGitGadget'" <gitgitgadget@gmail.com>,
        <git@vger.kernel.org>, "'sunlin'" <sunlin7@yahoo.com>
References: <pull.781.v2.git.git.1591672753363.gitgitgadget@gmail.com> <pull.781.v3.git.git.1593414441313.gitgitgadget@gmail.com> <xmqqeepxfmdm.fsf@gitster.c.googlers.com> <20200630074204.GA2144485@gmail.com>
In-Reply-To: <20200630074204.GA2144485@gmail.com>
Subject: [PATCH v3] Enable auto-merge for meld to follow the vim-diff beharior
Date:   Tue, 30 Jun 2020 19:37:51 +0800
Message-ID: <f78601d64ed2$e5c54de0$b14fe9a0$@zoom.us>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHRJ5MuIWMkBHXT+uLjlpK0dGJPAAHpZEAUAj9VN80CNchbFajIYZWQ
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The last change also available in https://github.com/git/git/pull/781/files.

