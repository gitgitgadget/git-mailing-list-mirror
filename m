Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05631C77B73
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 10:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243476AbjD0KLS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 06:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243407AbjD0KLR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 06:11:17 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67433449D
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 03:11:15 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f192c23fffso46416005e9.3
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 03:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682590274; x=1685182274;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=P8FBsbp6nf8nbFoAZRJmxldj9pOomsHbkI1sXx2gLBg=;
        b=ijq2wbqjaLAKJMPDGWZ6ollp/CSZvAr02s1t8C4IahfsUP7X0gnb+xkMA21KhmRYbd
         00q/lbROtwI0bR//NxkxaSkoKDxkeTKjz4FwFfQwB2vnAbBVWlECXIQkvsZHr4AENVV+
         WNZWM1bQgD6UQt88jN+qVeqQskfZBpGzH1g0YOJXpS5ffuZ92lqzYJARh8s/iQJSC3tI
         4pBK6dQdKAds+DYTeo1PMHBI2dZ9+QhaK/I9BoPPlHGpvUD2pYIYyUhGeNaIYg+sOzi9
         gte1vsHkAv1K2Jsjm12Qp68XnFGgCIDtB7HsbrqfMUMZ8eaJwedjvUlszxqZx3mc3XlW
         nYXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682590274; x=1685182274;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P8FBsbp6nf8nbFoAZRJmxldj9pOomsHbkI1sXx2gLBg=;
        b=bNON7e71nt662pgwduvSny13HKEs6FsvrB8U7SnYHU3zSzlnWFa7EXQWAdBQsI01HH
         dmuHKAyhznOMM/tul17F0XnmkN8yNq9heRoC2FMzKeXir7j3O8hmkARTZ9fjsDVuUgz6
         Vjw6g3KL3g/mmSX1KWsR4YgkMoZb6fDodt95N4EJfiJPYZEUC7WQD70jlzf2JDQanHpO
         +6DUSeF7EUEZE1tm9+3+GbROJPKk+fxwKHPtBBiqU1w2dhuk6oR22Nd3TuVvrx2arONT
         ulomt7lkfZrZk9ipELyrB7JNfpXF0tDq2fdClkENXUdK8s+xD/9T1NN0f+kp+i1HIU+w
         Rohg==
X-Gm-Message-State: AC+VfDzlMHN9zMIzcIUXaUqdgwZd5nxfUAek1ILQB7Qbk1J8SWPQUVpn
        9qqh8HsCkTbFzbyUgQJZDLgAMlampTE=
X-Google-Smtp-Source: ACHHUZ6Jlrl9Phl55z0DwecH6kcRA9Am7+m/MvS+laMXWFvlb/vnh9WOZI+0hmAvjPT4Gm4agNqnvA==
X-Received: by 2002:a7b:c7d0:0:b0:3f1:cfea:fd49 with SMTP id z16-20020a7bc7d0000000b003f1cfeafd49mr993411wmk.1.1682590273646;
        Thu, 27 Apr 2023 03:11:13 -0700 (PDT)
Received: from [192.168.1.195] ([90.255.142.254])
        by smtp.googlemail.com with ESMTPSA id n3-20020a7bcbc3000000b003f175b360e5sm20919624wmi.0.2023.04.27.03.11.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 03:11:13 -0700 (PDT)
Message-ID: <a04e7950-b74e-d43f-4d19-86def079748c@gmail.com>
Date:   Thu, 27 Apr 2023 11:11:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 3/4] parse_commit(): handle broken whitespace-only
 timestamp
Content-Language: en-US
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     Thomas Bock <bockthom@cs.uni-saarland.de>,
        Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
References: <20230427081330.GA1461786@coredump.intra.peff.net>
 <20230427081715.GA1478467@coredump.intra.peff.net>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20230427081715.GA1478467@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/04/2023 09:17, Jeff King wrote:
> The comment in parse_commit_date() claims that parse_timestamp() will
> not walk past the end of the buffer we've been given, since it will hit
> the newline at "eol" and stop. This is usually true, when dateptr
> contains actual numbers to parse. But with a line like:
> 
>     committer name <email>   \n
> 
> with just whitespace, and no numbers, parse_timestamp() will consume
> that newline as part of the leading whitespace, and we may walk past our
> "tail" pointer (which itself is set from the "size" parameter passed in
> to parse_commit_buffer()).
> 
> In practice this can't cause us to walk off the end of an array, because
> we always add an extra NUL byte to the end of objects we load from disk
> (as a defense against exactly this kind of bug). However, you can see
> the behavior in action when "committer" is the final header (which it
> usually is, unless there's an encoding) and the subject line can be
> parsed as an integer. We walk right past the newline on the committer
> line, as well as the "\n\n" separator, and mistake the subject for the
> timestamp.
> 
> We can solve this by trimming the whitespace ourselves, making sure that
> it has some non-whitespace to parse. Note that we need to be a bit
> careful about the definition of "whitespace" here, as our isspace()
> doesn't match exotic characters like vertical tab or formfeed. We can
> work around that by checking for an actual number (see the in-code
> comment). This is slightly more restrictive than the current code, but
> in practice the results are either the same (we reject "foo" as "0", but
> so would parse_timestamp()) or extremely unlikely even for broken
> commits (parse_timestamp() would allow "\v123" as "123", but we'll now
> make it "0").
> 
> I did also allow "-" here, which may be controversial, as we don't
> currently support negative timestamps. My reasoning was two-fold. One,
> the design of parse_timestamp() is such that we should be able to easily
> switch it to handling signed values, and this otherwise creates a
> hard-to-find gotcha that anybody doing that work would get tripped up
> on. And two, the status quo is that we currently parse them, though the
> result of course ends up as a very large unsigned value (which is likely
> to just get clamped to "0" for display anyway, since our date routines
> can't handle it).

I think this makes a good case for accepting '-'. The commit message is 
well explained as always :-) This all looks good to me apart from a 
query about one of the tests.

> The new test checks the commit parser (via "--until") for both vanilla
> spaces and the vertical-tab case. I also added a test to check these
> against the pretty-print formatter, which uses split_ident_line().  It's
> not subject to the same bug, because it already insists that there be
> one or more digits in the timestamp.
> 
> Helped-by: Phillip Wood <phillip.wood123@gmail.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>   commit.c               | 28 ++++++++++++++++++++++++++--
>   t/t4212-log-corrupt.sh | 41 +++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 67 insertions(+), 2 deletions(-)
> 

> +test_expect_success 'create commits with whitespace committer dates' '
> +	# It is important that this subject line is numeric, since we want to
> +	# be sure we are not confused by skipping whitespace and accidentally
> +	# parsing the subject as a timestamp.
> +	#
> +	# Do not use munge_author_date here. Besides not hitting the committer
> +	# line, it leaves the timezone intact, and we want nothing but
> +	# whitespace.
> +	#
> +	# We will make two munged commits here. The first, ws_commit, will
> +	# be purely spaces. The second contains a vertical tab, which is
> +	# considered a space by strtoumax(), but not by our isspace().

This comment is really helpful to explain what's going on and testing 
'\v' as well as ' ' is a good idea.

> +	test_commit 1234567890 &&
> +	git cat-file commit HEAD >commit.orig &&
> +	sed "s/>.*/>    /" <commit.orig >commit.munge &&
> +	ws_commit=$(git hash-object --literally -w -t commit commit.munge) &&
> +	sed "s/>.*/>   $(printf "\013")/" <commit.orig >commit.munge &&

Does the shell eat the '\v' when it trims trailing whitespace from the 
command substitution (I can't remember the rules off the top of my head)?

Best Wishes

Phillip

> +	vt_commit=$(git hash-object --literally -w -t commit commit.munge)
> +'
> +
> +test_expect_success '--until treats whitespace date as sentinel' '
> +	echo $ws_commit >expect &&
> +	git rev-list --until=1980-01-01 $ws_commit >actual &&
> +	test_cmp expect actual &&
> +
> +	echo $vt_commit >expect &&
> +	git rev-list --until=1980-01-01 $vt_commit >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'pretty-printer handles whitespace date' '
> +	# as with the %ad test above, we will show these as the empty string,
> +	# not the 1970 epoch date. This is intentional; see 7d9a281941 (t4212:
> +	# test bogus timestamps with git-log, 2014-02-24) for more discussion.
> +	echo : >expect &&
> +	git log -1 --format="%at:%ct" $ws_commit >actual &&
> +	test_cmp expect actual &&
> +	git log -1 --format="%at:%ct" $vt_commit >actual &&
> +	test_cmp expect actual
> +'
> +
>   test_done

