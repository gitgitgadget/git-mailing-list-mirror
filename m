Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB5841F4F8
	for <e@80x24.org>; Thu, 22 Sep 2016 18:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030345AbcIVShJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 14:37:09 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35613 "EHLO
        mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030267AbcIVShG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2016 14:37:06 -0400
Received: by mail-pa0-f46.google.com with SMTP id oz2so31733715pac.2
        for <git@vger.kernel.org>; Thu, 22 Sep 2016 11:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=7+t8bAQUzruyBRHSgUrmJoq1uBuQptdUgOZdxK3CVho=;
        b=F9ELBzU8BAGU6N0bJUKXQIblZQUpqM8oWaf+dD6W72yFaTjsennm7JCazzyLTohxng
         PhNJFP1jr8dL1dMWY+BeM8w8Fz7jJyg+HpCnK7fur6gBSNOrORMqyp7Dcua2XCfcQJ7z
         GBRMKJhuxuC2KlfddhuZnvB8WR6hP0zcwSD1LxdfGgT6F1Gh1PsKMDzutlNKqiQ4QLJp
         fr8o1eh1xSRg8tchaI7k1Yzt6T+CQ/hvWV6+4DlbGQrlUjBvbFpmbW5Dh4di6AV7lwcj
         qEzBjmDkxsSGoVCRdHxpYLnfj1oxAnWjB0KWjKQicy1BS3OprC3whjxciwhoFnYzFpqL
         QnDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7+t8bAQUzruyBRHSgUrmJoq1uBuQptdUgOZdxK3CVho=;
        b=NCYy3Tf+Uqtj9lAy1m00lUr/dEgYTk3hh/uoDC9jkPOVnd179sV4s6MURBfXgsFtOH
         e28l/VOsI4bviSVFU4zyvV/UtjLSMku7jHBjkzjE4nip2HVKANvFU5VhRmOGO4nK1wbA
         OJoTVfih1/xMJrVnzBrsSA5IfsD9pz4oetC8y7gNQdCO9BhlT3MX99lFbxeWm54QYr9K
         P0siyaX2w58A75Gsow0QbmVcCPcD78mZJjdh1KcScRHWqL9kwm20YynDIGksHlX3F9h6
         I8NibeC2Sy2dv+m+IyuKOap/SfCImAY7xFvNDIuKPXs7WaLB2E8PR9A/OEoQSvnrkUjo
         DhZg==
X-Gm-Message-State: AE9vXwN29RjWGSCPVC8YzOKxF0vQsAkaq3vDKJvscqnlR8ddizAOYL1q081HDFmkyWO6yzTW
X-Received: by 10.66.150.134 with SMTP id ui6mr5574041pab.41.1474569425184;
        Thu, 22 Sep 2016 11:37:05 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id x9sm5802715pff.19.2016.09.22.11.37.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 22 Sep 2016 11:37:03 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH] do not reset in_vain on non-novel acks
Date:   Thu, 22 Sep 2016 11:36:54 -0700
Message-Id: <cover.1474568670.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is regarding the packfile negotiation in fetch-pack. If there is a
concern that MAX_IN_VAIN would be hit too early (as a consequence of the
patch below), I'm currently investigating the possibility of improving
the negotiation ability of the client side further (for example, by
prioritizing refs or heads instead of merely prioritizing by date in the
priority queue of objects), but I thought I'd send the patch out first
anyway to see what others think.

Jonathan Tan (1):
  fetch-pack: do not reset in_vain on non-novel acks

 fetch-pack.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

-- 
2.8.0.rc3.226.g39d4020

