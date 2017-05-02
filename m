Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DD22207D6
	for <e@80x24.org>; Tue,  2 May 2017 04:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750734AbdEBEBT (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 00:01:19 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:33607 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750713AbdEBEBS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 00:01:18 -0400
Received: by mail-io0-f194.google.com with SMTP id o22so1894863iod.0
        for <git@vger.kernel.org>; Mon, 01 May 2017 21:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=vzA6ckdC54ogaoXZiOi+jlHsSpFGV13/1R9UAH/Wsn8=;
        b=Ac9uarjlVIW3uixyJIyzbHpHsbYL+L62v0jPovXMZcgYuet4dPnXaKAs/RppAcp/wk
         CQ7uRAs4HdfIiGTYaFCYXdGKUCEzCVPn7FXRI46FGB+VuBC4NKTMzDveFNBLiLiUUVaM
         su4ah4w2QGVOxyusmPdYTInbAsl7jPtoDzu5bliaFzyvlazfJSXGNvPMwksCdzPsW8I/
         Yz9N4OHmMVrfDd7Ef1FGGDmWmqA+UF4opao5t4vnn/+MpqYeB98KJ+dybIGlNaNKhkNm
         0kvtS67IzwgRi+0sRq3j6mFWgoaypVVIfcg9amFHwtDwJjVcd5Kv7pQuv2Yocir1z/fv
         khjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vzA6ckdC54ogaoXZiOi+jlHsSpFGV13/1R9UAH/Wsn8=;
        b=jURaG3vbFoJXORtY+XCyl/yfG9sp0C5Q0c538EfEMLSWsz6m6kG8J7a37fgKXgCgyc
         IwziWy3noGSf89ZrurNMXjW95OsX50GnmnLdKOcx1JC/igrLxX9Npl1UlMqMx1x3h87C
         MnRWjnHHPeQEIbOMCgZpXGtTY4ySy/4P6wzCmPrRyib4wbxJd8jIDBPdv1LfWjKG6vHU
         UmmGRo/9rsdhHcBqRF9HdPKaWBYYTJxVwgvFHLqhK0NPVZpUeweQPsNkiK8AXWkkOb/W
         ZoF9/1gWcfDOX0q8jJGoBvaZ3fcHrB+SDeleFeIoekTwqPEYd8NadApO5i+Xgt5E71f0
         08tw==
X-Gm-Message-State: AN3rC/71i/jOm9yTV99/M/yEqL0sAQDH3pjPejh+uLMaFT/rjitgbytH
        U3QtuOqV++ZUWw==
X-Received: by 10.107.9.37 with SMTP id j37mr26529163ioi.43.1493697677570;
        Mon, 01 May 2017 21:01:17 -0700 (PDT)
Received: from localhost.localdomain (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.gmail.com with ESMTPSA id p65sm7211762ioe.3.2017.05.01.21.01.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 May 2017 21:01:17 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, peff@peff.net,
        Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH v3 0/6] rebase -i: add config to abbreviate command-names
Date:   Tue,  2 May 2017 00:00:42 -0400
Message-Id: <20170502040048.9065-1-liambeguin@gmail.com>
X-Mailer: git-send-email 2.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the 'rebase.abbreviateCommands' configuration option to allow
`git rebase -i` to default to the single-letter command-names in
the todo list.

Using single-letter command-names can present two benefits.
First, it makes it easier to change the action since you only need to
replace a single character (i.e.: in vim "r<character>" instead of
"ciw<character>").
Second, using this with a large enough value of 'core.abbrev' enables the
lines of the todo list to remain aligned making the files easier to
read.

Changes from v1 to v2:
 - Improve Documentation and commit message

Changes from v2 to v3:
 - Transform a single patch into a series
 - change option name from 'rebase.abbrevCmd' to 'rebase.abbreviateCommands'
 - abbreviate all commands (not just pick)
 - teach `git rebase -i --autosquash` to recognise single-letter command-names
 - move rebase configuration documentation to Documentation/rebase-config.txt
 - update Documentation to use the preferred naming for the todo list
 - update Documentation and commit messages according to feedback

Liam Beguin (6):
  rebase -i: add abbreviated command-names handling
  rebase -i: add abbreviate_commands function
  rebase -i: add short command-name in --autosquash
  Documentation: move rebase.* config variables to a separate
    rebase-config.txt
  Documentation: use prefered name for the 'todo list' script
  Documentation: document the rebase.abbreviateCommands option

 Documentation/config.txt        | 31 +-----------------------
 Documentation/git-rebase.txt    | 21 +++-------------
 Documentation/rebase-config.txt | 53 +++++++++++++++++++++++++++++++++++++++++
 git-rebase--interactive.sh      | 24 ++++++++++++++++++++----
 4 files changed, 78 insertions(+), 52 deletions(-)
 create mode 100644 Documentation/rebase-config.txt

-- 
2.9.3

