Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3698C4332B
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 23:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBC602072C
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 23:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUC+S6z3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbgCTXLi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Mar 2020 19:11:38 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:40396 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbgCTXLi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Mar 2020 19:11:38 -0400
Received: by mail-pj1-f66.google.com with SMTP id bo3so3125604pjb.5
        for <git@vger.kernel.org>; Fri, 20 Mar 2020 16:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=NmSPiQqLNUuETBX4+DdiWcEYo6boSy9GbawNBeEiAI0=;
        b=mUC+S6z3/k5nOF8x1HEe4+pKhkX656cRKlneKpD2T4HMmLj8HGDs1SR+GuZbw2pc2d
         Xi1PeTweRyYTwVthuix7+s5AUaP7QSDjuXDvt7OnIU93lHrPoPR9k/HO+XZpm3p3/ebh
         GFqwbqXvpnv2rTjfC/BGrHtf1q3im9IKidJ/CI0XocIw2CL1vgM8KXZfIOkEJObu5uZx
         icMQS5nucN2ELBGfAJ+S91bgWyuNebW2AZ15jJYS2d3O8dba2SKyQBNDVvxP8BLyMI25
         cr5IAF6Ut/bJHh1jxqdjXhNtGU36ihUJsbrpO18iR/S/ZFICDF1HKN4fv32zdRvS0/Zp
         uj/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=NmSPiQqLNUuETBX4+DdiWcEYo6boSy9GbawNBeEiAI0=;
        b=cweLE7AkrQzWRb3Fi2NGTUdSTg9Gm++TCiMFag8qwGzdSBcDCZuEkk3f8f1MFJtOSc
         IdUzG0fPlRubxrF6hK4snQe9zQePnmDB/eGQ4VfRuYR/dN54Bbfpi1y5riZs7wejxW4j
         Rqe/EadMVV5A/6pZ11in9S4erhzUuaxtZV01GakkvlZ9H63EaI1OgLsc6Hk1b1/75kpZ
         3jlKOt7zdypuj45s9nLRWB5R+uDnYVw1WBgvA3bww0cdJ0qpMPOgg6YFiN5szO4ofJCX
         wdDRf2VcoLva1Hb/gWSbepYtS4Wppm9TEd6QRPbgbpGJv4MaOJoJOTYhZun0i6VgKOY2
         /HTA==
X-Gm-Message-State: ANhLgQ0p/hVymTDQRSdFkWd/BWByI3rw2u79Wlo4ZM33MEleRymkkGsW
        RuUDS+hfY1CdDW97h6hqj+dEoyd8
X-Google-Smtp-Source: ADFU+vvsO1bTHCMJt/83nj3mYittZMA92bug3pf+S7RuWJjFZZgqZCb7uqVZY9xYLPHB1z4kj2ZGVA==
X-Received: by 2002:a17:902:7441:: with SMTP id e1mr10567443plt.291.1584745896936;
        Fri, 20 Mar 2020 16:11:36 -0700 (PDT)
Received: from [192.168.0.113] ([27.106.4.235])
        by smtp.gmail.com with ESMTPSA id w19sm6322048pgm.27.2020.03.20.16.11.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2020 16:11:36 -0700 (PDT)
To:     Git Mailing List <git@vger.kernel.org>
Cc:     chriscool@tuxfamily.org
From:   Parth Gala <parthpgala@gmail.com>
Subject: [GSoC Project RFC] "git log --oneline" improvements
Message-ID: <28aee28c-8e8d-763a-66c7-d365025e56a2@gmail.com>
Date:   Sat, 21 Mar 2020 04:41:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey everyone,


I am Parth Gala. I am second year major in Electronics and Communications
Engineering at Dwarkadas J. Sanghvi College of Engineering. I am interested
in participating for GSoC 2020 under the Git organisation.

First of all I would like to apologise for sending in my participation so
late. I lost 2 crucial weeks of discussion from the end of Feb due to some
personal problems. I was initially interested in working on the rewrite of
submodule from shell to C, but after checking the mailing list I saw that
Shourya Shukla had already taken it up and had started work on it, so I
felt it wise to leave it to him. So all the reading that I did for
submodules had to be repeated for this project.

I went through the discussions here[1] and here[2] and what I could
conclude from [1] is, the 'git log --oneline' command currently shows the
decorations of a commit before the commit message but after the shortened
hash due to which the alignment of the messages is disturbed like this,

     3f07dac29 (HEAD -> master) pathspec: don't error out on 
all-exclusionary pathspec patterns
     ca4a562f2 pathspec magic: add '^' as alias for '!'
     02555c1b2 ls-remote: add "--diff" option to show only refs that differ
     6e3a7b339 (tag: v2.12.0-rc0, origin/master, origin/HEAD) Git 2.12-rc0
     fafca0f72 Merge branch 'cw/log-updates-for-all-refs-really'
     74dee5cfa Merge branch 'pl/complete-diff-submodule-diff'
     36acf4123 Merge branch 'rs/object-id'

And if the decorations were to be shown after the message and you were
checking the logs just to see the status of a branch rather than the
contents then you would again be at a disadvantage, since you would want
to have them visible right next to the hashes. Besides decorations at the
end would have the inconvenience of being truncated at the end of the line
on smaller screens.

This format for --oneline with decorations was decided upon,

   b9df16a4c (HEAD -> master)
             pathspec: don't error out on all-exclusionary pathspec patterns
   91a491f05 pathspec magic: add '^' as alias for '!'
   c8e05fd6d ls-remote: add "--diff" option to show only refs that differ
   20769079d (tag: v2.12.0-rc2, origin/master, origin/HEAD)
             Git 2.12-rc2
   076c05393 Hopefully the final batch of mini-topics before the final

In [2] such formats with date and timestamp are discussed along with
compatibility for --graph option as well,

   === 2015-09-17 ===
   * ee6ad5f4 12:16 jch (tag: v2.5.3) Git 2.5.3
     === 2015-09-09 ===
   * b9d66899 14:22 js  am --skip/--abort: merge HEAD/ORIG_HEAD tree 
into index
   |   === 2015-09-04 ===
   | * 27ea6f85 10:46 jch (tag: v2.5.2) Git 2.5.2
   * 74b67638 10:36 jch (tag: v2.4.9) Git 2.4.9
                        ..........
   * ecad27cf 10:32 jch (tag: v2.3.9) Git 2.3.9

So these are the two main formats to be enhanced along with as many options
of log as possible. What are your views on this ?

Also, I had submitted a patch series here[3] but I felt it was trivial so
took upon a bug fix[4] which is yet to be sent to the mailing list for
discussions.

I am currently drafting my proposal which I will send for discussion
after having received comments here.

Thanks :-),

Parth.

[1] : 
https://lore.kernel.org/git/xmqqeg42fslw.fsf@gitster.mtv.corp.google.com/T/#t
[2] : 
https://lore.kernel.org/git/CA+55aFwT2HUBzZO8Gpt9tHoJtdRxv9oe3TDoSH5jcEOixRNBXg@mail.gmail.com/T/#t
[3] : 
https://public-inbox.org/git/pull.545.git.1581535151.gitgitgadget@gmail.com/#t
[4] : https://github.com/gitgitgadget/git/pull/582
