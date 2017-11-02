Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BCFB20281
	for <e@80x24.org>; Thu,  2 Nov 2017 18:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933584AbdKBSEo (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 14:04:44 -0400
Received: from ikijono.foobar.fi ([193.65.3.99]:51862 "EHLO ikijono.foobar.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932196AbdKBSEn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 14:04:43 -0400
Received: from localhost (localhost [IPv6:::1])
        by ikijono.foobar.fi (Postfix) with ESMTP id 3ySXzY6KxSzrwdv6
        for <git@vger.kernel.org>; Thu,  2 Nov 2017 20:04:41 +0200 (EET)
X-Virus-Scanned: amavisd-new at ikijono.foobar.fi
Received: from ikijono.foobar.fi ([IPv6:::1])
        by localhost (ikijono.foobar.fi [IPv6:::1]) (amavisd-new, port 10023)
        with ESMTP id c4x5ya58FwFd for <git@vger.kernel.org>;
        Thu,  2 Nov 2017 20:04:40 +0200 (EET)
Received: from jhs-desktop.uk.solarflarecom.com (uk.solarflare.com [193.34.186.16])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ikijono.foobar.fi (Postfix) with ESMTPSA
        for <git@vger.kernel.org>; Thu,  2 Nov 2017 20:04:40 +0200 (EET)
Subject: Re: [BUG] git clean -d is too greedy
From:   Hermanni Suominen <hermanni@foobar.fi>
To:     git@vger.kernel.org
References: <d2e823e2-800d-17ba-c9d4-f490cefefd2f@foobar.fi>
Message-ID: <1b6ba313-8d99-8604-1774-0f481eeeabec@foobar.fi>
Date:   Thu, 2 Nov 2017 18:04:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <d2e823e2-800d-17ba-c9d4-f490cefefd2f@foobar.fi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was a bit trigger happy posting this, after digging a bit more this is 
a way more serious than I originally thought.

>    1) .gitignore exists in nested repo (either tracked or untracked)
>    2) .gitignore is excluded

This can be any file, including those commonly excluded such as *~.

Demonstrating this in a way that looks a lot more likely use case which 
will potentially wipe out lots of uncommitted work:

# git init -q foo && cd foo
# git init -q bar && cd bar
# touch bar bar~
# git add bar && git commit -qm asd && cd ..
# git clean -e \*~ -dn
Would remove bar/bar

If there were more tracked files in nested repo they'd be removed as 
well as long as there is at least one excluded file in nested repo.

-- 
Hermanni
