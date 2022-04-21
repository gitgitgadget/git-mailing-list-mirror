Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BCDCC433EF
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 15:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384038AbiDUPgz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 11:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349101AbiDUPgx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 11:36:53 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A3B2E082
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 08:34:03 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id s25so2351352wrb.8
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 08:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jLjv0KXjxZyRUnfkRN9+vx5nnC3xKx/BibjHo4BYBH0=;
        b=hXNHZ6KGOoFMzP5QkyriBmFj+xLNhXZffN0OEO30GNUQ6cL6Ueygd6gVtC1tTHqDKV
         nd0gvBbOGnpqMeK5DlRswBJW75unTEkUVXcQBPKbyYgolbPFqmGr5GjsfFlj698qrrq+
         8NvABiOLyLwI4WEdTTDdcfsidPt1dacRKUvrOwqfbhK+kJ5qtBslDXcWbmX+OT2COSPR
         XUOJ0E2TCUZoAY8I+MssxW15a+6YXJzdxwYst2QrPVH8e1CnfBUlbkH/AsqYQR8xHbga
         baLAuXHc6V6TRZ+Pd/gAEwy0QWlEXt8uyJH9dLJHMkrYZptMIr7qWCnr6ockOiyefTo+
         62lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jLjv0KXjxZyRUnfkRN9+vx5nnC3xKx/BibjHo4BYBH0=;
        b=2S9AhMsVEU5LhdQUeI35351NGdkE4VD/v5jXbU03sMQ6Mq+Pu4SlIDY6KTKZu9N9ws
         c13fh6D8XbX9vdF/YwjkPF/rrJxqw7/fTyDWijBsQ2EU3+suM/MaqkDemNTfzYnYVxuP
         N5zdti05HniaO99b3qNGyoOoF3cd+6GadJrbZvv5FprTIkMTfy118uLe5rWI3FCWJS4Z
         WNWJKJrlRbzDgsODpg/txLZ5bqQvBN4RmLX6GYfjFah7X1pydaItCweJfB8QzS+OEN17
         ufJmma0ltrNtOJlMCYQlLcdx0ZNkw5EjIiikZijGyUtluef0rKLc9/Xry3jYqqwhGLAD
         Y+UA==
X-Gm-Message-State: AOAM530xuMOOd8l5dh34/iR+y2SFIzDkwgOKDyuskzOTkNtnWsselkvN
        mgYw2EIyE77ZZuAtebFHUt6NpnoLzSKVpg==
X-Google-Smtp-Source: ABdhPJxDYLOXK+G6iNeoiGKQs/YI79L3908JQwgrwOBrwSi1zKbbS0HE8gzk730mvkfaHvekqv/L2w==
X-Received: by 2002:a05:6000:18a9:b0:20a:8e74:6a60 with SMTP id b9-20020a05600018a900b0020a8e746a60mr230992wri.65.1650555241909;
        Thu, 21 Apr 2022 08:34:01 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l126-20020a1c2584000000b00387d4f35651sm2370516wml.10.2022.04.21.08.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 08:34:01 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Gregory David <gregory.david@p1sec.com>,
        ptm-dev <ptm-dev@p1sec.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/2] show-brach: segfault fix from Gregory David
Date:   Thu, 21 Apr 2022 17:33:46 +0200
Message-Id: <cover-v3-0.2-00000000000-20220421T152704Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.876.g7efc8a7728c
In-Reply-To: <225b410d-2d98-8c0b-c289-22f753c175d4@p1sec.com>
References: <225b410d-2d98-8c0b-c289-22f753c175d4@p1sec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a version of
https://lore.kernel.org/git/225b410d-2d98-8c0b-c289-22f753c175d4@p1sec.com/
that applies with "git am", the patch got munged in transit (from the
looks of it from Thunderbird's wrapping).

I added a 1/2 to factor out some shared code used by the segfault fix,
and made the now-smaller 2/2 use that function.

I also renamed some varibles to reduce wrapping, and made the
append_one_rev() come after the ref formatting. Other similar code
above does that, it looks to me like they're equivalent
(append_one_rev increments ref_name_cnt).

Gregory David (1):
  show-branch: fix SEGFAULT when `--current` and `--reflog` together

Ævar Arnfjörð Bjarmason (1):
  show-branch: refactor in preparation for next commit

 builtin/show-branch.c  | 47 ++++++++++++++++++++++++++++++------------
 t/t3202-show-branch.sh | 43 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+), 13 deletions(-)

-- 
2.36.0.876.g7efc8a7728c

