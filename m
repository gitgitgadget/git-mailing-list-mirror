Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E51651F461
	for <e@80x24.org>; Fri, 23 Aug 2019 13:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405672AbfHWNi5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Aug 2019 09:38:57 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:46327 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbfHWNi4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Aug 2019 09:38:56 -0400
Received: by mail-wr1-f41.google.com with SMTP id z1so8658003wru.13
        for <git@vger.kernel.org>; Fri, 23 Aug 2019 06:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=S95ADlXMMVg/Cc9rpt/vieBcnSHFF3jcprenIwD/ADg=;
        b=p+dlVthYXAK1yzTkLKcFRPFq/LKE40y1EuCzJv0bFn6e5nMip5ADdWfpNKUUPy43vJ
         STWU+zdDzvQ2ma8jJPDb+TB9aionoNgbyC0NuukeWptzK9OvA8wFpXYkgR4wiMO3hdZm
         qdaQD62miNrVu5sXhrBjlsitm/rXDBVzHObBqBiNPTaPKkWT3jrlnxQRYjfaRvOlvUpx
         WYaIZ8e+gXKsKNQmUWj19iUUy+zkfRB3pb7tyt0mKqJN62+kOvbTaUtkY1RFPeAB3HbV
         TBiWjwhk2P5tQhD5a7ZC9MuRq/faSpbhaOSVdf7+ClbdnPt8ruvAfR0+3b+P0C253K6Y
         cDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=S95ADlXMMVg/Cc9rpt/vieBcnSHFF3jcprenIwD/ADg=;
        b=SPDd6q1yfB1Hn+gupoYMOReIdnvY1f3KApli3Sb+RTduWCIoOn7TmWBQlabff4LnD9
         TZpDuIzvVdLEJOvMprpVArzoj0FzLAP0Xr7h7ssTPFyG3eoiM7ST9R7JCiTPPigYBeiZ
         YWDlpuyWy7c5vg7aOSh8Qp1d2D0HR/e8KPBT4i0JesdqomqGX/RtD6SSNGYvZCSLk7XF
         WwrufQJ4+U4BuK9cGsBmcqUDIevfW3DStYNTqvyi7un4L9q+rtlPTRhqRGaV1iett4eh
         7xCik5E9ufqa2iqA6xgKNbDJ3IQ7ptj8qJ0Q7CDDtPVKBJvio6yT/qGzuMPNArOxqerP
         XN3g==
X-Gm-Message-State: APjAAAWenGjQo3jbStokr7f5hiNMLWJ8gxubirQsKphae/v8A08DDtGv
        I02dpoHT2g0fvrJsLFdCphQySG1I
X-Google-Smtp-Source: APXvYqxdFomPgl3M9xWlXw8ri3+WF/U+R2AC/vzTQinAu7NSVPDCqgGse+hSZ5VrTBc9g3K2cldyIg==
X-Received: by 2002:adf:b60c:: with SMTP id f12mr4734502wre.231.1566567533860;
        Fri, 23 Aug 2019 06:38:53 -0700 (PDT)
Received: from szeder.dev (x4db558a2.dyn.telefonica.de. [77.181.88.162])
        by smtp.gmail.com with ESMTPSA id j9sm3536400wrx.66.2019.08.23.06.38.52
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Aug 2019 06:38:53 -0700 (PDT)
Date:   Fri, 23 Aug 2019 15:38:50 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Subject: bug: interactive rebase's 'edit' insn copies notes to newly inserted
 commit
Message-ID: <20190823133850.GK20404@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I noticed that somehow two commits on the same branch ended up with
the same note attached.  I believe that this is the result of me using
interactive rebase's 'edit' instruction to insert new commits, and
then it copied the note from the edited commit to the commit from from
where I 'git rebase --continue'-ed.

Here's a simple illustration:

  $ git log --oneline --notes
  70be36f (HEAD -> master) third
  02b5ef9 second
  Notes:
      A note on the second commit
  
  f93427a first
  $ git config --get notes.rewriteref 
  refs/notes/commits
  $ git rebase -i HEAD^^
  ## Change the instruction sheet to 'edit' the "second" commit ##
  Stopped at 02b5ef9...  second
  You can amend the commit now, with
  
    git commit --amend 
  
  Once you are satisfied with your changes, run
  
    git rebase --continue

  $ git commit --allow-empty -m "Insert new commit #1"
  [detached HEAD 2d05076] Insert new commit #1
  $ git commit --allow-empty -m "Insert new commit #2"
  [detached HEAD 0ed24dc] Insert new commit #2
  $ git rebase --continue 
  Successfully rebased and updated refs/heads/master.
  $ git log --oneline --notes
  b02a593 (HEAD -> master) third
  0ed24dc Insert new commit #2
  Notes:
      A note on the second commit
  
  2d05076 Insert new commit #1
  02b5ef9 second
  Notes:
      A note on the second commit
  
  f93427a first

Notice how the note now appears twice, because it has been copied from
the (unmodified) "second" commit to the last commit that has been
inserted on top before continuing.

I certainly didn't expect this, and can't readily see a use case where
it's desirable, but maybe I just lack imagination :)  However, once
rebase stops for the 'edit' instruction the user can do just about
anything, so I'm not sure how rebase could figure out when to copy the
note and when not.

This is not a regression of following the rewrite in C, the scripted
version had the same behavior (I think v1.8.0 was the oldest I tried).

This doesn't happen when inserting a 'break' instruction between
picking the "second" and "third" commits, and then adding new commits.
Alas, the 'break' instruction is not even a year old, and I have been
using 'edit' for this purpose for over a decade now...  so
re-training my fingers will be hard :)

