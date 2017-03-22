Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C04920958
	for <e@80x24.org>; Wed, 22 Mar 2017 12:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934390AbdCVMBl (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 08:01:41 -0400
Received: from smtp6-g21.free.fr ([212.27.42.6]:51700 "EHLO smtp6-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934397AbdCVMBd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 08:01:33 -0400
Received: from [192.168.1.112] (unknown [164.177.97.114])
        (Authenticated sender: jn.avila)
        by smtp6-g21.free.fr (Postfix) with ESMTPSA id E8961780333
        for <git@vger.kernel.org>; Wed, 22 Mar 2017 13:01:29 +0100 (CET)
Subject: Re: [PATCH v3 2/2] l10n: Add git-add.txt to localized man pages
References: <20170312200248.3610-1-jn.avila@free.fr>
 <20170320210225.13046-1-jn.avila@free.fr>
 <20170320210225.13046-3-jn.avila@free.fr>
 <xmqqpohbtxi3.fsf@gitster.mtv.corp.google.com>
To:     git <git@vger.kernel.org>
From:   =?UTF-8?Q?Jean-No=c3=abl_Avila?= <jn.avila@free.fr>
Message-ID: <5036581a-f989-2db6-06ba-621db05c6de1@free.fr>
Date:   Wed, 22 Mar 2017 13:01:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqpohbtxi3.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le 20/03/2017 à 23:05, Junio C Hamano a écrit :
> Jean-Noel Avila <jn.avila@free.fr> writes:
>
>> Signed-off-by: Jean-Noel Avila <jn.avila@free.fr>
>> ---
>>  Documentation/po/documentation.fr.po | 1095 ++++++++++++++++++++++++++++++++++
>>  Documentation/po/documentation.pot   |  787 ++++++++++++++++++++++++
>>  2 files changed, 1882 insertions(+)
>>  create mode 100644 Documentation/po/documentation.fr.po
>>  create mode 100644 Documentation/po/documentation.pot
> This sounds more like
>
> Subject: l10n: add fr localization for git-add manual pages
>
> to me.  The actual part of this patch that adds "git-add" is the
> addition of Documentation/po/documentation.pot, and from that point
> of view, this patch may want to be further split into two.

The generation of the documentation.pot and the documentation.fr.po is
already "virtually" done because that's what the po4a.conf file
describes in the previous patch. The point is that the po4a.conf file
for a minimum viable run of make implies that at least a language and a
file be described.

For documentation.po.fr, what is indeed added is the effective
translation. So I guess we could probably split the series differently,
with a po4a.conf and empty files, then the translation.

>
> But more importantly, aren't we essentially adding an equivalent of
>
> 	cd Documentation && cat git-*.txt
>
> to our codebase?
>
> Surely we cannot avoid having a copy of all messages that are to be
> translated using msgid/msgstr based approach, and we already do so
> for end-user-facing in-program strings, but it just feels a bit too
> much having to carry a duplicate (and slightly a stale) copy of the
> entire documentation set around.  For N languages, we'll have an
> equivalent for N copies of the English text, in addition to the
> translated documentation.

True. The documentation source roughly weight 2.3MB, so each full
translation would add up 5MB to the working copy. More , that would also
generate another source of traffic for updates and questions from
readers, which may not be of interest for most developpers.

>
> I am wondering if Documentation/po part should be a separate
> repository, with a dedicated i18n/l10n coordinator.  Would it make
> it easier for (1) those who write code and doc without knowing other
> languages, (2) those who update .pot and coordinate the l10n effort
> for the documentation and (3) those who translate them if we keep
> them in a single repository?
This is one of the points raised in the first RFC mail. Splitting this
part would help a lot manage the translations with their own workflow,
would not clutter the main repo with files not really needed for
packaging and would simplify dealing with the interaction with crowd
translation websites which can directly push translation content to a
git repo.

There's still the question whether the secondary repo would copy the
original asciidocs and from there would manage them with po4a and then
the translated asciidoc sources would be pushed back to the main repo,
or if the main repo would still run the po4a, and only the translated po
files would be pushed back.

The first way would decouple the workflow and the tools used for
translating from the main repo. If po4a turns out to be too adventurous
for asciidoc (latest version tested with all the man pages, no visible
problem), that would not impact the main repo which could still benefit
from the job already done.

The later way would allow the main repo to keep an eye on how the
translation are up to date and decide to include them or not.

In any case, there would be a copy of the original asciidoc files to the
secondary repo, to be able to provide the source reference in the po
files and give context to the translators.

My personal preference would still go to the integration of po4a in the
main repo, but it isn't ready yet.

Thanks,

