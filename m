Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AECF71F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 21:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754869AbcJEV0Q convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 5 Oct 2016 17:26:16 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:47936 "EHLO
        iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754829AbcJEV0P (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 5 Oct 2016 17:26:15 -0400
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail)
        by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
        iface 141.3.10.81 id 1brthZ-0000Yp-U9; Wed, 05 Oct 2016 23:26:09 +0200
Received: from apache by webmail with local (Exim 4.84_2)
        (envelope-from <szeder@ira.uka.de>)
        id 1brthZ-0007l5-QT; Wed, 05 Oct 2016 23:26:09 +0200
Received: from x590c309c.dyn.telefonica.de (x590c309c.dyn.telefonica.de
 [89.12.48.156]) by webmail.informatik.kit.edu (Horde Framework) with HTTPS;
 Wed, 05 Oct 2016 23:26:09 +0200
Date:   Wed, 05 Oct 2016 23:26:09 +0200
Message-ID: <20161005232609.Horde.VetzEIKHDJUdcaOod9sHxuK@webmail.informatik.kit.edu>
From:   SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Leho Kraav <leho@conversionready.com>,
        =?utf-8?b?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 5/5] versioncmp: cope with common leading parts in
 versionsort.prereleaseSuffix
References: <20160906214550.Horde.ducOghtmsQb9pQ6lixxddVz@webmail.informatik.kit.edu>
 <20160907151251.30978-1-szeder@ira.uka.de>
 <20160907151251.30978-6-szeder@ira.uka.de>
 <20160907174841.Horde.Ru1LBEeLKomznlWVG-ZnS-Q@webmail.informatik.kit.edu>
 <20161005033353.Horde.33pf2naqnF4HgwPWSy9DaHV@webmail.informatik.kit.edu>
 <xmqq4m4qrapv.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqq4m4qrapv.fsf@gitster.mtv.corp.google.com>
User-Agent: Horde Application Framework 5
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1475702769.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Quoting Junio C Hamano <gitster@pobox.com>:

> SZEDER Gábor <szeder@ira.uka.de> writes:
>
>> And a final sidenote: sorting based on the longest matching suffix
>> also allows us to (ab)use version sort with prerelease suffixes to
>> sort postrelease tags as we please, too:
>>
>>  $ ~/src/git/git -c versionsort.prereleasesuffix=-alpha \
>>                  -c versionsort.prereleasesuffix=-beta \
>>                  -c versionsort.prereleasesuffix= \
>>                  -c versionsort.prereleasesuffix=-gamma \
>>                  -c versionsort.prereleasesuffix=-delta \
>>                  tag -l --sort=version:refname 'v3.0*'
>>  v3.0-alpha1
>>  v3.0-beta1
>>  v3.0
>>  v3.0-gamma1
>>  v3.0-delta1
>
> Assuming that gamma and delta are meant to indicate "these are
> post-release updates",

Indeed they were meant as post-release suffixes.  Naturally following
alpha and beta, they were the first to spring to mind that should be
sorted in non-lexicographical order, so I could show of postrelease
reordering.  It's just that we don't have a config like
'versionsort.postreleasesuffix', which is half the abuse.  The other
half of the abuse is that I had to explicitly indicate the position
of suffixless versions with an empty suffix between pre- and
postrelease suffixes.  The empty suffix matches on every tag, but
then it's overridden by all configured suffixes, so such a version
just stays in the middle.

> I think a mechanism that can yield the above
> result is fantastic ;-)

Heh.

Gut feeling tells me that I should take this as a subtle
encouragement to look into adding 'versionsort.postreleasesuffix',
shouldn't I ;)

