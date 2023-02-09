Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E565BC05027
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 14:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjBIOfP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Feb 2023 09:35:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbjBIOfO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2023 09:35:14 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7D05EBE1
        for <git@vger.kernel.org>; Thu,  9 Feb 2023 06:35:11 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id ba1so1974619wrb.5
        for <git@vger.kernel.org>; Thu, 09 Feb 2023 06:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j26wrAwYXOmNsP6OXokErQtQwfy6jefWlkS91WEjQ5c=;
        b=dqtq7R6Ab35n7YzzoR87ISN0GECXCFy9vsnMvOesHZlo0G4l6EW8eZZ2/3GrJPHrIp
         5yiNtmXWUynKyQY6PvYgBi4nRTIxoqPkKCNYDXc1raNYAC6ZjgfJvfZgxQd+8AM3cYq/
         KtwGqUva44J2gUkXMxenD4O8+kQJ57hx2XhZuCfxFRpVK9nO/jrnXROKq7RqXGflRMgV
         I2FvfCG3hlcvEdyYzG6yKrMwa7m4nb9q+Vjl41S2aaA6MHLSEBZAjPCRXKg8ex81Gpr/
         Pw7u6yyVMPbtjFe8G6CvMhFWyHVIcXMiXybSxcjGeJI9uAGKGGlkEY160a2+ejwLT1rO
         cm6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j26wrAwYXOmNsP6OXokErQtQwfy6jefWlkS91WEjQ5c=;
        b=a4bV91i+JPmXCM8tj1QBlIAlG+hwsXkKMz+CSPlYlVq/FkX8How3GnqHK7laaMG9xv
         79OWr93leBpxJuaZG0NIADTujzYChanPlQ0kX3kQfz9k8NGPQKkOY2rXjvdvF8ENSRSv
         4wPazRRrE8otaOzqFMykQOAVQkxwy02IEYa69EWf7Yu3OJrlatF6PDgQfd4HihtPwtWE
         BsEUG841Uhl+wvyGB0eFvN649frtPISbC+TUBPi9zX2Q2OU8KiKJRIVbTBZezPb5EMR+
         HnqQGre6Q8HOV8eDZq1HMGab1X7aZsOTr5bSKZ59tPtumN4XQ04ZHh5Yqa8MsPxj3BT1
         4VQg==
X-Gm-Message-State: AO0yUKVcUX7TtnDkCIiBt3av54QvvaAeWwRbSHMcIkrd9U3v1+7IiB1D
        rQTN0TizJgnsMI+OolsWEEF04DVfa3LRaxLW
X-Google-Smtp-Source: AK7set9pkHMdMCQEDxLarcCMmyfxbvjFTQoqMEQotm5LGtPMQSzSJXF17pD0X196Xqyl+np3ajhLpA==
X-Received: by 2002:a05:6000:813:b0:2c3:be89:7c2c with SMTP id bt19-20020a056000081300b002c3be897c2cmr5778905wrb.15.1675953309617;
        Thu, 09 Feb 2023 06:35:09 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k10-20020a056000004a00b002c3d814cc63sm1391477wrx.76.2023.02.09.06.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 06:35:08 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Max Gautier <max.gautier@redhat.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/2] gpg-interface: cleanup + convert low hanging fruit to configset API
Date:   Thu,  9 Feb 2023 15:35:04 +0100
Message-Id: <cover-0.2-00000000000-20230209T142225Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1475.gc2542cdc5ef
In-Reply-To: <+TqEM21o+3TGx6D@coredump.intra.peff.net>
References: <+TqEM21o+3TGx6D@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 09 2023, Jeff King wrote:

> If the gpg code used git_config_get_string(), etc, then they could just
> access each key on demand (efficiently, from an internal hash table),
> which reduces the risk of "oops, we forgot to initialize the config
> here". It does probably mean restructuring the code a little, though
> (since you'd often have an accessor function to get "foo.bar" rather
> than assuming "foo.bar" was parsed into an enum already, etc). That may
> not be worth the effort (and risk of regression) to convert.

I'd already played around with that a bit as part of reviewing Junio's
change, this goes on top of that.

I found that continuing this conversion was getting harder, but these
3 cases really were trivial cases where we're just reading a variable
globally, and then proceeding to use it in one specific place.

Out of the remaining ones gpg.program et all looked easiest, but I
didn't continue with it.

For anyone interested think it would be best to continue by converting
the remaining bits by having commit, tag etc. set up some "struct
gpg", so that when they could directly instruct it ot do its config
reading before parse_options(). The remaining complexity is mainly
with the file-global & having to juggle in what order we read & set
what.

FWIW when poking at this I found that we have fairly robust testing
support for this area, but it could be better, but it's good enough to
spot that if we stop reading these we'll fail tests.

But e.g. for the "gpg.program" we've got tests that'll fail if the
"gpg" program variable isn't read, but not for the "ssh" variable, but
as they'll both share the same/similar reader code any future
migration should spot any glaring bugs, just possibly not subtle ones.

Branch & passing[1] CI at:
https://github.com/avar/git/tree/avar/gpg-lazy-init-configset

1. Well, passing except for the general current Windows CI dumpster
   fire on topics based off current "master".

Ævar Arnfjörð Bjarmason (2):
  {am,commit-tree,verify-{commit,tag}}: refactor away config wrapper
  gpg-interface.c: lazily get GPG config variables on demand

 builtin/am.c            |  7 +----
 builtin/commit-tree.c   |  7 +----
 builtin/verify-commit.c |  7 +----
 builtin/verify-tag.c    |  7 +----
 gpg-interface.c         | 66 ++++++++++++++++-------------------------
 5 files changed, 29 insertions(+), 65 deletions(-)

-- 
2.39.1.1475.gc2542cdc5ef

