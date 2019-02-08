Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B88E71F453
	for <e@80x24.org>; Fri,  8 Feb 2019 11:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfBHLge convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 8 Feb 2019 06:36:34 -0500
Received: from elephants.elehost.com ([216.66.27.132]:26793 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbfBHLge (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 06:36:34 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x18BaO6Z061921
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 8 Feb 2019 06:36:24 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "=?UTF-8?Q?'SZEDER_G=C3=A1bor'?=" <szeder.dev@gmail.com>
Cc:     "'Jeff King'" <peff@peff.net>,
        "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>,
        "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
        <git-packagers@googlegroups.com>, <orgads@gmail.com>,
        "'Duy Nguyen'" <pclouds@gmail.com>
References: <000d01d4bf9b$d5d48da0$817da8e0$@nexbridge.com> <20190208111002.GU10587@szeder.dev>
In-Reply-To: <20190208111002.GU10587@szeder.dev>
Subject: RE: [Breakage] Git v2.21.0-rc0 - t5403 (NonStop)
Date:   Fri, 8 Feb 2019 06:36:17 -0500
Message-ID: <001001d4bfa2$84dcff70$8e96fe50$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKt9XefXcIt/s43+J5K5t2qIJW2rAEkL8zupBo39IA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 8, 2019 6:10, SZEDER Gábor
> On Fri, Feb 08, 2019 at 05:48:27AM -0500, Randall S. Becker wrote:
> > We have a few new breakages on the NonStop port in 2.21.0-rc0. The first
> is in t5403, as below:
> >
> > /home/git/git/t/trash
> > directory.t5403-post-checkout-hook/clone3/.git/hooks/post-checkout:
> > line 2: $GIT_DIR/post-checkout.args: ambiguous redirect not ok 8 - post-
> checkout hook is triggered by clone #
> > #               mkdir -p templates/hooks &&
> > #               write_script templates/hooks/post-checkout <<-\EOF &&
> > #               echo "$@" >$GIT_DIR/post-checkout.args
> > #               EOF
> > #               git clone --template=templates . clone3 &&
> > #               test -f clone3/.git/post-checkout.args
> > #
> >
> > The post-checkout hook is:
> > #!/usr/local/bin/bash
> > echo "$@" >$GIT_DIR/post-checkout.args
> >
> > This looks like it is a "bash thing" and $GIT_DIR might have to be in
> > quotes, and is not be specific to the platform. If I replace
> >
> > echo "$@" >$GIT_DIR/post-checkout.args
> >
> > with
> >
> > echo "$@" >"$GIT_DIR/post-checkout.args"
> >
> > The test passes.
> 
> Wow, this is the second time this "redirection to a filename with spaces
> under Bash" issue pops up today, see the other one here:
> 
>   https://public-inbox.org/git/20190208031746.22683-2-
> tmz@pobox.com/T/#u
> 
> In short, Bash (when invoked as bash) doesn't conform to POSIX in this
> respect; for a (too detailed) explanation see:
> 
>   https://public-inbox.org/git/20180926121107.GH27036@localhost/
> 
> Even our CodingGuidelines suggest the use of quotes around the
> redirection's target.
> 
> > I wonder I should provide this patch or whether the author would like to do
> so.
> 
> Well, since you didn't Cc the author, he might very well overlook this issue,
> so I think you should ;)

+ Nguyen and Orgad

Thanks. Fix has been submitted as a patch. This is definitely a common one. 😊

