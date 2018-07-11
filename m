Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF20E1F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 17:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388425AbeGKRIU (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 13:08:20 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46151 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbeGKRIU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 13:08:20 -0400
Received: by mail-wr1-f65.google.com with SMTP id s11-v6so18894829wra.13
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 10:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=on60a4sAOCFDMRpIIMAaYSVmINJ1aNVZD3tDVxflAAQ=;
        b=jP0GKYhNVkpBGnab0SCOvifrXFFBAuoX+s1HFyh1TlymGu6hkcJF73M5o19CVyF12O
         /6FuUNninPxPQ0KUaCje0hN2LVdh4xnpH/oSYtVJMwLElkiV1ghnN0avu2p3cJqqmh9i
         NK+CkRO0M8rL3rA1Fw3FR3w5bPK9phnplf9FzZsVYe6fQLjYP/AHINHIApDtryYq1lrW
         afEWhuZaMZsPdpnf8EOmJOL8YamJGQjmVLgHWVZEp796vG1NpH9zo+FrZeINCXMJM98H
         4QeCuEymfLfbFmM5xWZvU3bJESwBVuriY4Z8EDRJIPxH0qHal1YpJnnmghsqLGRkEhyH
         Z3eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=on60a4sAOCFDMRpIIMAaYSVmINJ1aNVZD3tDVxflAAQ=;
        b=fN2tgFgsGB2FinJZr5+jkdHxAcuSUGhqOth3JXkSZjIGXPo2/ep36qWED88CgJQrhb
         4xnSPzr86ITWsfhXpfjxGImHED2p/fowTtiGe/Zmjhd+WVKmk7N0jY9z6Z+Emx+O+kdB
         eUOvtXHsLVOiCslAvh5cZa1lOQg9PlcduCgs89j1U/rst0DV9buh7Ak1khBO5nVYnj2V
         NxItfjBlQtgvescu+CQowza7Cm2+oJOgP4/zl7OaTWVywU4IoKIU4sv/GdL3eKgxFs5e
         acuIyHjvV+Dq7xyrCrmPqhHJfs2d14kEJcS1KBAxZOQee20Q6f+iMWq31ek8tzBHdHaA
         /0rw==
X-Gm-Message-State: APt69E3rd9i1dp55OP2n/OCpr9uUVZj+D1GgLbI0ThUmgJPRPV6dnlRk
        1N7JfXv5CcbpgaB7/b6/+tQ=
X-Google-Smtp-Source: AAOMgpfAKCv7joMN971X/ucICbqriN2m06LIt5kTWbRJkhL1aPCs7diMcDzzrD/i5YaulRQImuKDvQ==
X-Received: by 2002:adf:8bd7:: with SMTP id w23-v6mr20526979wra.208.1531328584661;
        Wed, 11 Jul 2018 10:03:04 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id l10-v6sm38119046wrv.23.2018.07.11.10.03.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 10:03:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] read-cache: fix directory/file conflict handling in read_index_unmerged()
References: <20180711051834.28181-1-newren@gmail.com>
        <20180711051834.28181-3-newren@gmail.com>
Date:   Wed, 11 Jul 2018 10:03:03 -0700
In-Reply-To: <20180711051834.28181-3-newren@gmail.com> (Elijah Newren's
        message of "Tue, 10 Jul 2018 22:18:34 -0700")
Message-ID: <xmqqsh4p3dtk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>     The _only_ reason we want to keep a previously unmerged entry in the
>     index at stage #0 is so that we don't forget the fact that we have
>     corresponding file in the work tree in order to be able to remove it
>     when the tree we are resetting to does not have the path.
> ...
> So, that's the intended purpose of this function.  The problem is that
> when directory/files conflicts are present, trying to add the file to the
> index at stage 0 fails (because there is still a directory in the way),
> and the function returns early with a -1 return code to signify the error.
> As noted above, none of the callers who want the drop-to-stage-0 behavior
> check the return status, though, so this means all remaining unmerged
> entries remain in the index and the callers proceed assuming otherwise.

Nicely analysed and explained so far.

> ...  The temporary simultaneous appearance of the
> directory and file entries in the index will be removed by the callers
> before they attempt to write the index anywhere.

But this part makes me feel a bit uneasy, as I find this "will be
removed" a bit hand-wavy.  There are two such callers.  "am --skip"
and "reset".  

The former uses am.c::fast_forward_to that calls unpack_trees() to
two-way merge (aka "switch to the other branch") and these entries
with CE_CONFLICTED flag get removed in merged/deleted_entry().

"reset" (all variants) call unpack_trees() on the index prepared
with read_cache_unmerged(), and the unmerged entries that are marked
with CE_CONFLICTED bit get removed the same way.

So perhaps before "before they attempt to", saying "by calling
unpack_trees(), which excludes these unmerged entries marked with
CE_CONFLICTED flag from the resulting index," or something like that
would help uneasy readers?

> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  read-cache.c                         | 13 ++++++++-----
>  t/t1015-read-index-unmerged.sh       |  8 ++++----
>  t/t6020-merge-df.sh                  |  3 ---
>  t/t6042-merge-rename-corner-cases.sh |  1 -
>  4 files changed, 12 insertions(+), 13 deletions(-)
>
> diff --git a/read-cache.c b/read-cache.c
> index 372588260..666d295a5 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -2632,10 +2632,13 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
>  
>  /*
>   * Read the index file that is potentially unmerged into given
> - * index_state, dropping any unmerged entries.  Returns true if
> - * the index is unmerged.  Callers who want to refuse to work
> - * from an unmerged state can call this and check its return value,
> - * instead of calling read_cache().
> + * index_state, dropping any unmerged entries to stage #0 (potentially
> + * resulting in a path appearing as both a file and a directory in the
> + * index; the caller is responsible to clear out the extra entries
> + * before writing the index to a tree).  Returns true if the index is
> + * unmerged.  Callers who want to refuse to work from an unmerged
> + * state can call this and check its return value, instead of calling
> + * read_cache().
>   */
>  int read_index_unmerged(struct index_state *istate)
>  {
> @@ -2658,7 +2661,7 @@ int read_index_unmerged(struct index_state *istate)
>  		new_ce->ce_flags = create_ce_flags(0) | CE_CONFLICTED;
>  		new_ce->ce_namelen = len;
>  		new_ce->ce_mode = ce->ce_mode;
> -		if (add_index_entry(istate, new_ce, 0))
> +		if (add_index_entry(istate, new_ce, ADD_CACHE_SKIP_DFCHECK))
>  			return error("%s: cannot drop to stage #0",
>  				     new_ce->name);
>  	}
> diff --git a/t/t1015-read-index-unmerged.sh b/t/t1015-read-index-unmerged.sh
> index bbd64587c..5034ed931 100755
> --- a/t/t1015-read-index-unmerged.sh
> +++ b/t/t1015-read-index-unmerged.sh
> @@ -30,7 +30,7 @@ test_expect_success 'setup modify/delete + directory/file conflict' '
>  	)
>  '
>  
> -test_expect_failure 'read-tree --reset cleans unmerged entries' '
> +test_expect_success 'read-tree --reset cleans unmerged entries' '
>  	test_when_finished "git -C df_plus_modify_delete clean -f" &&
>  	test_when_finished "git -C df_plus_modify_delete reset --hard" &&
>  	(
> @@ -45,7 +45,7 @@ test_expect_failure 'read-tree --reset cleans unmerged entries' '
>  	)
>  '
>  
> -test_expect_failure 'One reset --hard cleans unmerged entries' '
> +test_expect_success 'One reset --hard cleans unmerged entries' '
>  	test_when_finished "git -C df_plus_modify_delete clean -f" &&
>  	test_when_finished "git -C df_plus_modify_delete reset --hard" &&
>  	(
> @@ -87,7 +87,7 @@ test_expect_success 'setup directory/file conflict + simple edit/edit' '
>  	)
>  '
>  
> -test_expect_failure 'git merge --abort succeeds despite D/F conflict' '
> +test_expect_success 'git merge --abort succeeds despite D/F conflict' '
>  	test_when_finished "git -C df_plus_edit_edit clean -f" &&
>  	test_when_finished "git -C df_plus_edit_edit reset --hard" &&
>  	(
> @@ -103,7 +103,7 @@ test_expect_failure 'git merge --abort succeeds despite D/F conflict' '
>  	)
>  '
>  
> -test_expect_failure 'git am --skip succeeds despite D/F conflict' '
> +test_expect_success 'git am --skip succeeds despite D/F conflict' '
>  	test_when_finished "git -C df_plus_edit_edit clean -f" &&
>  	test_when_finished "git -C df_plus_edit_edit reset --hard" &&
>  	(
> diff --git a/t/t6020-merge-df.sh b/t/t6020-merge-df.sh
> index 2af1beec5..46b506b3b 100755
> --- a/t/t6020-merge-df.sh
> +++ b/t/t6020-merge-df.sh
> @@ -89,9 +89,6 @@ test_expect_success 'modify/delete + directory/file conflict' '
>  '
>  
>  test_expect_success 'modify/delete + directory/file conflict; other way' '
> -	# Yes, we really need the double reset since "letters" appears as
> -	# both a file and a directory.
> -	git reset --hard &&
>  	git reset --hard &&
>  	git clean -f &&
>  	git checkout modify^0 &&
> diff --git a/t/t6042-merge-rename-corner-cases.sh b/t/t6042-merge-rename-corner-cases.sh
> index 1cbd946fc..583e68997 100755
> --- a/t/t6042-merge-rename-corner-cases.sh
> +++ b/t/t6042-merge-rename-corner-cases.sh
> @@ -323,7 +323,6 @@ test_expect_success 'rename/directory conflict + content merge conflict' '
>  	(
>  		cd rename-directory-1 &&
>  
> -		git reset --hard &&
>  		git reset --hard &&
>  		git clean -fdqx &&
