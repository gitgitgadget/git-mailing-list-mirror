Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 130531FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 23:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933159AbcLSXmf convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 19 Dec 2016 18:42:35 -0500
Received: from mxo1.nje.dmz.twosigma.com ([208.77.214.160]:47616 "EHLO
        mxo1.nje.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754593AbcLSXme (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 18:42:34 -0500
Received: from localhost (localhost [127.0.0.1])
        by mxo1.nje.dmz.twosigma.com (Postfix) with ESMTP id 2F72E100048;
        Mon, 19 Dec 2016 23:35:07 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo1.nje.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo1.nje.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TXMJOPMIfy3A; Mon, 19 Dec 2016 23:35:07 +0000 (GMT)
Received: from exmbdft5.ad.twosigma.com (exmbdft5.ad.twosigma.com [172.22.1.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo1.nje.dmz.twosigma.com (Postfix) with ESMTPS id 1B6718002E;
        Mon, 19 Dec 2016 23:35:07 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (172.22.2.43) by
 exmbdft5.ad.twosigma.com (172.22.1.56) with Microsoft SMTP Server (TLS) id
 15.0.1156.6; Mon, 19 Dec 2016 23:35:06 +0000
Received: from exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955]) by
 exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955%23]) with mapi id
 15.00.1263.000; Mon, 19 Dec 2016 23:35:06 +0000
From:   David Turner <David.Turner@twosigma.com>
To:     'Stefan Beller' <sbeller@google.com>,
        "gitster@pobox.com" <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "bmwill@google.com" <bmwill@google.com>,
        "sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>
Subject: RE: [PATCHv4 0/5] git-rm absorbs submodule git directory before
 deletion
Thread-Topic: [PATCHv4 0/5] git-rm absorbs submodule git directory before
 deletion
Thread-Index: AQHSWk+koPuPUuujEU+MuXbKCQtHJKEP7Bug
Date:   Mon, 19 Dec 2016 23:35:06 +0000
Message-ID: <a756fb33dbdb4a81a46e40c5e0aaef2f@exmbdft7.ad.twosigma.com>
References: <20161219232828.5075-1-sbeller@google.com>
In-Reply-To: <20161219232828.5075-1-sbeller@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.20.60.9]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Other than Brandon's issue on 3/5 (which I noticed myself but wanted to double-check that my mailer wasn't playing tricks on me and so lost the race to report), this version looks good.

> -----Original Message-----
> From: Stefan Beller [mailto:sbeller@google.com]
> Sent: Monday, December 19, 2016 6:28 PM
> To: gitster@pobox.com
> Cc: git@vger.kernel.org; bmwill@google.com; sandals@crustytoothpaste.net;
> David Turner; Stefan Beller
> Subject: [PATCHv4 0/5] git-rm absorbs submodule git directory before
> deletion
> 
> v4:
> * reworded commit messages of the last 2 patches
> * introduced a new patch introducing {run,start,finish}_command_or_die
> * found an existing function in dir.h to use to remove a directory
>   which deals gracefully with the cornercases, that Junio pointed out.
> 
> v3:
> * removed the patch to enhance ok_to_remove_submodule to absorb the
> submodule
>   if needed
> * Removed all the error reporting from git-rm that was related to
> submodule
>   git directories not absorbed.
> * instead just absorb the git repositories or let the absorb function die
>   with an appropriate error message.
> 
> v2:
> * new base where to apply the patch:
>   sb/submodule-embed-gitdir merged with sb/t3600-cleanup.
>   I got merge conflicts and resolved them this way:
> #@@@ -709,9 -687,10 +687,9 @@@ test_expect_success 'checking out a com
> #          git commit -m "submodule removal" submod &&
> #          git checkout HEAD^ &&
> #          git submodule update &&
> #-         git checkout -q HEAD^ 2>actual &&
> #+         git checkout -q HEAD^ &&
> #          git checkout -q master 2>actual &&
> # -        echo "warning: unable to rmdir submod: Directory not empty"
> >expected &&
> # -        test_i18ncmp expected actual &&
> # +        test_i18ngrep "^warning: unable to rmdir submod:" actual &&
> #          git status -s submod >actual &&
> #          echo "?? submod/" >expected &&
> #          test_cmp expected actual &&
> #
> 
> * improved commit message in "ok_to_remove_submodule: absorb the submodule
> git dir"
>   (David Turner offered me some advice on how to write better English off
> list)
> * simplified code in last patch:
>   -> dropped wrong comment for fallthrough
>   -> moved redundant code out of both bodies of an if-clause.
> * Fixed last patchs commit message to have "or_die" instead of or_dir.
> 
> v1:
> The "checkout --recurse-submodules" series got too large to comfortably
> send it out for review, so I had to break it up into smaller series'; this
> is the first subseries, but it makes sense on its own.
> 
> This series teaches git-rm to absorb the git directory of a submodule
> instead of failing and complaining about the git directory preventing
> deletion.
> 
> It applies on origin/sb/submodule-embed-gitdir.
> 
> Any feedback welcome!
> 
> Thanks,
> Stefan
> 
> Stefan Beller (5):
>   submodule.h: add extern keyword to functions
>   submodule: modernize ok_to_remove_submodule to use argv_array
>   run-command: add {run,start,finish}_command_or_die
>   submodule: add flags to ok_to_remove_submodule
>   rm: absorb a submodules git dir before deletion
> 
>  builtin/rm.c  | 82 +++++++++++++++---------------------------------------
> -----
>  run-command.c | 28 ++++++++++++++++++++  run-command.h |  4 +++
>  submodule.c   | 27 ++++++++++----------
>  submodule.h   | 58 ++++++++++++++++++++++++------------------
>  t/t3600-rm.sh | 39 +++++++++++-----------------
>  6 files changed, 114 insertions(+), 124 deletions(-)
> 
> --
> 2.11.0.rc2.53.gb7b3fba.dirty

