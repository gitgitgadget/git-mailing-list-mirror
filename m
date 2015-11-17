From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 4/5] grep: stop using PARSE_OPT_NO_INTERNAL_HELP
Date: Tue, 17 Nov 2015 11:25:53 +0100
Message-ID: <564B00B1.1070709@web.de>
References: <564AFF32.1030406@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 17 11:26:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZydSp-0004rO-1S
	for gcvg-git-2@plane.gmane.org; Tue, 17 Nov 2015 11:26:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753619AbbKQK0I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2015 05:26:08 -0500
Received: from mout.web.de ([212.227.17.11]:55453 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751218AbbKQK0F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2015 05:26:05 -0500
Received: from [192.168.178.36] ([79.253.153.213]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0LeLKb-1ajrMh2snN-00q7pf; Tue, 17 Nov 2015 11:25:58
 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <564AFF32.1030406@web.de>
X-Provags-ID: V03:K0:FVcydRKznOvctHX4S84PbdooVyBzTigyCwOQASdJ3ujPSwdwfOw
 VsBTLEiaefzr/b/vQ/nki2nb1FVnDbFGm0MYkpR/6PSzx1VlPJgBQsNb+o+Ml3p0/4aODjp
 EcAfjZmUHrZisnxLuKNUB7PJ0/w7nDezy0pPolFfZAS4KNrN725Wvifyzt7GHXWnUe3it+7
 e84r+Q9+JROunsP5nzzsg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XIVAvqYXmpc=:sYXtogpQJx8K/C6rrquZgd
 iCXPpn9OjkQc0FOBUrUg3VS1ARlf6Gbb/9nHMqW/Eraksq8d7Ffy61diullEy3ABFzD2P6Ke9
 qf4WN3GzLJCO+bXvostw7FdlUiB5dJPfMiedg6meB9xqiL0zAcGHMfdsJRTsj4mfKgLY6k/X1
 VrLlfwXowDpuax/XCvP7bw80/aC2J5EaGitDe/SziNo31f4gG+HJhRcTImPbrJODnBSHydByH
 6T06W9YlnjF2zmSwgIcVRU7Bo8iRttl/beBHS0uX20kN13sOnwfyg4l96EQucWPzUfB/bCyjj
 79ksAZqW7xascMhbMgIzt91ykb6182Ghhnt7yfjfas9uGoGwxBtLDTBEeUB9b/haLojQ5pCOJ
 JzkyJZGQoPHH06KRudBJ1N0mJ1smGiKdsJmMTp9nxFramUdd84Jk3YZqXIzf7gHhHKlTFI5rV
 aj1y01FXOiyStNdLTrDPJoqophHcmEZkj72jprvWU3x6PK0I5Xkg0CvPayunyqxUC505eSQri
 kov0PhFuG3uaUj3df6sRVf+/YScN6kQ6gC/MX/i4N1qOu1G8+3YjunPlKIXzAY9fQrJvV+QVd
 lvYlJQHa2P9J4wdiJ3yPofaFplPI5mx4YELBZ+48/c16/cQ2J74s217LT78pdCoy+nHRC65OX
 yPk9TuqK1W6jGjFUh65mD0+GFcnJzyr/Tuauf/77w1qa/OIxGY+XBebcpMEvWsoQee49lBQsU
 9R0bc/8xq2emTrgmH3GmEJD6iTAAMUdfWFJ9Jrg5Lc5JptmW3QyVQuCJYPH/BlNAxDgDcnu4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281398>

The flag PARSE_OPT_NO_INTERNAL_HELP is set to allow overriding the
option -h, except when it's the only one given.  This is the default
behavior now, so remove the flag and the hand-rolled --help-all
handling.  The internal --help-all handler now actually shows hidden
options, i.e. --debug in this case.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/grep.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index d04f440..749e346 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -612,11 +612,6 @@ static int pattern_callback(const struct option *opt, const char *arg,
 	return 0;
 }
 
-static int help_callback(const struct option *opt, const char *arg, int unset)
-{
-	return -1;
-}
-
 int cmd_grep(int argc, const char **argv, const char *prefix)
 {
 	int hit = 0;
@@ -738,18 +733,9 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			PARSE_OPT_OPTARG, NULL, (intptr_t)default_pager },
 		OPT_BOOL(0, "ext-grep", &external_grep_allowed__ignored,
 			 N_("allow calling of grep(1) (ignored by this build)")),
-		{ OPTION_CALLBACK, 0, "help-all", NULL, NULL, N_("show usage"),
-		  PARSE_OPT_HIDDEN | PARSE_OPT_NOARG, help_callback },
 		OPT_END()
 	};
 
-	/*
-	 * 'git grep -h', unlike 'git grep -h <pattern>', is a request
-	 * to show usage information and exit.
-	 */
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage_with_options(grep_usage, options);
-
 	init_grep_defaults();
 	git_config(grep_cmd_config, NULL);
 	grep_init(&opt, prefix);
@@ -766,8 +752,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	 */
 	argc = parse_options(argc, argv, prefix, options, grep_usage,
 			     PARSE_OPT_KEEP_DASHDASH |
-			     PARSE_OPT_STOP_AT_NON_OPTION |
-			     PARSE_OPT_NO_INTERNAL_HELP);
+			     PARSE_OPT_STOP_AT_NON_OPTION);
 	grep_commit_pattern_type(pattern_type_arg, &opt);
 
 	if (use_index && !startup_info->have_repository)
-- 
2.6.3
