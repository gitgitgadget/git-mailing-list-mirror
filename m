Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25B861F404
	for <e@80x24.org>; Mon,  9 Apr 2018 20:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754871AbeDIUJc (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 16:09:32 -0400
Received: from lucaswerkmeister.de ([94.130.58.99]:55660 "EHLO
        lucaswerkmeister.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754792AbeDIUJ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 16:09:28 -0400
Received: from theoden.lucaswerkmeister.de (unknown [IPv6:2a02:8109:92c0:22bb:be5f:f4ff:fecb:74cd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mail@lucaswerkmeister.de)
        by lucaswerkmeister.de (Postfix) with ESMTPSA id C4BB131A54E;
        Mon,  9 Apr 2018 22:09:26 +0200 (CEST)
Authentication-Results: lucaswerkmeister.de; dmarc=fail (p=none dis=none) header.from=lucaswerkmeister.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lucaswerkmeister.de;
        s=mail; t=1523304566;
        bh=7lq+fgJr++tfI9y8OwFkm9cfjvorsQqvhV3ItIluvzI=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type:Content-Transfer-Encoding:From:Reply-To:
         Subject:Date:To:Cc:In-Reply-To:References:Message-Id:Sender:
         Content-Type:Content-Transfer-Encoding:Content-Disposition:
         Mime-Version;
        b=TxPUECp+dLKJcZCaP/i2CmlXQ3jY7Cw/1dYtRvJcENhPcEAfgzLu5+cPQ2n0ZZL+v
         +Hk7s+qZtkkpAggGfzKKO2Ds/9roCVGSmigEAUYsQW4x4PNjowyX8iGv09BgSKvc5V
         fn/sR5vBp4BI+luEBPuzTGW5nK5wNIMTBNLJpYZ4=
Subject: Re: [PATCH] Fix condition for redirecting stderr
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org
References: <20180403221307.29194-1-mail@lucaswerkmeister.de>
 <20180409022303.GS29680@zaya.teonanacatl.net>
From:   Lucas Werkmeister <mail@lucaswerkmeister.de>
Openpgp: preference=signencrypt
Autocrypt: addr=mail@lucaswerkmeister.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <02f500d5-6038-a7c1-cd42-aadf33562818@lucaswerkmeister.de>
Date:   Mon, 9 Apr 2018 22:09:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180409022303.GS29680@zaya.teonanacatl.net>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09.04.2018 04:23, Todd Zullinger wrote:
> Lucas Werkmeister wrote:
>> Since the --log-destination option was added in 0c591cacb ("daemon: add
>> --log-destination=(stderr|syslog|none)", 2018-02-04) with the explicit
>> goal of allowing logging to stderr when running in inetd mode, we should
>> not always redirect stderr to /dev/null in inetd mode, but rather only
>> when stderr is not being used for logging.
> 
> Perhaps 's/^F/daemon: f/' on the subject?  (Junio may well
> already have done so while queueing locally.)

Indeed, sorry! Looks like Junio fixed it on his end (going by the
“what’s cooking” email), so I won’t reroll. (But I can at least set up a
local commit-msg hook to make sure I don’t forget the subject area again.)
