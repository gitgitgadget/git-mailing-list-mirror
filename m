Return-Path: <SRS0=QY2u=4X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77EFC10DCE
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 17:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B6F52051A
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 17:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OwWqXzzj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgCFR3S (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Mar 2020 12:29:18 -0500
Received: from mail-wm1-f48.google.com ([209.85.128.48]:53297 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbgCFR3S (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Mar 2020 12:29:18 -0500
Received: by mail-wm1-f48.google.com with SMTP id g134so3357098wme.3
        for <git@vger.kernel.org>; Fri, 06 Mar 2020 09:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VfiQ4Kg3uSVizuN8syHTHxBOffgiS7F7Ufcy12UgK4Y=;
        b=OwWqXzzjgZ+SHOCs4aPAqO3nQwdJ3RobeUhkX6yAvsI1wzFznX775w+yEtFZjVTnO2
         L2To1W+b4Ney2GFBXpvoE37X6mgCDhf0n3YHYq8tZ+K1NieMa9mME5aywYNol6h0gIpK
         Zj8Jv84bbbbPDwEZccXiWuh5qWG3Zabp2JNWeg7B/GLMPFtJqCRaiE55/2rHmK55Yu1r
         Z8NgE395t4gJJ4g5jRJWhtkmJUDyvE6OumrRBw/o0zTmo6tNZsX/+dQsZ5OZtviiUqVF
         Q6KQNpepkh5XvcqYXHxuw5fKIQ2dqig+/0OqKiTlHb2fc+vuIVDIH1hC5aZD0nkHsg+d
         jQkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VfiQ4Kg3uSVizuN8syHTHxBOffgiS7F7Ufcy12UgK4Y=;
        b=JwWCEsZ8tOrGg0WEYWAEzAwb0aGe49ovLXD1OOPCYPGZlv7reYvRQMLfmStjCUfgLB
         2By9bYGcmyt1ZcOzB040iLx6c2Gm048/OFRQ/5oBXTHuSam7/otdCQs/6OVazmfNwSTO
         WPq8Ppu22mkS+jPIs/6wx+UU942vr2cgUCsnJ6iIa1Vj7Pi/i5n44zv5PAyZsy+lvGrj
         hI5VWnyZpj+J446AFk0mr9HOWX5AQNEgqgKoGX7d8fCgB4P34aHItfKmsE5RQ9EaWkiK
         KBFiWiV5pT/EStTKlt2BDKHVCYhL78XN2flZnc/igSOheoIjrSh4NzIKLVjrOn9ljNs6
         raBg==
X-Gm-Message-State: ANhLgQ2Us2kZhV8N+bS84uRA6/In7VD1u292q4TclkpFbJS5k86CxFoC
        /rRkI4rEiRYj9Zt5MM5Z9ZI=
X-Google-Smtp-Source: ADFU+vtES2zAHN+DKaHQ8vych1Yw4D0MpqkdsCgQVbFfhj6NiU8+5K4zaIyVC/D/jNjbs96FlfD2XA==
X-Received: by 2002:a7b:c857:: with SMTP id c23mr5119267wml.68.1583515755207;
        Fri, 06 Mar 2020 09:29:15 -0800 (PST)
Received: from localhost ([2.28.70.205])
        by smtp.gmail.com with ESMTPSA id i1sm30098588wrs.18.2020.03.06.09.29.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Mar 2020 09:29:14 -0800 (PST)
Date:   Fri, 6 Mar 2020 17:29:13 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
Subject: Re: What's cooking in git.git (Mar 2020, #02; Thu, 5)
Message-ID: <20200306172913.GF1571684@cat>
References: <xmqq4kv24fzo.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4kv24fzo.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/05, Junio C Hamano wrote:
> * tg/retire-scripted-stash (2020-03-05) 2 commits
>   (merged to 'next' on 2020-03-05 at 8e82eb9dec)
>  + stash: remove the stash.useBuiltin setting
>  + stash: get git_stash_config at the top level
> 
>  "git stash" has kept an escape hatch to use the scripted version
>  for a few releases, which got stale.  It has been removed.
> 
>  Will merge to 'master'.

I was thinking only getting this into a release after 2.26 dropped,
and have written the docs with that in mind.  Not sure if this "Will
merge to 'master'" means that you were planning to get this into 2.26?
I have a slight preference for waiting until after the release to
merge this down, but I'm okay with doing it now.  If we want to do so
we need to tweak the description in 'Documentation/config/stash.txt'
to refer to 2.25 instead of 2.26.

Either way, we'll need the patch below on top, as I made an
embarrassing copy-paste mistake.  Sorry for the trouble.

--- >8 ---
Subject: [PATCH] Documentation/config/stash: make description refer to stash

Correct the description to refer to stash instead of rebase.  It was
copied from Documentation/config/rebase.txt, and this author was not
careful enough to replace all occurrences of rebase properly.

Reported-by: Jacob Keller <jacob.keller@gmail.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Documentation/config/stash.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config/stash.txt b/Documentation/config/stash.txt
index 0f3db821f6..be81bd1656 100644
--- a/Documentation/config/stash.txt
+++ b/Documentation/config/stash.txt
@@ -1,7 +1,7 @@
 stash.useBuiltin::
 	Unused configuration Variable.  Used in Git versions 2.22 to
 	2.26 as an escape hatch to enable the legacy shellscript
-	implementation of rebase. Now the built-in rewrite of it in C
+	implementation of stash. Now the built-in rewrite of it in C
 	is always used. Setting this will emit a warning, to alert any
 	remaining users that setting this now does nothing.
 
-- 
2.26.0.rc0

