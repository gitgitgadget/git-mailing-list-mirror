Return-Path: <SRS0=w3fS=3B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC79C33CA2
	for <git@archiver.kernel.org>; Sun, 12 Jan 2020 17:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BECB22084D
	for <git@archiver.kernel.org>; Sun, 12 Jan 2020 17:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fK3Ns+0c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732957AbgALRbS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jan 2020 12:31:18 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37112 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728512AbgALRbR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Jan 2020 12:31:17 -0500
Received: by mail-wr1-f68.google.com with SMTP id w15so6356702wru.4
        for <git@vger.kernel.org>; Sun, 12 Jan 2020 09:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:from:to:references:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=whbCp1WGUWVVOGzwZRU3SNRtutNuOR3hQs13S52wal4=;
        b=fK3Ns+0cx4gp9+ERsfNZ3WuPTmr62DMpd9fjiHHLAM8VS3l+ZlpGvZ8CPedKpS92u7
         ZNh1RnMj2FmJty3gKKMgZ6DuSxWfQ7C1QxqdGv+978T317iO/DJV1J+I6iPanKDLfD5E
         LDzr2I7h8AINchpg+tKaejgMbh14s4Av41CdcHKA6DQ8sDwYToieQ5FUyaudrar2yIsw
         smmI9x4YHwU/Dhw9/PP16oRnUV5SIjCXUhTf3cFhgtfxudH2mcgxKIcMntR6k15uNkMU
         CGoSDlEub3uok7NWS6VdI+Hx3aTJ3UmkaYxNr26GO1tCPbvYy41VumVdNJ1XytI5ihfq
         RwxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:from:to:references:cc
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=whbCp1WGUWVVOGzwZRU3SNRtutNuOR3hQs13S52wal4=;
        b=JqCc0qI3A+t7YH6IO2dGcNqN979oikdhA8UkNuWccw10/boLE8Bw4qwFTvigiBe5HT
         qc9Tb5HQa9GzK/IoK5FVm5xGULX0fvueysLh38Yw7k3zh/IwqgLwPq385YDN0O+gJ5Mw
         pA1tBp6pmV2WFUPxiUBUy8khsJ51bK3XWiLmqDEh0IuUckWCP6cJQEyoiSPbwg+h/9CC
         wk5ZGONwfuE/NQQTVucSmJC0VWTaXOyqtb98OCADpjZCrTYIZTO3F1GyMHOIc1ANm7Se
         Q85upnR49V5KUVh8BNcwbKcimUkY0UQ45nGP2IB1dS1lkm+dsL1uL4wmpzpCRHV2lD/K
         8b9Q==
X-Gm-Message-State: APjAAAU077sVn29bJ+3f500XxK5ppds9HRDj3QnvStK9JTk66KoYY/M9
        fsfCYlUHlJTRr9ebaGp6ztk=
X-Google-Smtp-Source: APXvYqxyFu2QUrVj3HZvmv1uawVtTkWdgMgZxbod1JuSFglxh63oTxs2RZuJGAMyxtqYx8Z/bGboZg==
X-Received: by 2002:adf:b193:: with SMTP id q19mr14297315wra.78.1578850274917;
        Sun, 12 Jan 2020 09:31:14 -0800 (PST)
Received: from [192.168.2.240] (host-92-22-19-5.as13285.net. [92.22.19.5])
        by smtp.gmail.com with ESMTPSA id f127sm11014047wma.4.2020.01.12.09.31.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jan 2020 09:31:14 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Problems with ra/rebase-i-more-options - should we revert it?
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
References: <f2fe7437-8a48-3315-4d3f-8d51fe4bb8f1@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>
Message-ID: <089637d7-b4b6-f6ba-cce1-29e22ce47521@gmail.com>
Date:   Sun, 12 Jan 2020 17:31:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <f2fe7437-8a48-3315-4d3f-8d51fe4bb8f1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/01/2020 16:12, Phillip Wood wrote:
> I'm concerned that there are some bugs in this series and think
> it may be best to revert it before releasing 2.25.0. Jonathan
> Nieder posted a bug report on Friday [1] which I think is caused
> by this series. While trying to reproduce Jonathan's bug I came
> up with the test below which fails, but not in the same way.

Doh I forgot to add --committer-date-is-author-date to the rebase
command line in that test. It passes with that added - how
embarrassing. However it does appear that it prefixes the date in
GIT_COMMITTER_DATE with @@ rather than @. I think (though am not
completely certain yet) the reason the test still passes is that
the date has more than 8 digits so although
match_object_header_date() fails because of the '@@'
match_digit() succeeds once the loop in parse_date_basic() strips
that prefix. Jonathan's test date only has 7 digits so
match_digit() does not treat it as a number of seconds since the
start of the epoch and fails to parse it. The fix for the @@ is
quite simple, the date we read from the author script already has
an @ so we don't need to add another. The diff below shows a 
basic fix but we should get rid of datebuf altogether as we don't 
need it. I need a break now I'll try and put a patch together 
later in the week if no one else has by then.

Best Wishes

Phillip

--- >8 ---
diff --git a/sequencer.c b/sequencer.c
index 763ccbbc45..22a38de47b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -988,7 +988,7 @@ static int run_git_commit(struct repository *r,
                if (!date)
                        return -1;
 
-               strbuf_addf(&datebuf, "@%s", date);
+               strbuf_addf(&datebuf, "%s", date);
                res = setenv("GIT_COMMITTER_DATE",
                             opts->ignore_date ? "" : datebuf.buf, 1);
 
> The
> test coverage of this series has always been pretty poor and I
> think it needs improving for us to have confidence in it. I'm
> also concerned that at least one of the
> tests ('--committer-date-is-author-date works with rebase -r')
> does not detect failures properly in the code below
> 
> 	while read HASH
> 	do
> 		git show $HASH --pretty="format:%ai" >authortime
> 		git show $HASH --pretty="format:%ci" >committertime
> 		test_cmp authortime committertime
> 	done <rev_list
> 
> 
> Best Wishes
> 
> Phillip
> 
> [1] https://lore.kernel.org/git/20200110231436.GA24315@google.com/
> 
> --- >8 ---
> diff --git a/t/t3433-rebase-options-compatibility.sh b/t/t3433-rebase-options-compatibility.sh
> index 5166f158dd..c81e1d7167 100755
> --- a/t/t3433-rebase-options-compatibility.sh
> +++ b/t/t3433-rebase-options-compatibility.sh
> @@ -6,6 +6,7 @@
>   test_description='tests to ensure compatibility between am and interactive backends'
>   
>   . ./test-lib.sh
> +. "$TEST_DIRECTORY"/lib-rebase.sh
>   
>   GIT_AUTHOR_DATE="1999-04-02T08:03:20+05:30"
>   export GIT_AUTHOR_DATE
> @@ -99,6 +100,22 @@ test_expect_success '--committer-date-is-author-date works with rebase -r' '
>          done <rev_list
>   '
>   
> +test_expect_success '--committer-date-is-author-date works when committing conflict resolution' '
> +       git checkout commit2 &&
> +       (
> +               set_fake_editor &&
> +               FAKE_LINES=2 &&
> +               export FAKE_LINES &&
> +               test_must_fail git rebase -i HEAD^^
> +       ) &&
> +       echo resolved > foo &&
> +       git add foo &&
> +       git rebase --continue &&
> +       git log -1 --format=%at commit2 >expect &&
> +       git log -1 --format=%ct HEAD >actual &&
> +       test_cmp expect actual
> +'
> +
>   # Checking for +0000 in author time is enough since default
>   # timezone is UTC, but the timezone used while committing
>   # sets to +0530.
> 
