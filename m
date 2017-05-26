Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5419F1FA14
	for <e@80x24.org>; Sat, 27 May 2017 01:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756380AbdE0BLs (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 May 2017 21:11:48 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:37809 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1948766AbdEZVy6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2017 17:54:58 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3wZKg435R7z5tlD;
        Fri, 26 May 2017 23:54:56 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 218BF4323;
        Fri, 26 May 2017 23:54:56 +0200 (CEST)
Subject: Re: [GSoC][PATCH v5 3/3] submodule: port subcommand foreach from
 shell to C
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     git@vger.kernel.org, bmwill@google.com, christian.couder@gmail.com,
        ramsay@ramsayjones.plus.com, sbeller@google.com
References: <20170521125814.26255-2-pc44800@gmail.com>
 <20170526151713.10974-1-pc44800@gmail.com>
 <20170526151713.10974-3-pc44800@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <83801d05-e3a9-b7e4-8f29-cd8172257dac@kdbg.org>
Date:   Fri, 26 May 2017 23:54:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <20170526151713.10974-3-pc44800@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 26.05.2017 um 17:17 schrieb Prathamesh Chavan:
> +	argv_array_pushf(&cp.env_array, "path=%s", list_item->name);

Not good! On Windows, environment variables are case insensitive. The 
environment variable "path" has a very special purpose, although it is 
generally spelled "PATH" (actually "Path" on Windows).

Lowercase "path" may have worked as long as it was only used in a shell 
script (and perhaps only by lucky coincidence), but this I can pretty 
much guarantee to fail. (I haven't tested it, though.)

The correct fix can only be to rename this variable here and in shell 
scripts that need the value that is set here.

-- Hannes
