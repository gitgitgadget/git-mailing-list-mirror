Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD46C433EF
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 21:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A92D610E7
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 21:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbhJTVdl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 17:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhJTVdk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 17:33:40 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09DCC06161C
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 14:31:25 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id i6so6433974ila.12
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 14:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=TDyd8Kb1YhLXxKOJ4PvbXSOe75mf3eqA+kGElTH0D1g=;
        b=OK80ifPklE5WlHJTMRDoxME1X2FQ5yqZrQbqUhKa03bsc8ViY0l0n4zp7arAZT0OxH
         S15hEtu5tsqMGWxHB0pYz6AfAI32yr1pxmeA0iCWFk/8ynzW3WFknNdkI0SKe/7Ob98A
         EK2VSVvFcoSbPq3HwLVCT9QnB9FbjLFTktwXx/S3IZ632lN+01i1SbnRJhGShm48PvrS
         4rEC4SC7haQ675Mxu1fU1lWovnjEwA13eQLgVuGgrPIuDoCFxMaUNJ5makQS4o0z3yFE
         fagN3rCtUA4flLPVBEYd7rBGAC7OgrDovs/49vMcmatVfXvqAqY0habGHKEMhY6h+s3A
         Cbcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=TDyd8Kb1YhLXxKOJ4PvbXSOe75mf3eqA+kGElTH0D1g=;
        b=YxtvY6TO58g/mxJX0Bxf07r+rxyoEeX4o3kN3BwntZuayMUPb+eW6BItwa3rQ/fP52
         5aSQr4NGjfE3dsrlLmZxpiOEyRdrahIjriuL5FjSEYw0ebmx3/tASjjzecp4vYqanG6/
         IGB4PsJRqU/lpp7c037Qk7kHYuTtGWd/S3z4EhbF7emCp4AITx3nda4hFOxBwzPv+z7F
         /DMipsA1yuvQKRGmhxzhYh7Lreygabf8I5vZ3r8/my2Lt4OVmjOyrlQsafHaNdrl+g0l
         qmE8WppgZGEp7okNXcIP6kDoSM9vsdE3ur8BQHhViK3XDkgPZTkd46LuAM1JQXChRKGP
         i9lg==
X-Gm-Message-State: AOAM530yWLVLEGTUimDKz+16sbwymn9cZVzggPxVksEQjqUXS2qRFkLO
        jjjJ9ld+0cF26Dnel/rBcOLIew==
X-Google-Smtp-Source: ABdhPJwO4hzwje6mUXQyeSurcGPxoMzDLZ/XNDC0BjQfQZi3pdvUjOih1BYo1J8j55UGYcsqd61F7w==
X-Received: by 2002:a92:cd8e:: with SMTP id r14mr931651ilb.291.1634765485216;
        Wed, 20 Oct 2021 14:31:25 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id n3sm1692116ili.37.2021.10.20.14.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 14:31:24 -0700 (PDT)
Date:   Wed, 20 Oct 2021 17:31:20 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
Subject: Re: [PATCH 0/8] Makefile: make command-list.h 2-5x as fast with -jN
Message-ID: <YXCKqAEwtwFozWk6@nand.local>
References: <YNqBtrXzUlJiuc7y@coredump.intra.peff.net>
 <cover-0.8-00000000000-20211020T183533Z-avarab@gmail.com>
 <YXB9moNHRj+nrnX9@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YXB9moNHRj+nrnX9@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 20, 2021 at 04:35:38PM -0400, Jeff King wrote:
> On Wed, Oct 20, 2021 at 08:39:51PM +0200, Ævar Arnfjörð Bjarmason wrote:
>
> > This series is based off an off-hand comment I made about making the
> > cmdlist.sh faster, in the meantime much of the same methods are
> > already cooking in "next" for the "lint-docs" target.
> >
> > See 7/8 for the main performance numbers, along the way I stole some
> > patches from Johannes Sixt who'd worked on optimizing the script
> > before, which compliment this new method of generating this file by
> > piggy-backing more on GNU make for managing a dependency graph for us.
>
> I still think this is a much more complicated and error-prone approach
> than just making the script faster. I know we can't rely on perl, but
> could we use it optimistically?

I'll take credit for this terrible idea of using Perl when available.

But I don't think we even need to, since we could just rely on Awk. That
has all the benefits you described while still avoiding the circular
dependency on libgit.a. But the killer feature is that we don't have to
rely on two implementations, the lesser-used of which is likely to
bitrot over time.

The resulting awk is a little ugly, because of the nested-ness. I'm also
no awk-spert, but I think that something like the below gets the job
done.

It also has the benefit of being slightly faster than the equivalent
Perl implementation, for whatever those extra ~9 ms are worth ;).

Benchmark #1: sh generate-cmdlist.sh command-list.txt
  Time (mean ± σ):      25.3 ms ±   5.3 ms    [User: 31.1 ms, System: 8.3 ms]
  Range (min … max):    15.5 ms …  31.7 ms    95 runs

Benchmark #2: sh generate-cmdlist.sh.old command-list.txt
  Time (mean ± σ):      34.9 ms ±   9.8 ms    [User: 41.0 ms, System: 6.9 ms]
  Range (min … max):    22.4 ms …  54.8 ms    64 runs

Summary
  'sh generate-cmdlist.sh command-list.txt' ran
    1.38 ± 0.49 times faster than 'sh generate-cmdlist.sh.old command-list.txt'

---

diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index a1ab2b1f07..39338ef1cc 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -64,12 +64,19 @@ print_command_list () {
 	echo "static struct cmdname_help command_list[] = {"

 	command_list "$1" |
-	while read cmd rest
-	do
-		printf "	{ \"$cmd\", $(get_synopsis $cmd), 0"
-		printf " | CAT_%s" $(echo "$rest" | get_category_line)
-		echo " },"
-	done
+	awk '{
+		f="Documentation/" $1 ".txt"
+		while((getline line<f) > 0) {
+			if (match(line, "^" $1 " - ")) {
+				syn=substr(line, RLENGTH+1)
+				printf "\t{ \"%s\", N_(\"%s\"), 0", $1, syn
+				for (i=2; i<=NF; i++) {
+					printf " | CAT_%s", $i
+				}
+				print " },"
+			}
+		}
+	}'
 	echo "};"
 }
