Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3F1C20248
	for <e@80x24.org>; Fri, 19 Apr 2019 18:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfDSSRG (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Apr 2019 14:17:06 -0400
Received: from cisrsmtp.univ-lyon1.fr ([134.214.188.146]:38448 "EHLO
        cisrsmtp.univ-lyon1.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbfDSSRE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Apr 2019 14:17:04 -0400
Received: from localhost (localhost [127.0.0.1])
        by cisrsmtp.univ-lyon1.fr (Postfix) with ESMTP id C3136A0106;
        Fri, 19 Apr 2019 18:01:31 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at cisrsmtp.univ-lyon1.fr
Received: from cisrsmtp.univ-lyon1.fr ([127.0.0.1])
        by localhost (cisrsmtp.univ-lyon1.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Azk7OkcCVsy1; Fri, 19 Apr 2019 18:01:31 +0200 (CEST)
Received: from BEMBX2013-01.univ-lyon1.fr (bembx2013-01.univ-lyon1.fr [134.214.201.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by cisrsmtp.univ-lyon1.fr (Postfix) with ESMTPS id 3C15DA0046;
        Fri, 19 Apr 2019 18:01:31 +0200 (CEST)
Received: from Corentin-Linux.lan (134.214.126.172) by
 BEMBX2013-01.univ-lyon1.fr (134.214.201.247) with Microsoft SMTP Server (TLS)
 id 15.0.1263.5; Fri, 19 Apr 2019 18:01:28 +0200
From:   Corentin BOMPARD <corentin.bompard@etu.univ-lyon1.fr>
To:     <gitster@pobox.com>
CC:     <corentin.bompard@etu.univ-lyon1.fr>, <git@vger.kernel.org>,
        <matthieu.moy@univ-lyon1.fr>, <nathan.berbezier@etu.univ-lyon1.fr>,
        <pablo.chabanne@etu.univ-lyon1.fr>
Subject: Re: [PATCH] [WIP/RFC] add git pull and git fetch --set-upstream
Date:   Fri, 19 Apr 2019 18:00:46 +0200
Message-ID: <20190419160046.5283-1-corentin.bompard@etu.univ-lyon1.fr>
X-Mailer: git-send-email 2.21.0-rc0
In-Reply-To: <xmqq7ebshz7v.fsf@gitster-ct.c.googlers.com>
References: <xmqq7ebshz7v.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [134.214.126.172]
X-ClientProxiedBy: JEMBX2013-02.univ-lyon1.fr (134.214.201.250) To
 BEMBX2013-01.univ-lyon1.fr (134.214.201.247)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>Corentin BOMPARD <corentin.bompard@etu.univ-lyon1.fr> writes:
>
>> Add the --set-upstream option to git pull/fetch
>> which lets the user set the upstream configuration
>> for the current branch.
>
> I think it is a good idea to mention what you exactly mean by "the
> upstream configuration" here.  
>
> Do you mean the "branch.<current-branch-name>.merge" configuration
> variable?

The upstream configuration means the branch.<current-branch-name>.merge 
and branch.<current-branch-name>.remote

>> +             /*
>> +              * We're setting the upstream configuration for the current branch. The
>> +              * relevent upstream is the fetched branch that is meant to be merged with
>> +              * the current one, i.e. the one fetched to FETCH_HEAD.
>> +              *
>> +              * When there are several such branches, consider the request ambiguous and
>> +              * err on the safe side by doing nothing and just emit a waring.
>> +              */
>> +             for (rm = ref_map; rm; rm = rm->next) {
>> +                     fprintf(stderr, "\n -%s", rm->name);
>> +                     if (rm->peer_ref) {
>> +                             fprintf(stderr, " -> %s", rm->peer_ref->name);
>> +                     } else {
>> +                             if (source_ref) {
>> +                                     fprintf(stderr, " -> FETCH_HEAD\n");
>> +                                     warning(_("Multiple branch detected, incompatible with set-upstream"));
>
> Shouldn't this be diagnosed as an error and stop the "fetch" or
> "pull", though?

We can actually replace the warning with a die, but we think it's too harsh on the user, 
and if the warning is showing the upstream stays the same.

We fixed the spotted bugs/mistakes.

The fixed patch will follow.
