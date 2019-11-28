Return-Path: <SRS0=/qQH=ZU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1717BC432C0
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 11:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA9422176D
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 11:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9DUd517"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfK1LO1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Nov 2019 06:14:27 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40795 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbfK1LO1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Nov 2019 06:14:27 -0500
Received: by mail-wm1-f68.google.com with SMTP id y5so11210064wmi.5
        for <git@vger.kernel.org>; Thu, 28 Nov 2019 03:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ix8w11e05zbwySAv3KKSz+luWbGbZjk1BnSonMNW00M=;
        b=B9DUd517noRJZDMdaBeprtTZeh1flt/wTUVThL9GdfIh1RZqtcN/Qi0O9k2mU9FkcV
         1nQeNH+hY8xokHNsY3ejOqlrpBN3j8r3quzdUwaiQk2oK8ekJWhX40737XeXiv54nKr+
         NVZp7I0VJ7jEOqskx3rkys47jGLYsb3fvLHQtzuXAkeqnUVF01RwblT3nFTj8YjG886k
         ah7feHfAwRgpT1F0t2Hpw/8EQVFHH4Kp95Y3MIf0DSeY0fLzON2CFDqQY9YYEn66n2Ys
         7sNdvlSRXyet7mnUHpBC/zrv9ujMPLYa/k96uCxXZV5ZiJj2BEJIc72YpU29geGfNbwZ
         /rhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Ix8w11e05zbwySAv3KKSz+luWbGbZjk1BnSonMNW00M=;
        b=NTkLr3+8WC0tQjn26EXxl39t7xwEzCjQ9gDEMWwmW6V/AZKimaKrwR5hvE98irc6SA
         IK/MaAXoL+mYCW1cn3nCB92ieDK4kNILWStsQbxgqZlD6I7ZO3lha0IboYPjApo3H3/A
         c9xnYf8oqaDhUZKfy/qJuDpvziN+k4ucLWqybeTbR5BBNYu+A47BYT7z0ob2jqJ6+Z07
         4DyPUQOmD+exTMs7KY0r5ApRGE8c0g65UsNSxA88yDq5HFpkNwOUmFvhIi2zz8vRRJ+O
         K5QQ48oTII9TOnkXOj3vz9BF4tI3YsqiTOIuMBUBSCBvpZd43NV1NnBiGN3vU+gSbva4
         B0MQ==
X-Gm-Message-State: APjAAAVoYKcD4tKS0EYcVPb2SLIxAgMqlinTI2+hJ+huhQ6wVdny3ilr
        HUbCSwJxVNv0hEf6p9ZZb1A=
X-Google-Smtp-Source: APXvYqwjZQiQ4ShyjskqsJjHdExHdZrAtWUSvHWHygpM6etixV64JtInyuu/3DhINoao9wXwYPxofw==
X-Received: by 2002:a7b:c5d2:: with SMTP id n18mr8523942wmk.37.1574939663748;
        Thu, 28 Nov 2019 03:14:23 -0800 (PST)
Received: from [192.168.2.240] (host-92-22-28-211.as13285.net. [92.22.28.211])
        by smtp.gmail.com with ESMTPSA id s10sm1876583wrw.12.2019.11.28.03.14.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2019 03:14:23 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 0/6] rebase -i: support more options
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        martin.agren@gmail.com, newren@gmail.com, t.gummerer@gmail.com
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
 <20191101140003.13960-1-rohit.ashiwal265@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <5bab5b95-b8e3-5e63-b592-b5cac30c8068@gmail.com>
Date:   Thu, 28 Nov 2019 11:14:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191101140003.13960-1-rohit.ashiwal265@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Rohit

On 01/11/2019 13:59, Rohit Ashiwal wrote:
> Hey Everyone
> 
> I got really busy lately, posting the patch now.
>   - Now handles the combination of --ignore-date and
>     --committer-date-is-author-date properly.
>   - Improved code coverage

Looking at the range-diff there's only a one line change to the tests. I 
sound like a broken record but Stolee's latest test report[1] shows 
there are still uncovered lines.

 > Rohit Ashiwal	c068bcc5 sequencer: allow callers of 
read_author_script() to ignore fields
 > sequencer.c
 > c068bcc5 840) free(kv.items[date_i].util);
 >
 > Rohit Ashiwal	cbd8db17 rebase -i: support --committer-date-is-author-date
 > sequencer.c
 > cbd8db17 890) return NULL;
 > cbd8db17 989) return -1;
 > cbd8db17 1428) goto out;
 > cbd8db17 1432) goto out;
 > cbd8db17 2603) opts->allow_ff = 0;
 > cbd8db17 2604) opts->committer_date_is_author_date = 1;

These last two should be tested I think

 > Rohit Ashiwal	08187b4c rebase -i: support --ignore-date
 > sequencer.c
 > 08187b4c 903) return NULL;
 > 08187b4c 920) argv_array_pushf(&child->env_array, 
"GIT_COMMITTER_DATE=%s", date.buf);

This should be tested

 > 08187b4c 1508) res = -1;
 > 08187b4c 1509) goto out;
 > 08187b4c 2608) opts->allow_ff = 0;
 > 08187b4c 2609) opts->ignore_date = 1;
 > 08187b4c 3639) push_dates(&cmd, opts->committer_date_is_author_date);

As should these three

Best Wishes

Phillip

[1] 
https://lore.kernel.org/git/1cb7ddbf-020e-d63a-85b6-5a9267c0a5a3@gmail.com/


>   - addressed the compatibility of --rebase-merges with --strategy
> 
> Thanks
> Rohit
> 
> Rohit Ashiwal (6):
>    rebase -i: add --ignore-whitespace flag
>    sequencer: allow callers of read_author_script() to ignore fields
>    rebase -i: support --committer-date-is-author-date
>    sequencer: rename amend_author to author_to_rename
>    rebase -i: support --ignore-date
>    rebase: add --reset-author-date
> 
>   Documentation/git-rebase.txt            |  25 ++++-
>   builtin/rebase.c                        |  48 ++++++--
>   sequencer.c                             | 141 ++++++++++++++++++++++--
>   sequencer.h                             |   2 +
>   t/t3422-rebase-incompatible-options.sh  |   2 -
>   t/t3433-rebase-options-compatibility.sh | 131 ++++++++++++++++++++++
>   6 files changed, 321 insertions(+), 28 deletions(-)
>   create mode 100755 t/t3433-rebase-options-compatibility.sh
> 
> Range-diff:
>    2:  77af1d66db ! 491:  e155af5a39 rebase -i: add --ignore-whitespace flag
>      @@ -16,7 +16,7 @@
>        --- a/Documentation/git-rebase.txt
>        +++ b/Documentation/git-rebase.txt
>       @@
>      - default is `--no-fork-point`, otherwise the default is `--fork-point`.
>      + with `--keep-base` in order to drop those commits from your branch.
>        
>        --ignore-whitespace::
>       +	Behaves differently depending on which backend is selected.
>      @@ -46,9 +46,8 @@
>         * --preserve-merges and --signoff
>         * --preserve-merges and --rebase-merges
>       + * --preserve-merges and --ignore-whitespace
>      -+ * --rebase-merges and --ignore-whitespace
>      -  * --rebase-merges and --strategy
>      -  * --rebase-merges and --strategy-option
>      +  * --keep-base and --onto
>      +  * --keep-base and --root
>        
>       
>        diff --git a/builtin/rebase.c b/builtin/rebase.c
>      @@ -124,16 +123,6 @@
>        		OPT_PASSTHRU_ARGV(0, "whitespace", &options.git_am_opts,
>        				  N_("action"), N_("passed to 'git apply'"), 0),
>        		OPT_BIT('f', "force-rebase", &options.flags,
>      -@@
>      - 	}
>      -
>      - 	if (options.rebase_merges) {
>      -+		if (options.ignore_whitespace)
>      -+			die(_("cannot combine '--rebase-merges' with "
>      -+			      "'--ignore-whitespace'"));
>      - 		if (strategy_options.nr)
>      - 			die(_("cannot combine '--rebase-merges' with "
>      - 			      "'--strategy-option'"));
>       
>        diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-incompatible-options.sh
>        --- a/t/t3422-rebase-incompatible-options.sh
>    3:  1f7f1407b2 = 492:  7ec673ebcb sequencer: allow callers of read_author_script() to ignore fields
>    4:  cc1614154e ! 493:  5af0d628de rebase -i: support --committer-date-is-author-date
>      @@ -40,9 +40,9 @@
>         * --preserve-merges and --rebase-merges
>         * --preserve-merges and --ignore-whitespace
>       + * --preserve-merges and --committer-date-is-author-date
>      -  * --rebase-merges and --ignore-whitespace
>      -  * --rebase-merges and --strategy
>      -  * --rebase-merges and --strategy-option
>      +  * --keep-base and --onto
>      +  * --keep-base and --root
>      +
>       
>        diff --git a/builtin/rebase.c b/builtin/rebase.c
>        --- a/builtin/rebase.c
>      @@ -173,10 +173,14 @@
>       +		struct ident_split ident;
>       +		struct strbuf date = STRBUF_INIT;
>       +
>      -+		if (split_ident_line(&ident, author, len) < 0)
>      -+			return error(_("malformed ident line"));
>      -+		if (!ident.date_begin)
>      -+			return error(_("corrupted author without date information"));
>      ++		if (split_ident_line(&ident, author, len) < 0) {
>      ++			res = error(_("malformed ident line"));
>      ++			goto out;
>      ++		}
>      ++		if (!ident.date_begin) {
>      ++			res = error(_("corrupted author without date information"));
>      ++			goto out;
>      ++		}
>       +
>       +		strbuf_addf(&date, "@%.*s %.*s",
>       +			    (int)(ident.date_end - ident.date_begin), ident.date_begin,
>      @@ -296,7 +300,7 @@
>       +
>       +test_expect_success '--committer-date-is-author-date works with rebase -r' '
>       +	git checkout side &&
>      -+	git merge commit3 &&
>      ++	git merge --no-ff commit3 &&
>       +	git rebase -r --root --committer-date-is-author-date &&
>       +	git rev-list HEAD >rev_list &&
>       +	while read HASH
>    5:  9e92c79bda = 494:  c7846945dd sequencer: rename amend_author to author_to_rename
>    6:  fc68e55e78 ! 495:  02f797b84d rebase -i: support --ignore-date
>      @@ -17,8 +17,8 @@
>        --ignore-date::
>       -	This flag is passed to 'git am' to change the author date
>       -	of each rebased commit (see linkgit:git-am[1]).
>      -+	Instead of using the given author date, reset it to the value
>      -+	same as the current time. This implies --force-rebase.
>      ++	Instead of using the given author date, reset it to the
>      ++	current time. This implies --force-rebase.
>        +
>        See also INCOMPATIBLE OPTIONS below.
>        
>      @@ -35,9 +35,9 @@
>         * --preserve-merges and --ignore-whitespace
>         * --preserve-merges and --committer-date-is-author-date
>       + * --preserve-merges and --ignore-date
>      -  * --rebase-merges and --ignore-whitespace
>      -  * --rebase-merges and --strategy
>      -  * --rebase-merges and --strategy-option
>      +  * --keep-base and --onto
>      +  * --keep-base and --root
>      +
>       
>        diff --git a/builtin/rebase.c b/builtin/rebase.c
>        --- a/builtin/rebase.c
>      @@ -83,10 +83,6 @@
>        	}
>        
>       -	if (options.committer_date_is_author_date)
>      -+	if (options.ignore_date) {
>      -+		options.committer_date_is_author_date = 0;
>      -+		setenv("GIT_COMMITTER_DATE", "", 1);
>      -+	}
>       +	if (options.committer_date_is_author_date ||
>       +	    options.ignore_date)
>        		options.flags |= REBASE_FORCE;
>      @@ -128,35 +124,56 @@
>       +	}
>       +	len = ident.mail_end - ident.name_begin + 1;
>       +
>      -+	strbuf_addf(&new_author, "%.*s ", len, author);
>      ++	strbuf_addf(&new_author, "%.*s ", len, ident.name_begin);
>       +	datestamp(&new_author);
>       +	return strbuf_detach(&new_author, NULL);
>       +}
>       +
>      -+static void push_dates(struct child_process *child)
>      ++static void push_dates(struct child_process *child, int change_committer_date)
>       +{
>       +	time_t now = time(NULL);
>       +	struct strbuf date = STRBUF_INIT;
>       +
>       +	strbuf_addf(&date, "@%"PRIuMAX, (uintmax_t)now);
>       +	argv_array_pushf(&child->env_array, "GIT_AUTHOR_DATE=%s", date.buf);
>      -+	argv_array_pushf(&child->env_array, "GIT_COMMITTER_DATE=%s", date.buf);
>      ++	if (change_committer_date)
>      ++		argv_array_pushf(&child->env_array, "GIT_COMMITTER_DATE=%s", date.buf);
>       +	strbuf_release(&date);
>       +}
>       +
>        static const char staged_changes_advice[] =
>        N_("you have staged changes in your working tree\n"
>        "If these changes are meant to be squashed into the previous commit, run:\n"
>      +@@
>      + 	                return -1;
>      +
>      + 	        strbuf_addf(&datebuf, "@%s", date);
>      +-	        res = setenv("GIT_COMMITTER_DATE", datebuf.buf, 1);
>      ++		res = setenv("GIT_COMMITTER_DATE",
>      ++			     opts->ignore_date ? "" : datebuf.buf, 1);
>      +
>      + 		strbuf_release(&datebuf);
>      + 	        free(date);
>       @@
>        		argv_array_push(&cmd.args, "--amend");
>        	if (opts->gpg_sign)
>        		argv_array_pushf(&cmd.args, "-S%s", opts->gpg_sign);
>       +	if (opts->ignore_date)
>      -+		push_dates(&cmd);
>      ++		push_dates(&cmd, opts->committer_date_is_author_date);
>        	if (defmsg)
>        		argv_array_pushl(&cmd.args, "-F", defmsg, NULL);
>        	else if (!(flags & EDIT_MSG))
>       @@
>      + 		strbuf_addf(&date, "@%.*s %.*s",
>      + 			    (int)(ident.date_end - ident.date_begin), ident.date_begin,
>      + 			    (int)(ident.tz_end - ident.tz_begin), ident.tz_begin);
>      +-		res = setenv("GIT_COMMITTER_DATE", date.buf, 1);
>      ++		res = setenv("GIT_COMMITTER_DATE",
>      ++			     opts->ignore_date ? "" : date.buf, 1);
>      + 		strbuf_release(&date);
>      +
>      + 		if (res)
>      +@@
>        
>        	reset_ident_date();
>        
>      @@ -198,7 +215,7 @@
>        		if (opts->gpg_sign)
>        			argv_array_push(&cmd.args, opts->gpg_sign);
>       +		if (opts->ignore_date)
>      -+			push_dates(&cmd);
>      ++			push_dates(&cmd, opts->committer_date_is_author_date);
>        
>        		/* Add the tips to be merged */
>        		for (j = to_merge; j; j = j->next)
>      @@ -239,31 +256,25 @@
>       +	git commit --amend --date="$GIT_AUTHOR_DATE" &&
>       +	git rebase --ignore-date HEAD^ &&
>       +	git show HEAD --pretty="format:%ai" >authortime &&
>      -+	git show HEAD --pretty="format:%ci" >committertime &&
>      -+	grep "+0000" authortime &&
>      -+	grep "+0000" committertime
>      ++	grep "+0000" authortime
>       +'
>       +
>       +test_expect_success '--ignore-date works with interactive backend' '
>       +	git commit --amend --date="$GIT_AUTHOR_DATE" &&
>       +	git rebase --ignore-date -i HEAD^ &&
>       +	git show HEAD --pretty="format:%ai" >authortime &&
>      -+	git show HEAD --pretty="format:%ci" >committertime &&
>      -+	grep "+0000" authortime &&
>      -+	grep "+0000" committertime
>      ++	grep "+0000" authortime
>       +'
>       +
>       +test_expect_success '--ignore-date works with rebase -r' '
>       +	git checkout side &&
>      -+	git merge commit3 &&
>      ++	git merge --no-ff commit3 &&
>       +	git rebase -r --root --ignore-date &&
>       +	git rev-list HEAD >rev_list &&
>       +	while read HASH
>       +	do
>       +		git show $HASH --pretty="format:%ai" >authortime
>      -+		git show $HASH --pretty="format:%ci" >committertime
>       +		grep "+0000" authortime
>      -+		grep "+0000" committertime
>       +	done <rev_list
>       +'
>       +
>    7:  396d5f16eb ! 496:  7a9fe1e612 rebase: add --reset-author-date
>      @@ -17,8 +17,8 @@
>        
>        --ignore-date::
>       +--reset-author-date::
>      - 	Instead of using the given author date, reset it to the value
>      - 	same as the current time. This implies --force-rebase.
>      + 	Instead of using the given author date, reset it to the
>      + 	current time. This implies --force-rebase.
>        +
>       
>        diff --git a/builtin/rebase.c b/builtin/rebase.c
> 
