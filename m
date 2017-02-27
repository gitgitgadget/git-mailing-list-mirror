Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 737221F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 23:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751834AbdB0Xvk (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 18:51:40 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35946 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751039AbdB0Xvh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 18:51:37 -0500
Received: by mail-pg0-f65.google.com with SMTP id 25so2553792pgy.3
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 15:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=jGn8xvBN/bKK3NVbnl9tCA+h0eZ/FTmrAFV65YT1FRE=;
        b=GX9sw78oAcXUzac54lT61DAkIP3EvoMIsZsWacVJ1EiLHXCXbXv2b4/Ebu6UWkDu/D
         KcomD85kQgv83M5SoiG8IrqbTKCqL8wajCfcByJdHntZtKhkwY36QuIw7IHS4GAx7u+G
         Ilwm4uzRm5jmsLUntViU52mvtGQAwJ0CD0Mp97a0Fiu+NDXD5IpaPP3O7j9uO5JDaf/Y
         1I367nfVJyNG8e3fRGoMGGnCU6sNfMMWTmWXHWolWrcsnLulaKNE8cmlhk93rk4IRc/z
         utEg+tM7s1T19ZwmU/8DLQsgZ8nUuRms0lAG98smXFqBrIv/P0palsg+1NWJqz1eFGLk
         FQjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=jGn8xvBN/bKK3NVbnl9tCA+h0eZ/FTmrAFV65YT1FRE=;
        b=qwD28ExRv9uGcbyBMMjwXRPdsnWh35v3SalBcJOKi9HhtE3QQJp/SEhjBZWEpBfuVB
         D8fVK0rPusxn6eRBw5+EJxxRgnKZ4nNeGDfpFIlcgpjoAcEM0ZkynV6NBR+EFJIas/4t
         lmhezmFVkCjh6Rg8x8fIhgSikcVmCDhQdbgsXoSLibF23r6of2iO/BizluGVDVx2mMGX
         jftohUKWr/9wifG7RqegIzeoycGjYo1qASKGIlJmQ0wYGh7jLVQj8Cz+z15/r2nhjB+a
         xpxWDjVdCu9VHj/YC4LJJP4H+koA9lT2BooV8iXelkLcIbc4HdFad5Qhw7opRxeQyd3M
         Ak1g==
X-Gm-Message-State: AMke39m7ZY/wgwS9EWJzRqOFHN+/hQ4AJoCnf1A30pgOaSkWN/gL2hcHgwETGhtt9Ba/7Q==
X-Received: by 10.99.105.8 with SMTP id e8mr22885787pgc.217.1488229768200;
        Mon, 27 Feb 2017 13:09:28 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:c953:ec42:862e:1e81])
        by smtp.gmail.com with ESMTPSA id x2sm32316832pfb.49.2017.02.27.13.09.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 27 Feb 2017 13:09:27 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        sunny@sunbase.org,
        =?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v7 4/6] stash: teach 'push' (and 'create_stash') to honor pathspec
References: <20170219110313.24070-1-t.gummerer@gmail.com>
        <20170225213306.2410-1-t.gummerer@gmail.com>
        <20170225213306.2410-5-t.gummerer@gmail.com>
Date:   Mon, 27 Feb 2017 13:09:26 -0800
In-Reply-To: <20170225213306.2410-5-t.gummerer@gmail.com> (Thomas Gummerer's
        message of "Sat, 25 Feb 2017 21:33:04 +0000")
Message-ID: <xmqqwpcbuyrd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

>  	if test -z "$patch_mode"
>  	then
> -		git reset --hard ${GIT_QUIET:+-q}
> +		if test $# != 0
> +		then
> +			git reset ${GIT_QUIET:+-q} -- "$@"
> +			git checkout ${GIT_QUIET:+-q} HEAD -- $(git ls-files -z --modified "$@")

"ls-files -z" on the command line?  

Apparently new tests do not cover the correctness of this codepath.

I wonder if this

	git ls-files -z --modified "$@" |
	git checkout-index -z --force --stdin

is what the above "checkout" wanted to do.  The "reset" in the
previous step presumably updated the index entries that match
specified pathspec to those of the HEAD, so checking out the paths
that match "$@" from the index would be the same as checking them
out from the HEAD (while updating the index with them).

Perhaps squash the following into an appropriate patch in the
series?

 git-stash.sh     |  3 ++-
 t/t3903-stash.sh | 16 ++++++++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/git-stash.sh b/git-stash.sh
index 28d0624c75..9c70662cc8 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -300,7 +300,8 @@ push_stash () {
 		if test $# != 0
 		then
 			git reset ${GIT_QUIET:+-q} -- "$@"
-			git checkout ${GIT_QUIET:+-q} HEAD -- $(git ls-files -z --modified "$@")
+			git ls-files -z --modified -- "$@" |
+			git checkout-index -z --force --stdin
 			git clean --force ${GIT_QUIET:+-q} -d -- "$@"
 		else
 			git reset --hard ${GIT_QUIET:+-q}
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index f7733b4dd4..e868aafab2 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -891,4 +891,20 @@ test_expect_success 'stash without verb with pathspec' '
 	test_path_is_file bar
 '
 
+test_expect_success 'stash with pathspec matching multiple paths' '
+	echo original >file &&
+	echo original >other-file &&
+	git commit -m "two" file other-file &&
+	echo modified >file &&
+	echo modified >other-file &&
+	git stash -- "*file" &&
+	echo original >expect &&
+	test_cmp expect file &&
+	test_cmp expect other-file &&
+	git stash pop &&
+	echo modified >expect &&
+	test_cmp expect file &&
+	test_cmp expect other-file
+'
+
 test_done
