Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57032C433EF
	for <git@archiver.kernel.org>; Sun,  5 Dec 2021 19:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237891AbhLET1Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Dec 2021 14:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237264AbhLET1P (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Dec 2021 14:27:15 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2016C061714
        for <git@vger.kernel.org>; Sun,  5 Dec 2021 11:23:47 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id t5so34213119edd.0
        for <git@vger.kernel.org>; Sun, 05 Dec 2021 11:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9e4Fz5wcbDLa2injo7w6QcbpAdT8V/UenZJcgsjtGqA=;
        b=FFM34wsd0JBSRbyi8pd76otB6+Q3CQkofHaecPF9/6Up4xMs504fFvX48OwN8HE5Qj
         RRpaZNajfNvGQeFwgJ14mKZzrlZhNt9LVZ/L9eNiyJOyRdQ9YaJz9GAqpSUgXi4rtv9I
         t7zPbd5Zcz9zM9GnmPd/H7xnq18t3mM3ZCjnr3I2lteYsMz73En5bzZmB9nGl3KFWPcq
         ySn0ECcyaf+asJuWDdfYuZ6aqoG6MOmiMzTPPF6QYV99SUU3bNPROHwmHmT6KyNnXtWP
         1uSZEG8DSiguaduIbR6k0NQD4WupDYQyuX+BbSf47b9bIiTVMwXMJJljjyxPjt9l6+Z+
         nKVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9e4Fz5wcbDLa2injo7w6QcbpAdT8V/UenZJcgsjtGqA=;
        b=BzrC6t/4jCM9uhEYTJdtV3gZvSBWf3x6n6Y+DLmyv7MYMG2URP+n1cjCGkUJDeGwMr
         tvvUGm5585olZ79aRNEQu1Eh7bmsGwpNtMVMBYjh1cA8q4kweTNQsBCT4rYC476O/PH6
         50p+AE1zlOqE3Twun9CyjFcwkEFudWWZYx6n+DNB0KqhvF8LjymXMWISeaxiZfKOpLEi
         LUux7FnjlzIJNaA4n92YdRA9lLCDZuhk8mT2s0ytzpguyaQFjuzCPn4fj2eFdEZ1y76y
         Y2xp2U2M3FhptvIhdhiKIpCe1BgZc9GDa94lire9XVzh5/Vf6s1k6C8Xt8TPPzLVEMFC
         7dfQ==
X-Gm-Message-State: AOAM532pCtOugXNHBdEZrF1VbeWCAQsWn+CTNxEPpYG11/HQNCKsz4RQ
        ljbRqz6aaI2/8Lwi/WGiYjA=
X-Google-Smtp-Source: ABdhPJyn0MySTMa3Euwu/941TmI1GPqB4mdHM4y1wtLsspPt0pMKf1hLjxB43W6ZJ1g1P1q7X33m3Q==
X-Received: by 2002:a05:6402:455:: with SMTP id p21mr46642935edw.384.1638732226544;
        Sun, 05 Dec 2021 11:23:46 -0800 (PST)
Received: from szeder.dev (94-21-58-127.pool.digikabel.hu. [94.21.58.127])
        by smtp.gmail.com with ESMTPSA id aq6sm5548345ejc.41.2021.12.05.11.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 11:23:46 -0800 (PST)
Date:   Sun, 5 Dec 2021 20:23:44 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 6/7] ssh signing: make fmt-merge-msg consider key
 lifetime
Message-ID: <20211205192344.GB624717@szeder.dev>
References: <20211117093529.13953-1-fs@gigacodes.de>
 <20211130141112.78193-1-fs@gigacodes.de>
 <20211130141112.78193-7-fs@gigacodes.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211130141112.78193-7-fs@gigacodes.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 30, 2021 at 03:11:11PM +0100, Fabian Stelzer wrote:
> diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
> index 06c5fb5615..2dd2423643 100755
> --- a/t/t6200-fmt-merge-msg.sh
> +++ b/t/t6200-fmt-merge-msg.sh
> @@ -91,6 +91,26 @@ test_expect_success GPGSSH 'created ssh signed commit and tag' '
>  	git tag -s -u"${GPGSSH_KEY_UNTRUSTED}" -m signed-ssh-tag-msg-untrusted signed-untrusted-ssh-tag left
>  '
>  
> +test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'create signed tags with keys having defined lifetimes' '
> +	test_when_finished "test_unconfig commit.gpgsign" &&
> +	test_config gpg.format ssh &&
> +	git checkout -b signed-expiry-ssh &&
> +	touch file &&
> +	git add file &&
> +
> +	echo expired >file && test_tick && git commit -a -m expired -S"${GPGSSH_KEY_EXPIRED}" &&
> +	git tag -s -u "${GPGSSH_KEY_EXPIRED}" -m expired-signed expired-signed &&
> +
> +	echo notyetvalid >file && test_tick && git commit -a -m notyetvalid -S"${GPGSSH_KEY_NOTYETVALID}" &&
> +	git tag -s -u "${GPGSSH_KEY_NOTYETVALID}" -m notyetvalid-signed notyetvalid-signed &&
> +
> +	echo timeboxedvalid >file && test_tick && git commit -a -m timeboxedvalid -S"${GPGSSH_KEY_TIMEBOXEDVALID}" &&
> +	git tag -s -u "${GPGSSH_KEY_TIMEBOXEDVALID}" -m timeboxedvalid-signed timeboxedvalid-signed &&
> +
> +	echo timeboxedinvalid >file && test_tick && git commit -a -m timeboxedinvalid -S"${GPGSSH_KEY_TIMEBOXEDINVALID}" &&
> +	git tag -s -u "${GPGSSH_KEY_TIMEBOXEDINVALID}" -m timeboxedinvalid-signed timeboxedinvalid-signed
> +'
> +
>  test_expect_success 'message for merging local branch' '
>  	echo "Merge branch ${apos}left${apos}" >expected &&
>  
> @@ -137,6 +157,40 @@ test_expect_success GPGSSH 'message for merging local tag signed by unknown ssh
>  	! grep "${GPGSSH_BAD_SIGNATURE}" actual &&
>  	grep "${GPGSSH_KEY_NOT_TRUSTED}" actual
>  '
> +
> +test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'message for merging local tag signed by expired ssh key' '
> +	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
> +	git checkout main &&
> +	git fetch . expired-signed &&
> +	git fmt-merge-msg <.git/FETCH_HEAD >actual 2>&1 &&
> +	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual

Are these messages supposed to go to standard output or error?  If
it's the former, then please drop the unnecessary (and confusing)
'2>&1' redirection, but if it's the latter, then save and 'grep' only
stderr.

> +'
> +
> +test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'message for merging local tag signed by not yet valid ssh key' '
> +	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
> +	git checkout main &&
> +	git fetch . notyetvalid-signed &&
> +	git fmt-merge-msg <.git/FETCH_HEAD >actual 2>&1 &&
> +	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
> +'
> +
> +test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'message for merging local tag signed by valid timeboxed ssh key' '
> +	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
> +	git checkout main &&
> +	git fetch . timeboxedvalid-signed &&
> +	git fmt-merge-msg <.git/FETCH_HEAD >actual 2>&1 &&
> +	grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
> +	! grep "${GPGSSH_BAD_SIGNATURE}" actual
> +'
> +
> +test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'message for merging local tag signed by invalid timeboxed ssh key' '
> +	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
> +	git checkout main &&
> +	git fetch . timeboxedinvalid-signed &&
> +	git fmt-merge-msg <.git/FETCH_HEAD >actual 2>&1 &&
> +	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
> +'
> +
>  test_expect_success 'message for merging external branch' '
>  	echo "Merge branch ${apos}left${apos} of $(pwd)" >expected &&
>  
> -- 
> 2.31.1
> 
