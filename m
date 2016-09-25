Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 757C9207EC
	for <e@80x24.org>; Sun, 25 Sep 2016 10:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965819AbcIYK0O (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Sep 2016 06:26:14 -0400
Received: from mx1.imag.fr ([129.88.30.5]:52054 "EHLO mx1.imag.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751582AbcIYK0N (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Sep 2016 06:26:13 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
        by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u8PAPfss008644
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Sun, 25 Sep 2016 12:25:41 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
        by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u8PAPg8X014676;
        Sun, 25 Sep 2016 12:25:42 +0200
From:   Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Santi =?iso-8859-1?Q?B=E9jar?= <sbejar@gmail.com>,
        Kevin Bracey <kevin@bracey.fi>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [RFC PATCH v2] revision: new rev^-n shorthand for rev^n..rev
References: <20160925085511.12515-1-vegard.nossum@oracle.com>
Date:   Sun, 25 Sep 2016 12:25:42 +0200
In-Reply-To: <20160925085511.12515-1-vegard.nossum@oracle.com> (Vegard
        Nossum's message of "Sun, 25 Sep 2016 10:55:11 +0200")
Message-ID: <vpq4m54wa1l.fsf@anie.imag.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Sun, 25 Sep 2016 12:25:42 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u8PAPfss008644
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1475403945.16996@2j2UwxdPl+ok9f4aaI9Wkw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vegard Nossum <vegard.nossum@oracle.com> writes:

>  Documentation/revisions.txt | 14 +++++++
>  builtin/rev-parse.c         | 28 ++++++++++++++
>  revision.c                  | 91 +++++++++++++++++++++++++++++++++++++++++++++
>  revision.h                  |  1 +

This would obviously need tests before you can drop the RFC flag.

> --- builtin/rev-parse.c
> +++ builtin/rev-parse.c
> @@ -292,6 +292,32 @@ static int try_difference(const char *arg)
>  	return 0;
>  }
>  
> +static int try_parent_exclusion(const char *arg)
> +{
> +	int ret = 0;
> +	char *to_rev = NULL;
> +	char *from_rev = NULL;
> +	unsigned char to_sha1[20];
> +	unsigned char from_sha1[20];

I didn't follow closely, but there are patch series by brian m. carlson
to convert these unsigned char array[20] to struct object_id. I guess
adding more arrays is going in the wrong direction. You may want to Cc
brian if unsure.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
