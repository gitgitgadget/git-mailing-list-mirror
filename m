From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/7] submodule: implement `module_list` as a builtin helper
Date: Wed, 19 Aug 2015 11:22:02 -0700
Message-ID: <xmqqfv3f9m0l.fsf@gitster.dls.corp.google.com>
References: <1439857323-21048-1-git-send-email-sbeller@google.com>
	<1439857323-21048-6-git-send-email-sbeller@google.com>
	<xmqqpp2j9m7g.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, hvoigt@hvoigt.net
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Aug 19 20:22:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZS803-000851-6E
	for gcvg-git-2@plane.gmane.org; Wed, 19 Aug 2015 20:22:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751915AbbHSSWF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2015 14:22:05 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:32939 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751804AbbHSSWE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2015 14:22:04 -0400
Received: by padfo6 with SMTP id fo6so2246265pad.0
        for <git@vger.kernel.org>; Wed, 19 Aug 2015 11:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=0UnlCWgwlChO3UpHdBO2YkdU+A+2JQE/oVhfBu6ZzgA=;
        b=wrDOKlNbMDiZjsvMJq1kgEq3u/+QXueg2Iq6ry9F9uRaN/BxdLHuZUNFyhzZu2BqQG
         RsaaRIep+t+G2WkNaNEztwtu3LH0rd8fBRlvOwPVnkxdUGDI9Uy7ovlAe4w8ekMXd7Ya
         7vGVpvYfAc14tWEJCOA8Msa+UKXhpWwdtVnPDYnOiWiipEitSoy7sUBoI4s/20RLy+Fy
         ij500VnnleuulsWiLa+RgGdc/RCOYMUjQ2wUUAIU5DW6nFRF+6YPEr6Ut6+efiemTfWL
         ixdCBxMXh4HupHXj71C2YLUUpoEG2Cyxt59fRRq3OYguIiV7kb6GANQ3JwEFjWagc5zN
         xo/A==
X-Received: by 10.66.144.40 with SMTP id sj8mr27026625pab.55.1440008523565;
        Wed, 19 Aug 2015 11:22:03 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a5d7:91a5:eac5:b635])
        by smtp.gmail.com with ESMTPSA id la4sm1618315pbc.76.2015.08.19.11.22.02
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 19 Aug 2015 11:22:02 -0700 (PDT)
In-Reply-To: <xmqqpp2j9m7g.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 19 Aug 2015 11:17:55 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276210>

Junio C Hamano <gitster@pobox.com> writes:

> Micronit.  Even though multiplication is commutative, the order of
> arguments to xcalloc() looks odd.  It lets you say "I want an array
> with nmemb elements, and each of its is size-bytes long" by giving
> it nmemb and then size.

Unrelated tangent, but while I have output from "git grep 'calloc.*pathspec'"
on my screen... ;-)

 builtin/checkout.c | 2 +-
 builtin/ls-files.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 7ea533e..e3b28e4 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -283,7 +283,7 @@ static int checkout_paths(const struct checkout_opts *opts,
 	if (opts->source_tree)
 		read_tree_some(opts->source_tree, &opts->pathspec);
 
-	ps_matched = xcalloc(1, opts->pathspec.nr);
+	ps_matched = xcalloc(opts->pathspec.nr, 1);
 
 	/*
 	 * Make sure all pathspecs participated in locating the paths
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 6fa2205..b6a7cb0 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -516,7 +516,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 
 	/* Treat unmatching pathspec elements as errors */
 	if (pathspec.nr && error_unmatch)
-		ps_matched = xcalloc(1, pathspec.nr);
+		ps_matched = xcalloc(pathspec.nr, 1);
 
 	if ((dir.flags & DIR_SHOW_IGNORED) && !exc_given)
 		die("ls-files --ignored needs some exclude pattern");
