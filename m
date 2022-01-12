Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D14C433F5
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 18:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356041AbiALSIL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 13:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356013AbiALSH5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 13:07:57 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44012C061748
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 10:07:57 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id f141-20020a1c1f93000000b003497aec3f86so2126657wmf.3
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 10:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GYvg7uphK81AcsqWjOpqtQOfvse9uVnaNdVSOr9lEPk=;
        b=JLX/q8u+2qGz6Et8y6XflrxcK9P16UvOudR1YNhrYagg7GZWbOihr9mBshQYzSOavR
         1BkiRvinjXRWOh/8kdSinT7LFOjhM+vAumjaaZQgr/fbPOgtJr+TK/xVkYjqOt+xyVkh
         QHdmO8EqWgMgXI86YDqetMpvWY0lft1ZsdR8EDHfOY67rCJw3dYfUmPjsUQ5EEl5kO4X
         oDgZGxKJQoZs4zrWGyULNLzZCe2oP27OL4NZGcrJsZ7jpSeOoejTUJ0gFFKFcSEp1pf+
         uby+3e5u7Q9LpDKrZpQ6sWhL41OGTV3gEEpCcZI4eLuTGCb4yhXA2DWhz0hspkAVsM+l
         Z3jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GYvg7uphK81AcsqWjOpqtQOfvse9uVnaNdVSOr9lEPk=;
        b=ULbFnKdt91szTv+FtEPRiC+Z5HDhnqlpRZx/GyHExi3Z/UwFNoR0Hc09DxAnxTN7lS
         Nr76UMGjgD4ZRUJVjVSyK/SyYpihVXlS8QRzUe2VHR9eiWgxmaSLN/bX4kWxpFN38PV7
         QAsVN3IZGCeH/iz9JF3DzSX0OxtnUwxw68Ly5/D64RgeU1LaAkEzHWsEDWFQhfMN1Ebl
         6ijm9ejSjfSmsBCSPtAy4f8Y3gvpqp/HuyDHEONvcd643vgbNzkmLbD4xuHVIVSePnKi
         JOrBimHNebN0tS9Wd7FovVkIPFN2gnJygU7etlpUXCVK1CMKwn/Kgbr24S7SQRpAJ2jt
         p2NA==
X-Gm-Message-State: AOAM532bH26eQpFUaqcuaJqdV0HcdqV4QI7KOAA67geprKJF0DrpuG2w
        0GVfUVtZceoDfdN4qy+dBXREzQVRQzU=
X-Google-Smtp-Source: ABdhPJxtIs+ZOTZEzHcjAoHVKa3jgIVnxNNsygmc37ESrd/lfdFUD0js4C5P+l2lLBEnpj6bcIwKdg==
X-Received: by 2002:a05:600c:34d2:: with SMTP id d18mr594400wmq.71.1642010875714;
        Wed, 12 Jan 2022 10:07:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q206sm493999wme.8.2022.01.12.10.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 10:07:54 -0800 (PST)
Message-Id: <747c9e9a4c8f18c324535ca0ab620d41c1dcc38b.1642010868.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1185.git.git.1642010868.gitgitgadget@gmail.com>
References: <pull.1185.git.git.1642010868.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 12 Jan 2022 18:07:43 +0000
Subject: [PATCH 2/7] reftable: reject 0 object_id_len
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

The spec says 2 <= object_id_len <= 31. We are lenient and allow 1,
but we forbid 0, so we can we can be sure that we never read a
0-length key.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/reader.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/reftable/reader.c b/reftable/reader.c
index 006709a645a..21843f5e935 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -155,6 +155,11 @@ static int parse_footer(struct reftable_reader *r, uint8_t *footer,
 	r->log_offsets.is_present = (first_block_typ == BLOCK_TYPE_LOG ||
 				     r->log_offsets.offset > 0);
 	r->obj_offsets.is_present = r->obj_offsets.offset > 0;
+	if (r->obj_offsets.is_present && !r->object_id_len) {
+		err = REFTABLE_FORMAT_ERROR;
+		goto done;
+	}
+
 	err = 0;
 done:
 	return err;
-- 
gitgitgadget

