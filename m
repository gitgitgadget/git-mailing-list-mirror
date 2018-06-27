Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11D671F516
	for <e@80x24.org>; Wed, 27 Jun 2018 06:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752989AbeF0Gse (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 02:48:34 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:46758 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752865AbeF0Gse (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 02:48:34 -0400
Received: by mail-yb0-f193.google.com with SMTP id s14-v6so349791ybp.13
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 23:48:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ToUvrBiLNqyK2xl7UXWjcpPyHbL+EEIhmZpOG58T1Cg=;
        b=b98tZoPZ6HRHFisV7+3okCt4EV35UBMkc6dIYxaLka1ngEymkBpZxJdhFRtAUyaJ+J
         d0nWgs1UM+MGyYlOb5qSMKN8XdBb9JvkIjq3p5grWV9kw6AM/9z/Z9SYr4QSfezkQDGk
         R2Qiyl7YpV8N4HuGN49BxJGv8Cr1qXzSkJR/tIuEKidUtCdrCtdWcDGDSut37lbw4Ol6
         m7NrAxdeNCFWoG5Rokcbz29k1idNPg3svvh72QnRNVakCbzhJTcJTIXbjB98o5W7Bdje
         /N5Ks3jsvvTUtY0fkgXiGkp0pdIGNlU2HEA68aLaTajjPggu3Z/UawoadBJw5crsmp/f
         S9dw==
X-Gm-Message-State: APt69E3cNt0PJ3ogDYG/Tu8S+qpZV9GCFkZT4Zf7bRQvS78f5Qc2oQ28
        mjg8jyLUb9QWjKEntMA9uxX+SOAzYoVQ/Nfn0sU=
X-Google-Smtp-Source: ADUXVKIt7wef4haqkePT+/6oSWTrjPk3gZNjO/z+9nAFCYmygaTC6reGwho+n0cc2VjGEoinb4CmNaqBwCy9NQ99ee8=
X-Received: by 2002:a5b:ac9:: with SMTP id a9-v6mr2255074ybr.287.1530082113523;
 Tue, 26 Jun 2018 23:48:33 -0700 (PDT)
MIME-Version: 1.0
References: <20180626073001.6555-1-sunshine@sunshineco.com>
 <20180626073001.6555-30-sunshine@sunshineco.com> <xmqqwouljr5e.fsf@gitster-ct.c.googlers.com>
 <CAPig+cSLyie8mr+u8Thv9cJ0J12nCA+RU6Mg3S5F8U68q1+nzQ@mail.gmail.com>
 <20180626201708.GA2341@sigill.intra.peff.net> <CAPig+cRvgsu-6f+mzjGVDWTVhFrhLY5MsNxEQBJYckKDpeaMAg@mail.gmail.com>
 <20180626210100.GA3682@sigill.intra.peff.net> <CABPp-BHgPgkgQj7i3rZtdbinVZvqH35uGraUK9doL-E8Y5QuSQ@mail.gmail.com>
 <67110b53-690c-abd4-9988-33278ee8c413@kdbg.org>
In-Reply-To: <67110b53-690c-abd4-9988-33278ee8c413@kdbg.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 27 Jun 2018 02:48:22 -0400
Message-ID: <CAPig+cQR48oPmTkO1YsDpSm-MYhyRuBwNdEJp_4+MhavP7CpXA@mail.gmail.com>
Subject: Re: [PATCH 29/29] t/test-lib: teach --chain-lint to detect broken
 &&-chains in subshells
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 27, 2018 at 2:27 AM Johannes Sixt <j6t@kdbg.org> wrote:
> Am 27.06.2018 um 04:15 schrieb Elijah Newren:
> > On Tue, Jun 26, 2018 at 2:01 PM, Jeff King <peff@peff.net> wrote:
> >> On Tue, Jun 26, 2018 at 04:46:18PM -0400, Eric Sunshine wrote:
> >>> Some of these dangers can be de-thoothed during the linting phase by
> >>> defining do-nothing shell functions:
> >>>      cp () { :; }
> >>> That, at least, makes the scariest case ("rm") much less so.
> >>
> >> Now that's an interesting idea. We can't catch every dangerous action
> >> (notably ">" would be hard to override), but it should be pretty cheap
> >> to cover some obvious ones.
> >
> > Crazy idea: maybe we could defang it a little more thoroughly with
> > something like the following (apologies in advance if gmail whitespace
> > damages this):
> >
> > -               if test "OK-117" != "$(test_eval_ "(exit 117) &&
> > $1${LF}${LF}echo OK-\$?" 3>&1)"
> > +               if test "OK-117" != "$(test_eval_ "cd() { return 0; }
> > && PATH=/dev/null && export PATH && (exit 117) && $1${LF}${LF}echo
> > OK-\$?" 3>&1)"

Interesting idea (coupled with Hannes's point below)...

> I'd define all these functions as { return 1; } because we want to stop
> any && chain as early as possible (and with an exit code that is not the
> sentinel value).

A very sensible suggestion.
