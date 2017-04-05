Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C378F20966
	for <e@80x24.org>; Wed,  5 Apr 2017 17:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755313AbdDERrd (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Apr 2017 13:47:33 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:32820 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753749AbdDERr1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2017 13:47:27 -0400
Received: by mail-pg0-f46.google.com with SMTP id x125so11524286pgb.0
        for <git@vger.kernel.org>; Wed, 05 Apr 2017 10:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hTU+dwXEYIohSixk+ARvN00NaJeUPCtulqtbL+RKJWE=;
        b=HnNrIWQDEOwjOE36pONTb4+dwxxex3OW7wOAg2Y5mX5MnhDjKF651q1PItFTRUtF5Z
         7k0HEZvrvSQhMDocBuVOOcYgbNqGwFeRVMwRCKiWbc76Z/tmZZrlY9nd6eMqw0Sj0XAE
         XVMWvhCogOFU5HL2mWBjyVsQqdz1vX+7ykYY6qI/AMqO+0zSRuh3/yCGEe0JKDeHjrJh
         hT8HAS6j9G8JbMrtpLIMFi6+IDWgXr3zTDseTfvWXBDtay4UZzMVZ5+MJzigW/tIj12k
         sz24pZ64V+C3ibE5/F8BorHgLSGemynP2GJ7+i+gVZDmY8+k6n5+6oECNiRi5Ssk5E/l
         bgtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hTU+dwXEYIohSixk+ARvN00NaJeUPCtulqtbL+RKJWE=;
        b=D2emmeztvUng+7z/d65isrFy3uCa7w0Y7A/j5OCq3eQAdFNx5+xbHCpXaO0rXDz1O0
         kr8At/NqJ0mGeKfHUk+AN/ghcWoZMC2D2S2T6o+AXJzkH20t1X1rElKgoOPMRsw6cdQV
         e0czHKXVu2PXCI+OFkffGXFoMrzgtutTkTt2gQS62ltSoUSEoEMXwN1SREtI9LWL0dCL
         zq8S0Yv2A+8ht8HZPeSFYFe07wdGYqvDLwZ7YOQINkUDn/NXwo1R80BIVmElzXRnE2mX
         L3bsmyL+lKUQRZO/KSzdrbEDI9HoUAebfzDrkcOqYOEPOB5DU8gmwKIedO2N+v91sB4Q
         3U8w==
X-Gm-Message-State: AFeK/H1ELWfqO67PZY+8N2ce3HyExkQx4AptVwlgpa0kaOyoWPZ4CdOOzQYnKrMM96on0b8Y
X-Received: by 10.84.233.143 with SMTP id l15mr37852646plk.93.1491414446047;
        Wed, 05 Apr 2017 10:47:26 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id m69sm38726623pfc.33.2017.04.05.10.47.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Apr 2017 10:47:25 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, jrnieder@gmail.com
Subject: [PATCH v3 0/5] propagating push-options, remote and refspec
Date:   Wed,  5 Apr 2017 10:47:14 -0700
Message-Id: <20170405174719.1297-1-bmwill@google.com>
X-Mailer: git-send-email 2.12.2.715.g7642488e1d-goog
In-Reply-To: <20170331235623.166408-1-bmwill@google.com>
References: <20170331235623.166408-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v3 builds upon v2 by adding 3 additional patches to add functionality to also
propagate the remote and refspec down to children process's working to push
submodules.  The remote and refspec will only be propagated if the provided
remote is configured. A remote provided in the form of a URL will cause the
remote and refspec to not be propagated down to the submodules and instead the
default remote and refspec will be used, preserving existing functionality.
Currently the only supported LHS of a refspec must exactly match a single ref
in the submodule (e.g. a branch name).

Patches [1/5] and [2/5] remain unchanged from v2.

Brandon Williams (5):
  push: unmark a local variable as static
  push: propagate push-options with --recurse-submodules
  remote: expose parse_push_refspec function
  submodule--helper: add push-check subcommand
  push: propagate remote and refspec with --recurse-submodules

 builtin/push.c                 |  5 +--
 builtin/submodule--helper.c    | 45 +++++++++++++++++++++++++
 remote.c                       |  2 +-
 remote.h                       |  1 +
 submodule.c                    | 74 +++++++++++++++++++++++++++++++++++++++---
 submodule.h                    |  5 ++-
 t/t5531-deep-submodule-push.sh | 52 +++++++++++++++++++++++++++++
 t/t5545-push-options.sh        | 40 +++++++++++++++++++++++
 transport.c                    |  4 ++-
 9 files changed, 219 insertions(+), 9 deletions(-)

-- 
2.12.2.715.g7642488e1d-goog

