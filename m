Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438FFC33CB1
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 07:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13A92207FF
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 07:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5k172gO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730126AbgAPH6N (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 02:58:13 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38914 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgAPH6M (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 02:58:12 -0500
Received: by mail-pg1-f193.google.com with SMTP id b137so9491381pga.6
        for <git@vger.kernel.org>; Wed, 15 Jan 2020 23:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mrBIOP53DBtVWzK4UIMd0nO89N6ungm3Jr7ZMosdzo0=;
        b=f5k172gOjxSBN/H5yuBJ3tFy4SwtjUodom2C5d0HIP84ClXcxamIC0N0zKCmQ+O56Q
         yD9UHYZj/aRjGbpMBX1VsgS4Hs88WpSNREVDBM0T8G3f+EGGYpUp5La4ubBRyu5mrGh3
         5UR7tTOlN83qqjw2JS8OhFOT+udZwKPJW5MgtiD7EZVR9vpA/YQMDBZVlIpwpIL1roLZ
         ZHVz8I0BtJrxeB06Hn0oFKz12utQYj/naINkA/CqKmYGe5Gv6FjImZFMAg63aw2cd+Na
         Q95Jv0K/YQXqcD0kV2/Oj2YI2y2GQUlB0gPH4bourDoJ+iYY+MMGb10qn5wXpuXYt6Wt
         IWnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mrBIOP53DBtVWzK4UIMd0nO89N6ungm3Jr7ZMosdzo0=;
        b=TRDl+mnHEHM8HsNnN0AI6L325TmssoGWlvUM5IIFsuS5sc5R9XUc631KY1L2WP65M0
         FauytJOx/iebGwufQ9dMslv80CCT7jZPv0OTPjqrUUV3isdXqXCU0QdrWbFPOWdssyBw
         rd3uz9T7OMwquV1dccnwkjZ3kxnSX+5k4P5X/a0anZOj/nVltvB3Zr9f7oc5R9jxdkeY
         7W5tq7jizaNeM3aW1PIC+wqmb7r++pKJ3DgMj0JArCqo22d611ak7D5017HIqjB+5HlC
         qFfAYbUgb2fJ223RWZ7gWknBPQvvnAs66SOpfysFvpLlCL7+Nmd8+yEM2WopvkGSoF74
         T4bQ==
X-Gm-Message-State: APjAAAWQWg7JDGLxbKSUzSQ3OT+D7QOkR+IlOSAQIzylZ/sX+VWqn7gI
        22XuWkRqheP+VrqtHf0n1JA=
X-Google-Smtp-Source: APXvYqw+F1cqvOUT2AiB2Z36YTtgQE+L5gNorm7LhqPLZrSjrv+IiczEnUv60lxzNkbH0eZY4ILQpA==
X-Received: by 2002:a65:678f:: with SMTP id e15mr37952030pgr.130.1579161491957;
        Wed, 15 Jan 2020 23:58:11 -0800 (PST)
Received: from google.com (240.242.82.34.bc.googleusercontent.com. [34.82.242.240])
        by smtp.gmail.com with ESMTPSA id c22sm23910751pfo.50.2020.01.15.23.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 23:58:11 -0800 (PST)
Date:   Thu, 16 Jan 2020 07:58:10 +0000
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Pavel Roskin <plroskin@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 15/15] rebase: change the default backend from "am" to
 "merge"
Message-ID: <20200116075810.GB242359@google.com>
References: <pull.679.v2.git.git.1577126999.gitgitgadget@gmail.com>
 <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
 <044853fd612ee8cf6928bb7c4ebb1eacaa172aa3.1577217299.git.gitgitgadget@gmail.com>
 <20200110231436.GA24315@google.com>
 <CABPp-BEGwJ=0+6TMYXvMzpds0h6bz4gZA8Pi95SH9M4CKBtfOw@mail.gmail.com>
 <052fdedc-2beb-91ab-c5c3-53fb99e64810@gmail.com>
 <nycvar.QRO.7.76.6.2001120942460.46@tvgsbejvaqbjf.bet>
 <CABPp-BGqWDo0vkY_zBZ6n+2T92W2iR90=41oJO_Ae1yZP8NO0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BGqWDo0vkY_zBZ6n+2T92W2iR90=41oJO_Ae1yZP8NO0A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:

>                                          Then omit calling the
> post-commit hook and it behaves the same as the am backend and no one
> in the world notices because no one in the world uses or cares about
> that hook except a few people at Google who happen to be used to the
> am-backend

Just responding to this part: I know this was a bit of thinking out
loud, but the "just a few people at Google" bit is counter-productive.
The search Emily ran
<https://github.com/search?l=&q=filename%3A%2Apost-commit%2A&type=Code>
shows that it's fairly common to use a post-commit hook for
deployment, with scripts like

	#!/bin/bash
	unset GIT_INDEX_FILE
	git --work-tree=/var/www/html --git-dir=/home/daniel/proj/.git checkout -f

or

	#!/bin/bash
	# Sync gh-pages branch with master
	#########################################
	git checkout gh-pages
	git rm -rf -q .
	git checkout master -- .
	git add .
	git commit -am "Syncing gh-pages with master"
	git checkout master

And I'm not saying that selfishly --- obviously, from a selfish
perspective, what you're proposing would change behavior the least and
I'd end up with happy users. :)  I'm just trying to help with updating
the list's collective model of user behavior.

(Actually, I want to remove jiri's post-commit hook --- so it is only
the example that revealed this behavior change and is not my
motivation for continuing to chime in in this thread.)

The deployment examples above seem like examples where the user would
want the script to run on "git am" (and on "git merge --ff-only", for
that matter) but not on the intermediate commits in "git rebase",
since when rebasing a multi-commit series, deploying earlier rebased
commits would cause the deployment to lose the benefit of later fixes.

[...]
> Ooh, that sounds interesting.  Do you have any more details?  My
> simple testing here shows that we exit with status 1, so we shouldn't
> have that problem unless perhaps there was something else in next
> (ra/rebase-i-more-options??) or some other special conditions that was
> causing it.

I can set aside some more time to investigate that one early next
week.

Thanks for the quick answers --- it's been very helpful.

Sincerely,
Jonathan
