Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE9CE1F428
	for <e@80x24.org>; Sat, 28 Apr 2018 19:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751414AbeD1Tf1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Apr 2018 15:35:27 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:35596 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751079AbeD1Tf1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Apr 2018 15:35:27 -0400
Received: from pomiot (d202-252.icpnet.pl [109.173.202.252])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mgorny)
        by smtp.gentoo.org (Postfix) with ESMTPSA id AC86F335C90;
        Sat, 28 Apr 2018 19:35:24 +0000 (UTC)
Message-ID: <1524944121.1013.13.camel@gentoo.org>
Subject: Re: [RFC PATCH] checkout: Force matching mtime between files
From:   =?UTF-8?Q?Micha=C5=82_G=C3=B3rny?= <mgorny@gentoo.org>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Marc Branchaud <marcnarc@xiplink.com>,
        "Robin H. Johnson" <robbat2@gentoo.org>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Date:   Sat, 28 Apr 2018 21:35:21 +0200
In-Reply-To: <CACsJy8AfE4XMgTLuM=9aWV7eX5Hd8CqmFMuEgQaSxsLfGoBb5w@mail.gmail.com>
References: <20180413170129.15310-1-mgorny@gentoo.org>
         <robbat2-20180423T200557-844830385Z@orbis-terrarum.net>
         <xmqqtvs18p9o.fsf@gitster-ct.c.googlers.com>
         <robbat2-20180425T060717-325652820Z@orbis-terrarum.net>
         <xmqqin8f4qoq.fsf@gitster-ct.c.googlers.com>
         <ad4d0d66-58f4-5cab-d314-a30a50e8ad32@xiplink.com>
         <xmqqefj24v3c.fsf@gitster-ct.c.googlers.com>
         <1524753972.1088.9.camel@gentoo.org>
         <CACsJy8AfE4XMgTLuM=9aWV7eX5Hd8CqmFMuEgQaSxsLfGoBb5w@mail.gmail.com>
Organization: Gentoo
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu sob, 28.04.2018 o godzinie 16∶23 +0200, użytkownik Duy Nguyen
napisał:
> On Thu, Apr 26, 2018 at 4:46 PM, Michał Górny <mgorny@gentoo.org> wrote:
> > For the record, we're using this with ebuilds and respective cache files
> > (which are expensive to generate).  We are using separate repository
> > which combines sources and cache files to keep the development
> > repository clean.  I have researched different solutions for this but
> > git turned out the best option for incremental updates for us.
> > 
> > Tarballs are out of question, unless you expect users to fetch >100 MiB
> > every time, and they are also expensive to update.  Deltas of tarballs
> > are just slow and require storing a lot of extra data.  Rsync is not
> > very efficient at frequent updates, and has significant overhead
> > on every run.  With all its disadvantages, git is still something that
> > lets our users fetch updates frequently with minimal network overhead.
> 
> I assume you're talking about the metadata directory in gentoo-x86
> repo. This specific case could be solved by renaming metadata to
> _metadata or something to put it on the top. "git checkout" always
> updates files in strcmp(path) order. This guarantees time(_metadata)
> <= time(ebuild) for all ebuilds without any extra touching (either in
> git or in a post-checkout hook)

We can't really rename it without breaking compatibility with all
package managers out there.  Preparing to do such a major change for
the sake of abusing implementation detail of git doesn't look like
a worthwhile idea.

> 
> The behavior has been this way since forever and as far as I can tell
> very unlikely to change at least for branch switching (major changes
> involved around the index). It's a bit easier to accidentally change
> how "git checkout -- path" works though. I don't know if we could just
> make this checkout order a promise and guarantee not to break it
> though. For it it does not sound like it adds extra maintenance
> burden.

-- 
Best regards,
Michał Górny

