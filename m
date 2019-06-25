Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F01B51F461
	for <e@80x24.org>; Tue, 25 Jun 2019 14:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730727AbfFYOfS convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 25 Jun 2019 10:35:18 -0400
Received: from mx0.karlstorz.com ([62.134.46.134]:23757 "EHLO
        mx0.karlstorz.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728710AbfFYOfS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 10:35:18 -0400
IronPort-SDR: ytcvDWovm7jEw6umWtbxhzlOWAQpklG8sAUwV95IUBWrX9LgYkRgSzh78bmVZULSo8JhpLznHO
 SellxxDnYulEbS8NjUFb6/4cJNoV9kWkxJ6jZzIKBUuQvxQgNkJPTSHRlj/Kce3uEvcrZfdnqi
 t3iU95ghbwdqdBTTLmATO3cde3wsW35LDXiWNOEFypjZTDS2a/N788taO2rqkvatunPsnu1UlI
 4ZnTEtYRpJoj9yxHlyN1d/4xprCQnCcJiifuP974dPok0Mv+YAYPozzelN2m+FNN4CfQTBMZqX
 j5U=
X-IronPort-AV: E=Sophos;i="5.63,416,1557180000"; 
   d="scan'208";a="923356"
Received: from tut-ex04-pv.kstg.corp ([10.0.10.234])
  by mx0.karlstorz.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 25 Jun 2019 16:35:15 +0200
Received: from TUT-EX01-PV.KSTG.corp ([169.254.1.241]) by
 TUT-EX04-PV.KSTG.corp ([10.0.10.234]) with mapi id 14.03.0439.000; Tue, 25
 Jun 2019 16:35:15 +0200
From:   "Boettger, Heiko" <Heiko.Boettger@karlstorz.com>
To:     Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
CC:     Kyle Meyer <kyle@kyleam.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: AW: specifying revision - how to enforce matching a tag/branch-name
 or revision only
Thread-Topic: specifying revision - how to enforce matching a
 tag/branch-name or revision only
Thread-Index: AQHVKEQ/jw27fdRITDCM6LgaQQxNWKasJEsAgABPrHM=
Date:   Tue, 25 Jun 2019 14:35:15 +0000
Message-ID: <8C0042D8869AEA4AA334B49AFBBCEF82024806510C@TUT-EX01-PV.KSTG.corp>
References: <8C0042D8869AEA4AA334B49AFBBCEF820243C01B6A@TUT-EX01-PV.KSTG.corp>
 <87sgs3rhpo.fsf@kyleam.com>
 <xmqq8stvklzd.fsf@gitster-ct.c.googlers.com>,<CACsJy8CBQhF2=nZ4tZj_h6Gr8PjK3amANjT38uhnurS0dehyiQ@mail.gmail.com>
In-Reply-To: <CACsJy8CBQhF2=nZ4tZj_h6Gr8PjK3amANjT38uhnurS0dehyiQ@mail.gmail.com>
Accept-Language: de-CH, en-US
Content-Language: de-CH
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.0.10.246]
x-kse-serverinfo: TUT-EX04-PV.KSTG.corp, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 6/25/2019 1:17:00 PM
x-kse-attachment-filter-scan-result: Clean
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

First of all many thanks for the responses.

And yes refs/heads/foo-g<hash> will be interpreted by "git checkout" as "git-describe" output, if there is no such branch. My current solution for the moment is to extract the commit-sha1 from the output of "git for-each-ref" and fail if there is no exact match otherwise git checkout will anyway do what I want, because it finds the branch.

Regards
Heiko

________________________________________
Von: Duy Nguyen [pclouds@gmail.com]
Gesendet: Dienstag, 25. Juni 2019 13:43
An: Junio C Hamano
Cc: Kyle Meyer; Boettger, Heiko; git@vger.kernel.org
Betreff: Re: specifying revision - how to enforce matching a tag/branch-name or revision only

On Fri, Jun 21, 2019 at 10:16 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Kyle Meyer <kyle@kyleam.com> writes:
>
> >> git rev-parse "${BRANCH_NAME}"  || git rev-parse "refs/remotes/${UPSTREAM}/${BRANCH_NAME}"
> >>
> >> Unfortunately somebody used the branch name "add-gcc10" and `git rev-parse` which didn't exist on one repository. However `git rev-parse`
> >> also supports to parse the `git-describe` format which resulted in checkout a commit starting with "cc10".

I wonder if something like refs/heads/foo-g<hash> could trip the
parser and mistake it as a `git-describe` output. Staring at
get_describe_name() alone the answer might be an unfortunate "yes".
But maybe something will kick in earlier and reject it.

> >
> > Can't you prepend "refs/heads/" to BRANCH_NAME to disambiguate?
>
> Yes, that is the kosher way for most commands.

Some commands always prepend refs/heads/ to the <branch> argument you
give it if I remember correctly. Or I think I accidentally made
refs/heads/refs/heads/something once with some command (then hell
ensued). If true, prepending refs/heads/ is not really foolproof.

> It gets a bit tricky for "checkout <branch-or-committish>" that
> changes its behaviour (a local branch is checked out and the next
> commit extends it, other committishes like tags and remote-tracking
> branch tips are checked out on a detached HEAD), and has special
> rules for a "${BRANCH_NAME}" that is both the name of a local branch
> and something else.

I think "git checkout --no-guess --no-detach <branch>" should only
accept a branch (i.e. ref: refs/heads/<branch>). Dropping --no-detach
should allow any ref, which interprets refs/heads/foo as an absolute
ref, not as refs/heads/refs/heads/foo.

> Hopefully (Duy Cc'ed) "git switch" would improve the situation.

"git switch" has slightly saner defaults, but with --guess being
default to be friendlier to interactive usage, it's still not that
much friendlier to scripts, unfortunately.
--
Duy
