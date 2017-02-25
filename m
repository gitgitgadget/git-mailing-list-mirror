Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A776201A9
	for <e@80x24.org>; Sat, 25 Feb 2017 01:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751474AbdBYBbx (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 20:31:53 -0500
Received: from mail-pg0-f48.google.com ([74.125.83.48]:35022 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751424AbdBYBbw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 20:31:52 -0500
Received: by mail-pg0-f48.google.com with SMTP id b129so18103938pgc.2
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 17:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KCBunLyoVT/wTg45dzMSd2oirhcOd+C2P6/ZiAalU28=;
        b=k+Cq4SLBEB80LA17S8QhHV25LrnCBGiBl6GjaSxC21c4ZiQqdXkiiPBkhc8NxP2P2B
         BJJYnmoSzxATg+/0nh7UgQ11fWaBy6dtpDgEL7BaJa1w7VYBXQTrssLZdEnXumIEMtSV
         08jhoCRvI/S/JKr1togtNrnxwrRN8pl3PRqZYKZOnWGGArhzNDjMRWGT4siulWrY6sJf
         XH+zhDUBEL75+1p1HKirvoUHy4Oi2hxuwIWPQ19mXbtndzZuBmgWBVgS4MIOyEO11BOg
         FnQlpQgGx2ByIoq0I1xy0OJpxqkfEN3MzTZ89jkHwzd3RScyZUykt35S0/yh3MyXwRxq
         efZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KCBunLyoVT/wTg45dzMSd2oirhcOd+C2P6/ZiAalU28=;
        b=meNQS72BRmnDL7AdtbJvz2lmYgt57eg73ThO1vrt+vvBoASsxs7bjVOx6MSWE4iLa4
         +rRn2deb+QOL+7OCWZGM8rs9q54eCACLXuMZrGrb7a/WN6MP7fHUIC1byhVySW6b8ehV
         V+1FjoqfLwJh1jjmZrgDDNsQh6Vsk78goML+o9eHJxUl1JkCDNHlW7Hh0aWESUCC56FR
         pu6fDB/wVMfyooZS6+yfmSmsL0MofyNEaJuYRbQsHr1i8VHVrLE2bJnGbxGBbeuhL3MX
         sbqbnxzP4EdYvbpYGQJQZlTlyV29pG++u9s81MVL+DGgRNQnkpfgHXm6kBmIYpUMGB4g
         9MUA==
X-Gm-Message-State: AMke39mLV5ee3jMDkunLlpVP0+Ll5D6A1ydTunQInQCM/yoloOo9UObqpFYGP5EFpXuRh0S3
X-Received: by 10.84.140.36 with SMTP id 33mr8074168pls.136.1487986311178;
        Fri, 24 Feb 2017 17:31:51 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:2d9e:d4fd:456:fee4])
        by smtp.gmail.com with ESMTPSA id f3sm17250321pga.34.2017.02.24.17.31.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 24 Feb 2017 17:31:50 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     j6t@kdbg.org
Cc:     git@vger.kernel.org, philipoakley@iee.org, gitster@pobox.com,
        sop@google.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH] submodule init: warn about falling back to a local path
Date:   Fri, 24 Feb 2017 17:31:47 -0800
Message-Id: <20170225013147.23663-1-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.16.ge4278d41a0.dirty
In-Reply-To: <CAGZ79kbzhHaV4-cVvqwodwXSBstRfH1FrOh=iYMvU6cqYUcUng@mail.gmail.com>
References: <CAGZ79kbzhHaV4-cVvqwodwXSBstRfH1FrOh=iYMvU6cqYUcUng@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a submodule is initialized, the config variable 'submodule.<name>.url'
is set depending on the value of the same variable in the .gitmodules
file. When the URL indicates to be relative, then the url is computed
relative to its default remote. The default remote cannot be determined
accurately in all cases, such that it falls back to 'origin'.

The 'origin' remote may not exist, though. In that case we give up looking
for a suitable remote and we'll just assume it to be a local relative path.

This can be confusing to users as there is a lot of guessing involved,
which is not obvious to the user.

So in the corner case of assuming a local autoritative truth, warn the
user to lessen the confusion.

This behavior was introduced in 4d6893200 (submodule add: allow relative
repository path even when no url is set, 2011-06-06), which shared the
code with submodule-init and then ported to C in 3604242f080a (submodule:
port init from shell to C, 2016-04-15).

In case of submodule-add, this behavior makes sense in some use cases[1],
however for submodule-init there does not seem to be an immediate obvious
use case to fall back to a local submodule. However there might be, so
warn instead of die here.

While adding the warning, also clarify the behavior of relative URLs in
the documentation.

[1] e.g. http://stackoverflow.com/questions/8721984/git-ignore-files-for-public-repository-but-not-for-private
"store a secret locally in a submodule, with no intention to publish it"

Reported-by: Shawn Pearce <spearce@spearce.org>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

> Perhaps s/ all submodules/,&/?

done

> I read this as "copying..., resolving relative to the default remote
> (if exists)."

reworded with shorter sentences:
  Initialize the submodules recorded in the index (which were
  added and committed elsewhere) by setting `submodule.$name.url`
  in .git/config. It uses the same setting from .gitmodules as
  a template. If the URL is relative, it will be resolved using
  the default remote. If there is no default remote, the current
  repository will be assumed to be upstream.
...
   next paragraph
  

 Documentation/git-submodule.txt | 38 ++++++++++++++++++++++++--------------
 builtin/submodule--helper.c     |  8 +++-----
 2 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 8acc72ebb8..e05d0cddef 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -73,13 +73,17 @@ configuration entries unless `--name` is used to specify a logical name.
 +
 <repository> is the URL of the new submodule's origin repository.
 This may be either an absolute URL, or (if it begins with ./
-or ../), the location relative to the superproject's origin
+or ../), the location relative to the superproject's default remote
 repository (Please note that to specify a repository 'foo.git'
 which is located right next to a superproject 'bar.git', you'll
 have to use '../foo.git' instead of './foo.git' - as one might expect
 when following the rules for relative URLs - because the evaluation
 of relative URLs in Git is identical to that of relative directories).
-If the superproject doesn't have an origin configured
++
+The default remote is the remote of the remote tracking branch
+of the current branch. If no such remote tracking branch exists or
+the HEAD is detached, "origin" is assumed to be the default remote.
+If the superproject doesn't have a default remote configured
 the superproject is its own authoritative upstream and the current
 working directory is used instead.
 +
@@ -118,18 +122,24 @@ too (and can also report changes to a submodule's work tree).
 
 init [--] [<path>...]::
 	Initialize the submodules recorded in the index (which were
-	added and committed elsewhere) by copying submodule
-	names and urls from .gitmodules to .git/config.
-	Optional <path> arguments limit which submodules will be initialized.
-	It will also copy the value of `submodule.$name.update` into
-	.git/config.
-	The key used in .git/config is `submodule.$name.url`.
-	This command does not alter existing information in .git/config.
-	You can then customize the submodule clone URLs in .git/config
-	for your local setup and proceed to `git submodule update`;
-	you can also just use `git submodule update --init` without
-	the explicit 'init' step if you do not intend to customize
-	any submodule locations.
+	added and committed elsewhere) by setting `submodule.$name.url`
+	in .git/config. It uses the same setting from .gitmodules as
+	a template. If the URL is relative, it will be resolved using
+	the default remote. If there is no default remote, the current
+	repository will be assumed to be upstream.
++
+Optional <path> arguments limit which submodules will be initialized.
+If no path is specified, all submodules are initialized.
++
+When present, it will also copy the value of `submodule.$name.update`.
+This command does not alter existing information in .git/config.
+You can then customize the submodule clone URLs in .git/config
+for your local setup and proceed to `git submodule update`;
+you can also just use `git submodule update --init` without
+the explicit 'init' step if you do not intend to customize
+any submodule locations.
++
+See the add subcommand for the defintion of default remote.
 
 deinit [-f|--force] (--all|[--] <path>...)::
 	Unregister the given submodules, i.e. remove the whole
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 899dc334e3..15a5430c00 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -356,12 +356,10 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 			strbuf_addf(&remotesb, "remote.%s.url", remote);
 			free(remote);
 
-			if (git_config_get_string(remotesb.buf, &remoteurl))
-				/*
-				 * The repository is its own
-				 * authoritative upstream
-				 */
+			if (git_config_get_string(remotesb.buf, &remoteurl)) {
+				warning(_("could not lookup configuration '%s'. Assuming this repository is its own authoritative upstream."), remotesb.buf);
 				remoteurl = xgetcwd();
+			}
 			relurl = relative_url(remoteurl, url, NULL);
 			strbuf_release(&remotesb);
 			free(remoteurl);
-- 
2.12.0.rc1.16.ge4278d41a0.dirty

