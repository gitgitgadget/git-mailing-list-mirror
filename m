Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 634B7202A3
	for <e@80x24.org>; Tue, 17 Oct 2017 07:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932721AbdJQHKE (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Oct 2017 03:10:04 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:52794 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932382AbdJQHKD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Oct 2017 03:10:03 -0400
Received: by mail-io0-f195.google.com with SMTP id f20so1136164ioj.9
        for <git@vger.kernel.org>; Tue, 17 Oct 2017 00:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NdcSOUkUwx55CRZLIUjO2KT7edZBhzBHPPLNp0MLu9k=;
        b=pxs4HkxksbZ26cmxZgiUaut27iVSNqsrl61zVSrKFpTVQt+njt5AlhWZ7jhZvA3JfI
         tcbjKoCkAyEpPVRJW53cMsSHdwchQhX0ZBZ6Usr77NtBN0mpBb/cPCKt7KyxVpW/pbLC
         9/snmOnj8XZ6+6QmM/KugEndR8ccgjUOpgnVu/aOWNrXMAAiIqFP9Aj6MRotTtTJ+gwi
         BDuIplba2aq1xpLsHZseuPDYWtf8NlrhD1TVw1+z7U8kNNUS/PqSnZTDrS3XrLE0danD
         VLb5IT792GSEvuduRwm/AUxJMbPUHZuBqXR1Tav+wWud+cUQnGoG+8HU8J9K0mPSMOrB
         BtaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NdcSOUkUwx55CRZLIUjO2KT7edZBhzBHPPLNp0MLu9k=;
        b=jfS2EiInzW4mCQSffwyCZJgC/C1FVNsq2WBu15I9VG5SgBCq+b1G1f20iShi2NWgNU
         pZxyWTAOHWIgFUBTIU1NvsY5SXtftCukKoLfJZ8g0qxYaXF7gf8/BoUAhoVcAc5i22NZ
         vA6XVds2Ko0N/7VndigSRWwk90jUfmLHIGOryFjP0r88mWFMhAquNnup7ZkD4h9MXQgH
         Leq+9MMX5+c5IoIUjVHyHX6yOVMMp25agzws3XW+qiFbIYfEWPc9rK49z2COaWyf6Xll
         /H0FAxyp6VMrVxjekknUqF056AWlyNr2NBn9q/4Ew7sB9TZF2EDzX3+x3NmzCtOs/x6D
         Kxjw==
X-Gm-Message-State: AMCzsaWzrFH2qaho9HlekrbVemnAjLQxMXEUueYxsJ6GaSka8MVt4NbS
        tbfzmhVNblGLfWML18/+IqQ=
X-Google-Smtp-Source: AOwi7QAvYcyYDwmJe9BxLpmTR8IEDeHMKpsIXKFkKlvZTszKJloY1iLrwWQZEUoqe+n4lGiuxEHEaA==
X-Received: by 10.107.147.67 with SMTP id v64mr15006867iod.211.1508224202735;
        Tue, 17 Oct 2017 00:10:02 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id l65sm635107itb.6.2017.10.17.00.10.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Oct 2017 00:10:02 -0700 (PDT)
Date:   Tue, 17 Oct 2017 00:10:00 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Marko Kungla <marko.kungla@gmail.com>,
        git@vger.kernel.org
Subject: [PATCH 2/3] check-ref-format --branch: strip refs/heads/ using
 skip_prefix
Message-ID: <20171017071000.ms2jearljljhxtgm@aiede.mtv.corp.google.com>
References: <20170717172709.GL93855@aiede.mtv.corp.google.com>
 <20170817102217.3yw7uxnkupdy3lh5@sigill.intra.peff.net>
 <xmqqinffsibr.fsf@gitster.mtv.corp.google.com>
 <xmqq1sm3s751.fsf@gitster.mtv.corp.google.com>
 <20171016224512.6fhtce5anmff577b@sigill.intra.peff.net>
 <xmqqbml6r2js.fsf@gitster.mtv.corp.google.com>
 <20171017024203.6hqzy2paed6fyvym@sigill.intra.peff.net>
 <xmqqo9p6phxg.fsf@gitster.mtv.corp.google.com>
 <xmqq7evupemj.fsf@gitster.mtv.corp.google.com>
 <20171017070619.bdgvujmbw4uxvwle@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171017070619.bdgvujmbw4uxvwle@aiede.mtv.corp.google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

The expansion returned from strbuf_check_branch_ref always starts with
"refs/heads/" by construction, but there is nothing about its name or
advertised API making that obvious.  This command is used to process
human-supplied input from the command line and is usually not the
inner loop, so we can spare some cycles to be more defensive.  Instead
of hard-coding the offset strlen("refs/heads/") to skip, verify that
the expansion actually starts with refs/heads/.

[jn: split out from a larger patch, added explanation]

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/check-ref-format.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/check-ref-format.c b/builtin/check-ref-format.c
index 6c40ff110b..bc67d3f0a8 100644
--- a/builtin/check-ref-format.c
+++ b/builtin/check-ref-format.c
@@ -39,12 +39,14 @@ static char *collapse_slashes(const char *refname)
 static int check_ref_format_branch(const char *arg)
 {
 	struct strbuf sb = STRBUF_INIT;
+	const char *name;
 	int nongit;
 
 	setup_git_directory_gently(&nongit);
-	if (strbuf_check_branch_ref(&sb, arg))
+	if (strbuf_check_branch_ref(&sb, arg) ||
+	    !skip_prefix(sb.buf, "refs/heads/", &name))
 		die("'%s' is not a valid branch name", arg);
-	printf("%s\n", sb.buf + 11);
+	printf("%s\n", name);
 	strbuf_release(&sb);
 	return 0;
 }
-- 
2.15.0.rc1.287.g2b38de12cc

