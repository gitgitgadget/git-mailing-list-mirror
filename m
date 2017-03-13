Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58E3D20373
	for <e@80x24.org>; Mon, 13 Mar 2017 21:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753413AbdCMVns (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 17:43:48 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:33996 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750902AbdCMVnq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 17:43:46 -0400
Received: by mail-pg0-f53.google.com with SMTP id 77so70559666pgc.1
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 14:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o4rw6G9IxRhZDRnkBP4m9kU9vAvJKDpAwIZUhWd+MXk=;
        b=ebvGrQaiVmsGdTYUEJMtevaFoqtUK99jlPijBaOfhy44qqDQPX+5HIN9LIBqwev6qX
         RrGdIzy+qUQVd4d3WjWVwx2gzXNvA0yOIGGWYKwOGNpQKh7yc86GX0D8L7tA3VsdIy8W
         ennx7rSrnVTnGiJWq1MDq7/EIX24tTLz3GGbCM1ZD17kM95/1+TVNsxcVMRaWHoFQHM9
         oNrWUkmahHLcmT0octEd4s8cHdRD1/1dx2oXbjzrS+6xTeb0SdwEHgJtSeAsbtN7HXGU
         EZa8uTRKlx1fZqM65soM0jMigT/HSGdSKb+gFMFECMFi94mzDPy6XPgjipJRcpLbqXT4
         9biQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o4rw6G9IxRhZDRnkBP4m9kU9vAvJKDpAwIZUhWd+MXk=;
        b=GHoU3nF4tTMwmv+YvK7hl/i1cNrbqyiLOjdPEvoYoH49iYIhTXVyNlRro1P3pkEXGL
         ke5QZaKkI4GVVyDh8FsWdsrWWEgSicgU2VzhXa1NdOi4popwRFtlgggojhEMyaKyETsm
         Vu0SSkQE/iWSpFmqdTaCsiVdYjdlR674AsJ/Xn5QCYYoBXkGG/sczTp1oMMeYc0Q+WiR
         +BcANiEqhEKu5nU6EA9drACkd2sCSyADHKz9vsDO94y0RUxEV0p+LZFsELFynDZnfjA6
         OzMjeOpvsgFO1yZewUtTsyiCKMNHTC+7UbZBG9ens3y9qI8ALTbXBURFTSC85ZTJ/WA/
         KYrg==
X-Gm-Message-State: AMke39mEz/p5UpdRifSPe4/Y/6Z3thDmydHo5pvwGN8OyNHOUaBo3VxBveOaF44AUskW3Ssi
X-Received: by 10.84.225.22 with SMTP id t22mr51058722plj.14.1489441425236;
        Mon, 13 Mar 2017 14:43:45 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id 129sm34525937pgj.59.2017.03.13.14.43.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Mar 2017 14:43:44 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        gitster@pobox.com
Subject: [PATCH v3 00/10] decoupling a submodule's existence and its url
Date:   Mon, 13 Mar 2017 14:43:31 -0700
Message-Id: <20170313214341.172676-1-bmwill@google.com>
X-Mailer: git-send-email 2.12.0.246.ga2ecc84866-goog
In-Reply-To: <20170309012345.180702-1-bmwill@google.com>
References: <20170309012345.180702-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

changes in v3:

* Droped a patch which tried to use a more accurate URL for deinit.  It didn't
  really fit inside the scope of this series.  It may be something we want to
  revisit later though.

* The --init-active flag now ensure that all submodules which are configured to
  be 'active' (either via 'submodule.active' or 'submodule.<name>.active') go
  through the initialization phase and have their relevent info copied over to
  the config.


Brandon Williams (10):
  submodule--helper: add is_active command
  submodule status: use submodule--helper is-active
  submodule sync: use submodule--helper is-active
  submodule--helper clone: check for configured submodules using helper
  submodule: decouple url and submodule existence
  submodule update: add `--init-active` switch
  clone: add --submodule-spec=<pathspec> switch
  completion: clone can initialize specific submodules
  submodule--helper init: set submodule.<name>.active
  submodule add: respect submodule.active and submodule.<name>.active

 Documentation/config.txt               |  15 +++-
 Documentation/git-clone.txt            |  23 ++++--
 Documentation/git-submodule.txt        |   9 +++
 builtin/clone.c                        |  36 +++++++++-
 builtin/submodule--helper.c            |  68 ++++++++++++++----
 contrib/completion/git-completion.bash |   1 +
 git-submodule.sh                       |  43 +++++++++--
 submodule.c                            |  36 ++++++++--
 t/t7400-submodule-basic.sh             | 128 +++++++++++++++++++++++++++++++++
 t/t7413-submodule-is-active.sh         | 107 +++++++++++++++++++++++++++
 10 files changed, 431 insertions(+), 35 deletions(-)
 create mode 100755 t/t7413-submodule-is-active.sh

-- 
2.12.0.246.ga2ecc84866-goog

