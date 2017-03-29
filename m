Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12E491FAFB
	for <e@80x24.org>; Wed, 29 Mar 2017 00:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932749AbdC2Acs (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 20:32:48 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:34835 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932571AbdC2Ac1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 20:32:27 -0400
Received: by mail-qt0-f196.google.com with SMTP id r5so122768qtb.2
        for <git@vger.kernel.org>; Tue, 28 Mar 2017 17:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=yVeq/+C1sMGJhIfNcjfzDbdq9ap30lMIIBFDY3OXtH8=;
        b=dlgKq5B4yfwa0shHvnDy9kOUNCCcjyTjjRFWL5Xj+BB1qLQTru9D1OkZbNlSmh9oKp
         88/xZ+yYIeKEzpwXVkMB6bgpgPbhnzpg/VtGYP3l8UmUv2fFXpz0o+1fwRg/FyYRWjUM
         a0TqtNXF7T/iVPHVM5GjEv7tYey6tMFaL0QywLnWT0feES6htaLZmFYO18nfPt0vhr4E
         Eqbx+hEXmR13nIhFCElny6KwyTcQHfT11kjMI6NJpzjU6yn57rqwvZAQNVK3S/gj6vY5
         nmq4A1Exn05C1YgmguTPa+6ZPXPLw8gTDoWcJp0A0uH6NhLjhCOqIq8afE9onZ8vdNGU
         c42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yVeq/+C1sMGJhIfNcjfzDbdq9ap30lMIIBFDY3OXtH8=;
        b=HJU2RWIhcyv/w+kgDhLqujqrbVWqFdZeHxopNIQdYpSLG+i6equOjsxMit3ZJwP/41
         d/r5DeQGurl5RcMVOw8CysXQ3oK3jgGJQ/E3aTYPFSLdHa03gsyheqAOa9E2n8ZTkGNB
         YJ/2ovRWGvZHTDiczhC6UjZ4RButUAnlJYVWplXKfL4Jvw8WFRDHx6d95Qz+UWVkcpfP
         UCjfstxN8xF06v4GpSdYcyCwQlFP2MRZJe+NDeyTM+XfWaX7usgob/kiKyEJTcg7C8DZ
         mizHAGCNd+J8P4G3DasM3/Wqk3if8RlnoEZ2gceTwNvZhfCACBIDixanNHfgS5AF/syG
         2Ipg==
X-Gm-Message-State: AFeK/H3CUwZiiAQKukW0yPTts9qi8FkBjyxbea/SpFcphNG992RU5ym+AQM0NCArVbanjA==
X-Received: by 10.237.50.97 with SMTP id y88mr32045102qtd.104.1490747545676;
        Tue, 28 Mar 2017 17:32:25 -0700 (PDT)
Received: from Daniels-MacBook-Pro.local.net ([187.11.121.49])
        by smtp.gmail.com with ESMTPSA id x26sm3819420qtx.47.2017.03.28.17.32.22
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 28 Mar 2017 17:32:24 -0700 (PDT)
From:   Daniel Ferreira <bnmvco@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        mhagger@alum.mit.edu, Daniel Ferreira <bnmvco@gmail.com>
Subject: [PATCH v4 0/5] [GSoC] remove_subtree(): reimplement using iterators
Date:   Tue, 28 Mar 2017 21:32:08 -0300
Message-Id: <1490747533-89143-1-git-send-email-bnmvco@gmail.com>
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi there,

This is the fourth version of the GSoC microproject of refactoring
remove_subtree() from recursively using readdir() to use dir_iterator. Below
are the threads for other versions:

v1: https://public-inbox.org/git/CAGZ79kZwT-9mHTiOJ5CEjk2wDFkn6+NcogjX0=vjhsAh16ANYg@mail.gmail.com/T/#t
v2: https://public-inbox.org/git/CACsJy8Dxh-QPBBLfaFWPAWUsbA9GVXA7x+mXLjEvYKhk1zOpig@mail.gmail.com/T/#t
v3: https://public-inbox.org/git/CAGZ79kYtpmURSQWPumobA=e3JBFjKhWCdv_LPhKCd71ZRwMovA@mail.gmail.com/T/#t

In this version of the patch, I followed Michael's suggestion
of splitting the commits responsible for adding the new feature to
dir_iterator. His suggestion of using flags instead of an options
struct has also been adopted.

This version also contains a test that is finally able to test the
function decently (not the one Stefan had suggested, which
did not result in a call to remove_subtree). I am just unsure about
its location in t/. I'd appreciate suggestions to put it in a more
decent home.

Daniel Ferreira (5):
  dir_iterator: add helpers to dir_iterator_advance
  dir_iterator: iterate over dir after its contents
  remove_subtree(): reimplement using iterators
  remove_subtree(): test removing nested directories
  files_reflog_iterator: amend use of dir_iterator

 dir-iterator.c                  | 105 +++++++++++++++++++++++++++++++---------
 dir-iterator.h                  |  14 ++++--
 entry.c                         |  31 ++++--------
 refs/files-backend.c            |   2 +-
 t/t2000-checkout-cache-clash.sh |  11 +++++
 5 files changed, 114 insertions(+), 49 deletions(-)

--
2.7.4 (Apple Git-66)

