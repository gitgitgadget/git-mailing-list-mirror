Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290F5EB64D8
	for <git@archiver.kernel.org>; Wed, 14 Jun 2023 16:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245223AbjFNQAh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jun 2023 12:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245220AbjFNQAc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2023 12:00:32 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733212120
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 09:00:26 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b4f8523197so7833775ad.1
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 09:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686758426; x=1689350426;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5/sEDjSNT2Hg4D0UbW5wjd4tRFI4UwWyc5xTh7zQ3lg=;
        b=M4SJ38QQoO+Xda7p48yTPr5lToAVVQFMjG3jUtuZHHYoCpYTVWCcteZDI7zYMko2T7
         QL5v75FF89F87VG5/n/B1Aul5HA94yEBbPtXNqFl5T1TImn1BURel/ks2JK0+PkBjY7X
         HChvjEP03RK0YJ03lJSbmAuCFVuxgHhtlL0GX9b6eRZwEm9mosbLweVJbKl/M5iEQbDv
         82q5YAr61rxcE4nFg+U1MAVfUWw3wUPaBu7j9kHRRVg/mlqj1cB85r/ExblIHkoZJ35V
         cMmKNDKFOQ7d9LD0GqGASb7F+gFRoMhCp9popwZPUHI1Qtrx1iUI/cvrx7Rf4ea4iUU5
         dQvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686758426; x=1689350426;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5/sEDjSNT2Hg4D0UbW5wjd4tRFI4UwWyc5xTh7zQ3lg=;
        b=kz9X30P7a7qOaX6W2yqZIVjNDb/GeL1djfcNx40fqQ8dmmJIZm9Sp72Lv8cN7ip9T6
         JlNrfLf1yB8d4V6y8VB0HD9VcxSSZ75apexgoDUuWJNdYg1ipaL5p629BWVzwmwFUVnX
         WcMDZYWCUP69HsOklNpxh9vS6mF5DtLHkfMoWaGgEAGbjJTTnzk9CIu3fGuFTfnfKnQt
         GJIqX1326S7bwmKB4rEhuOtHtD5/g86KLRE5M9mYou8EcDM/ly6ArX/fHNVa9PX16bFB
         u9AJPeY5wicE+op3Zyprn8jlzeKaO69oV0jniTKsGRuwIaE8Eo7mXRw+XzQ9+0Qt5REq
         XRjA==
X-Gm-Message-State: AC+VfDxeUlwp2RhMoPEh/ogYoaDf93Sgio57piUgmVZgQFJG1KTWqY7s
        +6MuPMQli2SsTM32AVsHqm+BSlVthUg=
X-Google-Smtp-Source: ACHHUZ70hi2ybgMwdrFzkFav8mo3KhvNswbUCQMBq0TaS6i2zls31ea3uSiDMowv5Wsq6wk2Xd/NEQ==
X-Received: by 2002:a17:90b:4387:b0:25c:7d4:7cd with SMTP id in7-20020a17090b438700b0025c07d407cdmr2360351pjb.24.1686758425530;
        Wed, 14 Jun 2023 09:00:25 -0700 (PDT)
Received: from localhost (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id c14-20020a17090a020e00b0023fcece8067sm11910052pjc.2.2023.06.14.09.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 09:00:24 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, M Hickford <mirth.hickford@gmail.com>,
        Jeff King <peff@peff.net>,
        Matthew John Cheetham <mjcheetham@outlook.com>
Subject: Re: [PATCH 2/2] credential: erase all matching credentials
References: <pull.1525.git.git.1686741785.gitgitgadget@gmail.com>
        <fcdb579263f87dd089c50fc5799cf30b21f4d12c.1686741785.git.gitgitgadget@gmail.com>
Date:   Wed, 14 Jun 2023 09:00:24 -0700
In-Reply-To: <fcdb579263f87dd089c50fc5799cf30b21f4d12c.1686741785.git.gitgitgadget@gmail.com>
        (M. Hickford via GitGitGadget's message of "Wed, 14 Jun 2023 11:23:05
        +0000")
Message-ID: <xmqqv8fqxcdj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"M Hickford via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: M Hickford <mirth.hickford@gmail.com>
>
> Users expect that
> `echo "url=https://example.com" | git credential reject` or
> `echo "url=https://example.com\nusername=tim" | git credential reject`
> erase all matching credentials.

Perhaps that is a sensible expectation.  It is unclear from the
above description what happens instead without the "fix", though.

By the way, I do not think your

    cc. Jeff King peff@peff.net cc: Matthew John Cheetham mjcheetham@outlook.com

in 0/2 is doing anything; I've manually added them to Cc: of this
message and left everything in the patch below, even though I am not
commenting on anything there myself, to give them easier reference.

Thanks.

> Fixes for credential-cache and credential-store.
>
> Signed-off-by: M Hickford <mirth.hickford@gmail.com>
> ---
>  Documentation/git-credential.txt   |  4 ++--
>  Documentation/gitcredentials.txt   |  2 +-
>  builtin/credential-cache--daemon.c | 15 ++++++++------
>  builtin/credential-store.c         |  3 ++-
>  t/lib-credential.sh                | 33 ++++++++++++++++++++++++++++++
>  5 files changed, 47 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
> index 0e6d9e85ec7..04bfb918de6 100644
> --- a/Documentation/git-credential.txt
> +++ b/Documentation/git-credential.txt
> @@ -38,8 +38,8 @@ to any configured credential helpers, which may store the credential
>  for later use.
>  
>  If the action is `reject`, git-credential will send the description to
> -any configured credential helpers, which may erase any stored
> -credential matching the description.
> +any configured credential helpers, which may erase stored credentials
> +matching the description.
>  
>  If the action is `approve` or `reject`, no output should be emitted.
>  
> diff --git a/Documentation/gitcredentials.txt b/Documentation/gitcredentials.txt
> index 100f045bb1a..65d652dc40e 100644
> --- a/Documentation/gitcredentials.txt
> +++ b/Documentation/gitcredentials.txt
> @@ -260,7 +260,7 @@ appended to its command line, which is one of:
>  
>  `erase`::
>  
> -	Remove a matching credential, if any, from the helper's storage.
> +	Remove matching credentials, if any, from the helper's storage.
>  
>  The details of the credential will be provided on the helper's stdin
>  stream. The exact format is the same as the input/output format of the
> diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
> index 82f376d3351..5e3a766e42d 100644
> --- a/builtin/credential-cache--daemon.c
> +++ b/builtin/credential-cache--daemon.c
> @@ -33,12 +33,12 @@ static void cache_credential(struct credential *c, int timeout)
>  	e->expiration = time(NULL) + timeout;
>  }
>  
> -static struct credential_cache_entry *lookup_credential(const struct credential *c, int match_password)
> +static struct credential_cache_entry *lookup_credential(const struct credential *c)
>  {
>  	int i;
>  	for (i = 0; i < entries_nr; i++) {
>  		struct credential *e = &entries[i].item;
> -		if (credential_match(c, e, match_password))
> +		if (credential_match(c, e, 0))
>  			return &entries[i];
>  	}
>  	return NULL;
> @@ -48,9 +48,12 @@ static void remove_credential(const struct credential *c)
>  {
>  	struct credential_cache_entry *e;
>  
> -	e = lookup_credential(c, c->password != NULL);
> -	if (e)
> -		e->expiration = 0;
> +	int i;
> +	for (i = 0; i < entries_nr; i++) {
> +		e = &entries[i];
> +		if (credential_match(c, &e->item, c->password != NULL))
> +			e->expiration = 0;
> +	}
>  }
>  
>  static timestamp_t check_expirations(void)
> @@ -127,7 +130,7 @@ static void serve_one_client(FILE *in, FILE *out)
>  	if (read_request(in, &c, &action, &timeout) < 0)
>  		/* ignore error */ ;
>  	else if (!strcmp(action.buf, "get")) {
> -		struct credential_cache_entry *e = lookup_credential(&c, 0);
> +		struct credential_cache_entry *e = lookup_credential(&c);
>  		if (e) {
>  			fprintf(out, "username=%s\n", e->item.username);
>  			fprintf(out, "password=%s\n", e->item.password);
> diff --git a/builtin/credential-store.c b/builtin/credential-store.c
> index e0ae028b1c3..85b147e460f 100644
> --- a/builtin/credential-store.c
> +++ b/builtin/credential-store.c
> @@ -36,7 +36,8 @@ static int parse_credential_file(const char *fn,
>  			found_credential = 1;
>  			if (match_cb) {
>  				match_cb(&entry);
> -				break;
> +				if (strcmp(op, "erase"))
> +					break;
>  			}
>  		}
>  		else if (other_cb)
> diff --git a/t/lib-credential.sh b/t/lib-credential.sh
> index f7e4e29c5e1..3f4100b6ce2 100644
> --- a/t/lib-credential.sh
> +++ b/t/lib-credential.sh
> @@ -45,6 +45,8 @@ helper_test_clean() {
>  	reject $1 https example.com user2
>  	reject $1 https example.com user4
>  	reject $1 https example.com user5
> +	reject $1 https example.com user6
> +	reject $1 https example.com user7
>  	reject $1 http path.tld user
>  	reject $1 https timeout.tld user
>  	reject $1 https sso.tld
> @@ -298,6 +300,37 @@ helper_test() {
>  		EOF
>  	'
>  
> +	test_expect_success "helper ($HELPER) erases all matching credentials" '
> +		check approve $HELPER <<-\EOF &&
> +		protocol=https
> +		host=example.com
> +		username=user6
> +		password=pass1
> +		EOF
> +		check approve $HELPER <<-\EOF &&
> +		protocol=https
> +		host=example.com
> +		username=user7
> +		password=pass1
> +		EOF
> +		check reject $HELPER <<-\EOF &&
> +		protocol=https
> +		host=example.com
> +		EOF
> +		check fill $HELPER <<-\EOF
> +		protocol=https
> +		host=example.com
> +		--
> +		protocol=https
> +		host=example.com
> +		username=askpass-username
> +		password=askpass-password
> +		--
> +		askpass: Username for '\''https://example.com'\'':
> +		askpass: Password for '\''https://askpass-username@example.com'\'':
> +		EOF
> +	'
> +
>  	: ${GIT_TEST_LONG_CRED_BUFFER:=1024}
>  	# 23 bytes accounts for "wwwauth[]=basic realm=" plus NUL
>  	LONG_VALUE_LEN=$((GIT_TEST_LONG_CRED_BUFFER - 23))
