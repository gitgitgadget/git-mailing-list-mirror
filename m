Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B7BA1F404
	for <e@80x24.org>; Mon, 26 Feb 2018 18:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751515AbeBZSvU (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 13:51:20 -0500
Received: from upper-gw.cixit.se ([92.43.32.133]:40216 "EHLO mail.cixit.se"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750991AbeBZSvT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 13:51:19 -0500
X-Greylist: delayed 476 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Feb 2018 13:51:18 EST
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
        by mail.cixit.se (8.14.3/8.14.3/Debian-9.4) with ESMTP id w1QIh9An015388
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 26 Feb 2018 19:43:09 +0100
Received: from localhost (peter@localhost)
        by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id w1QIh8aB015384;
        Mon, 26 Feb 2018 19:43:09 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
Date:   Mon, 26 Feb 2018 19:43:08 +0100 (CET)
From:   Peter Krefting <peter@softwolves.pp.se>
To:     Git Mailing List <git@vger.kernel.org>
cc:     =?ISO-8859-15?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
        peff@peff.net, j6t@kdbg.org, lars.schneider@autodesk.com,
        gitster@pobox.com, patrick@luehne.de, larsxschneider@gmail.com
Subject: Re: [PATCH/RFC 1/1] Auto diff of UTF-16 files in UTF-8
In-Reply-To: <20180226172706.7822-1-tboegi@web.de>
Message-ID: <alpine.DEB.2.00.1802261939390.15209@ds9.cixit.se>
References: <20171218131249.GB4665@sigill.intra.peff.net> <20180226172706.7822-1-tboegi@web.de>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
Organization: /universe/earth/europe/norway/oslo
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7 (mail.cixit.se [127.0.0.1]); Mon, 26 Feb 2018 19:43:09 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tboegi@web.de:

> +static inline int buffer_has_utf16_bom(const void *buf, size_t len) {
> +  const unsigned char *text = (unsigned char *)buf;
> +  if (!text ||  len < 2)
> +    return 0;
> +  if (text[0] == 0xff && text[1] == 0xfe)
> +    return 1;
> +  if (text[0] == 0xfe && text[1] == 0xff)
> +    return 1;
> +  return 0;
> +}

This would also match a UTF-32LE BOM, not that I think anyone would 
actually use that for text files, but it might be worth adding a test 
for that, just in case?

   if (text[0] == 0xff && text[1] == 0xfe)
     return len < 4 || (text[2] != 0 && text[3] != 0);

-- 
\\// Peter - http://www.softwolves.pp.se/
