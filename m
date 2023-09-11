Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD857CA0EC2
	for <git@archiver.kernel.org>; Mon, 11 Sep 2023 21:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349375AbjIKVdY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236334AbjIKKVy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 06:21:54 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C021AB
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 03:21:48 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-5007c8308c3so7039515e87.0
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 03:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694427707; x=1695032507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uxQsiQTkVQCmjF/jvwYFn4WKUnEi52EvsZQDwu4zdec=;
        b=UYcV2+HeRebLXgyO8mytBO7OjIsyMASxLDoxzdQ6iijaahmO4d5733+VmJc2sGufVV
         KiLwDw2y0Vmyb6GDQm86r4URkt2Sy5JjerQwUqtKLynFB8RKLBUIsfvyFI0SsOWTcO77
         WYL11z+FTVg5F0EmYv86cjZMNczZ3F5EIsU7SQbkF5u4ivcUHIe5XyADXJuO1sgOfGZv
         DCAIHu3O7yn2flO3thhYR8llcMinqeXJyhiOfpqbpwbCsOatPcjYXw3bNJSwbHowWJm7
         HQvHL+VTqyLm2MRm7Ig2X7KffTfmxNWWNuZvwSC7r/zoefDU6jOdBvqVk5I0TSrn530m
         8ZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694427707; x=1695032507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uxQsiQTkVQCmjF/jvwYFn4WKUnEi52EvsZQDwu4zdec=;
        b=KwMFKWQK/znkQMu1unnoO4Jou99eRWHGAjOEoaqs+07OLWArZcnoTfkWKi3BcRydQp
         MNTMkeja6DXJ8BDQ5/JY8pa3Z56i5IYRzl2rCJQLgTqCbk/hqweecNo5gWQ6AbA7BW4g
         J3k7jknyFvCENica7iuCyTGZl08F/wpMgBEzIIuZ/xM69jGWiAvqQ85SH1zBkKDLHNtE
         stuoCxd5FOfOFSqRjOdBjxpWekw9H043nkrwXGEeFVHTNjkg8UXLTuQXGg8Y2O3xDljk
         4XeLzCqtQ+svSdMbSPiv1A1ssDv66FXeHG9n8nZYztViEqIH6nfvzHxJAKrek7HgnFs2
         G9KQ==
X-Gm-Message-State: AOJu0YxO58c88Gd59N43DF0q+SXcT4oGzR/d4i3vY9tZ30k1z1g5jckk
        UwavVh2PQz2PVU/u3mqbhVhJsRuR7fM=
X-Google-Smtp-Source: AGHT+IHrfXze18dGfd6l0ayyL6HjiYOj7nY1QYrkeh7XV3Pl1fZEkph/+c3wDkVe3tR8XgCJYAm5cg==
X-Received: by 2002:a05:6512:238e:b0:500:91c1:9642 with SMTP id c14-20020a056512238e00b0050091c19642mr8238398lfv.21.1694427706657;
        Mon, 11 Sep 2023 03:21:46 -0700 (PDT)
Received: from localhost.localdomain (78-67-21-133-no600.tbcn.telia.com. [78.67.21.133])
        by smtp.gmail.com with ESMTPSA id n26-20020ac2491a000000b00500b3157eb9sm1304655lfi.158.2023.09.11.03.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 03:21:45 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, ZheNing Hu <adlternative@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH] completion: commit: complete configured trailer tokens
Date:   Mon, 11 Sep 2023 12:20:15 +0200
Message-ID: <20230911102017.1927468-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.42.0.465.g461bb28fbd
In-Reply-To: <pull.1583.git.1694108551683.gitgitgadget@gmail.com>
References: <pull.1583.git.1694108551683.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philippe,

> Add a __git_trailer_tokens function to list the configured trailers
> tokens, and use it in _git_commit to suggest the configured tokens,
> suffixing the completion words with ':' so that the user only has to add
> the trailer value.

Makes sense.

I've never dabbled in the completion scripts, so take the following with
some salt.

> +__git_trailer_tokens ()
> +{
> +	git config --name-only --get-regexp trailer.\*.key | awk -F. '{print $2}'
> +}

The rest of this script uses `__git config` rather than `git config`.
The purpose of `__git` seems to be to respect options given on the
command line, so I think we would want to use it here.

These "." in "trailer." and ".key" will match any character. We also
don't anchor this at beginning and end. Maybe tighten this a bit and use
'^trailer\..*\.key$' to behave better in the face of config such as
this:

	[strailer]
		skeying = "s"
	[trailerx]
		keyx = "x"

Another thing. Consider such a config:

	[trailer "q.p"]
		key = "Q-p-by"

The "trailer.q.p.key" config above ends up completing as just "q"
because of how you use `print $2`. I see that `git commit --trailer=`
itself is fairly relaxed here, so `--trailer=q` effectively ends up
picking up "q.p" in the end. Tightening that is obviously out of scope
here and I have no opinion if the current behavior there is intended.
But maybe we should be a bit less relaxed here and complete to "q.p"? At
any rate, it gets weird when you also have "trailer.q.x.key" in your
config but we still just suggest the one "q".

I see your patch is in next, but maybe some of this tightening might be
worthwhile doing on top of it?

Martin
