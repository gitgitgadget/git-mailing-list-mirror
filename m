Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11269C433ED
	for <git@archiver.kernel.org>; Tue, 18 May 2021 13:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E06F161184
	for <git@archiver.kernel.org>; Tue, 18 May 2021 13:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241502AbhEROAn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 10:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239860AbhEROAm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 10:00:42 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7ACAC061573
        for <git@vger.kernel.org>; Tue, 18 May 2021 06:59:24 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
        s=default; t=1621346361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=J7NxxvXc24GLvJ2saJe8zpoIQ4oE6fpjHdLcFLOq8yY=;
        b=zvdP1RTacdqOr0pcOes+WGb9c86rYj0Xo+aYAkm8kSMlMSLvDnD5ehyIY27MVbItyoKhJb
        2KifEFS/ZSJFToB1UVplcS59841V5+w9XqktsQeR1jyXeKujjUyH6dz0hSrfHh0QNx7wqG
        NjEd5Q8OWboCqTDJHdIAjgCD3XsLmiY=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 18 May 2021 09:59:20 -0400
Message-Id: <CBGFBF8EDCPS.LNG4VOVFVR6M@ziyou.local>
Cc:     "Christian Couder" <christian.couder@gmail.com>
Subject: [BUG] apply -N deletes the index
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Raymond E. Pasco" <ray@ameretat.dev>
To:     <git@vger.kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: ray@ameretat.dev
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Expected behavior: git apply -N foo.patch applies a patch to the
worktree, additionally adding 'new file' entries in the patch to the
index as intent-to-add entries.

Actual behavior: git apply -N foo.patch overwrites the entire index, so
that after the command it *only* contains the intent-to-add entries
added by the patch, and nothing else. (It still applies properly to the
worktree.)

I am looking at apply.c to figure out why this happens, but thought a
report to the list was warranted; any thoughts from someone more
familiar with this machinery would be helpful.

I went back in the history and this seems to have happened since the
feature was first added (ac997db0, Merge branch 'nd/diff-apply-ita').
