Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B21C77B73
	for <git@archiver.kernel.org>; Mon,  1 May 2023 14:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbjEAOjW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 10:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbjEAOjU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 10:39:20 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545CD10E3
        for <git@vger.kernel.org>; Mon,  1 May 2023 07:38:56 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-74de7635180so248678185a.3
        for <git@vger.kernel.org>; Mon, 01 May 2023 07:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682951934; x=1685543934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=69XN+ySDC7Lib4uR4MzUGjnvyENiLHwVBKs99d1Vo6Q=;
        b=hhILzznzVn+jVy7wDvGW+eOyadCzk9cjno45gjI8VTw+BsZpzTd7IaT+VvOF0qRJBb
         wdHbr2niyPc4chp6lEMYb45qeDEKXj6q8EwM0hjYmUkYI04zfk9lFXfHUyGYNVopLRNh
         WRdGcsgc73X5eIWcCDmd/jRuxGP4FP1xDbe6wteWHBTILyqI6Rv6xew77biSkzxsryR5
         LdFClMxdfolllvv/VXS0BAET/xFkIAEJrLRWuRyfmp1EsPzqM/DdkfJ195xzukM7uuGD
         v24rXv/j+9FN9I+UxgcCLjDwotA/k5U+Ja3NDdZNB+P0XzUuQ+0L0ZSb1vFDwiW0dHRy
         HM6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682951934; x=1685543934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=69XN+ySDC7Lib4uR4MzUGjnvyENiLHwVBKs99d1Vo6Q=;
        b=Avn77+VixJJ9XW6J0iHqxQ1za0ELClYuT5BMtYS8SfsxHtEs1O8Kx+Jqw97clW7cp1
         QZY7XEP5kNGkSzAchEdyZPZYPhDz8N9ZlDKnZ/N7wqlYcHUI2eu7FlAfeKDsAAn1UEk2
         PDoKAHNyiyiwnBDuwMYOrQisD4f9X1NU/YXsVRTh+aD9IqvPVvvM2YuSuciQ6Kiyu8S8
         Nwu3vmO3u7YJHDgw/nhPlnaZYfE/c3YEiEEFHdCKJseVssERSDc12WmKJtpe3qk7ou+a
         v5rSb/EO7nnWu+4JNHDqAwiG+MaYJ15FaW/dH0B3J2lzLOthc2/CCDVQ3PR8Su2CNP3m
         9C6w==
X-Gm-Message-State: AC+VfDxYAxlFa9oexq+1DiTZ0M8jg4cAb3TaVkH61Nzg3Xzs9UC9iYQa
        MVGrsztjN3yqBAyOccp8dBlGJUwroVnrhw==
X-Google-Smtp-Source: ACHHUZ6gaZLUQfxCqCGwynWzQ7Ok0nz0cZnwoTjqyKiKR3OiIZF9ORpFox9TwhYc2op+oc3Ic2h/Sw==
X-Received: by 2002:a05:6214:21aa:b0:616:5c8b:582 with SMTP id t10-20020a05621421aa00b006165c8b0582mr18723qvc.37.1682951933999;
        Mon, 01 May 2023 07:38:53 -0700 (PDT)
Received: from localhost.localdomain (dsl-157-118.b2b2c.ca. [66.158.157.118])
        by smtp.gmail.com with ESMTPSA id i10-20020a0cedca000000b005ef493c6bebsm8687211qvr.77.2023.05.01.07.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 07:38:53 -0700 (PDT)
From:   Maxim Cournoyer <maxim.cournoyer@gmail.com>
To:     git@vger.kernel.org
Cc:     Maxim Cournoyer <maxim.cournoyer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 0/3] send-email: add --header-cmd option
Date:   Mon,  1 May 2023 10:38:45 -0400
Message-Id: <20230501143848.19674-1-maxim.cournoyer@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <xmqqcz3s3oz7.fsf@gitster.g>
References: <xmqqcz3s3oz7.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

This v4 drops the copyright hunk as suggested by Eric, and adds a
 --no-header-cmd as suggested by Junio.

Thanks you!

Maxim Cournoyer (3):
  send-email: extract execute_cmd from recipients_cmd
  send-email: add --header-cmd, --no-header-cmd options
  send-email: detect empty blank lines in command output

 Documentation/config/sendemail.txt |  1 +
 Documentation/git-send-email.txt   | 11 ++++
 git-send-email.perl                | 87 +++++++++++++++++++++++-------
 t/t9001-send-email.sh              | 71 +++++++++++++++++++++++-
 4 files changed, 150 insertions(+), 20 deletions(-)

Diff-intervalle contre v3 :
-:  ---------- > 1:  4bc38e69bd send-email: extract execute_cmd from recipients_cmd
-:  ---------- > 2:  60606e8d21 send-email: add --header-cmd, --no-header-cmd options.
-:  ---------- > 3:  2ed6a3f965 send-email: detect empty blank lines in command output

base-commit: 48d89b51b3bb8a60580c36731b96a7206ce1e5b9
-- 
2.39.2

