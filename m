From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH 2/5] implement submodule config cache for lookup of
 submodule names
Date: Sat, 14 Jun 2014 00:37:12 +0200
Message-ID: <20140613223701.GA3799@sandbox-ub>
References: <20140605060425.GA23874@sandbox-ub>
 <20140605060750.GC23874@sandbox-ub>
 <xmqq38f96b9f.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 14 00:38:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wva6x-000748-F0
	for gcvg-git-2@plane.gmane.org; Sat, 14 Jun 2014 00:38:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752154AbaFMWiL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 18:38:11 -0400
Received: from smtprelay03.ispgateway.de ([80.67.31.41]:48323 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751357AbaFMWiK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 18:38:10 -0400
Received: from [77.21.74.130] (helo=sandbox-ub)
	by smtprelay03.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1Wva61-00076s-3X; Sat, 14 Jun 2014 00:37:17 +0200
Content-Disposition: inline
In-Reply-To: <xmqq38f96b9f.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251647>

On Thu, Jun 12, 2014 at 02:58:20PM -0700, Junio C Hamano wrote:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> 
> > ...
> > +static int is_cache_init = 0;
> 
> Please don't initialise variables in the .bss to zero by hand.

Ok will remove that.

> > + ...
> > +	warning("%s:.gitmodules, multiple configurations found for "
> > +			"submodule.%s.%s. Skipping second one!",
> > +			commit_string, name, option);
> > +}
> > + ...
> > +		if (strcmp(value, "untracked") && strcmp(value, "dirty") &&
> > +		    strcmp(value, "all") && strcmp(value, "none")) {
> > +			warning("Invalid parameter \"%s\" for config option "
> > +					"\"submodule.%s.ignore\"", value, var);
> > +			goto release_return;
> > +		}
> 
> These two look inconsistent in different ways.  I think we typically
> quote the names like so:
> 
> 	warning("I have trouble with variable '%s' somehow", var);

Ok will change the quotation for the variable and parameter names.

Here is the fixup[1] I will queue in my branch.

Cheers Heiko

[1] ---8<----
Subject: [PATCH] fixup! implement submodule config cache for lookup of
 submodule names

---
 submodule-config.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/submodule-config.c b/submodule-config.c
index 437fbdb..f330ccc 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -26,7 +26,7 @@ struct submodule_entry {
 };
 
 static struct submodule_cache cache;
-static int is_cache_init = 0;
+static int is_cache_init;
 
 static int config_path_cmp(const struct submodule_entry *a,
 			   const struct submodule_entry *b,
@@ -230,7 +230,7 @@ static void warn_multiple_config(const unsigned char *commit_sha1,
 	if (commit_sha1)
 		commit_string = sha1_to_hex(commit_sha1);
 	warning("%s:.gitmodules, multiple configurations found for "
-			"submodule.%s.%s. Skipping second one!",
+			"'submodule.%s.%s'. Skipping second one!",
 			commit_string, name, option);
 }
 
@@ -298,8 +298,8 @@ static int parse_config(const char *var, const char *value, void *data)
 		}
 		if (strcmp(value, "untracked") && strcmp(value, "dirty") &&
 		    strcmp(value, "all") && strcmp(value, "none")) {
-			warning("Invalid parameter \"%s\" for config option "
-					"\"submodule.%s.ignore\"", value, var);
+			warning("Invalid parameter '%s' for config option "
+					"'submodule.%s.ignore'", value, var);
 			goto release_return;
 		}
 
-- 
2.0.0
