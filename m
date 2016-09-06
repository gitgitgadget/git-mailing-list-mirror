Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D7591F6BF
	for <e@80x24.org>; Tue,  6 Sep 2016 12:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755794AbcIFMcw (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Sep 2016 08:32:52 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:38262 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753617AbcIFMcv (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 6 Sep 2016 08:32:51 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id E252B20699;
        Tue,  6 Sep 2016 08:32:49 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute3.internal (MEProxy); Tue, 06 Sep 2016 08:32:49 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-sasl-enc
        :x-sasl-enc; s=mesmtp; bh=AYtyQprgGb0AXQ3RPXyzBbsdr3A=; b=i2Bfzl
        0tl9Epy4rZN2wbx37XKxpP9eflOiisGhbVsYfWwaeMjlHTEhLZvcXxwRWH/z8vYB
        X3XbaMCEShQrhKA/mJBT9ylxHj51e57uK/7O4QzXfPh9cqDgimYmOA/RMsvf0tLS
        CoEOvca1ECSTzWEL0ipE+cAejEd0Pdr9gMjBw=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=AYtyQprgGb0AXQ3
        RPXyzBbsdr3A=; b=tqmWL1smgrQT9cfC7weS+4ZnCCFinBJEPE4EZvIu1Ppyx/V
        EQAnQafj6mYZ7osJET7h3r6uPTaJmSuFxKnUAgj97YoXo7YD9ocfI0ZY0LaQx6/h
        z/2ol87AXNeJxPOas3XSgomv+y9toX0ZmWnUsgLExokwXl5Lhwy76sRy3YYw=
X-Sasl-enc: M34hU4ys5j7+bWlMAR0avohGRTyxH0nzyHUbCfpj+cD+ 1473165169
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
        by mail.messagingengine.com (Postfix) with ESMTPA id E32DACCE97;
        Tue,  6 Sep 2016 08:32:46 -0400 (EDT)
Subject: Re: [PATCH] Unbreak interactive GPG prompt upon signing
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
References: <0b8196564ac9f1db7c59b42d7e0973ba1399ec52.1473148900.git.johannes.schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   Michael J Gruber <git@drmicha.warpmail.net>
Message-ID: <ced7502d-0095-bd90-19e3-c14d0e4d4f07@drmicha.warpmail.net>
Date:   Tue, 6 Sep 2016 14:32:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <0b8196564ac9f1db7c59b42d7e0973ba1399ec52.1473148900.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin venit, vidit, dixit 06.09.2016 10:01:
> With the recent update in efee955 (gpg-interface: check gpg signature
> creation status, 2016-06-17), we ask GPG to send all status updates to
> stderr, and then catch the stderr in an strbuf.
> 
> But GPG might fail, and send error messages to stderr. And we simply
> do not show them to the user.
> 
> Even worse: this swallows any interactive prompt for a passphrase. And
> detaches stderr from the tty so that the passphrase cannot be read.
> 
> So while the first problem could be fixed (by printing the captured
> stderr upon error), the second problem cannot be easily fixed, and
> presents a major regression.

My Git has that commit and does ask me for the passphrase on the tty.
Also, I do get error messages:

git tag -u pebcak -s testt -m m
error: gpg failed to sign the data
error: unable to sign the tag

which we could (maybe should) amend by gpg's stderr.

> So let's just revert commit efee9553a4f97b2ecd8f49be19606dd4cf7d9c28.

That "just" reintroduces the problem that the orignal patch solves.

The passphrase/tty issue must be Windows specific - or the non-issue
Linux-specific, if you prefer.

> This fixes https://github.com/git-for-windows/git/issues/871
> 
> Cc: Michael J Gruber <git@drmicha.warpmail.net>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> Published-As: https://github.com/dscho/git/releases/tag/fix-gpg-v1
> Fetch-It-Via: git fetch https://github.com/dscho/git fix-gpg-v1
> 
>  gpg-interface.c | 8 ++------
>  t/t7004-tag.sh  | 9 +--------
>  2 files changed, 3 insertions(+), 14 deletions(-)
> 
> diff --git a/gpg-interface.c b/gpg-interface.c
> index 8672eda..3f3a3f7 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -153,11 +153,9 @@ int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *sig
>  	struct child_process gpg = CHILD_PROCESS_INIT;
>  	int ret;
>  	size_t i, j, bottom;
> -	struct strbuf gpg_status = STRBUF_INIT;
>  
>  	argv_array_pushl(&gpg.args,
>  			 gpg_program,
> -			 "--status-fd=2",
>  			 "-bsau", signing_key,
>  			 NULL);
>  
> @@ -169,12 +167,10 @@ int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *sig
>  	 */
>  	sigchain_push(SIGPIPE, SIG_IGN);
>  	ret = pipe_command(&gpg, buffer->buf, buffer->len,
> -			   signature, 1024, &gpg_status, 0);
> +			   signature, 1024, NULL, 0);
>  	sigchain_pop(SIGPIPE);
>  
> -	ret |= !strstr(gpg_status.buf, "\n[GNUPG:] SIG_CREATED ");
> -	strbuf_release(&gpg_status);
> -	if (ret)
> +	if (ret || signature->len == bottom)
>  		return error(_("gpg failed to sign the data"));
>  
>  	/* Strip CR from the line endings, in case we are on Windows. */
> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> index 8b0f71a..f9b7d79 100755
> --- a/t/t7004-tag.sh
> +++ b/t/t7004-tag.sh
> @@ -1202,17 +1202,10 @@ test_expect_success GPG,RFC1991 \
>  # try to sign with bad user.signingkey
>  git config user.signingkey BobTheMouse
>  test_expect_success GPG \
> -	'git tag -s fails if gpg is misconfigured (bad key)' \
> +	'git tag -s fails if gpg is misconfigured' \
>  	'test_must_fail git tag -s -m tail tag-gpg-failure'
>  git config --unset user.signingkey
>  
> -# try to produce invalid signature
> -test_expect_success GPG \
> -	'git tag -s fails if gpg is misconfigured (bad signature format)' \
> -	'test_config gpg.program echo &&
> -	 test_must_fail git tag -s -m tail tag-gpg-failure'
> -
> -
>  # try to verify without gpg:
>  
>  rm -rf gpghome
> 

