Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6EB51F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 05:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbeJLM7X (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 08:59:23 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44750 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbeJLM7X (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 08:59:23 -0400
Received: by mail-pf1-f195.google.com with SMTP id r9-v6so5570113pff.11
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 22:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IjIRM20n29dEXLQlGwN61VPpJ49MK/JxH0CzdPNclw8=;
        b=VNVwlLnVevoTUwUXYP7xzex6U75NZhkMuWgvSpHwAAJlW5dbrw0B6mftIaWZ4KJqY1
         fh0P9WAhmdu/fpdTNl8RT2Ecgr9njtMqwPe7iOzw7eImOWNtz9cdTtE55LRSRcQetEG9
         vcbXrjDAEPfucr9moSK0nQmOc8HFgKuyQBjgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IjIRM20n29dEXLQlGwN61VPpJ49MK/JxH0CzdPNclw8=;
        b=cecdQKwYbElzfM2nnxyG8bROuG8zc3kDIIHwmKxLA+GjmzvL3Y7aF4ACkKlEp3VoT9
         OdRjPaYESHd0LXg+MDmiwm/4+mrBwMjz4dtLk5rO9Ri+krGi7neyoUQC7GfFjPlZeQoS
         PHPKw2Df1ja9wqI6btJEHwn5NPBqAFrAGk1mycBt4b8jsZ1WJyuT/RR5c7Gxv8U8tf6M
         Bdf4JrcxHSqLkbEWtcCKsDy2pFDF7i+UMcJZDeesMuybxsmXBuo5GlFstG4LV+rMD2+h
         0eHZrEBkSLS8eazqI83YcqJBXa9CSXUkn7/vWYtE/Je/fSO62sDypS0KfreifSquzEiF
         nZ1g==
X-Gm-Message-State: ABuFfohg9sL+X/8SGs7VdRsjiYIKiZ6D9cVOZR9unS+ivJbwOqYa3Sgq
        qvZywPVookm2ntKuupn5kva0XBqeysTihWOD
X-Google-Smtp-Source: ACcGV61xDLSXb4TN/+93fwxfy1tMWppEXijQEvKDh6iUWkvAVQzfTZkbp6iGv2qZv36NDZu/McFOjA==
X-Received: by 2002:a63:1f0a:: with SMTP id f10-v6mr4153927pgf.313.1539322120908;
        Thu, 11 Oct 2018 22:28:40 -0700 (PDT)
Received: from lgd-kipper.hsd1.ca.comcast.net ([2601:646:8581:1fcf:8286:f2ff:fe24:931b])
        by smtp.gmail.com with ESMTPSA id t26-v6sm209110pfa.158.2018.10.11.22.28.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 22:28:39 -0700 (PDT)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Chen Bin <chenbin.sh@gmail.com>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        George Vanburgh <gvanburgh@bloomberg.net>,
        Merland Romain <merlorom@yahoo.fr>,
        Vinicius Kursancew <viniciusalexandre@gmail.com>,
        larsxschneider@gmail.com, Lex Spoon <lex@lexspoon.org>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCHv1 0/3] git-p4: improved unshelving
Date:   Fri, 12 Oct 2018 06:28:30 +0100
Message-Id: <20181012052833.6945-1-luke@diamand.org>
X-Mailer: git-send-email 2.19.1.272.gf84b9b09d4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series teaches the git-p4 unshelve command to handle
intervening changes to the Perforce files.

At the moment if you try to unshelve a file, and that file has been
modified since the shelving, git-p4 refuses. That is so that it
doesn't end up generating a commit containing deltas from several P4
changes.

This gets to be more annoying as time goes on and the files you are
interested in get updated by other people.

However, what we can do is to create a parent commit matching the
state of the tree when the shelve happened, which then lets git-p4
create a git commit containing just the changes that are wanted.

It's still impossible to determine the true state of the complete
tree when the P4 shelve was created, since this information is not
recorded by Perforce. Manual intervention is required to fix that.

There are also a few other smaller fixes, the main one being
that it no longer unshelves into refs/remotes/p4/master/unshelved, but
instead into refs/remotes/p4-unshelved.

That's because the git-p4 branch detection gets confused by branches
appearing in refs/remotes/p4.


Luke Diamand (3):
  git-p4: do not fail in verbose mode for missing 'fileSize' key
  git-p4: unshelve into refs/remotes/p4-unshelved, not
    refs/remotes/p4/unshelved
  git-p4: fully support unshelving changelists

 Documentation/git-p4.txt | 10 ++---
 git-p4.py                | 90 +++++++++++++++++++++++-----------------
 t/t9832-unshelve.sh      | 75 ++++++++++++++++++++++++++-------
 3 files changed, 117 insertions(+), 58 deletions(-)

-- 
2.19.1.272.gf84b9b09d4

