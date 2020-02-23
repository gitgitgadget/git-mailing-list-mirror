Return-Path: <SRS0=MMY4=4L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB70C35671
	for <git@archiver.kernel.org>; Sun, 23 Feb 2020 10:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A767208C4
	for <git@archiver.kernel.org>; Sun, 23 Feb 2020 10:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehchAp1a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgBWKPF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Feb 2020 05:15:05 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:38821 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgBWKPF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Feb 2020 05:15:05 -0500
Received: by mail-yb1-f193.google.com with SMTP id x9so1107110ybl.5
        for <git@vger.kernel.org>; Sun, 23 Feb 2020 02:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VAQnohus/cXSDuEQVZFVApCOPwMOcQs2UxFCLHyaejI=;
        b=ehchAp1ajgDYD/AgbdIajcZGDSZ1GneuRzKsYNlKLkJw7T9XttgeXEtvPNt2+ZE3dP
         y9iIWm5vTZuqHerE9apF7E6+KZvWAqUgfWqjZLAFw0RHwkTNhOK7dxNwJjZpspG1r8EF
         MIf+VuUM+IvCoGgyH/ZM8IlXkO6iBaN9ZFV9nNgudDwRyjvLmCAfQdT1O8iB244cqa3c
         ZCcTbZfMxdNPT0l8Xx8Tr7XZ5hmTVlr2koMLIX7nscXYiLoAFxHzlQ9c5BKK1FVWr7rp
         ZNRXVkYtq1SyuV6bL+i3O70NELlQ8GEduJ+ipBHPFyvTUMtGJYjEWbaAsWuulByX5hP4
         SpFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=VAQnohus/cXSDuEQVZFVApCOPwMOcQs2UxFCLHyaejI=;
        b=tTjbQyp5dwEeM0MHEMUvWh+HLVx8MPyvDpJkolm8Lcy2J8UPgPq9N8eF8gH7Z5HKEV
         mvk2OkEpKqInJIdZPsbwOiDQEIzTcQx9Gin3MRYm5ifb2JG78/vzELZhbjgIbgRu6QYG
         S5UvZohHmzRvw0i60ltiFa41yqKmgPgpZAAIZIx7lTHo2Zb4JensIVeK13TCpdiWeIZd
         NTSXgGajFR+Gyqt3jJjo5v3kLInXhXxW/RsgdwzmX9mejI6G/CKT3NEFhzPo5jQmFPyU
         NWjLM363APGFSKsJuEXJu7K28hUTOgg5ez1P+5tXTUHVvdSaob14XR8014f4C65dbrSj
         NvMw==
X-Gm-Message-State: APjAAAV5fQJoXuG6m+eMwbkpnO2QB+uM5V46B9+JKk6gD6cuGnw1wUBR
        f5w6qZbo4nPnApdq6VU4AzvmV+zZ
X-Google-Smtp-Source: APXvYqzc5UNxT4JHnlpoPW/agpu5BB/5XoeeaNYGmtTQdyDOa8RVi+eX/1tm+EYM5zIsdJntBBpJqw==
X-Received: by 2002:a25:75c5:: with SMTP id q188mr41586604ybc.141.1582452903675;
        Sun, 23 Feb 2020 02:15:03 -0800 (PST)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id j11sm3621767ywg.37.2020.02.23.02.15.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Feb 2020 02:15:03 -0800 (PST)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Mike Hommey <mh@glandium.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 0/2] git-rebase: refuse to switch to branch checked out elsewhere
Date:   Sun, 23 Feb 2020 05:14:05 -0500
Message-Id: <20200223101407.77036-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.25.1.526.gf05a752211
In-Reply-To: <20200220002932.5jws6qpnivlvxckw@glandium.org>
References: <20200220002932.5jws6qpnivlvxckw@glandium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-switch, git-checkout, and git-worktree all refuse to switch to a
branch already checked out in some other worktree. Mike Hommey
reported[1] that git-rebase is not careful like those other commands.
This patch series fixes that shortcoming.

[1]: https://lore.kernel.org/git/20200220002932.5jws6qpnivlvxckw@glandium.org/

Eric Sunshine (2):
  t3400: make test clean up after itself
  rebase: refuse to switch to branch already checked out elsewhere

 builtin/rebase.c  |  5 +++--
 t/t3400-rebase.sh | 20 +++++++++++++++++++-
 2 files changed, 22 insertions(+), 3 deletions(-)

-- 
2.25.1.526.gf05a752211

