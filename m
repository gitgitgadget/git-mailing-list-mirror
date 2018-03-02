Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 936421F404
	for <e@80x24.org>; Fri,  2 Mar 2018 01:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163940AbeCBBTi (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 20:19:38 -0500
Received: from mail-pl0-f51.google.com ([209.85.160.51]:37242 "EHLO
        mail-pl0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163276AbeCBBTh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 20:19:37 -0500
Received: by mail-pl0-f51.google.com with SMTP id ay8-v6so4715546plb.4
        for <git@vger.kernel.org>; Thu, 01 Mar 2018 17:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=5Lf2C5ybCbTgDwShlao7JZx3yqHoKOiF440M/qgJeIE=;
        b=MeE0lUaTgXQLfv6c7EOZXNvFv2nbcsyW+e9S76ACei888966Kda+BMn+nhI1J6dc8f
         yANvCZouNzlWwpyuMZUTGW9zVPS3W26gezSjdp8BY0sdumafOCBfSqhMphNV8rqkHdZN
         mPivsBaeu4faZafmSdSIm0Q5a+z/ZlPOm3rZPdliTfFAfOQuIRbzzioS93syc+Fdl9jG
         VsdFBhk750pmTVjuQvRVVcphwF5NP6dH4pCJT/UtY8d/1uZjrc0z0qpYwT6CAXcGWPD/
         NM4pkG8tqvpph48/IQ1eQS5er+c4HxMMlq68s7FFB34wGv/N18N8aCjuHWJ6Abgv7YGB
         oBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=5Lf2C5ybCbTgDwShlao7JZx3yqHoKOiF440M/qgJeIE=;
        b=czo4IQm2bY5ObIN408Vu8iNw2LtZMGX5lKIlcs4U6glR++1lzw3+HL65kXO8Nnl9JC
         QMbF3l9IPR1OK8WF/WZGXDrNFn0SuYFECOfIyfHwbBMJnXy0B7N7UqIDBSqSNGJ1Kxdd
         +cQ+uDqGc5dVeOzGAsD7KU5uIezwXW/TywRL2mAf1obW2IlknzCJWY7Tm+IB6CnsshyS
         nHFvWAiamoL0MqDeOd+5pTjxpEz0F5fmEOR8K0u+25I6dnoKaecCR7l1cWJEbl1zOxQU
         WP1z9tTJAERjuf84Uv9WJCT58AlhIukskCri59qZpQr999q/cf8ukzRA5N3zfrbYu1Cl
         tFSA==
X-Gm-Message-State: APf1xPB6ELl0UiouRx2ieErWLae3SyKGw3F6MxBn2fXSDD3653FwV6yj
        Vvyv0FOxi8Z5j1UYWTRZFutgXTuLl5N93dUDbtNzhw==
X-Google-Smtp-Source: AG47ELtUgyGoQ5e8htmy7NkO/iT15epAjud0ZU5G2oXaRP5pKzTRTW5xwSgSAW8BL2waMLkTdI1tZd3maRhhXmohYPs=
X-Received: by 2002:a17:902:7a2:: with SMTP id 31-v6mr3633209plj.313.1519953576753;
 Thu, 01 Mar 2018 17:19:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.236.137.23 with HTTP; Thu, 1 Mar 2018 17:19:35 -0800 (PST)
From:   Sam Kuper <sam.kuper@uclmail.net>
Date:   Fri, 2 Mar 2018 01:19:35 +0000
X-Google-Sender-Auth: ET0z5b04DaCQctudCxrzF3cxbTY
Message-ID: <CAD-Jur+6m1SjqHVWBxW5HnTjutSVrkP+dEXdYmFHzoUf0FGdNA@mail.gmail.com>
Subject: Bug report: "Use of uninitialized value $_ in print"
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

First, background. I encountered a bug on Debian Stretch, using this
git version:

$ git --version
git version 2.11.0


The bug is that in the midst of running

git -c interactive.diffFilter="git diff --word-diff --color" add --patch

and after having answered "y" to some patches and "n" to others, git
suddenly spewed the following output:


Use of uninitialized value $_ in print at
/usr/lib/git-core/git-add--interactive line 1371, <STDIN> line 74.
Stage this hunk [y,n,q,a,d,/,K,j,J,g,e,?]? n
Use of uninitialized value $_ in print at
/usr/lib/git-core/git-add--interactive line 1371, <STDIN> line 75.
Use of uninitialized value $_ in print at
/usr/lib/git-core/git-add--interactive line 1371, <STDIN> line 75.
Use of uninitialized value $_ in print at
/usr/lib/git-core/git-add--interactive line 1371, <STDIN> line 75.
Use of uninitialized value $_ in print at
/usr/lib/git-core/git-add--interactive line 1371, <STDIN> line 75.
Use of uninitialized value $_ in print at
/usr/lib/git-core/git-add--interactive line 1371, <STDIN> line 75.
Use of uninitialized value $_ in print at
/usr/lib/git-core/git-add--interactive line 1371, <STDIN> line 75.
Use of uninitialized value $_ in print at
/usr/lib/git-core/git-add--interactive line 1371, <STDIN> line 75.
Use of uninitialized value $_ in print at
/usr/lib/git-core/git-add--interactive line 1371, <STDIN> line 75.
Use of uninitialized value $_ in print at
/usr/lib/git-core/git-add--interactive line 1371, <STDIN> line 75.
Use of uninitialized value $_ in print at
/usr/lib/git-core/git-add--interactive line 1371, <STDIN> line 75.
Use of uninitialized value $_ in print at
/usr/lib/git-core/git-add--interactive line 1371, <STDIN> line 75.
Use of uninitialized value $_ in print at
/usr/lib/git-core/git-add--interactive line 1371, <STDIN> line 75.
Use of uninitialized value $_ in print at
/usr/lib/git-core/git-add--interactive line 1371, <STDIN> line 75.
Use of uninitialized value $_ in print at
/usr/lib/git-core/git-add--interactive line 1371, <STDIN> line 75.
Use of uninitialized value $_ in print at
/usr/lib/git-core/git-add--interactive line 1371, <STDIN> line 75.
Use of uninitialized value $_ in print at
/usr/lib/git-core/git-add--interactive line 1371, <STDIN> line 75.
Use of uninitialized value $_ in print at
/usr/lib/git-core/git-add--interactive line 1371, <STDIN> line 75.
Use of uninitialized value $_ in print at
/usr/lib/git-core/git-add--interactive line 1371, <STDIN> line 75.
Use of uninitialized value $_ in print at
/usr/lib/git-core/git-add--interactive line 1371, <STDIN> line 75.
Use of uninitialized value $_ in print at
/usr/lib/git-core/git-add--interactive line 1371, <STDIN> line 75.
Use of uninitialized value $_ in print at
/usr/lib/git-core/git-add--interactive line 1371, <STDIN> line 75.
Use of uninitialized value $_ in print at
/usr/lib/git-core/git-add--interactive line 1371, <STDIN> line 75.
Use of uninitialized value $_ in print at
/usr/lib/git-core/git-add--interactive line 1371, <STDIN> line 75.
Use of uninitialized value $_ in print at
/usr/lib/git-core/git-add--interactive line 1371, <STDIN> line 75.
Use of uninitialized value $_ in print at
/usr/lib/git-core/git-add--interactive line 1371, <STDIN> line 75.
Use of uninitialized value $_ in print at
/usr/lib/git-core/git-add--interactive line 1371, <STDIN> line 75.
Use of uninitialized value $_ in print at
/usr/lib/git-core/git-add--interactive line 1371, <STDIN> line 75.
Use of uninitialized value $_ in print at
/usr/lib/git-core/git-add--interactive line 1371, <STDIN> line 75.
Use of uninitialized value $_ in print at
/usr/lib/git-core/git-add--interactive line 1371, <STDIN> line 75.
Use of uninitialized value $_ in print at
/usr/lib/git-core/git-add--interactive line 1371, <STDIN> line 75.
Use of uninitialized value $_ in print at
/usr/lib/git-core/git-add--interactive line 1371, <STDIN> line 75.
Use of uninitialized value $_ in print at
/usr/lib/git-core/git-add--interactive line 1371, <STDIN> line 75.


I hope that this bug report can help the git core maintainers to
either fix the problem upstream, or to co-ordinate a fix with the
Debian git maintainer(s) if the bug does not exist upstream.

Thanks for the great DVCS :)

P.S. I am not subscribed to this mailing list, so please CC me in your
reply if you want me to see it.
