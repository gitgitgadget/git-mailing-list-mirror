Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2AE220248
	for <e@80x24.org>; Thu, 18 Apr 2019 09:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388504AbfDRJvd (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Apr 2019 05:51:33 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:39623
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388422AbfDRJvd (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 18 Apr 2019 05:51:33 -0400
X-IronPort-AV: E=Sophos;i="5.60,365,1549926000"; 
   d="scan'208";a="303288269"
Received: from dhcp-13-174.lip.ens-lyon.fr (HELO moylip) ([140.77.13.174])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES256-GCM-SHA384; 18 Apr 2019 11:51:29 +0200
From:   Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     BOMPARD CORENTIN p1603631 <corentin.bompard@etu.univ-lyon1.fr>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        BERBEZIER NATHAN p1601409 <nathan.berbezier@etu.univ-lyon1.fr>,
        CHABANNE PABLO p1602176 <pablo.chabanne@etu.univ-lyon1.fr>
Subject: Re: [PATCH] [WIP/RFC] add git pull and git fetch --set-upstream
References: <20190409125205.13754-1-corentin.bompard@etu.univ-lyon1.fr>
        <20190417160138.6114-1-corentin.bompard@etu.univ-lyon1.fr>
        <36559daca9d84f7a91933add734020cd@BPMBX2013-01.univ-lyon1.fr>
Date:   Thu, 18 Apr 2019 11:51:28 +0200
In-Reply-To: <36559daca9d84f7a91933add734020cd@BPMBX2013-01.univ-lyon1.fr>
        (Junio C. Hamano's message of "Thu, 18 Apr 2019 01:35:48 +0000")
Message-ID: <86h8av7ian.fsf@univ-lyon1.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> --- a/Documentation/fetch-options.txt
>> +++ b/Documentation/fetch-options.txt
>> @@ -165,6 +165,11 @@ ifndef::git-pull[]
>>  	Disable recursive fetching of submodules (this has the same effect as
>>  	using the `--recurse-submodules=no` option).
>>  
>> +--set-upstream::
>> +	If the new URL remote is correct, pull and add upstream (tracking) 
>> +	reference, used by argument-less linkgit:git-push[1] and other commands.
>
> git-push and other commands?

I think this is taken from the documentation of --set-upstream for push,
which says:

-u::
--set-upstream::
	For every branch that is up to date or successfully pushed, add
	upstream (tracking) reference, used by argument-less
	linkgit:git-pull[1] and other commands. For more information,
	see `branch.<name>.merge` in linkgit:git-config[1].

Probably the reasoning was to make a symmetry between "git push
--set-upstream", which mentions "pull" in the doc, and the new "git pull
--set-upstream". However, I do not think there should be such symmetry:

Actually, the way I see it, the notion of uptream (i.e.
branch.<branch>.remote and branch.<branch>.merge) is primarily about
"pull" and friends, and "push" happens to use it also by default. But
when branch.<branch>.pushRemote is set, upstream is really about
pulling, and pushing goes to the pushRemote.

>> +	/* TODO: remove debug trace */
>
> Perhaps do so before sending it out for the review?

Yes. This is WIP for now, but it's time to get closer to a real patch,
and these debug statements are counter-productive for that.

>> +	test_must_be_empty merge.$1
>> +}
>
> If this wanted to say "It is OK for the variable to be missing, and
> it also is OK for the variable to have an empty string as its value;
> all other cases are unacceptable",

Actually, I don't think the "present but empty" case makes sense here,
so just test_must_fail git config "$1" should do the trick.

I agree with all other remarks.

-- 
Matthieu Moy
https://matthieu-moy.fr/
