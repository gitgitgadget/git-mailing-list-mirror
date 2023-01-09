Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898D1C54EBD
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 05:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234343AbjAIFO6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Jan 2023 00:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234227AbjAIFOz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 00:14:55 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA43BC15
        for <git@vger.kernel.org>; Sun,  8 Jan 2023 21:14:54 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id y5so5302550pfe.2
        for <git@vger.kernel.org>; Sun, 08 Jan 2023 21:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+9Oa8ugsxzNaE04ebNRcbqARDu+Za9UoY0lSkeFjGGc=;
        b=YSGrKbPlqCgryqIeX7MD8dNlpc/hlqvkXGbGG2xlWpZzYj9b+AM2EX/oED9K1PEC/M
         p+xhGdjz7wChF53Yp4ZB4NNtb2pg7AifwrBONlzaer8H9oHQlKRbArjUJXtD1HQlXyh1
         UspTn1MWeOt+CWt8XdPK5cB38vtganH7SB/0X7hLD9FdWDpCVoyWY42Pw4g1CHJMx233
         Elq++VdUk+gi/HeOyV8018gRjVg22mtjZDvL9XCrONgCVx0+n6nXexPhfBWlF52zTS3i
         wRkfO6Hr935MUxAXX3Gw9bDSoI5g4NhOVnOA48WJWN7LBOxc6LB7I8A+BB4GZjJI7+KD
         93+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+9Oa8ugsxzNaE04ebNRcbqARDu+Za9UoY0lSkeFjGGc=;
        b=ZRHxCyecJ22iKNPlEi74tukwqzoWsS2MFv8cIrWxcqxELd43YF5GOs9v1bXsd3VyI/
         9RgEvJHe6EiuAZ+kMXNQrVhlMZ8qu17k6yrBN8sLWHuUvVGJKL1yBQ1ke0IAFiuEgZT9
         mlz2uAEJayMZ9YB6seoDyUEpq+YIR2wEhOfRKaOmQJKtdOF7pTeukKQ4NC/LB5HZMTqG
         4+nBGO/D5k9IRkOklinMdpsGhsp/nBNFW7a838ULYvkIqeeBI+AJadJ23hAZEhEv+M0n
         5J+NnQJJHMsjm++n0cQs2EB+O6atTSbqDgkWKCOynD6NfBs26DTwjAWUGGlji5jnX9N5
         wD2Q==
X-Gm-Message-State: AFqh2kp422TOvoNMefIawZOdb5wkUZj/px1dbeLY+kDJL8SirdL4yDah
        CZJ7/NDDJ55QuVLW9NtpfzY=
X-Google-Smtp-Source: AMrXdXtOwAR2HkoCIsbyW3Gqpt9q7HelADQ6FT+EGV032NGWQV7Sn3DO7yhy/6/Mg+Kv5WuKNbuEFw==
X-Received: by 2002:a05:6a00:3016:b0:582:c140:7b9f with SMTP id ay22-20020a056a00301600b00582c1407b9fmr22265221pfb.8.1673241293544;
        Sun, 08 Jan 2023 21:14:53 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id y29-20020aa793dd000000b0056c2e497b02sm5181045pff.173.2023.01.08.21.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 21:14:53 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Seija Kijin <doremylover123@gmail.com>
Subject: Re: [PATCH] merge: break out of all_strategy loop when strategy is
 found
References: <pull.1429.git.git.1673203153257.gitgitgadget@gmail.com>
Date:   Mon, 09 Jan 2023 14:14:52 +0900
In-Reply-To: <pull.1429.git.git.1673203153257.gitgitgadget@gmail.com> (Rose
        via GitGitGadget's message of "Sun, 08 Jan 2023 18:39:13 +0000")
Message-ID: <xmqqsfgkuw4z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Rose via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Seija Kijin <doremylover123@gmail.com>
>
> strncmp does not modify any of the memory,
> so looping through all elements is a waste of resources.

Modifying or not probably has little to do with why we may want to
do this change.

Here, we are trying to see which commands that appear in the
main_cmds table do not appear in the all_strategy[] table.  The way
we do so is by iterating over the main_cmds table, and for each of
the command, if it is found in the all_strategy[] table.  If there
is one, then found bit is set.  If there isn't, then found bit is
left clear.  After looping over all_strategy[] table, we act upon
the value of the found bit.

So, as soon as we find one match in all_strategy[] table and flip
the found bit on, in the loop we never clear the bit.  So it does
make sense to break out of that inner loop once we find a single
match.

    Once we find a match, there is no point to try finding the
    second match in the inner loop.  Break out of the loop once we
    find the first match.

would be a more appropriate explanation.

>  builtin/merge.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 0f093f2a4f2..5ab0feb47b6 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -189,9 +189,12 @@ static struct strategy *get_strategy(const char *name)
>  			int j, found = 0;
>  			struct cmdname *ent = main_cmds.names[i];
>  			for (j = 0; j < ARRAY_SIZE(all_strategy); j++)
> -				if (!strncmp(ent->name, all_strategy[j].name, ent->len)
> -						&& !all_strategy[j].name[ent->len])
> +				if (!strncmp(ent->name, all_strategy[j].name,
> +					     ent->len) &&
> +				    !all_strategy[j].name[ent->len]) {
>  					found = 1;
> +					break;
> +				}

The above is not wrong per-se, but we can do the same with less
damage to the code, e.g.

 builtin/merge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git c/builtin/merge.c w/builtin/merge.c
index dd474371a2..2437aae6bc 100644
--- c/builtin/merge.c
+++ w/builtin/merge.c
@@ -188,7 +188,7 @@ static struct strategy *get_strategy(const char *name)
 		for (i = 0; i < main_cmds.cnt; i++) {
 			int j, found = 0;
 			struct cmdname *ent = main_cmds.names[i];
-			for (j = 0; j < ARRAY_SIZE(all_strategy); j++)
+			for (j = 0; !found && j < ARRAY_SIZE(all_strategy); j++)
 				if (!strncmp(ent->name, all_strategy[j].name, ent->len)
 						&& !all_strategy[j].name[ent->len])
 					found = 1;


I've mentioned it before, but could you please drop the

    Rose <83477269+AtariDreams@users.noreply.github.com>

address from the Cc: list?  It is rude to force those who want to
respond to you to remove the non-working address that is meant not
to receive any responses.

Thanks.
