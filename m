From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 6/3] revert: remove --reset compatibility option
Date: Tue, 22 Nov 2011 05:20:46 -0600
Message-ID: <20111122112046.GG7399@elie.hsd1.il.comcast.net>
References: <20111120073059.GA2278@elie.hsd1.il.comcast.net>
 <CALkWK0=45OwcBoH2TorsgwTbaXjnffVuh0mGxh2+ShN9cuF-=A@mail.gmail.com>
 <20111120094650.GB2278@elie.hsd1.il.comcast.net>
 <20111122111207.GA7399@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Phil Hord <phil.hord@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 22 12:20:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSoPL-0003u0-59
	for gcvg-git-2@lo.gmane.org; Tue, 22 Nov 2011 12:20:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758341Ab1KVLUu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Nov 2011 06:20:50 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:47913 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754839Ab1KVLUu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2011 06:20:50 -0500
Received: by iage36 with SMTP id e36so40722iag.19
        for <git@vger.kernel.org>; Tue, 22 Nov 2011 03:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=cNOPWFcxrW8epOgPexR9erKQtnO3cRznHRX7BGJyMsM=;
        b=gxw5h6UBiNyzoA06RrL82tbjv/PSKSVCCECrWmjwa/fT8RbYbyStEmNU18CfB0LfgF
         rKsSKkSVhUTA72FUYOMDiAge5dG5hnVDIR4Sp9bWJn/dZFuD5yyzf5Pp1mY03cQL8l9M
         KQ9nkdJiKNSDbmyscTQYLs+N1Jr32nso1WylY=
Received: by 10.231.63.209 with SMTP id c17mr4810778ibi.65.1321960849573;
        Tue, 22 Nov 2011 03:20:49 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id eb23sm58779443ibb.2.2011.11.22.03.20.48
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Nov 2011 03:20:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20111122111207.GA7399@elie.hsd1.il.comcast.net>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185787>

Remove the "git cherry-pick --reset" option, which has a different
preferred spelling nowadays ("--quit").  Luckily the old --reset name
was not around long enough for anyone to get used to it.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Thanks for reading.

 builtin/revert.c                |    3 ---
 t/t3510-cherry-pick-sequence.sh |    4 ++--
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 70a5fbb6..0c61668b 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -154,9 +154,6 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 		OPT_STRING(0, "strategy", &opts->strategy, "strategy", "merge strategy"),
 		OPT_CALLBACK('X', "strategy-option", &opts, "option",
 			"option for merge strategy", option_parse_x),
-		{ OPTION_BOOLEAN, 0, "reset", &remove_state, NULL,
-			"alias for --quit (deprecated)",
-			PARSE_OPT_HIDDEN | PARSE_OPT_NOARG },
 		OPT_END(),
 		OPT_END(),
 		OPT_END(),
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 63297ad6..f28a4e8a 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -94,7 +94,7 @@ test_expect_success '--quit cleans up sequencer state' '
 	test_path_is_missing .git/sequencer
 '
 
-test_expect_success 'cherry-pick --reset (another name for --quit)' '
+test_expect_success '--quit keeps HEAD and conflicted index intact' '
 	pristine_detach initial &&
 	cat >expect <<-\EOF &&
 	OBJID
@@ -105,7 +105,7 @@ test_expect_success 'cherry-pick --reset (another name for --quit)' '
 	:000000 100644 OBJID OBJID A	unrelated
 	EOF
 	test_must_fail git cherry-pick base..picked &&
-	git cherry-pick --reset &&
+	git cherry-pick --quit &&
 	test_path_is_missing .git/sequencer &&
 	test_must_fail git update-index --refresh &&
 	{
-- 
1.7.8.rc3
