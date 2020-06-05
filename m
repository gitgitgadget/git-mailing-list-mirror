Return-Path: <SRS0=KQVw=7S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF66C433DF
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 23:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 505BE2064C
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 23:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eMPRbEhu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbgFEXa1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Jun 2020 19:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728330AbgFEXa1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jun 2020 19:30:27 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA46C08C5C2
        for <git@vger.kernel.org>; Fri,  5 Jun 2020 16:30:26 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x11so4288957plv.9
        for <git@vger.kernel.org>; Fri, 05 Jun 2020 16:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=k99ecoMAkNXx8fgacp3sozpOuFRLnmOPoheTRCOTN4w=;
        b=eMPRbEhu7o49VnIcL1UxuHKZRmAayzQIn/k72/W0JkvxGMXn+JAFymUf0KXtfLfEbo
         meHMaBb26fDjcxtiwAvFsQgMdM0TVAY/t4Sy8WZbCLc2LwpXIvWbZkImJpgm2zMAZvO1
         LMEpC7SzvLMbbixEm4ysVqCy7OHnkVXMBJFI+FcUXsuEUCoDX7yhfdhLGJ2/lwXIaRTM
         B4azktluwcdECYxhhDpsUpPNWQzRtsPGjl93xEqZVeXlFw21LtymFAxZ0EMffWeuP9GJ
         8/E5E9ZKxUsWOUCScYfd8nWV4iT3e8oXUV3hCa3L9K0qpPk8vlrnhLl34EazS9Lxignk
         XvLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=k99ecoMAkNXx8fgacp3sozpOuFRLnmOPoheTRCOTN4w=;
        b=KggPlbBvEVwqKtsMbGgrAstFBuI3OeEjFnXyBfqUFKvE98Fx9cFdnU+lvkxIxnq6w/
         rWJRG5OHPTy2iBbXtPkSO3dakHCe/ryjV98O2b4yocNJF+wVdqvu/EbN9fY/cAGjFoCT
         7D+rBgbJcCxdT/5WwPElaGYFjKIcBgOq7dC4nmlQnWq31aNxikmtPrvpSUoJkPGT3hiv
         Pn2tH+pcHEvnRtROg4pLzljMgVx/4lC7/HgF+iYK1fso/dvWHj5+OkBN8ikwDedfPVg2
         j7wFkSnzfGO7HyGQ3WiFMv8i9iLsI1DHHzMJHmn8tMpBAzk5qzwgJbOtww9uma4wpPUS
         0GGA==
X-Gm-Message-State: AOAM530EaBSEpdAwGVB5JVePAvOyw4gMFfwN6+8I5NGwgs0inRWCnz+6
        hFLOLoYgbNINPzmV7irQIN+3Tw==
X-Google-Smtp-Source: ABdhPJzXJBejR5G3ilG2xVTVZ1gmH5CF36srD365p3/GjVEUx+TujeX7LUa4K1enhbL+LnMZynRWXQ==
X-Received: by 2002:a17:90a:fe83:: with SMTP id co3mr5381538pjb.204.1591399825812;
        Fri, 05 Jun 2020 16:30:25 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:ece8:7fe:c1f1:a20f])
        by smtp.gmail.com with ESMTPSA id q185sm590493pfb.82.2020.06.05.16.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 16:30:24 -0700 (PDT)
Date:   Fri, 5 Jun 2020 16:30:19 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fuzz-commit-graph: properly free graph struct
Message-ID: <20200605233019.GC65111@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
References: <35063a0ab4edbaa5bd5b0138e6a6a5b36a8664c5.1591397562.git.steadmon@google.com>
 <20200605230233.GA167014@google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
In-Reply-To: <20200605230233.GA167014@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 2020.06.05 16:02, Jonathan Nieder wrote:
> Josh Steadmon wrote:
> 
> > Use the provided free_commit_graph() to properly free the commit graph
> > in fuzz-commit-graph. Otherwise, the fuzzer itself leaks memory when the
> > struct contains pointers to allocated memory.
> >
> > Signed-off-by: Josh Steadmon <steadmon@google.com>
> > ---
> >  fuzz-commit-graph.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> How can I reproduce this?

Building the fuzzer is dependent on the exact versions of clang &
libFuzzer that you have installed; on my machine, with clang 9.0.1-10
and libFuzzer 9, I build as follows:

$ make CC=clang \
    CXX=clang++ \
    CFLAGS="-fsanitize=fuzzer-no-link,address" \
    LIB_FUZZING_ENGINE=/usr/lib/llvm-9/lib/libFuzzer.a \
    fuzz-all

Then you can run fuzz-commit-graph on the attached test case:

$ ./fuzz-commit-graph /tmp/testcase-fuzzer-leak

When built from master, I get a leak error:


$ ./fuzz-commit-graph /tmp/testcase-fuzzer-leak
INFO: Seed: 2332984289
INFO: Loaded 1 modules   (70798 inline 8-bit counters): 70798 [0x15c8b82, 0x15da010), 
INFO: Loaded 1 PC tables (70798 PCs): 70798 [0x12a7db8,0x13bc698), 
./fuzz-commit-graph: Running 1 inputs 1 time(s) each.
Running: /tmp/testcase-5725798091980800

=================================================================
==192153==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 12 byte(s) in 1 object(s) allocated from:
    #0 0x49be6d in malloc (/usr/local/google/home/steadmon/src/git/fuzz-commit-graph+0x49be6d)
    #1 0xc2ff15 in do_xmalloc (/usr/local/google/home/steadmon/src/git/fuzz-commit-graph+0xc2ff15)
    #2 0xc2fe66 in xmalloc (/usr/local/google/home/steadmon/src/git/fuzz-commit-graph+0xc2fe66)
    #3 0x5cfc4e in parse_commit_graph (/usr/local/google/home/steadmon/src/git/fuzz-commit-graph+0x5cfc4e)
    #4 0x1085b39 in LLVMFuzzerTestOneInput (/usr/local/google/home/steadmon/src/git/fuzz-commit-graph+0x1085b39)
    #5 0x109b41c in fuzzer::Fuzzer::ExecuteCallback(unsigned char const*, unsigned long) (/usr/local/google/home/steadmon/src/git/fuzz-commit-graph+0x109b41c)

SUMMARY: AddressSanitizer: 12 byte(s) leaked in 1 allocation(s).

INFO: a leak has been found in the initial corpus.

INFO: to ignore leaks on libFuzzer side use -detect_leaks=0.


When run with this patch, the fuzzer does not report a leak.


> > diff --git a/fuzz-commit-graph.c b/fuzz-commit-graph.c
> > index 9fd1c04edd..430817214d 100644
> > --- a/fuzz-commit-graph.c
> > +++ b/fuzz-commit-graph.c
> > @@ -12,7 +12,7 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
> >  	initialize_the_repository();
> >  	g = parse_commit_graph((void *)data, size);
> >  	repo_clear(the_repository);
> > -	free(g);
> > +	free_commit_graph(g);
> 
> In any event, the patch itself is sensible, so
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
> 
> Thanks.

--HcAYCG3uE/tztfnV
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=testcase-fuzzer-leak
Content-Transfer-Encoding: base64

Q0dQSAEBNP9GREdOAAAAAAAAADpFREdFAAAAAAAAAARPSURGAAAAAAAAAANfS01MAAAAAAAA
AE1PTkQ4AAAAAAAAAABCREFUAAAAAAAAAwBPSURMAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABDREFUAAAAAAAAAwBPLkRM
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAABCSURYAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAA
AAAGAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAABEs7pAAAAAAAAAAAAA/gAAAAAAAAAAAAAA
AAAAAAAAPQAAAAAAAAAAAAAAAAAAAAAAAAAAQ0dQSAEBRwRGRElPAAAAAAAAAAFCRUFUAAAA
AAAAAAAAAAAAAAAAAAAAAQAAAAAAEABPBAAAAAAAAAAAQklEWAAAAAAAAAAAAAAAACgAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADa2tra2tra2tra2tra2tra
2tra2tra2tra2tra2tra2tra2tra2tra2tra2tra2tra2tra2tra2tra2tra2tra2tra2tra
2tra2tra2tra2tra2toAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAENEQVQA
AAAAAAADAE8uREwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAADR0VZNACoAAAAAAAAAAAAAAAAHAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAABwAAAAAAAAAAAAAAAAAAAAA=

--HcAYCG3uE/tztfnV--
