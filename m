Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFFF0C63797
	for <git@archiver.kernel.org>; Sun, 15 Jan 2023 22:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjAOWrI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Jan 2023 17:47:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbjAOWrG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2023 17:47:06 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497DC1B57A
        for <git@vger.kernel.org>; Sun, 15 Jan 2023 14:47:05 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id g9so8788498qtu.2
        for <git@vger.kernel.org>; Sun, 15 Jan 2023 14:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZmYylSTL4G/h8dVIXJ0FLsASr3qr7gnzuxLeYYij9xo=;
        b=RyWsaaQM5vh/hnvRITTeocso7Si5cijfCTwzb2/fo7CYWR+Po/kNYiwEPQ20Y0sgqO
         UGpy3igMlofPh/dF0sELFdmFM/lXotvxWOYIPfoFYD+lH3/EocycDKLdquUZ+NDj7lQQ
         sgxrHRjtGulO1VR2dgiffYBSJUbl5Ik5xciO+J0FRM2jCWy3FA3FYctM4gfwurW8oCQj
         3w0z4jgocwJ9EYWkQMQ58DoLJZAq2p7RvMCrt5ZfkIAXj8JoATPShV9zaC6qF7pCBhoe
         X8RF2guh6RlzMkrQQKbCc2D7fiqcjARG5JK5SQaOKdL1cUJe3DLDPAyy+nxgj8T7loCO
         L7eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZmYylSTL4G/h8dVIXJ0FLsASr3qr7gnzuxLeYYij9xo=;
        b=wZUFohg+zAPL6LlTQfY8LHDgzNZ41fNxdZ/dhfZf2nJ9bYA+F/YI3EWsZw1cSWPFLg
         PnMi1QY/sv5VMgp17JGMhSBjZUUxNJ8HnzB8SrVQnHcK+B0ZBreN68NxrEEdraMC3eLs
         TDxO5vb4fiItOOalIh0yiWYaJjStrJJ4X1d4tey0W/5AEDP8mK3yjTBHtLEizOv0rg0T
         c9m6QaZvRRL9VFPpP3qVPKgr17qDs9RUPNyuLw6GNH+9IxHUjXy09v5Jtjlqsp9vhPPb
         TxO4aD6xOHPw9wwxZfpace/voVeExYYGHetfDtajFiTfQ9cINRWVZUpXTYGGPUrxzVvi
         zHDQ==
X-Gm-Message-State: AFqh2koIfJ80lWK37KAchPv9OZTIqIX/EYfDO36nY4sER+0fhc5GmOSd
        +SRL7w0VZMoe4GGuZY7a07gZjqoYIvom7A==
X-Google-Smtp-Source: AMrXdXvHV/psALlaMuN8Gih4aESrQvl2/HZhytoOUSEPW6BoCtDXyc3fSR4sWWHKm0kHnh25DlbzIQ==
X-Received: by 2002:ac8:5f91:0:b0:3b2:e9c2:37f3 with SMTP id j17-20020ac85f91000000b003b2e9c237f3mr18225628qta.16.1673822824370;
        Sun, 15 Jan 2023 14:47:04 -0800 (PST)
Received: from localhost.my.domain ([2601:6c1:c281:3430:223:24ff:fe37:484e])
        by smtp.gmail.com with ESMTPSA id z26-20020ac8711a000000b003b62dcbedb8sm1477197qto.74.2023.01.15.14.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jan 2023 14:47:03 -0800 (PST)
Date:   Sun, 15 Jan 2023 17:47:02 -0500
From:   Crls <kaploceh@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     git@vger.kernel.org
Subject: Re: ctrl-z ignored by git; creates blobs from non-existent repos
Message-ID: <Y8SCZvMu7DZZH1Pl@localhost.my.domain>
References: <632d051b-d81b-b35d-0641-c2488a124810@gmail.com>
 <Y8Qfj32h89hq5UD6@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y8Qfj32h89hq5UD6@mit.edu>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 15, 2023 at 10:45:19AM -0500, Theodore Ts'o wrote:
> On Fri, Jan 13, 2023 at 05:01:01PM -0500, Crls wrote:
> > Ctrl-Z is ignored by git; Git-clone injects blobs even with non-existent
> > repos
> > 
> > Steps to reproduce 1- git clone github whateverrepo/whatevernonexistentrepo
> > or 1- git clone gitlab whateverrepo/whatevernonexistentrepo 2= Git prompts
> > for a username
> 
> % git clone github whateverrepo/whatevernonexistentrepo
> fatal: repository 'github' does not exist
> 
> I think what you meant was:
> 
> % git clone https://github.com/whateverrepo/whatevernonexistentrepo
> Cloning into 'whatevernonexistentrepo'...
> Username for 'https://github.com': 
> 
Yes. That's what I meant… thank you. I was having a problem with the formatting while sending the message to the mailing list

Content-Policy reject msg: The message contains HTML subpart, therefore we consider it SPAM or Outlook Virus. TEXT/PLAIN is accepted.! BF:; S229631AbjAMVJQ (in reply to end of DATA command)


> > 3- Press Ctrl-Z to stop *git* from running either on the virtual console/tty
> > *git* automatically creates blobs with directories and disregards
> 
> So it's not that Control-Z is being ignored.  It's that by the time
> you see the prompt for "Username for 'https://github.com': ", the
> directories already exist.  Try looking at
> whatevernonexistentrepo/.git as soon as the prompt shows up.  You'll
> see that the .git directory has been greated.
> 
> Now, when you type ^Z, the git processes are stopped --- but the
> objects are created already.

The directories exist not because ^Z is used, but because by the time git-clone prompts for a username, git is already set on what to do next. Correct? in other words, the process is shoved down my throat. Or the user's throat in this case. Or going by another analogy, it certainly sounds as if I meant: «Git, please git-clone such and such repo, but let me fix just a typo on the repo name before submitting it, pretty please» and then Git replies: «too late for that chick-a-doodle» and there it goes. It injects blobs all over (well, not all over but on the dir specified).


> 
> Username for 'https://github.com': ^Z
> [1]+  Stopped                 git clone https://github.com/whateverrepo/whatevernonexistentrepo
> % ps aux | grep git
> tytso       5097  0.0  0.0   9736  4480 pts/0    T    10:41   0:00 git clone https://github.com/wha
> tytso       5098  0.0  0.0   9736  3992 pts/0    T    10:41   0:00 /usr/lib/git-core/git remote-htt
> tytso       5099  0.0  0.1 102332 16104 pts/0    T    10:41   0:00 /usr/lib/git-core/git-remote-htt
> tytso       5140  0.0  0.0   6332  2072 pts/0    S+   10:43   0:00 grep git
> 
> 
> The 'T' means that the processes are stopped.
> 
> > Expected: The same issue does not happen with other non-existent repos e.g.,
> > git clone git.zx2c4/ it returns the message of fatal repo not found
> 
> So what's going on is that github.com is not returning a non-existent
> repo error; it's prompting for a username/password, as _if_ the
> repository exists.  That's presumably to prevent disclosing
> information as to whether or not a private repository exists or not.

I agree with you there. Coincidentally speaking, why does a username warrants a prompt from git, is simply beyond me. I mean, that is certainly the more far-fetched reasoning of implementation I've read in a long long time.

Can you git-clone a user? What about the user's settings? What about the remainder its gpg tokens and so forth? In other words, if a user's repo is not found, why even prompting for a username? The latter, that is, the user's repo, is redundant,  when the prompt is clearly asking for a username, and not a repo.


> 
> Once the authentication fails, git will remove the partially created
> repro, so it's really not a problem in practice.
> 
> Cheers,
> 
> 						- Ted

Not true. Preventing the disclosure of information has nothing to do with the issue here. If anything seems clear to me, is that prompting for a username, does indeed disclose usernames, private, public and whatnot from either github or gitlab.

And Technically speaking, yes, I agree with you in that if ^Z main operation is to suspend the process, there's not much further ado. Right?

p.s

I consulted this issue with Thomas Dickey, before sending an email through this interface, and he acknowledges that the operation from git occurs before. Thus confirming some of your statements, and also… that by the time git exits and it's done with,  in whatever dir of my choosing, ^Z couldn't do anything else about it. But I beg to differ. While ^Z may not do anything about it, then git should instead. Or so I think.

running stty -a returns:

swtch = <undef>; start = ^Q; stop = ^S; susp = ^Z; rprnt = ^R; werase = ^W;

take care Ted

Carlos


-- 
Seems a computer engineer, a systems analyst, and a programmer were
driving down a mountain when the brakes gave out.  They screamed down the
mountain, gaining speed, but finally managed to grind to a halt, more by
luck than anything else, just inches from a thousand foot drop to jagged
rocks.  They all got out of the car:
        The computer engineer said, "I think I can fix it."
        The systems analyst said, "No, no, I think we should take it
into town and have a specialist look at it."
        The programmer said, "OK, but first I think we should get back
in and see if it does it again."
