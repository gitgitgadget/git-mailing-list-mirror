Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0556E1F404
	for <e@80x24.org>; Tue, 27 Mar 2018 03:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751840AbeC0DS0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 23:18:26 -0400
Received: from avasout04.plus.net ([212.159.14.19]:56677 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751249AbeC0DSZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 23:18:25 -0400
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id 0f7ufqTXAsD7b0f7vfDfY3; Tue, 27 Mar 2018 04:18:24 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=CvORjEwD c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=bt3WUTiwAAAA:8 a=yMhMjlubAAAA:8 a=sUX920SBAAAA:8
 a=EBOSESyhAAAA:8 a=B9cyP-JphD63wTbySoMA:9 a=QEXdDO2ut3YA:10
 a=OXx4ngWzwLx9h_IvVXMu:22 a=egVJUTT-lD9PU5ZP4Sin:22 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v4] json_writer: new routines to create data in JSON
 format
To:     git@jeffhostetler.com, git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, l.s.r@web.de, wink@saville.com,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20180326143136.47116-1-git@jeffhostetler.com>
 <20180326143136.47116-2-git@jeffhostetler.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <ce076d5e-f30f-006e-a25e-ff1a900562bf@ramsayjones.plus.com>
Date:   Tue, 27 Mar 2018 04:18:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180326143136.47116-2-git@jeffhostetler.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfD0E4Hfskf+5eIVFemn7Re0W91u9/Z494uW8NUeQ5slQ+SZp5P8ow8KqmJOrF64YUnI37A0JGTvY0WaxYP2TcnGlrCRNK/55dQhwe1DQH0e/s4foGt9b
 wTu92TTmyksQh2cdJGkStLyVo++7kNOv7Pv/dOcvUHipLE+2QaLg8vG/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 26/03/18 15:31, git@jeffhostetler.com wrote:
> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Add a series of jw_ routines and "struct json_writer" structure to compose
> JSON data.  The resulting string data can then be output by commands wanting
> to support a JSON output format.
> 
> The json-writer routines can be used to generate structured data in a
> JSON-like format.  We say "JSON-like" because we do not enforce the Unicode
> (usually UTF-8) requirement on string fields.  Internally, Git does not
> necessarily have Unicode/UTF-8 data for most fields, so it is currently
> unclear the best way to enforce that requirement.  For example, on Linx
> pathnames can contain arbitrary 8-bit character data, so a command like
> "status" would not know how to encode the reported pathnames.  We may want
> to revisit this (or double encode such strings) in the future.
> 
> The initial use for the json-writer routines is for generating telemetry
> data for executed Git commands.  Later, we may want to use them in other
> commands, such as status.
> 
> Helped-by: René Scharfe <l.s.r@web.de>
> Helped-by: Wink Saville <wink@saville.com>
> Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  Makefile                    |   2 +
>  json-writer.c               | 395 +++++++++++++++++++++++++++++
>  json-writer.h               |  92 +++++++
>  t/helper/test-json-writer.c | 590 ++++++++++++++++++++++++++++++++++++++++++++
>  t/t0019-json-writer.sh      | 253 +++++++++++++++++++
>  5 files changed, 1332 insertions(+)
>  create mode 100644 json-writer.c
>  create mode 100644 json-writer.h
>  create mode 100644 t/helper/test-json-writer.c
>  create mode 100755 t/t0019-json-writer.sh
> 
[snip]

Thanks, this version fixes all issues I had (with the compilation
and sparse warnings).

[Was using UINT64_C(0xffffffffffffffff) a problem on windows?]

ATB,
Ramsay Jones


