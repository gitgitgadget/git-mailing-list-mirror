Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 816FC1FAF4
	for <e@80x24.org>; Sat,  4 Feb 2017 06:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753740AbdBDGuV (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Feb 2017 01:50:21 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33370 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753685AbdBDGuU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2017 01:50:20 -0500
Received: by mail-pg0-f66.google.com with SMTP id 194so3883665pgd.0
        for <git@vger.kernel.org>; Fri, 03 Feb 2017 22:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=AjCceBsLRjFGRisAJNxPf4OqynbseLPpBOoLDY6lMbQ=;
        b=ijn1a8a9sybiJQj5YMhBDw6IGRh1IG6lsxgZ16ogVmmoL5TwkgrFrkCDZjY/ulop5l
         9deFNp5kA9aO1nPC/xdUAZaF97Pft7Y8gnYi7oPSkIyDLz5No9ZKCBBLxawpN3XNly0w
         gifvn+W58PIRILvvDlKkYqQXpX7yajCZIwfCaI3T/2wXN+N4qPQZpznwrKqt9sq8K/W9
         FymWjzaoy5La7Uh7Vo/WCdqOpDJhoxKbAsFGoQujs1DVafMPpr6fI3ZmdEJUS7Af2g5B
         kwly6M8E1kAMoM/RW9mXnB+8MkbUvRAxCwKSLnH/jXwjzbxDv+QGb0OLagblslcrIvau
         v7MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=AjCceBsLRjFGRisAJNxPf4OqynbseLPpBOoLDY6lMbQ=;
        b=e6swUAjw5e8QMz3tAquhAKTFAj0NuvEScSI9aQCF5oUnmQp3Br0kRsJEUGMyJjE3FD
         +cnjbI/qvyfeo4okNwfwU1PiG5rkAnUx1hy6Y4u8fkMfQCc7rK5ECxXKJoXSsQZgfhX9
         4Nw3ah1tdRR2kbGeopu7qCkehv9zGuarndcZpvhU8bPk1T+a8ig9aQIwOAUZ++RfC7+s
         /3TGfaV47tqNDAJHGpB51hv2EMkIgprl8Fd4WQakezA47cY9xG3QKfXAX7+XnMgOjig/
         crgnI9pt5SOl4jeRhfITtGqDI6E3DICKqnTrt/0VIXEwonYytSX9BakVDmvR92TiJhn1
         p0wQ==
X-Gm-Message-State: AIkVDXIaes7YF2ywFmuTpjWOCbURHc9p029ECkFsXJeNgH//uYhWkiooJ33/zNMZK3lduA==
X-Received: by 10.98.66.138 with SMTP id h10mr1074058pfd.94.1486191019978;
        Fri, 03 Feb 2017 22:50:19 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:dd9f:576d:b8fa:253a])
        by smtp.gmail.com with ESMTPSA id w123sm71851893pfb.44.2017.02.03.22.50.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 03 Feb 2017 22:50:19 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Gumbel\, Matthew K" <matthew.k.gumbel@intel.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] commit: Optimize number of lstat() calls
References: <DA0A42D68346B1469147552440A645039A9C9988@ORSMSX115.amr.corp.intel.com>
Date:   Fri, 03 Feb 2017 22:50:18 -0800
In-Reply-To: <DA0A42D68346B1469147552440A645039A9C9988@ORSMSX115.amr.corp.intel.com>
        (Matthew K. Gumbel's message of "Fri, 3 Feb 2017 23:22:30 +0000")
Message-ID: <xmqqwpd678lx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Aside from whitespace breakage, I think we should never skip the
refreshing of the real index that is left after "git commit"
finishes.

Between these two calls to refresh_cache(), the one that writes out
a temporary index that contains the contents of HEAD plus the
contents of the working tree for the specified paths may be fine
without refreshing, unless somebody else (like the pre-commit hook)
looks at it.  But the other one refreshes the real index file that
will be used after "git commit" returns the control.  Users and
scripts that run "git commit" inside expect that the entries in the
resulting index are refreshed after "git commit" returns, and I do
not think of a safe way to optimizing it out; unlike the other one,
to which we can say "as long as there is no pre-commit hook, nobody
will look at it after we are done", there does not an easy-to-check
set of conditions that we can use to decide when it is safe to skip
refreshing.

Besides, leaving the main index not refreshed would mean the user
has to pay the refreshing cost when s/he runs other commands "git
diff", "git status", etc. after "git commit" for the first time;
so...

