Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E14EB64D9
	for <git@archiver.kernel.org>; Thu, 15 Jun 2023 21:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjFOVJU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jun 2023 17:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjFOVJS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2023 17:09:18 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9361726AA
        for <git@vger.kernel.org>; Thu, 15 Jun 2023 14:09:17 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1a68c02553aso157811fac.0
        for <git@vger.kernel.org>; Thu, 15 Jun 2023 14:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686863357; x=1689455357;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=soPNxAyKJ9RUIyo6kxP5pacTuNoM51m3yapgku5ejDU=;
        b=A5jnrepxC/TMSTSL4pCRiWQjEq4o4ZwioAKDnbqcSdaqzdpXwnlgM1aXZuFw4uUgxF
         XG0k3Ptht7FuOEXBxTZCB/BS7VzCzgkyWCdmYdS6TKyGoubVM/lPIm8O9CRttXwhhhZ0
         n5TJjuq9TAi3/ZQ9L7mw6UodyEXwfVIIPOqhHe4Tdsnj225pLCLtoS+uBpIxgULuZxK1
         QsdMuAyybFpMlxz0Hxo+jK+e6qrPE0svYiY4YRecYY4p8zXftiFytBayP7kP41T1Aul5
         8zpkZMwIrrDBaleT6gjYiIWE4fvdUZwMX07WIxjVqsMZFxwdWAxhPQIpKG6/QIkU4q1h
         FORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686863357; x=1689455357;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=soPNxAyKJ9RUIyo6kxP5pacTuNoM51m3yapgku5ejDU=;
        b=KBc7mLpGujpY7wvtLJiOCk4cGvRiy0F4X9ToTaF4lr7qKuh97TOm9om0cn3G3bNpCA
         HpAUrGBmI/c2VcD3T1zoYmhxvLpp5w3+nmtMqd1GBKgbpzAZ5wAnezPL+bMWGME/txBZ
         zdvVeGcxVENJoQa4yugos+51yd2+3nJGuktEfNmLTug7c5zhC4yHXbDZKdN51PfgqRrx
         ZoQbdnZk0NhyhAIfz7PQtmcD73LU/AJMfBTpxBCwoFIcJyrVsxhtVJsUCGcXZFqm/NLb
         Brp1I9JYFqXFS1RB73IOF7UhlsIAbfx7gbKOkIB8Nu3SWXUp70Lkq/0AMogNA8/DY5Hk
         K3vQ==
X-Gm-Message-State: AC+VfDzc8a5OmcWWqXpKOflkgAl1GFAx5duZ4o9jep6Z4gzhaEYxFqAj
        GiRZ/tDsBw0MPM6kkCIWMFA=
X-Google-Smtp-Source: ACHHUZ6byUKBdYNGD/bGfVVkZ244ry2aW4qZrZnsRpmdtB9+Xc7w7iOeTYMhQ9N0XoknBkbA62v8Fw==
X-Received: by 2002:a05:6871:4c7:b0:19f:214b:b852 with SMTP id n7-20020a05687104c700b0019f214bb852mr194782oai.56.1686863356799;
        Thu, 15 Jun 2023 14:09:16 -0700 (PDT)
Received: from localhost (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id r91-20020a17090a43e400b00256dff5f8e3sm55201pjg.49.2023.06.15.14.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 14:09:16 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH v4 0/2] credential: improvements to erase in helpers
References: <pull.1525.v3.git.git.1686809004.gitgitgadget@gmail.com>
        <pull.1525.v4.git.git.1686856773.gitgitgadget@gmail.com>
Date:   Thu, 15 Jun 2023 14:09:15 -0700
In-Reply-To: <pull.1525.v4.git.git.1686856773.gitgitgadget@gmail.com>
        (M. Hickford via GitGitGadget's message of "Thu, 15 Jun 2023 19:19:31
        +0000")
Message-ID: <xmqqh6r8v3es.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"M Hickford via GitGitGadget" <gitgitgadget@gmail.com> writes:

> M Hickford (2):
>   credential: avoid erasing distinct password
>   credential: erase all matching credentials
>
>  Documentation/git-credential.txt   |   2 +-
>  Documentation/gitcredentials.txt   |   2 +-
>  builtin/credential-cache--daemon.c |  17 +++--
>  builtin/credential-store.c         |  15 +++--
>  credential.c                       |   7 +-
>  credential.h                       |   2 +-
>  t/lib-credential.sh                | 103 +++++++++++++++++++++++++++++
>  7 files changed, 128 insertions(+), 20 deletions(-)

It is helpful to reviewers to describe/summarize, in your own words,
what changed since the previous version, in the cover letter.

The range-diff generated for the versions can serve as a good
supporting material, and it would help you while writing that
summary, but not a substitute for the summary.

Thanks.

> base-commit: d7d8841f67f29e6ecbad85a11805c907d0f00d5d
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1525%2Fhickford%2Ferase-test-v4
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1525/hickford/erase-test-v4
> Pull-Request: https://github.com/git/git/pull/1525
>
> Range-diff vs v3:
>
>  1:  df3c8a15bf8 ! 1:  91d4b04b5e1 credential: avoid erasing distinct password
>      @@ builtin/credential-store.c: static struct lock_file credential_lock;
>        	FILE *fh;
>        	struct strbuf line = STRBUF_INIT;
>       @@ builtin/credential-store.c: static int parse_credential_file(const char *fn,
>      - 
>        	while (strbuf_getline_lf(&line, fh) != EOF) {
>        		if (!credential_from_url_gently(&entry, line.buf, 1) &&
>      --		    entry.username && entry.password &&
>      + 		    entry.username && entry.password &&
>       -		    credential_match(c, &entry)) {
>      -+			entry.username && entry.password &&
>      -+			credential_match(c, &entry, match_password)) {
>      ++		    credential_match(c, &entry, match_password)) {
>        			found_credential = 1;
>        			if (match_cb) {
>        				match_cb(&entry);
>      @@ credential.c: void credential_clear(struct credential *c)
>        {
>        #define CHECK(x) (!want->x || (have->x && !strcmp(want->x, have->x)))
>        	return CHECK(protocol) &&
>      --	       CHECK(host) &&
>      --	       CHECK(path) &&
>      + 	       CHECK(host) &&
>      + 	       CHECK(path) &&
>       -	       CHECK(username);
>      -+		CHECK(host) &&
>      -+		CHECK(path) &&
>      -+		CHECK(username) &&
>      -+		(!match_password || CHECK(password));
>      ++	       CHECK(username) &&
>      ++	       (!match_password || CHECK(password));
>        #undef CHECK
>        }
>        
>      @@ t/lib-credential.sh: helper_test_clean() {
>        	reject $1 https example.com user1
>        	reject $1 https example.com user2
>        	reject $1 https example.com user4
>      -+	reject $1 https example.com user5
>      -+	reject $1 https example.com user8
>      ++	reject $1 https example.com user-distinct-pass
>      ++	reject $1 https example.com user-overwrite
>        	reject $1 http path.tld user
>        	reject $1 https timeout.tld user
>        	reject $1 https sso.tld
>      @@ t/lib-credential.sh: helper_test() {
>       +		check approve $HELPER <<-\EOF &&
>       +		protocol=https
>       +		host=example.com
>      -+		username=user8
>      ++		username=user-overwrite
>       +		password=pass1
>       +		EOF
>       +		check approve $HELPER <<-\EOF &&
>       +		protocol=https
>       +		host=example.com
>      -+		username=user8
>      ++		username=user-overwrite
>       +		password=pass2
>       +		EOF
>       +		check fill $HELPER <<-\EOF &&
>       +		protocol=https
>       +		host=example.com
>      -+		username=user8
>      ++		username=user-overwrite
>       +		--
>       +		protocol=https
>       +		host=example.com
>      -+		username=user8
>      ++		username=user-overwrite
>       +		password=pass2
>       +		EOF
>       +		check reject $HELPER <<-\EOF &&
>       +		protocol=https
>       +		host=example.com
>      -+		username=user8
>      ++		username=user-overwrite
>       +		password=pass2
>       +		EOF
>       +		check fill $HELPER <<-\EOF
>       +		protocol=https
>       +		host=example.com
>      -+		username=user8
>      ++		username=user-overwrite
>       +		--
>       +		protocol=https
>       +		host=example.com
>      -+		username=user8
>      ++		username=user-overwrite
>       +		password=askpass-password
>       +		--
>      -+		askpass: Password for '\''https://user8@example.com'\'':
>      ++		askpass: Password for '\''https://user-overwrite@example.com'\'':
>       +		EOF
>       +	'
>       +
>      @@ t/lib-credential.sh: helper_test() {
>       +		check approve $HELPER <<-\EOF &&
>       +		protocol=https
>       +		host=example.com
>      -+		username=user5
>      ++		username=user-distinct-pass
>       +		password=pass1
>       +		EOF
>       +		check reject $HELPER <<-\EOF &&
>       +		protocol=https
>       +		host=example.com
>      -+		username=user5
>      ++		username=user-distinct-pass
>       +		password=pass2
>       +		EOF
>       +		check fill $HELPER <<-\EOF
>       +		protocol=https
>       +		host=example.com
>      -+		username=user5
>      ++		username=user-distinct-pass
>       +		--
>       +		protocol=https
>       +		host=example.com
>      -+		username=user5
>      ++		username=user-distinct-pass
>       +		password=pass1
>       +		EOF
>       +	'
>  2:  e06d80e99a0 ! 2:  42f41b28e6e credential: erase all matching credentials
>      @@ Commit message
>       
>           `credential reject` sends the erase action to each helper, but the
>           exact behaviour of erase isn't specified in documentation or tests.
>      -    Some helpers (such as credential-libsecret) delete all matching
>      -    credentials, others (such as credential-cache and credential-store)
>      -    delete at most one matching credential.
>      +    Some helpers (such as credential-store and credential-libsecret) delete
>      +    all matching credentials, others (such as credential-cache) delete at
>      +    most one matching credential.
>       
>           Test that helpers erase all matching credentials. This behaviour is
>           easiest to reason about. Users expect that `echo
>      @@ Commit message
>           "url=https://example.com\nusername=tim" | git credential reject` erase
>           all matching credentials.
>       
>      -    Fix credential-cache and credential-store.
>      +    Fix credential-cache.
>       
>           Signed-off-by: M Hickford <mirth.hickford@gmail.com>
>       
>      @@ builtin/credential-cache--daemon.c: static void serve_one_client(FILE *in, FILE
>        			fprintf(out, "username=%s\n", e->item.username);
>        			fprintf(out, "password=%s\n", e->item.password);
>       
>      - ## builtin/credential-store.c ##
>      -@@ builtin/credential-store.c: static int parse_credential_file(const char *fn,
>      - 			found_credential = 1;
>      - 			if (match_cb) {
>      - 				match_cb(&entry);
>      --				break;
>      - 			}
>      - 		}
>      - 		else if (other_cb)
>      -
>        ## t/lib-credential.sh ##
>       @@ t/lib-credential.sh: helper_test_clean() {
>      - 	reject $1 https example.com user2
>        	reject $1 https example.com user4
>      - 	reject $1 https example.com user5
>      -+	reject $1 https example.com user6
>      -+	reject $1 https example.com user7
>      - 	reject $1 https example.com user8
>      + 	reject $1 https example.com user-distinct-pass
>      + 	reject $1 https example.com user-overwrite
>      ++	reject $1 https example.com user-erase1
>      ++	reject $1 https example.com user-erase2
>        	reject $1 http path.tld user
>        	reject $1 https timeout.tld user
>      + 	reject $1 https sso.tld
>       @@ t/lib-credential.sh: helper_test() {
>        		EOF
>        	'
>      @@ t/lib-credential.sh: helper_test() {
>       +		check approve $HELPER <<-\EOF &&
>       +		protocol=https
>       +		host=example.com
>      -+		username=user6
>      ++		username=user-erase1
>       +		password=pass1
>       +		EOF
>       +		check approve $HELPER <<-\EOF &&
>       +		protocol=https
>       +		host=example.com
>      -+		username=user7
>      ++		username=user-erase2
>       +		password=pass1
>       +		EOF
>       +		check reject $HELPER <<-\EOF &&
