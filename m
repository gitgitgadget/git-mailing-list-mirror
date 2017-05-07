Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DA661F9A9
	for <e@80x24.org>; Sun,  7 May 2017 22:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753935AbdEGWfu (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 May 2017 18:35:50 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35254 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752600AbdEGWft (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 May 2017 18:35:49 -0400
Received: by mail-pf0-f196.google.com with SMTP id u26so7503494pfd.2
        for <git@vger.kernel.org>; Sun, 07 May 2017 15:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=0XR87KSaRfwCqNuqBcK3jhNzdt0Kp5FpXaMx+pjRCxE=;
        b=CScxOXKMNRXesQS8xIS/ijF+K+16GeefuMGNZ7n9Y0afembQqSSzKS41IT8PdH1t/i
         whXJoZh5o41Ap/HxJOLq4tMeonpPZP7gZLkIS/f7bVrVBbd1/l+knJeRwFtFQ389vJQx
         0HpApRKVxijyjWU2YALeQ6DqTQTXQa66HGfWr5HDquh5fa4GKomsey6HL7YMGAKdglrr
         6Lbc4XjTvYKY194Xxn/bm6o5z6G2gcPLOMQEsADxv/WaCmX9Y7i8tHzkG9PD4fcOdIhX
         lgByniPiVh2o6FFhfZuE8+eLFZognekUiH8JJ5Rsp3uD9nl6gWSJqJyJexTj9BaQ/0A6
         JdeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=0XR87KSaRfwCqNuqBcK3jhNzdt0Kp5FpXaMx+pjRCxE=;
        b=NzTsTg8CJ6hpLxH5H4rbW2n5yGMK75C9rG85aMTcAAhHEBzkW9fOF2t+eF3oDEKb/F
         MlNalH8IA8g4WQTX1iwe9BRvK6Ws+AIsL7/OUXN1Gb31naW/VeprIRBxOtPL9NOIUjRv
         222bwUag9qgScLMbH1wc/M8dWIjEn+bfDNc8yi1lMex/4LPwwUfD7cVllQZUi904DXnN
         vQClCs7VO2mQFTadep4fzpK/ZP41SEiYCvUf2fJqg6oOPjFTu5x6NktQL1n3e5nQTpqk
         7UxvQuoIBjUH98/6mUWWzFQR9tY+fcEwiwHm+aYx4/GPkZ2dcnEyPY8BFEQBd7+qQpCL
         ASuw==
X-Gm-Message-State: AODbwcBJGHBww/w/7PEVdCf7pgZ7vJqNWEirM6fWtQXxksGkwJLIFvAI
        8SYBwdpUuC5jxy40
X-Received: by 10.98.130.1 with SMTP id w1mr985435pfd.128.1494171328836;
        Sun, 07 May 2017 08:35:28 -0700 (PDT)
Received: from HP ([110.64.73.123])
        by smtp.gmail.com with ESMTPSA id d13sm1312439pfl.12.2017.05.07.08.35.26
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 May 2017 08:35:27 -0700 (PDT)
Date:   Mon, 8 May 2017 07:35:14 +0800
From:   Yubin Ruan <ablacktshirt@gmail.com>
To:     git@vger.kernel.org
Subject: [RFC] Add warning when git discard changes on another branch?
Message-ID: <20170507233512.GA9332@HP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
I think it would be better if git can warn use if we switch to another branch
without committing the modification. Git will warn if the modification is based
on a commit different from where the checkout happened.

For example, say I am now on branch 'master' and all files *clean*. Now if I do:
    $ git checkout -b issue
and make some changes to a file:
    $ echo "modification on branch issue" >> lala.txt
and then switch back to branch 'master':
    $ git checkout master
and git can see the changes:
    $ git status
      On branch master
      Changes not staged for commit:
        (use "git add <file>..." to update what will be committed)
        (use "git checkout -- <file>..." to discard changes in working directory)
      
      	modified:   lala.txt
      
      no changes added to commit (use "git add" and/or "git commit -a")
      
Now, if I do "git checkout -- lala.txt", then I will lose that change on branch
'issue' too!!! 

If, on branch 'issue', the changes to 'lala.txt' are based on a commit different
from where the checkout happened, i.e.
     
    on branch 'master'
        |
        |  <-- git checkout -b issue
         \
          \  <-- modification to git happened on a commit different from where
                 the checkout happened

then git would warn us something like this:

    error: Your local changes to the following files would be overwritten by checkout:
    	lala.txt
    Please, commit your changes or stash them before you can switch branches.
    Aborting

So, I think it is better to add some similar warinings if the modification
happened on a commit the *same* as where the checkout happened, i.e.

    on branch 'master'
        |
        |  <-- git checkout -b issue
           <-- modification to git happened on a commit different from where
               the checkout happened

I already lost some of my work by this ...

(p.s please add me to the Cc because I am not in this list)
---
Yubin
