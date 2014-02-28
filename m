From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] i18n: proposed command missing leading dash
Date: Fri, 28 Feb 2014 13:41:40 -0800
Message-ID: <20140228214140.GP7855@google.com>
References: <1393620766-17582-1-git-send-email-sandy.carter@savoirfairelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jn.avila@free.fr,
	Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
To: Sandy Carter <sandy.carter@savoirfairelinux.com>
X-From: git-owner@vger.kernel.org Fri Feb 28 22:41:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJVBk-0005Xe-M1
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 22:41:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752147AbaB1Vlo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 16:41:44 -0500
Received: from mail-pb0-f51.google.com ([209.85.160.51]:56837 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712AbaB1Vln (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 16:41:43 -0500
Received: by mail-pb0-f51.google.com with SMTP id uo5so588097pbc.38
        for <git@vger.kernel.org>; Fri, 28 Feb 2014 13:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=3Jwex9W7BsfpzhmWyE71yaHLBmmmzMzoEQEqQUczFhY=;
        b=MwiZ27CVse/N+ootvO721ko1trQ5r8OjtsGy58aOTH2o5zWfT3wV2jK1sIzEhQJ8Ia
         ZAgP0XfGBWU+3+MO7sj/ZLd6yfVu0I7NFkJb5SBzeJyFH3uvE3/3mQ9RHurgXElqAYLs
         CuiOuvuqZIh9RRgRUM8PqR5NnHGLbGNjde0CaZokzriUZGlwhwqV67fnhXB8G/hAO5KA
         L434puSmBIVpU+ZTHNbCRTAg6J0DdGMzTUPsx8VnAAP0WgdF5S9d45WEwR4Csc57lVXL
         DimiB3Bb6HE99LossPLmGhzFlBu4QnHczFhFwQALQRd4IWwH/mchumsirkpYkA3o4rI7
         7rKQ==
X-Received: by 10.68.226.70 with SMTP id rq6mr5942472pbc.107.1393623703379;
        Fri, 28 Feb 2014 13:41:43 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id qs1sm9495670pbb.18.2014.02.28.13.41.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 28 Feb 2014 13:41:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1393620766-17582-1-git-send-email-sandy.carter@savoirfairelinux.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243020>

Hi,

Sandy Carter wrote:

> Add missing leading dash to proposed commands in french output when
> using the command:

Thanks!

[...]
> --- a/po/fr.po
> +++ b/po/fr.po
> @@ -3266,7 +3266,7 @@ msgstr "    git branch -d %s\n"
>  #: builtin/branch.c:1027
>  #, c-format
>  msgid "    git branch --set-upstream-to %s\n"
> -msgstr "    git branch -set-upstream-to %s\n"
> +msgstr "    git branch --set-upstream-to %s\n"

To make life saner for translators, this should be either
untranslatable or a single multi-line string, I suspect:

diff --git i/builtin/branch.c w/builtin/branch.c
index b4d7716..972040c 100644
--- i/builtin/branch.c
+++ w/builtin/branch.c
@@ -1022,11 +1022,13 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		 */
 		if (argc == 1 && track == BRANCH_TRACK_OVERRIDE &&
 		    !branch_existed && remote_tracking) {
-			fprintf(stderr, _("\nIf you wanted to make '%s' track '%s', do this:\n\n"), head, branch->name);
-			fprintf(stderr, _("    git branch -d %s\n"), branch->name);
-			fprintf(stderr, _("    git branch --set-upstream-to %s\n"), branch->name);
+			fprintf(stderr, "\n");
+			fprintf(stderr, _("If you wanted to make '%s' track '%s', do this:\n\n"
+					  "    git branch -d %s\n"
+					  "    git branch --set-upstream-to %s"),
+					head, branch->name, branch->name, branch->name);
+			fprintf(stderr, "\n");
 		}
-
 	} else
 		usage_with_options(builtin_branch_usage, options);
 
What do you think?

Jonathan
