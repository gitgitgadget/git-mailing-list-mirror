Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 660D31F404
	for <e@80x24.org>; Mon, 17 Sep 2018 14:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbeIQT3C convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 17 Sep 2018 15:29:02 -0400
Received: from elephants.elehost.com ([216.66.27.132]:29080 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbeIQT3B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 15:29:01 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w8HE1Qvu077841
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 17 Sep 2018 10:01:26 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Taylor Blau'" <me@ttaylorr.com>,
        "=?iso-8859-1?Q?'=C6var_Arnfj=F6r=F0_Bjarmason'?=" <avarab@gmail.com>
Cc:     "'John Austin'" <john@astrangergravity.com>, <git@vger.kernel.org>,
        <sandals@crustytoothpaste.net>, <larsxschneider@gmail.com>,
        <pastelmobilesuit@github.com>, "'Joey Hess'" <id@joeyh.name>
References: <CA+AhR6fWpzL1ozt2H=y8TaQrgT-6dvkkK_K_P-pXniXT+xcMuQ@mail.gmail.com> <20180914190025.GJ55140@syl> <CA+AhR6fH4=VbuMPasbaH9u52Y=tgJJzhgxosPOb3819ivCVJOg@mail.gmail.com> <20180915164052.GA88932@syl> <878t41lcfi.fsf@evledraar.gmail.com> <20180917135525.GF71477@syl>
In-Reply-To: <20180917135525.GF71477@syl>
Subject: RE: Git for games working group
Date:   Mon, 17 Sep 2018 10:01:19 -0400
Message-ID: <000f01d44e8e$ec37f600$c4a7e200$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJCK+yvnEb5QI/ikbJlwoBcKKGxtwJ84Xf9AsGEat8CU8XVTAJ6d6v5Avvgq9KjsIEEUA==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On September 17, 2018 9:55 AM Taylor Blau wrote:
> On Sun, Sep 16, 2018 at 04:55:13PM +0200, Ævar Arnfjörð Bjarmason wrote:
> > In the hypothetical git-annex-like case (simplifying a bit for the
> > purposes this explanation), for every FILE in your tree you have a
> > corresponding FILE.lock file, but it's not a boolean, but a log of
> > who's asked for locks, i.e. lines of:
> >
> >     <repository UUID> <ts> <state> <who (email?)> <explanation?>
> >
> > E.g.:
> >
> >     $ cat Makefile.lock
> >     my-random-per-repo-id 2018-09-15 1 avarab@gmail.com "refactoring
> all Makefiles"
> >     my-random-per-repo-id 2018-09-16 0 avarab@gmail.com "done!"
> >
> > This log is append-only, when clients encounter conflicts there's a
> > merge driver to ensure that all updates are kept.
> 
> Certainly. I think that there are two things that aren't well expressed
under
> this mechanism:
> 
>   1. Having a log of locks held against that (a) file doesn't prevent us
>      from introducing merge conflicts at the <file>.lock level, so we're
>      reliant upon the caller first running 'git pull' and hoping that no
>      one beats them out to locking and pushing their lock.
> 
>   2. Multi-file locks, e.g., "I need to lock file(s) X, Y, and Z
>      together." This isn't possible in Git LFS today with the existing
"git
>      lfs lock" command (I had to check, but it takes only _one_ filename
as
>      its argument).
> 
>      Perhaps it would be nice to support something like this someday in
>      Git LFS, but I think we would have to reimagine how this would look
>      in your file.lock scheme.

I have an interest in this particular scheme, so am looking at porting both
golang and git-lfs over to my platform (HPE-NonStop). The multi-file lock
problem can be addressed through a variety of cooperative scheme, and if I
get the port, I'm hoping to contribute something to solve it (that's a big
IF at this point in time) - there are known mutex patterns to solve this
AFAIR. My own community has a similar requirement, so I'm investigating.

Cheers,
Randall


