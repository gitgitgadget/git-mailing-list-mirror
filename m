Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79B201F404
	for <e@80x24.org>; Tue, 13 Feb 2018 18:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965439AbeBMSju (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 13:39:50 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:46313 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965399AbeBMSjt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 13:39:49 -0500
Received: by mail-pg0-f66.google.com with SMTP id a11so443490pgu.13
        for <git@vger.kernel.org>; Tue, 13 Feb 2018 10:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3+QwIQHQG/FhhdHfsLUg1xwRPl0E4Bk5PYgmOjXJyxM=;
        b=UZZpOtYhjHTwA0lLlFdgEV+OiX90dEzG5LVfNKOlBlO7tLebH0KLZAG6hz0m/vmt49
         sDxh7SNzXfRo61x07L14E99Gklmpm2sNrtp4LzrhBtPkQ+QZcCSsWJXOhgZjheEoJe4t
         zgodolEbNKRNFA4os4vzfwjVoorc8+orJBtu1PiHF/qjLNahfLFGY94kmNlJN5K6dB1N
         tiKpcSpHMUTqbSczAGrL7Jg1oBvT6LG/SIjsZIhwC/IFMYQURMkuIGYXe2dFmORGswJE
         eBEjnW1wLbQSZHkLGrWor+bjZ3tM31uz1MFWWkaTSIwKLwndhFQzUs8aNcCoJJ7f8UXp
         TBfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3+QwIQHQG/FhhdHfsLUg1xwRPl0E4Bk5PYgmOjXJyxM=;
        b=MiFvLDMpBE8mcszAI/jieIQAJfNBUji9ovuIQkrJEoxwMY3kqPjfVxwAMQIl7M4Wnk
         H2HUZmbXSWTDMQxoZrBu966GSYIi5RRHeADtJCYAxx9PfLIV1DCImSzXB/mpsW0bwCeC
         ndNhnI33xb9ZmzWkVnuYpyRxxi94yeSXZpSxGK5txjve28myp8KVZi1amh4fVoVRMS33
         9FHXjGZXkaRVhAWAcpQDEAuTfSGlqfVKh94DilvjcKCsW6DBKO0TqsJVOWUHmnBCNDi+
         IaYKZgZytnGspwNWIFaq2x5WrOUOEddnssnQsrImTpwenoxpvFGHJZPuxmfBqeJIhxv6
         zdXQ==
X-Gm-Message-State: APf1xPAV64wi58PWsHmZfHcTvlMMUKmbflLS3THoeTw1v3EdNv7vQBEk
        jxHw+GfjBI4s49rrvOoDNIhT+VERMxQ=
X-Google-Smtp-Source: AH8x22616fNqaP3kqZ05I1VgCb9vKSAbeENGl+waBSQ3ubJ2FlXHhRhkKqGotbZl2+cnfzc0nELaIg==
X-Received: by 10.99.143.28 with SMTP id n28mr1726746pgd.254.1518547188954;
        Tue, 13 Feb 2018 10:39:48 -0800 (PST)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id i69sm29944102pfk.24.2018.02.13.10.39.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Feb 2018 10:39:47 -0800 (PST)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     l.s.r@web.de, stolee@gmail.com,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v2 0/2] Refactor hash search with fanout table
Date:   Tue, 13 Feb 2018 10:39:37 -0800
Message-Id: <cover.1518546891.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
In-Reply-To: <cover.1517609773.git.jonathantanmy@google.com>
References: <cover.1517609773.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Updates from v1:
 - use uint32_t so that we can operate on packfiles of up to 4G objects
   (this also means that I had to change the signature of the function)
 - don't hide types

Derrick: you'll need to slightly change your patch to use the new API.
As for find_abbrev_len_for_pack(), that's a good idea - I didn't do it
in this set but it definitely should be done.

Jonathan Tan (2):
  packfile: remove GIT_DEBUG_LOOKUP log statements
  packfile: refactor hash search with fanout table

 packfile.c    | 29 ++++-------------------------
 sha1-lookup.c | 28 ++++++++++++++++++++++++++++
 sha1-lookup.h | 22 ++++++++++++++++++++++
 3 files changed, 54 insertions(+), 25 deletions(-)

-- 
2.16.0.rc1.238.g530d649a79-goog

