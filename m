Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1DDCC433DB
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 14:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC993239D4
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 14:27:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbhAUOYS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jan 2021 09:24:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730975AbhAUOXl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jan 2021 09:23:41 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931F4C061575
        for <git@vger.kernel.org>; Thu, 21 Jan 2021 06:22:53 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id z22so1590018qto.7
        for <git@vger.kernel.org>; Thu, 21 Jan 2021 06:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=t+uBJUKHRj/IiNftrGJ+xZPcZKi9TgZASiOegIWsxxM=;
        b=uKvRXiUkZAt7M/7GaC89zrKbSQdmTwORSWS0rnqqER8HcDUhc9KjLmLv6gSVW/lHXF
         92zuQIfK1wDOHK854GK+qGegcutI3Yhyhfhqz/GawzI+y6vlibxe/ISo27rEP+WdVtRq
         oqqP0OLf4RS/zcyuPIpSpOWDugLT5gHzxHl3QcK3g1a/2pCk/EbPqWXxlRhiOKNipnTd
         1NDhiCxE8GQEDg3iR1h7Umxy8UfILbjs8skZASq5ViNvCIo0QVp7VAUTf8TVvGK2Wk8U
         9+rysteMlImKzgZ9tnCXeBuFqNTcT1gjAnVk8DiwCkYWVYV0R0MPvz2m4/Qlsg17ad16
         VmAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t+uBJUKHRj/IiNftrGJ+xZPcZKi9TgZASiOegIWsxxM=;
        b=Bn2dThQFwxY+7qy7r5tQhN2alEBr2YD/27AhzUNRjY8BnhvLFFtk6ncJeeAEJXUS5v
         C//MMcXt2pwx4zh0/Zv7wFcc6expIRbO/SSlVjSb18VGurkpm0X09/h/kCKdAUSgSOec
         6tKzVxhZvh3X0x9flT0EJVvymqWJk7UmAGDKUwwjuAbPxWkTSKIuPA3gNfcNQ/sYGJqv
         eeEocRBttEsoz4Oj1tOrNreYjTStq7sunrGlOr03ijqoKmZImMVkY4Q2fzg1jqPWbpru
         BrIyCG7g0rQitGhR4e6hv86+qblWiAqyalgY1oPkLcU/Be5cDBLfkLq8VQ3k55XfeHUP
         E1rw==
X-Gm-Message-State: AOAM533I65qZmIRB1Ai8uUp/KhbXPu3AJHdH6+ENwlaHTj/ZsQ+Ltbt/
        JtatLJkMAb9c+JYUIdUflvH+W7neTik=
X-Google-Smtp-Source: ABdhPJwqcvOmCFg3/QaYMoxyYiy/qP+b0/BtdevZkPzrslwFm7hY8UIEu28gHur+HdGqwUwmxYNpRQ==
X-Received: by 2002:ac8:6657:: with SMTP id j23mr13737807qtp.204.1611238972498;
        Thu, 21 Jan 2021 06:22:52 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id i129sm3695901qkd.114.2021.01.21.06.22.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jan 2021 06:22:51 -0800 (PST)
Subject: Re: FW: Bug Report: changes to submodule's files can be silently lost
 forever
To:     Tim Yorke <TYorke@visionrt.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <PA4PR08MB60969AFFD0607BDBE3ACBBE6A9A10@PA4PR08MB6096.eurprd08.prod.outlook.com>
 <PA4PR08MB60967539EC75C9AACC4C46A5A9A10@PA4PR08MB6096.eurprd08.prod.outlook.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <af8020e6-fe8f-1a48-aba9-f3ad9d7084e4@gmail.com>
Date:   Thu, 21 Jan 2021 09:22:50 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <PA4PR08MB60967539EC75C9AACC4C46A5A9A10@PA4PR08MB6096.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Tim!

Le 2021-01-21 à 08:48, Tim Yorke a écrit :

> What did you do before the bug happened? (Steps to reproduce your issue)
> 
> - I used the command "git config submodule.recurse true" in my top-level repository
> - made a change to a file in a submodule (located within my top-level repository)
> - performed a git checkout in the top-level repository to a commit that didn't have the submodule
> - performed a git checkout in the top-level repository back to a commit that does have the submodule
> 
> What did you expect to happen? (Expected behavior)
> 
> When attempting the first checkout (i.e. to a commit without the submodule), I'd expect an warning telling me that the submodule was not up-to-date (uncommited changes). 


That's indeed very sensible.

> 
> What happened instead? (Actual behavior)
> 
> The changes to the file in the submodule were lost forever without any warning
> 
> What's different between what you expected and what actually happened?
> 
> My uncommitted changes were silently lost forever, whereas I'd expect either 
> - to be warned before I could continue or
> - the uncommited changes to be retained.
>

Thanks for the report. This is a known problem ([1], [2], [3]),
and I'm working on fixing it.

Just to be sure, the changes you lost were to a tracked file in
the submodule, right ? It was not a new, untracked file ?

I'm not quite ready yet to submit my fixes, but if you want to compile
Git from source in the meantime, the heart of the fix is this diff:


diff --git a/unpack-trees.c b/unpack-trees.c index 323280dd48..a3e3d98de1 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1872,7 +1872,7 @@ static int verify_uptodate_1(const struct cache_entry *ce,
   
   		if (submodule_from_ce(ce)) {
   			int r = check_submodule_move_head(ce,
-				"HEAD", oid_to_hex(&ce->oid), o);
+				"HEAD", empty_tree_oid_hex(), o);
   			if (r)
   				return add_rejected_path(o, error_type, ce->name);
   			return 0;

This should prevent Git from switching branches if any tracked files are modified
in the submodule.

Cheers,

Philippe.

[1] https://lore.kernel.org/git/570e77a07f0b4d4ea09307e5fa819d6f@fiveco.ch/t/#u
[2] https://lore.kernel.org/git/20200525094019.22padbzuk7ukr5uv@overdrive.tratt.net/
[3] https://lore.kernel.org/git/CAHsG2VT4YB_nf8PrEmrHwK-iY-AQo0VDcvXGVsf8cEYXws4nig@mail.gmail.com/

