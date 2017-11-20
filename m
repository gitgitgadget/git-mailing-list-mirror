Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD7F1202A0
	for <e@80x24.org>; Mon, 20 Nov 2017 02:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751215AbdKTCKB (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Nov 2017 21:10:01 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50200 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751043AbdKTCKB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Nov 2017 21:10:01 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2AD47B63F1;
        Sun, 19 Nov 2017 21:10:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Qg9ZRHiktkEjJezJ7Yya23j/u9s=; b=KZwlB3
        OA8TecqJ7PSjBJrWTmRdKyaUGV8Aplt1c9u85Z67XABx+/vS22UmbFc0SXbnP34P
        yE7PK29XicTLgHNIveeiQihd/67TnOtFDRyMH04vxEfflfRXqPyRYMzqqmp02MeC
        6f8QRueU33crwBFRqiWyLcT75SrYC251QeNoM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=P/d6jJudTerrALCextVInmjAcW/RkgJy
        dN8L3WAaVJWrGYJzukSvLHwdD0v7l9Vz/JWXOcOJFaUlLtoP22GO3IQr6LpZVCDH
        alKNjI3KfblHQVwOnaQbQZMNoz6r7k1iloboJGU0qc2fVFeQvxuwiuVScPNH45X+
        FSWFnUrd+UM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1B97BB63EF;
        Sun, 19 Nov 2017 21:10:00 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8FBE6B63EE;
        Sun, 19 Nov 2017 21:09:59 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] docs: checking out using @{-N} can lead to detached state
References: <20171119175411.13570-1-kaartic.sivaraam@gmail.com>
Date:   Mon, 20 Nov 2017 11:09:58 +0900
In-Reply-To: <20171119175411.13570-1-kaartic.sivaraam@gmail.com> (Kaartic
        Sivaraam's message of "Sun, 19 Nov 2017 23:24:11 +0530")
Message-ID: <xmqqpo8dn1jd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E94D9C6A-CD97-11E7-A6F5-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> The commit message of 75d6e552a (Documentation: @{-N} can refer to
> a commit, 2014-01-19) clearly specifies how @{-N} can be used to
> refer not only to a branch but also to a commit. IOW, @{-N} is a
> syntax for the N-th last "checkout" and not the N-th last "branch"

If you define a new term "checkout" to mean "what was checked out",
yes that is correct.  After re-reading the said commit and the text
it tried to update, I agree with you that it did not go far enough.

After the first paragraph explains what happens during "checkout
<branch>" and goes from the normal case where <branch> is really a
branch name to an arbitrary commit (where "detaching" needs to be
mentioned), a commit before 75d6e552a added mention of @{-N} and
made it appear as if it were a reference to a commit (i.e. not a
branch name) and that was why it said "As a special case" and
mentioned "detaching".  The problem lies in a lot older one,
696acf45 ("checkout: implement "-" abbreviation, add docs and
tests", 2009-01-17).

I agree that a real fix should ensure that @{-N} is merely a
short-hand for what was checked out in the Nth-previous "git
checkout" operation, *and* regardless of which between a branch name
or a commit object name that Nth thing is, the previous rules we
already gave in the first paragraph apply---if the thing checked out
in the Nth-previous "git checkout" was a branch, we checkout the
branch.  If it was a commit, we detach.

So perhaps we should start from dropping that "As a special case".

    You can also use the `"@{-N}"` syntax to refer to the thing the N-th
    last "git checkout" operation checked out; if it was a branch, that
    branch is checked out, and otherwise the HEAD is detached at the
    commit.  You may also specify `-` which is synonymous to `"@{-1}"`.

or something like that.  If we do so, we'd further need to tweak "As
a further special case", as this rewrite makes it clear that "@{-N}"
is not a special case at all (instead it is merely a different way
to spell <branch> or <commit> that is already covered).

Thanks.


> diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
> index e108b0f74..238880f10 100644
> --- a/Documentation/git-checkout.txt
> +++ b/Documentation/git-checkout.txt
> @@ -272,9 +272,8 @@ section of linkgit:git-add[1] to learn how to operate the `--patch` mode.
>  	commit, your HEAD becomes "detached" and you are no longer on
>  	any branch (see below for details).
>  +
> -As a special case, the `"@{-N}"` syntax for the N-th last branch/commit
> -checks out branches (instead of detaching).  You may also specify
> -`-` which is synonymous with `"@{-1}"`.
> +As a special case, the `@{-N}` syntax checks out the N-th last branch/commit(checkout).
> +You may also specify `-` which is synonymous with `@{-1}`.
>  +
>  As a further special case, you may use `"A...B"` as a shortcut for the
>  merge base of `A` and `B` if there is exactly one merge base. You can
