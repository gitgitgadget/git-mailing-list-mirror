Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 554641FD09
	for <e@80x24.org>; Wed, 31 May 2017 15:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751067AbdEaPGf (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 11:06:35 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33912 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750998AbdEaPGe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 11:06:34 -0400
Received: by mail-wm0-f66.google.com with SMTP id d127so4318264wmf.1
        for <git@vger.kernel.org>; Wed, 31 May 2017 08:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=frI4zsNJmO7DfftwjtU7Nj4udxxRSTXPL+S3bSdKx44=;
        b=lZtOMeN2XTZNfl5cRFoUrSlEq0iF8YPycpaCcZS90ohl36NVZM34QQhZmKncRekUJ4
         VhoJJhnXEm3ebxgZcItkZJEbvfth338G/foBl0G1jOGuvPAzaDdmw7Fw7MjA9CWMIM8p
         OH8kiTR51keUhfEZL6HRv+uMA/9ObP7FsT4Kc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=frI4zsNJmO7DfftwjtU7Nj4udxxRSTXPL+S3bSdKx44=;
        b=du7tsOrLZHw3syEtaLKXVgCC8u5Gwdaki/WTJCU/2qjJZsa4UTEoPfDJsPQoeh2FZY
         VbT1jfL2SvVi5XXHYiEbJ67BEjISh9i75cZ87KRy/FqkqcEG/LvGzCi7TRUnIbl/aJGu
         jKCFO2fWvUKJLwmMcF6Bw2rQfzYX+/qMXxVsOxyZDajAzNSWNg6CM58JClaXtGNwE7cs
         SBDB4PClJN4glS1PHmWfnYn3zeITdiBcqjE0fPsvOu1BovbBvUlMXZ+/qOAJebY6PqjW
         xPnkPNEw+aW7+A89XrTGzQQo/m/Lwp8UfZy35pRQ6kfl/XUESiVShs4ip7ETEJyf5Skj
         5HjQ==
X-Gm-Message-State: AODbwcCjdrdcdJ+ZCvej911Svk5rGLW7Eq3oT8CO4B2TWKQkMTIkljcG
        QCsjmt4Pz8LmkFzzms2Zug==
X-Received: by 10.223.169.171 with SMTP id b40mr5813852wrd.147.1496243187104;
        Wed, 31 May 2017 08:06:27 -0700 (PDT)
Received: from dinwoodie.org ([2001:ba8:0:1c0::9:1])
        by smtp.gmail.com with ESMTPSA id q77sm18444814wmb.4.2017.05.31.08.06.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 May 2017 08:06:25 -0700 (PDT)
Date:   Wed, 31 May 2017 16:06:24 +0100
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] docs: fix literal quoted spaces
Message-ID: <20170531150624.GC18266@dinwoodie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When compiling the documentation, asciidoc thinks a backtick surrounded
by whitespace shouldn't be interpreted as marking the start or end of a
literal.  In most cases, that's useful behaviour, but in the git-pull
documentation the space is clearly intended to be part of the monospace
formatted text.

Instead, use + to avoid asciidoc's literal passthrough, and encode the
space as {sp}.  In particular, this means asciidoc will correctly detect
the end of the monospace formatting, rather than having it continue past
the backtick.

Signed-off-by: Adam Dinwoodie <adam@dinwoodie.org>
---
 Documentation/git-pull.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 942af8e0f..da31c5e40 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -159,7 +159,7 @@ present while on branch `<name>`, that value is used instead of
 
 In order to determine what URL to use to fetch from, the value
 of the configuration `remote.<origin>.url` is consulted
-and if there is not any such variable, the value on `URL: ` line
+and if there is not any such variable, the value on +URL:{sp}+ line
 in `$GIT_DIR/remotes/<origin>` file is used.
 
 In order to determine what remote branches to fetch (and
@@ -167,7 +167,7 @@ optionally store in the remote-tracking branches) when the command is
 run without any refspec parameters on the command line, values
 of the configuration variable `remote.<origin>.fetch` are
 consulted, and if there aren't any, `$GIT_DIR/remotes/<origin>`
-file is consulted and its `Pull: ` lines are used.
+file is consulted and its +Pull:{sp}+ lines are used.
 In addition to the refspec formats described in the OPTIONS
 section, you can have a globbing refspec that looks like this:
 
-- 
2.12.3

