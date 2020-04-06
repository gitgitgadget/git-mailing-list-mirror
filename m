Return-Path: <SRS0=cWmm=5W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CBAC2BA1B
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 16:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B179222247
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 16:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qaeDHjlj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729348AbgDFQEq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 12:04:46 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44778 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729344AbgDFQEo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Apr 2020 12:04:44 -0400
Received: by mail-wr1-f65.google.com with SMTP id c15so26343wro.11
        for <git@vger.kernel.org>; Mon, 06 Apr 2020 09:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=KlTPpY8KapYD9cgqo6XVCa2TjyWpQUoXPCDV8eclW8s=;
        b=qaeDHjljudW805ajqxQcQdNkS62UXm87PugqRH3j3/d0vQskg125lpguCGyursIX2Q
         So/BGd+4hGghgT27vUnuBiU6068M74Ogn733g/HrOQbZKzG6sRJ8dBmzy4Ob7ORyOfcp
         BahvkfQIvUzb0jbwhuWleIBAvtKkcXinTuXsZ8lamgwJqTdvM2RukV6XRTKU/B8bH2cS
         TfXlsoxjWw7eTlU7MlHuJJn9um5IBian3AtFaCNBmr/qCuThfnkpsIXj6nGQB1mKUIm9
         rMtM0KwoHJf8o9sS/rS4qfV6PHOyIZeT1ga7qtJTYXrcPR0Hu3zC2Lu7ZxcKKQOPYXCw
         sI1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=KlTPpY8KapYD9cgqo6XVCa2TjyWpQUoXPCDV8eclW8s=;
        b=DtHyO/9Ji5j2x0tV2ET/yzBNflX50EtKbWPvLWMmXl1cg1zbHYVxc4HPcwrL0enevK
         remjZSCO88l+PNF6zMIADe6q8KSW6hswOrNll7rD22JQa8HHROWFYOh5Q+6ZrdfMlkOj
         NvXXtlPo5VuMtMkspkQtZs2OlY+FUj3XTJV9gSCWmlqt+pWGCvsnX09l3uP5vJxEoXTF
         RxNU/fqlKoGCaOtFuxWgAAMIW14ql4BShHSqk5EsfH8xHlOUkSclxgyVy9LVsUBrvX11
         N+UYC3TdfVLT7K5cOdKSzbcf6fulleG1Pm9fx2K1aVK3DgoBk0iXfwpIP+eWxvahqadE
         2cXQ==
X-Gm-Message-State: AGi0PuY2gH18/6GTTmIHjlmcOFZQFQlK2zpbwFBsxTwqtGH7K4NU8HN+
        VygK1lBZ8DVQ9AEiqsAuIG+wPy/VXMA=
X-Google-Smtp-Source: APiQypKBVomD6Yl+z3ip0o8MaE1kAaRuF9xce0pt4OySi98PyIz8qAQn44RvSdb+LonMn28EwNyVyQ==
X-Received: by 2002:adf:e991:: with SMTP id h17mr14259933wrm.17.1586189081469;
        Mon, 06 Apr 2020 09:04:41 -0700 (PDT)
Received: from feanor (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id w18sm4093554wrn.55.2020.04.06.09.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 09:04:40 -0700 (PDT)
Date:   Mon, 6 Apr 2020 18:04:39 +0200
From:   Damien Robert <damien.olivier.robert@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/1] remote.c: fix handling of %(push:remoteref)
Message-ID: <20200406160439.gg5uu6kepnyxpvuc@feanor>
X-PGP-Key: http://www.normalesup.org/~robert/pro/files/Damien_Olivier_Robert.asc
X-Start-Date: Mon, 06 Apr 2020 17:46:48 +0200
References: <20200303161223.1870298-3-damien.olivier.robert+git@gmail.com>
 <20200312164558.2388589-1-damien.olivier.robert+git@gmail.com>
 <20200328131553.GA643242@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200328131553.GA643242@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From Jeff King, Sat 28 Mar 2020 at 09:15:53 (-0400) :

> The tests makes sense to me, though I found a few nits to pick:
[...]

So I updated the tests as follow. I put them in another test, as you
suggested, this is indeed much clearer.

test_expect_success ':push:remoteref' '
	git init remote-tests &&
	(
		cd remote-tests &&
		test_commit initial &&
		git remote add from fifth.coffee:blub &&
		git config branch.master.remote from &&
		actual="$(git -c push.default=simple for-each-ref \
			--format="%(push:remotename),%(push:remoteref)" \
			refs/heads/master)" &&
		test from, = "$actual" &&
		git config branch.master.merge refs/heads/master &&
		actual="$(git -c push.default=simple for-each-ref \
			--format="%(push:remotename),%(push:remoteref)" \
			refs/heads/master)" &&
		test from,refs/heads/master = "$actual" &&
		git config branch.master.merge refs/heads/other &&
		actual="$(git -c push.default=simple for-each-ref \
			--format="%(push:remotename),%(push:remoteref)" \
			refs/heads/master)" &&
		test from, = "$actual" &&
		actual="$(git -c push.default=upstream for-each-ref \
			--format="%(push:remotename),%(push:remoteref)" \
			refs/heads/master)" &&
		test from,refs/heads/other = "$actual" &&
		actual="$(git -c push.default=current for-each-ref \
			--format="%(push:remotename),%(push:remoteref)" \
			refs/heads/master)" &&
		test from,refs/heads/master = "$actual" &&
		actual="$(git -c push.default=matching for-each-ref \
			--format="%(push:remotename),%(push:remoteref)" \
			refs/heads/master)" &&
		test from,refs/heads/master = "$actual" &&
		actual="$(git -c push.default=nothing for-each-ref \
			--format="%(push:remotename),%(push:remoteref)" \
			refs/heads/master)" &&
		test from, = "$actual"
	)
'

And the test works with my patch.

So I decided for completude to also test with
		git config branch.master.pushRemote to
to test with a triangular workflow, and I found several (already existing)
bugs.

Heres what happen with such a triangular workflow when we do a `git push`:
- with push.default=simple, we have
	case PUSH_DEFAULT_SIMPLE:
		if (triangular)
			setup_push_current(remote, branch);
		else
			setup_push_upstream(remote, branch, triangular, 1);
		break;
  so the current branch is always pushed.
- with push.default=upstream, we have
	case PUSH_DEFAULT_UPSTREAM:
		setup_push_upstream(remote, branch, triangular, 0);
		break;
  which then gives
  	if (triangular)
		die(_("You are pushing to remote '%s', which is not the upstream of\n"
		      "your current branch '%s', without telling me what to push\n"
		      "to update which remote branch."),

By the way this matches what the documentation says.

However here is the result of
git -c push.default=$value for-each-ref --format="%(push:remotename),%(push:remoteref),%(push)" refs/heads/master
for $value=
- simple: to,,
- upstream: to,refs/heads/other,refs/remotes/from/other

Note that without my patch the %(push:remoteref) values would always be empty,
but my patch does not touch %(push).

So in both branch_get_push_1 and branch_get_push_remoteref I should first
detect if we have a triangular workflow, and update the logic of the code
accordingly.
