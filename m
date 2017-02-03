Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6AA11F9AF
	for <e@80x24.org>; Fri,  3 Feb 2017 02:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752009AbdBCCy0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 21:54:26 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36252 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751867AbdBCCyZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 21:54:25 -0500
Received: by mail-wm0-f65.google.com with SMTP id r18so1190196wmd.3
        for <git@vger.kernel.org>; Thu, 02 Feb 2017 18:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MQ/PZuymKEUGBEiGX1BydBnFtsE/3r+sPIrTsVyn2cY=;
        b=Nnib5QqSc1KLLOtOp1ZG4WQMmhbZ+KN8oIy32PwYiRlYMOdactBb1sMIdNAMTzEN4H
         Zgzq8xZ5yQ09S3rd+818FjBRjwe7CdshZab7e0TTU/wbSfHAw7Ohba6sefiLGcbRXK7S
         A86a2hyFPwZpAGvB52ey6aPeZoR63yU6pkX0a7657LXLt4n4sQya1BJEpVSjosk7rRCB
         VYMCEdlHmCP9B5hFTWjFHZxhZjqr/+rwrVT7fnrqtP0gTZ9RTMqvNai4c2CF3YWSyY4O
         vtrT6ENjhunmfqaB8C7CVeA+Dkru6AFc338HKEyJZWoh2HPRwfs0Ri62gzd9X7/w33J7
         nt3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MQ/PZuymKEUGBEiGX1BydBnFtsE/3r+sPIrTsVyn2cY=;
        b=ubGlsstom4gFAFfRtvRbVzE151NOf6bQHFWsToZQtq9w64BBdmE3cfNjhMtnELyCJX
         o91GjeCUNUN84f86Eshn4ainNdnocnIdpxLd3k8FytsMdRcK6WvNd3KyqCt5+p5fr8Zm
         hBjzoBIOia3HEd3F+LhHGk/EPN/St8WideQr7sZAh9AiGXNxChe0FRLxzpn2IA1q8NjR
         RGcFiCtSjH2CVuGgAHrwL/xzsHDJYT7afGbXjm73ptCZnpNuZ8X9D3gsWLLbfHg/dLLR
         5apdUY+7G4G9YYjaCCwCdWMNE9DwrtZlP+3vNQS3gh58bs++yq2Pue0kUPKtoehr/+gn
         L/+Q==
X-Gm-Message-State: AIkVDXKOgwNG7AXoGmI7CeQdN7asz1ughfop1aHfZnoA+34b9wCLMvigWMCbs/8Vk7EcWQ==
X-Received: by 10.223.176.16 with SMTP id f16mr9667701wra.113.1486090464361;
        Thu, 02 Feb 2017 18:54:24 -0800 (PST)
Received: from localhost.localdomain (x590d744d.dyn.telefonica.de. [89.13.116.77])
        by smtp.gmail.com with ESMTPSA id c133sm652291wmd.13.2017.02.02.18.54.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Feb 2017 18:54:23 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 00/12] completion: speed up refs completion
Date:   Fri,  3 Feb 2017 03:53:53 +0100
Message-Id: <20170203025405.8242-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.11.0.555.g967c1bcb3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series speeds up refs completion for large number of refs, partly
by giving up disambiguating ambiguous refs (patch 6) and partly by
eliminating most of the shell processing between 'git for-each-ref'
and 'ls-remote' and Bash's completion facility.  The rest is a bit of
preparatory reorganization, cleanup and bugfixes.

The last patch touches the ZSH wrapper, too.  By a lucky educated
guess I managed to get it work on the first try, but I don't really
know what I've actually done, so...  ZSH users, please have a closer
look.

At the end of this series refs completion from a local repository is
as fast as it can possibly get, at least as far as the completion
script is concerned, because it basically does nothing anymore :)  All
it does is run 'git for-each-ref' with assorted options to do all the
work, and feed its output directly, without any processing into Bash's
COMPREPLY array.  There is still room for improvements in the code
paths using 'git ls-remote', but for that we would need enhancements
to 'ls-remote'.

It goes on top of the __gitdir() improvements series I just posted at:

  http://public-inbox.org/git/20170203024829.8071-1-szeder.dev@gmail.com/T/

This series is also available at:

  https://github.com/szeder/git completion-refs-speedup


SZEDER Gábor (12):
  completion: remove redundant __gitcomp_nl() options from _git_commit()
  completion: wrap __git_refs() for better option parsing
  completion: support completing full refs after '--option=refs/<TAB>'
  completion: support excluding full refs
  completion: don't disambiguate tags and branches
  completion: don't disambiguate short refs
  completion: let 'for-each-ref' and 'ls-remote' filter matching refs
  completion: let 'for-each-ref' strip the remote name from remote
    branches
  completion: let 'for-each-ref' filter remote branches for 'checkout'
    DWIMery
  completion: let 'for-each-ref' sort remote branches for 'checkout'
    DWIMery
  completion: list only matching symbolic and pseudorefs when completing
    refs
  completion: fill COMPREPLY directly when completing refs

 contrib/completion/git-completion.bash | 205 ++++++++++++++++--------
 contrib/completion/git-completion.zsh  |   9 ++
 t/t9902-completion.sh                  | 282 +++++++++++++++++++++++++++++++++
 3 files changed, 430 insertions(+), 66 deletions(-)

-- 
2.11.0.555.g967c1bcb3

