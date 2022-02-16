Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F27BC433F5
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 09:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbiBPJLq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 04:11:46 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbiBPJLp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 04:11:45 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75311117F
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 01:11:32 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id b6-20020a621b06000000b004e1453487efso1124885pfb.22
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 01:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=t1+lThmRU7KlTH/xoW0WNwd+1kur3//1EXJrYFFEW/A=;
        b=FYXw27keyVyq+TeLFvOtX+gzQArQSZyqfHJLUUqSomCNM65hjJXAd7vpb9dr2Wh2G4
         HPzPUWyISngk1RQCDFC0UI4JP6BWBll6kLDo3PmtWCw/DkEtjpxSNJu/F0LLvgcQtKA9
         jJFYtF2Fmn/LKDAZx3G0gJ669g4ZUX0qLu5nQUsrJ4W4susMtP38c/2TJgZHf9EHzQ/x
         1PQ4PJh07qlG6YFfAXUDe2ek+cH52yqEkjlD20/+6hIsTco1KvqR0jh5R/7wyUItMBBw
         rw794ANHg0I9BheMwCGU2qcrzhZqRZq7d3QXZs2lPdjBUHkOUK1+m3zsM051k8+Goetp
         wFrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=t1+lThmRU7KlTH/xoW0WNwd+1kur3//1EXJrYFFEW/A=;
        b=3id0VvKg7LNo0iYTyPsLgm1slWSuoEr/1IjrG8jxtXt2IvQmRk4sSRxYB+QMCRqkiZ
         9hPzmbBbjloAGLHjtXGot0mLTECylz7W6LEIHBvVCMu9QJS4KlaeJuWk3j0LLbR1aPON
         aL9m4aLxz4sCYq/9bDmDJYlBXokh2viDIFDnj1ZvLz6LkpntJR914n7OY7BV3ltTtgBA
         +BPERaLyS9PQcziW7lF3GcrNnL3gpte9eKsMA/yEvPbrBii30B1skwpDw267GWlgp5fX
         hrE0/Qt0J7IR95OCAqRtXyhgjxsBBnvf8HBsdi3SxA9XkOF60wPTY1mnABxhgIkOZaLE
         O+CA==
X-Gm-Message-State: AOAM533qRPo34lsZcemzwU2BMNyD0yQaBOt/oaToiC5Fx2iBAbJm+0As
        hrpxxKcEQsil5Pp5xChemkKJV/XFUj/5GA==
X-Google-Smtp-Source: ABdhPJw7zOq7yRgKvmmFrPf8qnESw+5nQdmrWp7XDbe3xXyoI2UFZ8NZeQQa93kyc3sIZcNo640xt+Yu8swEMA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:be08:b0:1b8:be87:4014 with SMTP
 id a8-20020a17090abe0800b001b8be874014mr606445pjs.199.1645002691821; Wed, 16
 Feb 2022 01:11:31 -0800 (PST)
Date:   Wed, 16 Feb 2022 17:11:29 +0800
In-Reply-To: <kl6lr1835poe.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-Id: <kl6lee435g72.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220215220229.1633486-1-jonathantanmy@google.com> <kl6lr1835poe.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v2 7/9] fetch: fetch unpopulated, changed submodules
From:   Glen Choo <chooglen@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Jonathan Tan <jonathantanmy@google.com> writes:
>
>> Glen Choo <chooglen@google.com> writes:
>>> +	# Create new superproject commit with updated submodules
>>> +	add_upstream_commit &&
>>> +	(
>>> +		cd submodule &&
>>> +		(
>>> +			cd subdir/deepsubmodule &&
>>> +			git fetch &&
>>> +			git checkout -q FETCH_HEAD
>>> +		) &&
>>> +		git add subdir/deepsubmodule &&
>>> +		git commit -m "new deep submodule"
>>> +	) &&
>>> +	git add submodule &&
>>> +	git commit -m "new submodule" &&
>>
>> I thought add_upstream_commit() would do this, but apparently it just
>> adds commits to the submodules (which works for the earlier tests that
>> just tested that the submodules were fetched, but not for this one). I
>> think that all this should go into its own function.

I'm testing out a function that does exactly what these lines do, i.e.
create a superproject commit containing a submodule change containing a
deepsubmodule change. That works pretty well and it makes sense in the
context of the tests.

>> Also, I understand that "git fetch" is there to pick up the commit we
>> made in add_upstream_commit, but this indirection is unnecessary in a
>> test, I think. Can we not use add_upstream_commit and just create our
>> own in subdir/deepsubmodule? (This might conflict with subsequent tests
>> that use the old scheme, but I think that it should be fine.)

We can avoid the "git fetch" if we first need to fix an inconsistency in
how the submodules are set up. Right now, we have:

  test_expect_success setup '
    mkdir deepsubmodule &&
    [...]
    mkdir submodule &&
    (
    [...]
      git submodule add "$pwd/deepsubmodule" subdir/deepsubmodule &&
      git commit -a -m new &&
      git branch -M sub
    ) &&
    git submodule add "$pwd/submodule" submodule &&
    [...]
    (
      cd downstream &&
      git submodule update --init --recursive
    )
  '

resulting in a directory structure like:

$pwd
|_submodule
  |_subdir
    |_deepsubmodule
|_deepsubmodule

and upstream/downstream dependencies like:

upstream                             downstream            
--------                             ----------
$pwd/deepsubmodule                   $pwd/downstream/submodule/subdir/deepsubmodule (SUT)
                                     $pwd/submodule/subdir/deepsubmodule


So we can't create the commit in submodule/subdir/deepsubmodule, because
that's not where our SUT would fetch from.

Instead, we could fix this by having a more consistent
upstream/downstream structure:

$pwd
|_submodule
  |_subdir
    |_deepsubmodule

upstream                             downstream            
--------                             ----------
$pwd/submodule/subdir/deepsubmodule  $pwd/downstream/submodule/subdir/deepsubmodule (SUT)

This seems more convenient to test, but before I commit to this, is
there a downside to this that I'm not seeing?
