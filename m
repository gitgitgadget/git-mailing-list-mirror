Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF2DC43334
	for <git@archiver.kernel.org>; Fri, 24 Jun 2022 15:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiFXP7D (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jun 2022 11:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiFXP7C (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jun 2022 11:59:02 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA5C52501
        for <git@vger.kernel.org>; Fri, 24 Jun 2022 08:59:00 -0700 (PDT)
Received: (Authenticated sender: contact@luigifab.fr)
        by mail.gandi.net (Postfix) with ESMTPSA id 99F1A100003;
        Fri, 24 Jun 2022 15:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=luigifab.fr; s=gm1;
        t=1656086339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FC0bHD83kRtyBZSWSzS7uRYZf1eEC/FGy8+2xyDIu5o=;
        b=drTHn1vj3CoE8Y8FqkTqCsinhKai5TMvQtRCu1XGAGwlhQcQ3ovuYi8cnnUUwGAJsZQ/I4
        ppebJMoK2hVTp91/3goRIoXaaEE07Anci2vKReQmMSAWw48oHj9ycsMlGk1J91OFBN8Ccy
        rHg2txx9Oocq99VH5Etu0J2/0CNRos6JftJHdDV1CI2sMvtc2g5rk/o9qj6LdmCqyWC9wg
        BZUYihX3qlAA1y/ENRa2u93/nVUB4P2TLERtmNY/XmHA5yts3FrS95b9y5aKVYIFz8yR8r
        0Fl2Vq6Ko7mD2QWMlsVWsFF2KBVkxmgQFpYYgOJad/zq3iHh6MF9vXV+ypKQzw==
Message-ID: <7c490fea-fa8a-0245-5b3f-981b8797a7cd@luigifab.fr>
Date:   Fri, 24 Jun 2022 17:58:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: git a/xyz or b/xyz
Content-Language: fr
To:     Konstantin Khomoutov <kostix@bswap.ru>
Cc:     git@vger.kernel.org
References: <b4f40821-8592-1a35-8b60-219fd7e29e9f@luigifab.fr>
 <20220620111230.ck7nkouzkviidtcu@carbon>
From:   Fabrice Creuzot <code@luigifab.fr>
In-Reply-To: <20220620111230.ck7nkouzkviidtcu@carbon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks! --no-prefix do the job.

Le 20/06/2022 à 13:12, Konstantin Khomoutov a écrit :
> On Sat, Jun 18, 2022 at 12:45:30PM +0200, Fabrice Creuzot wrote:
> 
>> When we are reading a "git diff", all paths are prefixed with "a/" and "b/".
>> Example:
>>
>> diff --git a/xyz
>> index 4aa4b5230..1c2b8b69e 100644
>> --- a/xyz
>> +++ b/xyz
>> @@ -1,7 +1,7 @@
>>
>>
>> With my terminal, I double click on the path to select the full path for
>> copy.
>>
>> Then, when I paste: "git log a/xyz",
>>   git says: unknown revision or path not in the working tree
>>
>> Ok, I need to remove the "a/" or "b/".
>> But, is git can understand that "a/xyz" is "xyz" because "a/xyz" does not
>> exist?
> 
> A quick answer: pass `git diff` the "--no-prefix" command-line option to
> suppress generation of these prefixes.
> 
> 
> A bit of historical context.
> 
> Please note that `git diff` - at least by default - generates its output using
> the format known as "unified diff" which was invented an implemented way
> before Git was concieved [1]. Quite probably on your system you have access to
> the two command line tools - `diff` and `patch`, - one of which generates
> diffs by comparing two files, and another one being able to update a file
> using a patch information produced by the former.
> 
> The diff format records the pathnames of the files compared when the patch
> data was generated.
> 
> Now consider that a patch file can describe changes to apply to any set of
> files. In order to achieve this, the format has to name the files to be used.
> 
> Now consider that the diff format can use used for two conceptually slightly
> different purposes:
> 
>   - A patch file in this format can describe a set of "concrete" changes.
> 
>     Say, you pass a patch file to someone, they just run `patch` on it and
>     that tool patches a set of files no matter where it was run from.
> 
>   - A patch file in this format can describe a set of changes intended to
>     be applied to a particular state of a file or a set of files, possibly
>     comprising a hierarchy, located anywhere in the target filesystem.
>     
>     A good example is a source tree of a software project: a user can fetch
>     a tarball with a software project and unpack it everywhere they wish.
>     They then should be able to apply a patch file to that unpacked tree.
> 
> Note that in the former case the names of the names of the files listed in a
> patch file may not share even the smallest common prefix while in the second
> case they will have the same prefix, and the prefix may not even be needed at
> all.
> 
> Historically the patch files to be used in the second case were generated by
> running a tool like `diff` against the two hierarchies of files: a source,
> unmodified directory, and the copy of that directly with the necessary
> modifications. That is, you'd run something like
> 
>    $ diff -u srcdir modified > changes.patch
> 
> and because of that the generated patch file would naturally contain file
> names starting with "srcdir/" and "modified/" prefixes.
> 
> The tool to apply patch files, `patch`, has a command-line option "-p" (for
> "prefix") which can be used to strip the specified number of prefix
> directories from the names of the files when applying a patch file. So to
> apply a patch generated by comparing two directory hierarchy you'd routinely
> pass "-p1" to that tool, like in
> 
>    $ cd srcdir
>    $ patch -p1 < changes.patch
> 
> 
> OK, so you can now note that `git diff` is different from the classical patch
> maniputation tools in that its operation is somewhat virtualized: by default
> it generates a patch describing the set of differences between the work tree
> and the index, and can be told to generate a patch between sets of files in
> named revisions and so on. So there's no two directories physically existing
> on the file system and so `git diff` generates fake prefixes.
> 
> Exactly why it does so by default, I don't know, but I suppose it's just to be
> in line with the classical use case explained above which was in widespread
> use before Git even existed.
> 
> 1. https://en.wikipedia.org/wiki/Diff#Unified_format
> 
