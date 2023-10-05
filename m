Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C582E92702
	for <git@archiver.kernel.org>; Thu,  5 Oct 2023 14:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbjJEO3I (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Oct 2023 10:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234072AbjJEO1L (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2023 10:27:11 -0400
Received: from mail.smrk.net (mail.smrk.net [IPv6:2001:19f0:6c01:2788:5400:4ff:fe27:adaa])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4C424871
        for <git@vger.kernel.org>; Thu,  5 Oct 2023 04:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smrk.net; s=20221002;
        t=1696504793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TyySmyxJFX9OoTIomsGEpyCYdxyKKJiX7lkMPqweBUo=;
        b=Yfeeaq6dvP0v3glJDAqh9oui2m7ZU+W+oSAwr25aRZQ70zaB6076stVeqV6QhRnyMM1dRM
        8Ex7ULcIh/T0/1xZmsbmAUnoQLxKndeygJ7iN3/+F1b4vNJt5wZ9T00VPIWp21xvnKCeK2
        +qud7Ip4SulgthtqCk1LHCcF4ruCPqDVnWpkERkoK6Qd6dsjbh4SY4gVx9kFzUVWFMbZKn
        xtadxM1kJkkYQtRVsRzlIXMRKZBFKj14uNMTCj2XWuGtSSNxLfIa1qOKBd3GbdftqHB26x
        AxTbDGU3EeU5eoVagruJnmnLOnkd/na+8jAgRIKDPcoZWfLbTuMsGyPtxhd8Fw==
Received: from localhost (<unknown> [192.168.5.2])
        by smrk (OpenSMTPD) with ESMTPSA id 9e887e9c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 5 Oct 2023 13:19:53 +0200 (CEST)
From:   =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@smrk.net>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, avarab@gmail.com
Subject: Re: [PATCH] doc/cat-file: clarify description regarding various
 command forms
In-Reply-To: <20231003200659.GC1562@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 3 Oct 2023 16:06:59 -0400")
References: <20231003082513.3003520-1-stepnem@smrk.net>
        <20231003200659.GC1562@coredump.intra.peff.net>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date:   Thu, 05 Oct 2023 13:20:18 +0200
Message-ID: <20231005132018+0200.47596-stepnem@smrk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 3 Oct 2023 16:06:59 -0400
Jeff King wrote:

>>  DESCRIPTION
>>  -----------
>> -In its first form, the command provides the content or the type of an o=
bject in
>> +This command can operate in two modes, depending on whether an option f=
rom
>> +the `--batch` family is specified.
>> +
>> +In non-batch mode, the command provides the content or the type of an o=
bject in
>>  the repository. The type is required unless `-t` or `-p` is used to fin=
d the
>>  object type, or `-s` is used to find the object size, or `--textconv` or
>>  `--filters` is used (which imply type "blob").
>
> The existing text here is already a bit vague, considering the number of
> operations it covers (like "-e", for example, which is not showing "the
> content or the type" at all). But that is not new in your patch, and it
> is maybe even OK to be a bit vague here, and let the OPTIONS section
> cover the specifics.

So how about we just butcher the DESCRIPTION completely; after all, the
information it gives is not quite correct (other than what you already
mentioned, e.g., -e is omitted in the "type not required" part; one is
left to wonder what <format> refers to: you have to go read the OPTIONS
and BATCH OUTPUT sections anyway), and the correct parts only duplicate
information given in the following sections, providing opportunities to
become out of date when the command and its documentation evolve:

Changes (if we agree this is the way to go, I'll also update the --help
output):
  synopsis:
    - move the (--textconv | --filters) form before --batch, closer
      to the other non-batch forms
    - cosmetics: swap -t and -s, --filters and --textconv (sort
      alphabetically)
  description:
    - reformulate, omit vague/imprecise information better
      provided in the detailed options list

SYNOPSIS
    git cat-file <type> <object>
    git cat-file (-e | -p) <object>
    git cat-file (-s | -t) [--allow-unknown-type] <object>
    git cat-file (--filters | --textconv)
                 [<rev>:<path|tree-ish> | --path=3D<path|tree-ish> <rev>]
    git cat-file (--batch | --batch-check | --batch-command) [--batch-all-o=
bjects]
                 [--buffer] [--follow-symlinks] [--unordered]
                 [--filters | --textconv] [-Z]

DESCRIPTION
    This command can operate in two modes, depending on whether an
    option from the --batch family is specified.

    In non-batch mode, the command provides information on an object
    named on the command line.

    In batch mode, arguments are read from standard input.

[That's all for a summary, read the following sections for details.]

>> -In the second form, a list of objects (separated by linefeeds) is provi=
ded on
>> +In batch mode, a list of objects (separated by linefeeds) is provided on
>>  stdin, and the SHA-1, type, and size of each object is printed on stdou=
t. The
>>  output format can be overridden using the optional `<format>` argument.=
 If
>>  either `--textconv` or `--filters` was specified, the input is expected=
 to
>
> I think this got a bit inaccurate with "--batch-command", which is a
> whole different mode itself compared to --batch and --batch-check. I
> don't think your patch is really making anything worse, but arguably
> there are three "major modes" here.

This is not obvious to me (the "three major modes" part).  AIUI it's
still mainly a batch (read from stdin) vs. non-batch (args on command
line) dichotomy.  The details differ (just args vs. command + args), but
so does e.g. -e differ in providing information via exit code rather
than stdout.

(But please note I'm not trying to pose as an expert here: this all
started with me coming to git-cat-file(1) to _learn_ about cat-file
and finding the description more than a little confusing.)

--=20
=C5=A0t=C4=9Bp=C3=A1n
