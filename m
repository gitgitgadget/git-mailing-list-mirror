Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3611CCA473
	for <git@archiver.kernel.org>; Wed,  1 Jun 2022 15:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352931AbiFAPXY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jun 2022 11:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344983AbiFAPXU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jun 2022 11:23:20 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D378587215
        for <git@vger.kernel.org>; Wed,  1 Jun 2022 08:23:18 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id rs12so4437840ejb.13
        for <git@vger.kernel.org>; Wed, 01 Jun 2022 08:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=N4jKD3cyNvGz2zcFtw9N5yntNfcxeRd5JJ4b+mn4J0U=;
        b=UqEcjuiSo7WOX3qCnjNUrdXgk2E3rYpkZrJtuTUB4mv32d9v2IvDoincq3B9RR/XtG
         MMNdwX/OzzVzFxlM0ax3k/0Me6Dxw8aOZ1P+s5nVicr3b3ciVT/vN/uKEBWU7MER0LuN
         NAXuw3p/ObGiGIkoyeAx4qvh1PgXHTH7rhSd2qFgangF5j+9FREGNARUwbJeb+UdnmDL
         RqBYKAoXlRBDUVpwII3LpYCBYVJsMx/CQbcJz5g2Fz165Jy3eeuXd4y+ww4f76YgGS4Q
         0FQePPaO80y8UIW53HiRjcCKDUYxj4JEppTALUd966+xl5JrYLZyaOtQd+GJjmH3gC4i
         iOAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=N4jKD3cyNvGz2zcFtw9N5yntNfcxeRd5JJ4b+mn4J0U=;
        b=It3paVqGKNA6GFgxqN8Ddy4IIgACbE47ZHpnwH+xSWvo2Eh7M05A2qp8ZZ/Y9BPjbN
         G3wqg3gUfVoP6cPeQom+KlFii+bdP4NnOIFKJLv1DLfpFNUwbfDtNEuCAzpUJ5t/J5sF
         VIMyCijQyBR8wiUblwJwF0uILc2wj5HXJA3U9+0xl6KV9KEOIPzMJP7eVZ5UK0BKByS0
         P+pQCrgzXjoNbtYcnyo5iYjKF/FjtIsLpTy70UNvSqR3Nq40mL2fTGbg0ZG6ITAIhctP
         SBBXFf+iDKH/tk+KLr6VPzpbwHwdmagJEpvtcDhcX3q7CvNwNvzWkuSnl4Am2aRHeonR
         F6QA==
X-Gm-Message-State: AOAM533OxTDHz3isq8Npk+q8bYUcdNDaM1OYxHC2nwc8SY4+wsaH1ytB
        YoVM3wTwDJTApjPVD5LERJo=
X-Google-Smtp-Source: ABdhPJxCQFmvoJBQK4jwMRvSE+RZqi4SRHex3GYKlH8g7mubDrWdYoDoK+DihYH8TTYbdbZD5/fqlA==
X-Received: by 2002:a17:907:3f0d:b0:6ff:43e:bb1a with SMTP id hq13-20020a1709073f0d00b006ff043ebb1amr72740ejc.52.1654096997193;
        Wed, 01 Jun 2022 08:23:17 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id k11-20020a056402048b00b0042ab02e3485sm1116735edv.44.2022.06.01.08.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 08:23:16 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nwQBn-001F7o-TZ;
        Wed, 01 Jun 2022 17:23:15 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3] revert: optionally refer to commit in the
 "reference" format
Date:   Wed, 01 Jun 2022 17:14:41 +0200
References: <xmqqsfp2b30k.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2205231507350.352@tvgsbejvaqbjf.bet>
 <xmqq35gzn9vk.fsf@gitster.g> <xmqq8rqn7buk.fsf_-_@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqq8rqn7buk.fsf_-_@gitster.g>
Message-ID: <220601.86zgiwz9uk.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 26 2022, Junio C Hamano wrote:

> When this option is in use, the first line of the pre-filled editor
> buffer becomes a comment line that tells the user to say _why_.  If
> the user exits the editor without touching this line by mistake,
> what we prepare to become the first line of the body, i.e. "This
> reverts commit 8fa7f667 (do this and that, 2022-04-25)", ends up to
> be the title of the resulting commit.  This behaviour is designed to
> help such a user to identify such a revert in "git log --oneline"
> easily so that it can be further reworded with "git rebase -i" later.

This is a good trade-off, and means that the --no-edit case is also
preserved. However...

> @@ -2167,14 +2184,20 @@ static int do_pick_commit(struct repository *r,
>  		base_label = msg.label;
>  		next = parent;
>  		next_label = msg.parent_label;
> -		strbuf_addstr(&msgbuf, "Revert \"");
> -		strbuf_addstr(&msgbuf, msg.subject);
> -		strbuf_addstr(&msgbuf, "\"\n\nThis reverts commit ");
> -		strbuf_addstr(&msgbuf, oid_to_hex(&commit->object.oid));
> +		if (opts->commit_use_reference) {
> +			strbuf_addstr(&msgbuf,
> +				"# *** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***");
> +		} else {
> +			strbuf_addstr(&msgbuf, "Revert \"");
> +			strbuf_addstr(&msgbuf, msg.subject);
> +			strbuf_addstr(&msgbuf, "\"");
> +		}
> +		strbuf_addstr(&msgbuf, "\n\nThis reverts commit ");
> +		refer_to_commit(opts, &msgbuf, commit);
>  
>  		if (commit->parents && commit->parents->next) {
>  			strbuf_addstr(&msgbuf, ", reversing\nchanges made to ");
> -			strbuf_addstr(&msgbuf, oid_to_hex(&parent->object.oid));
> +			refer_to_commit(opts, &msgbuf, parent);
>  		}

...the way this is implemented means that we end up with a much more
verbose subject line in the case of reverts, which doesn't seem to be
intended (or at least not called out in the commit message).

I think a good solution to that would be to e.g. emit:

    # *** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***

    Reverts commit <git reference>

    This revert of a merge reverts changes made to <git reference 2>.

Instead of what you have, which is:

    # *** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***

    This reverts commit <git reference>, reversing
    changes made to <git reference 2>.

It's sharing a bit less code between the two, but I think the message is
suffering for it now.

I.e. the "Revert <reference>" change to "This reverts commit
<reference>" doesn't per-se seem intentional, but just a side-effect of
the optional "reference" revert's default "subject" line piggy-backing
on the non-"reference" body.

> +test_expect_success 'identification of reverted commit (default)' '
> +	test_commit to-ident &&
> +	test_when_finished "git reset --hard to-ident" &&
> +	git checkout --detach to-ident &&
> +	git revert --no-edit HEAD &&
> +	git cat-file commit HEAD >actual.raw &&
> +	grep "^This reverts " actual.raw >actual &&
> +	echo "This reverts commit $(git rev-parse HEAD^)." >expect &&

This pattern hides git exit codes & segfaults (I don't remember if I
mentioned that in a previous round, I think so...).

> +test_expect_success 'identification of reverted commit (--reference)' '
> +	git checkout --detach to-ident &&
> +	git revert --reference --no-edit HEAD &&
> +	git cat-file commit HEAD >actual.raw &&
> +	grep "^This reverts " actual.raw >actual &&
> +	echo "This reverts commit $(git show -s --pretty=reference HEAD^)." >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'identification of reverted commit (revert.reference)' '
> +	git checkout --detach to-ident &&
> +	git -c revert.reference=true revert --no-edit HEAD &&
> +	git cat-file commit HEAD >actual.raw &&
> +	grep "^This reverts " actual.raw >actual &&
> +	echo "This reverts commit $(git show -s --pretty=reference HEAD^)." >expect &&
> +	test_cmp expect actual

Also (probably mentioned) I'd find this much easier to read/review if it
was using test_cmp, now you need to carefully parse the code to see what
the outputs are like exactly, but if we compared the full output...
