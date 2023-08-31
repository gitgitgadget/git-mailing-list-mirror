Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A70C83F32
	for <git@archiver.kernel.org>; Thu, 31 Aug 2023 17:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244878AbjHaRKf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Aug 2023 13:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237542AbjHaRKe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2023 13:10:34 -0400
Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C546A3
        for <git@vger.kernel.org>; Thu, 31 Aug 2023 10:10:31 -0700 (PDT)
Received: from [192.168.0.106] (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 4Rc72s1nrfz5tlC;
        Thu, 31 Aug 2023 19:10:28 +0200 (CEST)
Message-ID: <defa2a66-598e-4721-a644-680de0116dec@kdbg.org>
Date:   Thu, 31 Aug 2023 19:10:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Problem: `fatal: too-short tree object` when executing
 hash-object on tree
To:     Gareth Hayes <gareth.hayes@bitcoin.org.hk>
References: <0de414f8-f409-467f-a504-06a78f088981@app.fastmail.com>
Content-Language: en-US
From:   Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org
In-Reply-To: <0de414f8-f409-467f-a504-06a78f088981@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 31.08.23 um 12:58 schrieb Gareth Hayes:
> Problem: I'm trying to reproduce the identifier of a tree object using `git cat-file -p <tree object identifier> | git hash-object -t tree --stdin`

XY-problem alert!?

> This results in an error:
> `fatal: too-short tree object`
> 
> To replicate: 
> `git cat-file -p HEAD`
> `git cat-file -p <tree object identifier from output of above> | git hash-object -t tree --stdin`
> 
> This works for other object types but not trees. What am I doing wrong?

Recall that the -p in cat-file means "pretty" (-print). The data that
makes up a tree object is far from pretty, hence, you can't feed it into
git hash-object directly.

You can either turn the pretty-printed input into a tree object

   git cat-file -p $treeoid | git mktree

or hash the raw data

   git cat-file tree $treeoid | git hash-object -t tree --stdin


-- Hannes

