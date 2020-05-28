Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FFAC433E0
	for <git@archiver.kernel.org>; Thu, 28 May 2020 14:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BC2720814
	for <git@archiver.kernel.org>; Thu, 28 May 2020 14:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cR/7qab9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390634AbgE1OBs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 10:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390596AbgE1OBr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 10:01:47 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E70C05BD1E
        for <git@vger.kernel.org>; Thu, 28 May 2020 07:01:47 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ci21so3233541pjb.3
        for <git@vger.kernel.org>; Thu, 28 May 2020 07:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Ld8aSZHQlCcr3WmCrhIzqhXbdm+Kl+uTUe7Zbqux7Rg=;
        b=cR/7qab9r9OzbTZHJkGMqd0h6iEBsQNzxeri15/BRbTWeeqWOfsTwVELoGVjkHezu9
         cjZ7L4U0S6lNi8UXvDRe6O+uCRxmqVlPC1Bayds5l8DVw5X+HUfEWRxIzuI7/jBx2LTx
         TfhGyCoGEjjxoYw/21FKBgk1jKmR6DdTAws/sbk3r+cUxXd32BegVtr5lSmkIG3nlcqO
         3d7/3ahu6vUeZP6aijKxjPgpMI6NqBiEfcvmODewseHGjyfOixVEV83z85JYhNLMVVZK
         0RI6+bDk8ZQcgI/JjOfqpLt/fGgUBshP0WvXo5/nipU+sPxFvLUtcOgMSmQ613AAv5IG
         wtUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Ld8aSZHQlCcr3WmCrhIzqhXbdm+Kl+uTUe7Zbqux7Rg=;
        b=tgQXP/vVtrwjnJo37wqBrdEQfIA7ATdBNVXa9am2D/VTcJO4l6RjNZnKL/3536ppjT
         8przpOuXW2K7zleeTls0vWlUnupdnaeEBoqtr4r82oNHDR7KCBCRfeJZHNUNcGtL31o/
         Wxmj+z8WBvLixZPjyQ8Fz6Z/qiIjh3JRP/aFE4SQOT2hYw0BHzXS2POF5rwXen3UvUvK
         0XSgdZQ87n+E92pGpq7t3m0ZbjTzCvm6geGqctQzQZdbAgG95d4PieQdVXlFsPCAgiz6
         gHArX6ialqG0E8enSQxvja5IpO4XjtK0tH8nE7AbIVRZOT1prgiECEBajibFFcWrHM3K
         WazQ==
X-Gm-Message-State: AOAM530JDIGPduCdCTxPMcljZMm4heiFQ+Jjj2icrvoV/xtTcqeqHD4A
        n2tRE9DZ7nRdVU30oIHT8BA=
X-Google-Smtp-Source: ABdhPJxsg0snaFRQs8QyX9zseRc1Q+F8gk6jDCI1ITq4xPaUJTbUZYRtVQm7pacXAq+TTD4LbewwLw==
X-Received: by 2002:a17:902:6906:: with SMTP id j6mr3770470plk.261.1590674506633;
        Thu, 28 May 2020 07:01:46 -0700 (PDT)
Received: from localhost ([2402:800:6374:cd6f:3908:64aa:a24d:1be1])
        by smtp.gmail.com with ESMTPSA id c12sm3964241pgt.91.2020.05.28.07.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 07:01:44 -0700 (PDT)
Date:   Thu, 28 May 2020 21:01:42 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, git@vger.kernel.org,
        christian.couder@gmail.com, gitster@pobox.com,
        liu.denton@gmail.com, sunshine@sunshineco.com,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v4] submodule: port subcommand 'set-branch' from shell to
 C
Message-ID: <20200528140142.GA1951@danh.dev>
References: <20200521163819.12544-1-shouryashukla.oo@gmail.com>
 <20200523163929.7040-1-shouryashukla.oo@gmail.com>
 <33127873-fb19-2bd5-3028-bcd1757e92e5@gmail.com>
 <20200527171358.GA22073@konoha>
 <20200528122147.GA1983@danh.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200528122147.GA1983@danh.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-05-28 19:21:47+0700, Đoàn Trần Công Danh <congdanhqx@gmail.com> wrote:
> On 2020-05-27 22:43:58+0530, Shourya Shukla <shouryashukla.oo@gmail.com> wrote:
> >  > +	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper set-branch ${GIT_QUIET:+--quiet} ${branch:+--branch $branch} ${default:+--default} -- "$@"
> > 
> > > Danh questioned whether '$branch' needs to be quoted here. I too think it
> > > needs to be quoted unless I'm missing something.
> > 
> > We want to do this because $branch is an argument right?
> 
> We want to do this because we don't want to whitespace-split "$branch"
> 
> Let's say, for some reason, this command was run:
> 
> 	git submodule set-branch --branch "a-branch --branch another" a-submodule

Anyway, after typing this.
I'm thinking a bit, then re-read gitcli(7),
I think git-submodule is quite broken regarding to Git's guidelines:

-----------8<----------

Here are the rules regarding the "flags" that you should follow when you are
scripting Git:

 * it's preferred to use the non-dashed form of Git commands, which means that
   you should prefer `git foo` to `git-foo`.

 * splitting short options to separate words (prefer `git foo -a -b`
   to `git foo -ab`, the latter may not even work).

 * when a command-line option takes an argument, use the 'stuck' form.  In
   other words, write `git foo -oArg` instead of `git foo -o Arg` for short
   options, and `git foo --long-opt=Arg` instead of `git foo --long-opt Arg`
   for long options.  An option that takes optional option-argument must be
   written in the 'stuck' form.
------------>8--------------

Current Git, with and without this change, this command will fail:

	git submodule set-branch --branch=a-branch a-submodule

Thus, a script conformed with gitcli(7) will fail.
(And our git-submodule(1) doesn't conform with gitcli(7), FWIW).

After this change, those commands will success:

	git submodule--helper set-branch --branch a-branch a-submodule
	git submodule set-branch --branch "a-branch --branch=another" a-submodule

(The second one was written for demonstration purpose only,
I don't expect it will success)

This isn't related to this change, and git-submodule(1) will be
rewritten in C in the very near future.
Just want to make sure it's awared.

> 
> This version will run:
> 
> 	git submodule--helper --branch a-branch --branch another a-submodule
> 
> Which will success if there's a branch "another" in the "a-submodule".
> While that command should fail because we don't accept refname with
> space.

-- 
Danh
