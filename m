Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8C0C433FE
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 21:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbiAZVsc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 16:48:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232753AbiAZVsc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 16:48:32 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D71CC06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 13:48:31 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id u18so1016993edt.6
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 13:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7kwuwd2imiszuc3as4/EstISrek7yRheFm+uf0QKoQ8=;
        b=hH1yUUWCqIJBkuz/65KaK3Dj/sMbDA+eTiMXkobcRv+dUbYgTydK1koPg2Krfqq9mj
         3wxbFi+DytcLZpxa4ol+Sz3Diw2LgQ/a9ms8URX3QZoPeXAAwbu+Yi7dxSJPQXzJNnmn
         qzjLpzG/rRphiU4+kLGb6ev2tmIp0pld/jQBGCDkVd4PoLV6zLQb28YRyW+rv/yGYRf0
         Es/t/xAXVoxlX3ZSeELoXobDjxB+hjoHjyoI7yOQaAei3VBBB+rMHT60GESv7kITQ63v
         yuQeMmrSGXy9kbOK/NiclF/26Zowe+WRMRe2zSTQ/6DZzTU1UrpLFJqbzG7iDIxXSWxR
         VVnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7kwuwd2imiszuc3as4/EstISrek7yRheFm+uf0QKoQ8=;
        b=DjR0VlQ4bqf9+rzjHFAhF6UIv82trEuA6HrQPK5fJrZkkZ0qEn27roQZyLs02J6sIw
         yeSt18y8DbOkeOMPhRYBgOb/D2sQBeJ3OaQsKJlbKUAYm8tcFW8x9qk0U0OYqEjLVWCs
         TcKVtL5i7SKjkpiCRrDrL/RgWOo+BSIn+4DjLNpgJkZKpKRYnPkEl8FUyAl2Eol3q3CV
         ElI4yrTqyu+MAsjdr6KjjnY/LFE2WePkHYJFZh1xCr08TRynWTwpGZZdznuJNCtyRkaK
         YGP83eNgdTnNOdXC7fsE56/i6KpChCrSXim0CHks3XIsDzrCAjoDli6MCv+ENcag5BFn
         6WIQ==
X-Gm-Message-State: AOAM531ULn0fF4Rj1pM05jITwILi1/XxgNy25WOFG8hZK0vfxm8bFB5j
        pkUQ9QJ3k8fq1QPSRSO0JgE=
X-Google-Smtp-Source: ABdhPJx1sEyW28nrGYSacBUP89V+wnVCpEuUN09TzZaR7Par5XuiC5c5qenj1oCa/vh5STUTQh1FPw==
X-Received: by 2002:a05:6402:3450:: with SMTP id l16mr883421edc.225.1643233709964;
        Wed, 26 Jan 2022 13:48:29 -0800 (PST)
Received: from szeder.dev (84-236-78-162.pool.digikabel.hu. [84.236.78.162])
        by smtp.gmail.com with ESMTPSA id bo11sm7920276ejb.24.2022.01.26.13.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 13:48:29 -0800 (PST)
Date:   Wed, 26 Jan 2022 22:48:24 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Konstantin Khomoutov <kostix@bswap.ru>, git@vger.kernel.org
Subject: Re: [RFC] shell: local x=$1 may need to quote the RHS
Message-ID: <20220126214824.GA2581@szeder.dev>
References: <xmqqsftc3nd6.fsf@gitster.g>
 <20220125092419.cgtfw32nk2niazfk@carbon>
 <xmqqa6fjzlm0.fsf@gitster.g>
 <YfBbRca0Rjl59MM0@nand.local>
 <xmqqo83zt54a.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo83zt54a.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 25, 2022 at 09:53:25PM -0800, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
> 
> > Yeah; bisecting dash with your example script pointed me at cbb71a8
> > (eval: Add assignment built-in support again, 2018-05-19), which indeed
> > appears in v0.5.11 (and all subsequent versions).
> >
> > cbb71a8 points at release 0.3.8-15, which predates Git (and a tag
> > pointing at it was never created, since it's behind the big "initial
> > import" commit at the beginning of dash.git's history). But skimming
> > ChangeLog.O, we see:
> >
> >     * Removed assignment builtins since it is at best undefined by the
> >       SuS and also can't be implemented consistently.
> >
> > So this probably didn't work at all between that 0.3.8-15 up until v0.5.11.
> >
> >> The manual page for recent dash may need an update.
> >> Can you perhaps file a bug on their documentation?
> >
> > Yes, I agree that dash.1 is out-of-date after cbb71a8. Konstantin:
> > please feel free to use any of this if it's helpful to you in creating a
> > bug report for the dash folks.
> 
> I doubt that we can write off dash v0.5.10 as too old to matter, as
> the tagger date seems to be mid 2020 at 
> 
> https://kernel.googlesource.com/pub/scm/utils/dash/dash/+/refs/tags/v0.5.11

I agree, and v0.5.10 is widely used, as it is the default shell in
Ubuntu 20.04 LTS.

> So here is a bit wider "grep" output, looking for
> 
> $ git grep '^[ 	]*local[	 ].*=' \*.sh
> 
> to reject _any_ assignment on the same line as "local", but I
> manually excluded the ones that are not meant to be run with dash.
> I obviously excluded the one in t0000 (try_local_xy) that is a
> weather-balloon for this exact issue.
> 
> According to this thread, these would not work correctly on dash
> older than 0.5.11 and needs fixing by splitting declaration of
> variables as locals and assignment of their initial values.

I don't think that's necessary.  Whatever that (apparently horribly
outdated) documentation might state, I think what really matters is
what dash actually does.

The patch below puts a bit more strain on our `local` weatherballoon
test:

  - It checks assignments from a parameter expansion and command
    substitution as well, not only simple string assignments.

  - The expanded values contain spaces and are quoted (to avoid the
    field splitting issue that started this thread [1]).

  - Creates a local variable with a name that doesn't hide an already
    existing variable in the global scope, to see whether it becomes
    global.

It succeeds with all tagged dash versions, the oldest being v0.5.2
tagged on 2005-01-31.  I think that's more than old enough to say that
it's not necessary to put local variable declaration and assignment on
different lines, and we can declare multiple local variables on one
line.

Note that NetBSD 8.1's /bin/sh need quotes on the RHS in similar
assignments as well.

[1] We've already run into this issue in ebee5580ca
    (parallel-checkout: avoid dash local bug in tests, 2021-06-06),
    but apparently didn't think through what else might be affected by
    that bug.


diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 03fead95e7..196106fdf5 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -22,8 +22,8 @@ modification *should* take notice and update the test vectors here.
 . "$TEST_DIRECTORY"/lib-subtest.sh
 
 try_local_xy () {
-	local x="local" y="alsolocal" &&
-	echo "$x $y"
+	local x="local" y="${no_such_var-also local}" z="$(echo "third local")" &&
+	echo "$x $y $z"
 }
 
 # Check whether the shell supports the "local" keyword. "local" is not
@@ -37,11 +37,11 @@ try_local_xy () {
 test_expect_success 'verify that the running shell supports "local"' '
 	x="notlocal" &&
 	y="alsonotlocal" &&
-	echo "local alsolocal" >expected1 &&
+	echo "local also local third local" >expected1 &&
 	try_local_xy >actual1 &&
 	test_cmp expected1 actual1 &&
-	echo "notlocal alsonotlocal" >expected2 &&
-	echo "$x $y" >actual2 &&
+	echo "notlocal alsonotlocal z_unset" >expected2 &&
+	echo "$x $y ${z-z_unset}" >actual2 &&
 	test_cmp expected2 actual2
 '
 
