Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B50D1F8CF
	for <e@80x24.org>; Fri,  9 Jun 2017 19:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751788AbdFITXe (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Jun 2017 15:23:34 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:32850 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751713AbdFITXd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jun 2017 15:23:33 -0400
Received: by mail-pg0-f46.google.com with SMTP id f185so29391098pgc.0
        for <git@vger.kernel.org>; Fri, 09 Jun 2017 12:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=UKVeo1s2LEjoG6bMZZFoJq48rZBgbENxuGVnkiOXzOQ=;
        b=e6yWJms/cm3JKzGUE+VdP2WbyvPv9wBwqKBzINFWK64eafj6hFRXr3ZPJVrSXshiyl
         vQvlKpNPpt3o9iiltGolb8alA4J9yd8BWc/EA29sPqi5vtXb38QoGtE38lzrSJI+0NUi
         v45OHxFNWhw3IZyaNJNQNZQ4IO6kF8bHgBd1oqdP44n0ZwRGsXNa9MozV8G8J9x8pu/Y
         2ksFmoYQU/DxcGo6T02KrlvNdWVr/JjY5JXTjwugYv2/+Q4kI1u4SZTBMIF3jBoRFK8N
         g8s8QPwXwfXRfo/41IbJMA63e5T0kFJT1ksdZsxlLdRs1DJu+U3zQfdyFapFNXOyjp0V
         ZAzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UKVeo1s2LEjoG6bMZZFoJq48rZBgbENxuGVnkiOXzOQ=;
        b=rz9PVxO0DVb7Wa1mDHyLt/Xa7zX6NjUBBnHJND+kq+S2BFjhVzB6nja7T4hAnwt3qh
         8g5pJqZ9mKbKXzwY/Vr8j8zpG9kNaOCdUpXSHGxbNRKOqh+hGrrNhEeee/v8q17CQOBC
         Y6rjLTfUCW2udNekJ+/y/0fCU53XOiKeo3pYsNJWF8xrpQFeW41n6jM8bW3oDJUtRRmA
         TnvBMJRqy2gtr06Jn49wlOX2So3xgRcO7JX4O6wnm/cr2t1HWk0VKy0gwalmS4HH0HjU
         uVzAWJ0r9zVKtu6LFhCHnfaMVWqQKs4lY8njGwXpcKGYPuY92mmoH/7r1tHsz8FxOY/G
         /Ytg==
X-Gm-Message-State: AODbwcBs/emaTikUOY3HsTX6FhTJ5vjAK+xZD2c/6aPXW5it0UQ6BH2R
        QiEF+2F0LjV2cXwGQp7iGg==
X-Received: by 10.99.122.92 with SMTP id j28mr30308694pgn.13.1497036211892;
        Fri, 09 Jun 2017 12:23:31 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id f72sm5757924pfe.4.2017.06.09.12.23.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Jun 2017 12:23:30 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [RFC PATCH 0/4] Improvements to sha1_file
Date:   Fri,  9 Jun 2017 12:23:22 -0700
Message-Id: <cover.1497035376.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.13.1.508.gb3defc5cc-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was investigating how to adapt my existing patch for missing blob
support [1] to consult a manifest of missing blobs, and found it
difficult to further modify sha1_file.c without doing some further
refactoring. So here are some patches to do that.

I think patch 1 is an independently good change - it makes the code
clearer and is also a net reduction in lines. If none of the other
patches here make it, maybe patch 1 should go in independently.

Patches 2-3 are also collectively independent, but more invasive. The
commit messages explain what's going on in more detail, but basically
there are 3 functions doing similar things (getting information for an
object regardless of where it's stored) with duplicated mechanisms, and
for maintainability, it is better to combine them into one function.

Patch 4 is my adaptation of [1] after all the refactoring - notice that
I just needed to edit 1 storage-agnostic object info function instead
of previously needing to edit 3. It is still a work in progress - the
code looks complete, but I would probably need to at least document the
missing blob manifest format. I am providing it here just to show the
effectiveness of the refactoring in patches 2-3.

I am hoping for reviews on patches 1-3 to be included into the tree.

[1] https://public-inbox.org/git/20170426221346.25337-1-jonathantanmy@google.com/

Jonathan Tan (4):
  sha1_file: teach packed_object_info about typename
  sha1_file: extract type and size from object_info
  sha1_file: consolidate storage-agnostic object fns
  sha1_file, fsck: add missing blob support

 Documentation/config.txt |  10 +
 builtin/cat-file.c       |  29 +--
 builtin/fsck.c           |   7 +
 builtin/pack-objects.c   |   5 +-
 cache.h                  |  12 +-
 sha1_file.c              | 484 +++++++++++++++++++++++++++++++----------------
 streaming.c              |   4 +-
 t/t3907-missing-blob.sh  |  69 +++++++
 8 files changed, 439 insertions(+), 181 deletions(-)
 create mode 100755 t/t3907-missing-blob.sh

-- 
2.13.1.508.gb3defc5cc-goog

