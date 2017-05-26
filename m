Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53ABE1FA14
	for <e@80x24.org>; Fri, 26 May 2017 15:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1947898AbdEZPYB (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 May 2017 11:24:01 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33272 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1947895AbdEZPX7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2017 11:23:59 -0400
Received: by mail-pf0-f196.google.com with SMTP id f27so3502592pfe.0
        for <git@vger.kernel.org>; Fri, 26 May 2017 08:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TD8acxIp28O6qe+BWI4bEK8kjJjOp2pYxU2/I4wl/cM=;
        b=C2qYPI3BueAToUq+ExUH3bRPqp3imQ2+JZZ2Xgm4FHeIZlANNlCYe8PlYOryIHu4tY
         iUMKTlG8kmQ/Tk76Op5ZPHbHhUV91qbkvumH2ca1XD74cdRadGhrGrjmTUwQFFiWsck6
         F6Z+EanddYIC4471+InUBE8VipSSN3bWraqZrniwZnUd2ZoQfVHCw2iRCY718eIyS356
         gvEKXtUncTqQz6fhBUlcEXV5Lnc2JzseJIAM9L6YktBvJmnP3eJJhildT4o9tkKS8stE
         PK7Ka1mogMqpPoeWRG0rpuAFkpCB4QBeeP36Fc5XAXsgiRPEJ2cMJUGEOkYcT6b4WRv7
         RpEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TD8acxIp28O6qe+BWI4bEK8kjJjOp2pYxU2/I4wl/cM=;
        b=JfnS1OwZ1nLP35x7k+DPYDXHxeHvwlMH/tzd1ltDy7keH94y3SBcHHmi2zStrX1lP+
         s5VEwNUFc0DhNWlc1SP12+zREYpenbvYu18z5DQRUy9zgSURdGAgSaFQbQb1rKdxls0K
         lEZ6hHl4hCaRRFacuUK1GPa9PaWrt6z95VJjPFi5Bf/aKEejDDmumyGaYd2yuGlUoOti
         UJhCoLSVITPwBppKC0eFveo8za5F0e8U7a5sKL0haxBUQy+r/9tnauncca6YNj7GrQir
         v3ikxG5jE6LzUuLkMB3fnX/EpJ2KE7hwkkaHvIKoP5JIgYC3eDhPCaDkZ2SlVPvcTAf8
         vK3g==
X-Gm-Message-State: AODbwcAfIN2wZXi+5Ig8DWS/naL/uNoXeQYvFD2sXPIjTKgf0EItFnEn
        Nb/NQ7PtRrJZRxi9AyQ=
X-Received: by 10.99.129.66 with SMTP id t63mr3068268pgd.224.1495811847478;
        Fri, 26 May 2017 08:17:27 -0700 (PDT)
Received: from prathampc-X550JX.domain.name ([116.73.73.225])
        by smtp.gmail.com with ESMTPSA id e24sm3105198pgn.1.2017.05.26.08.17.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 May 2017 08:17:26 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     bmwill@google.com, christian.couder@gmail.com,
        ramsay@ramsayjones.plus.com, sbeller@google.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH v5 1/3] submodule: fix buggy $path and $sm_path variable's value
Date:   Fri, 26 May 2017 20:47:11 +0530
Message-Id: <20170526151713.10974-1-pc44800@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170521125814.26255-2-pc44800@gmail.com>
References: <20170521125814.26255-2-pc44800@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

According to the documentation about git-submodule foreach subcommand's
$path variable:
$path is the name of the submodule directory relative to the superproject

But it was observed when the value of the $path value deviates from this
for the nested submodules when the <command> is run from a subdirectory.
This patch aims for its correction.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
---
This series of patch is based on gitster/jk/bug-to-abort for untilizing its 
BUG() macro.

The observation made was as follows:
For a project - super containing dir (not a submodule) and a submodule sub 
which contains another submodule subsub. When we run a command from super/dir:

git submodule foreach "echo \$path-\$sm_path"

actual results:
Entering '../sub'
../sub-../sub
Entering '../sub/subsub'
../subsub-../subsub

expected result wrt documentation and current test suite:
Entering '../sub'
sub-../sub
Entering '../sub/subsub'
subsub-../sub/subsub

This make the value of $path confusing and I also feel it deviates from its 
documentation:
$path is the name of the submodule directory relative to the superproject.
Hence, this patch corrects the value assigned to the $path and $sm_path.

 git-submodule.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index c0d0e9a4c..ea6f56337 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -344,9 +344,9 @@ cmd_foreach()
 				prefix="$prefix$sm_path/"
 				sanitize_submodule_env
 				cd "$sm_path" &&
-				sm_path=$(git submodule--helper relative-path "$sm_path" "$wt_prefix") &&
 				# we make $path available to scripts ...
 				path=$sm_path &&
+				sm_path=$displaypath &&
 				if test $# -eq 1
 				then
 					eval "$1"
-- 
2.11.0

