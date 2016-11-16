Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A3E72042F
	for <e@80x24.org>; Wed, 16 Nov 2016 23:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932250AbcKPXin (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Nov 2016 18:38:43 -0500
Received: from mail-it0-f52.google.com ([209.85.214.52]:37152 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932676AbcKPXim (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2016 18:38:42 -0500
Received: by mail-it0-f52.google.com with SMTP id y23so3016984itc.0
        for <git@vger.kernel.org>; Wed, 16 Nov 2016 15:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=GM71/BEROMSH/x0Bts+1dT7+koFd4mocLrE1/Df+NaM=;
        b=t1yPhqm30nymMJVnguxBPmsXJP6bJR2nKUmr5y2xZz4ERb+7zGG8joyn1iPHWN/H7I
         TrJdre5tyM6bT7cnfzXUPTe725AvDJ6Wm9ZMuQ6smajyPT592xQr/TvdAkJ3jqt7O/4W
         8OoctDtUP5tCWKeUC0Z/ie0yZK2Wq11g0MeKVHsjcNtygUcZ81qgOtg6YDj7Icu9RFSG
         hdyn+TaXSy7uqU2J264Th7S/HPDBgTdvOGLNcWDly+XbFUadLR12mbuhq7P7USEmO7IA
         3izy3I363pcsQqSK575lUrMVGpryW7PybxhbCaK3BlpJ2ls22AHq/zUyW8G938c5+L3R
         srpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=GM71/BEROMSH/x0Bts+1dT7+koFd4mocLrE1/Df+NaM=;
        b=EqX7oXDXjzUrxLp0EFG5tKX+goly+YjCQ0c9G+RC3ie98g9G9lQADjjzzX5mtMOzbQ
         pb0fxDEu3YxuYJVKJwEMJRJgsoUjHRdJrUrcx1Th88BpA/HZrWD7creXFTwDYC8Z1RFK
         bpb4MP7EYOCZCs7/vH6Lk2fCeGGig5vT57pcf9tSNvXwwSirZ2H2ogYwcHproUwzZTNZ
         oaNu8VjCxCzw8EQREXHZmF2totPjDBP4FHGQHBq2PxK3srWr4m5DkiFwhVgG4ETfu4ar
         8EWUCtNXL57m1E2tj9eVu40XAIQt796JctZDic77yMQYesqvDnpEwsZIJndNo3KAXmzK
         9YHw==
X-Gm-Message-State: AKaTC00N/7lrDSoLFU1D+vUHI1KuI0A8Qg6TYo6RdiYXrKp7W6a7ER3QDZHA8DtfurUGcyjc4LmlA/I9FYqFag==
X-Received: by 10.107.179.195 with SMTP id c186mr577332iof.35.1479339521061;
 Wed, 16 Nov 2016 15:38:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.164.219 with HTTP; Wed, 16 Nov 2016 15:38:40 -0800 (PST)
From:   Norbert Kiesel <nkiesel@gmail.com>
Date:   Wed, 16 Nov 2016 15:38:40 -0800
Message-ID: <CAM+g_NvFhyReNREpTYKbXKm=8QmSH1tnrTCyFm9HusOnfAbCCA@mail.gmail.com>
Subject: [Bug?] git notes are not copied during rebase
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I am currently a heavy user of rebasing and noticed that my notes
don't get correctly applied, even if notes.rewrite.rebase is set
explicitly to true (though manual says that is the default).

Below is a use case that shows that a commit on a branch got rebased,
but the note was not copied to the new commit.

% mkdir notes
% cd notes
% git init
Initialized empty Git repository in /tmp/notes/.git/
% date
% git add a
% git commit -m c1
[master (root-commit) 2e24a91] c1
 1 file changed, 1 insertion(+)
 create mode 100644 a
% git checkout -b mybranch
Switched to a new branch 'mybranch'
% date
% git add b
% git commit -m c2
[mybranch 5ef9954] c2
 1 file changed, 1 insertion(+)
 create mode 100644 b
% git notes add -m note1
% git log
commit 5ef9954 (HEAD -> mybranch)
Author: Norbert Kiesel <nkiesel@metricstream.com>
Date:   Mon Nov 14 15:48:00 2016 -0800

    c2

Notes:
    note1

commit 2e24a91 (master)
Author: Norbert Kiesel <nkiesel@metricstream.com>
Date:   Mon Nov 14 15:48:00 2016 -0800

    c1
% git notes
c39895a0948c17df2028f07c3ec0993a532edabf
5ef9954dbadddfccefe95277be5e7a995335124b
% git checkout master
Switched to branch 'master'
% date
% git commit -a -m c3
[master 1368832] c3
 1 file changed, 1 insertion(+)
% git rebase master mybranch
First, rewinding head to replay your work on top of it...
Applying: c2
% git log
commit 8921cb7 (HEAD -> mybranch)
Author: Norbert Kiesel <nkiesel@metricstream.com>
Date:   Mon Nov 14 15:48:00 2016 -0800

    c2

commit 1368832 (master)
Author: Norbert Kiesel <nkiesel@metricstream.com>
Date:   Mon Nov 14 15:48:00 2016 -0800

    c3

commit 2e24a91
Author: Norbert Kiesel <nkiesel@metricstream.com>
Date:   Mon Nov 14 15:48:00 2016 -0800

    c1
% git notes
c39895a0948c17df2028f07c3ec0993a532edabf
5ef9954dbadddfccefe95277be5e7a995335124b
