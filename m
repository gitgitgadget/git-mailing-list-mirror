From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [WIP/PATCH 1/9] submodule: prepare for recursive checkout of
 submodules
Date: Mon, 3 Feb 2014 16:01:50 -0800
Message-ID: <20140204000150.GJ30398@google.com>
References: <xmqqd2k4hh4p.fsf@gitster.dls.corp.google.com>
 <52CC3E16.4060909@web.de>
 <xmqqvbxvekwv.fsf@gitster.dls.corp.google.com>
 <52EFF25E.6080306@web.de>
 <52EFF290.5090501@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	"W. Trevor King" <wking@tremily.us>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Feb 04 01:01:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WATSg-0002Cx-VT
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 01:01:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753338AbaBDABz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 19:01:55 -0500
Received: from mail-pb0-f49.google.com ([209.85.160.49]:35339 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752854AbaBDABy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 19:01:54 -0500
Received: by mail-pb0-f49.google.com with SMTP id up15so7698988pbc.36
        for <git@vger.kernel.org>; Mon, 03 Feb 2014 16:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=7FznBB5TBYQChLrXG1Xm2MLU1M3fc/7s545gM8/emZ0=;
        b=Ep1I/SuM5UnxwTfsSO8b3wFy1WihBAlxA8MQUgeph6CvIqCh82Ojq/ERAMiO1l3V3k
         SweQ8WQ3VcyzyLSBX7HTImNmmYXOXwG3592gwhD0w8tTqhzp1TQdN7HteE7NJtTciJ2X
         0Dl1GVPB0ADYcBVviylI2mwJELEDSrGCACVh6+RYM/QcR7OTpGdoAEU6bTOf2o818fLf
         dMND2H7cCqB0i6VvxgI/6r9vSY8cclM2aRjz9Ng7bU+soUzrBAwc1h5f1uzpnivXXSh+
         2nD7Q5fCTTT01dFyQ0mdAvjtT05SdtmjR52lCrhSDscQSfkCqdpqZbGnO9UXV5CXlvzE
         v8bg==
X-Received: by 10.66.122.201 with SMTP id lu9mr39870789pab.40.1391472113866;
        Mon, 03 Feb 2014 16:01:53 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id nu10sm59964327pbb.16.2014.02.03.16.01.52
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 03 Feb 2014 16:01:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <52EFF290.5090501@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241500>

Jens Lehmann wrote:

> This commit adds the functions and files needed for configuration,
> documentation, setting the default behavior and determining if a
> submodule path should be updated automatically.

Yay!

[...]
>  Documentation/recurse-submodules-update.txt |  8 +++++
>  submodule.c                                 | 50 +++++++++++++++++++++++++++++
>  submodule.h                                 |  6 ++++
>  3 files changed, 64 insertions(+)
>  create mode 100644 Documentation/recurse-submodules-update.txt

I like the shared documentation snippet.

Ok, naive questions and overly pedantic nitpicking follow.  Patch with
a couple of suggested changes at the end.

[...]
> --- /dev/null
> +++ b/Documentation/recurse-submodules-update.txt
> @@ -0,0 +1,8 @@
> +--[no-]recurse-submodules::
> +	Using --recurse-submodules will update the work tree of all
> +	initialized submodules according to the commit recorded in the
> +	superproject if their update configuration is set to checkout'. If
> +	local modifications in a submodule would be overwritten the checkout
> +	will fail unless forced. Without this option or with
> +	--no-recurse-submodules is, the work trees of submodules will not be
> +	updated, only the hash recorded in the superproject will be updated.

Tweaks:

 * Spelling out "--no-recurse-submodules, --recurse-submodules" (imitating
   e.g. --decorate in git-log(1))

 * Shortening, using imperative mood
 
 * Skipping description of safety check, since it matches how checkout
   works in general

That would make

	--no-recurse-submodules::
	--recurse-submodules::
		Perform the checkout in submodules, too.  This only affects
		submodules with update strategy `checkout` (which is the
		default update strategy; see `submodule.<name>.update` in
		link:gitmodules[5]).
	+
	The default behavior is to update submodule entries in the superproject
	index and to leave the inside of submodules alone.  That behavior can also
	be requested explicitly with --no-recurse-submodules.

Ideas for further work:

 * The safety check probably deserves a new section where it could be
   described in detail alongside a description of the corresponding check
   for plain checkout.  Then the description of the -f option could
   point to that section.

 * What happens when update = merge, rebase, or !command?  I think
   skipping them for now like suggested above is fine, but:

   - It would be even better to error out when there are changes to carry
     over with update = merge or rebase

   - Better still to perform the rebase when update = rebase

   - I have no idea what update = merge should do for non-fast-forward
     moves

> --- a/submodule.c
> +++ b/submodule.c
> @@ -16,6 +16,8 @@ static struct string_list config_name_for_path;
>  static struct string_list config_fetch_recurse_submodules_for_name;
>  static struct string_list config_ignore_for_name;
>  static int config_fetch_recurse_submodules = RECURSE_SUBMODULES_ON_DEMAND;
> +static int config_update_recurse_submodules = RECURSE_SUBMODULES_OFF;
> +static int option_update_recurse_submodules = RECURSE_SUBMODULES_DEFAULT;

Confusingly, config_update_recurse_submodules is set using the
--recurse-submodules-default option, not configuration.  There's
precedent for that in fetch.recurseSubmodules handling, but perhaps
a comment would help --- something like

	/*
	 * When no --recurse-submodules option was passed, should git fetch
	 * from submodules where submodule.<name>.fetchRecurseSubmodules
	 * doesn't indicate what to do?
	 *
	 * Controlled by fetch.recurseSubmodules.  The default is determined by
	 * the --recurse-submodules-default option, which propagates
	 * --recurse-submodules from the parent git process when recursing.
	 */
	static int config_fetch_recurse_submodules = RECURSE_SUBMODULES_ON_DEMAND;

	/*
	 * When no --recurse-submodules option was passed, should git update
	 * the index and worktree within submodules (and in turn their
	 * submodules, etc)?
	 *
	 * Controlled by the --recurse-submodules-default option, which
	 * propagates --recurse-submodules from the parent git process
	 * when recursing.
	 */
	static int config_update_recurse_submodules = RECURSE_SUBMODULES_OFF;

[...]
> @@ -382,6 +384,48 @@ int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg)
>  	}
>  }
> 
> +int parse_update_recurse_submodules_arg(const char *opt, const char *arg)
> +{
> +	switch (git_config_maybe_bool(opt, arg)) {
> +	case 1:
> +		return RECURSE_SUBMODULES_ON;
> +	case 0:
> +		return RECURSE_SUBMODULES_OFF;
> +	default:
> +		if (!strcmp(arg, "checkout"))
> +			return RECURSE_SUBMODULES_ON;

Hm, is this arg == checkout case futureproofing for when
--recurse-submodules learns to handle submodules without
'update = checkout', too?

Is it safe to leave it out for now?

[...]
> +int submodule_needs_update(const char *path)

Return value convention: 1 means "do update"; 0 means "don't update".

Some day later I suppose 2 or -1 could mean "error out".  Ok.

Naming nit: needs_update sounds like it's checking if there was a
change at that path.  How about something like submodule_should_update(),
!submodule_ignore_for_update(), or update_should_recurse_into_submodule()?

[...]
> @@ -589,6 +633,12 @@ int push_unpushed_submodules(unsigned char new_sha1[20], const char *remotes_nam
>  	return ret;
>  }
> 
> +void set_config_update_recurse_submodules(int default_value, int option_value)
> +{
> +	config_update_recurse_submodules = default_value;
> +	option_update_recurse_submodules = option_value;
> +}

Could option_parse_update_submodules set
option_update_recurse_submodules directly?  Alternatively, could this
function examine option_value so that submodule.c would only need one
variable?

	if (option_value == RECURSE_SUBMODULES_DEFAULT)
		update_recurse_submodules = default_value;
	else
		update_recurse_submodules = option_value;

If .gitmodules some day grows a submodule.<name>.checkoutRecurseSubmodules
option then it would be convenient to have the option that overrides and
the default tracked separately.  Is that the idea here?

I might try writing a dummy command to test this basic --recurse-submodules
option handling as a separate patch.

Thanks,
Jonathan

diff --git i/Documentation/recurse-submodules-update.txt w/Documentation/recurse-submodules-update.txt
index e57d452..eae376d 100644
--- i/Documentation/recurse-submodules-update.txt
+++ w/Documentation/recurse-submodules-update.txt
@@ -1,8 +1,10 @@
---[no-]recurse-submodules::
-	Using --recurse-submodules will update the work tree of all
-	initialized submodules according to the commit recorded in the
-	superproject if their update configuration is set to checkout'. If
-	local modifications in a submodule would be overwritten the checkout
-	will fail unless forced. Without this option or with
-	--no-recurse-submodules is, the work trees of submodules will not be
-	updated, only the hash recorded in the superproject will be updated.
+--no-recurse-submodules::
+--recurse-submodules::
+	Perform the checkout in submodules, too.  This only affects
+	submodules with update strategy `checkout` (which is the
+	default update strategy; see `submodule.<name>.update` in
+	linkgit:gitmodules[5]).
++
+The default behavior is to update submodule entries in the superproject
+index and to leave the inside of submodules alone.  That behavior can
+also be requested explicitly with `--no-recurse-submodules`.
diff --git i/submodule.c w/submodule.c
index b3eb28d..f88bf70 100644
--- i/submodule.c
+++ w/submodule.c
@@ -12,11 +12,30 @@
 #include "argv-array.h"
 #include "blob.h"
 
+/*
+ * When no --recurse-submodules option was passed, should git fetch
+ * from submodules where submodule.<name>.fetchRecurseSubmodules doesn't
+ * indicate what to do?
+ *
+ * Controlled by fetch.recurseSubmodules.  The default is determined by
+ * the --recurse-submodules-default option, which propagates
+ * --recurse-submodules from the parent git process when recursing.
+ */
+static int config_fetch_recurse_submodules = RECURSE_SUBMODULES_ON_DEMAND;
+
+/*
+ * When no --recurse-submodules option was passed, should git update the
+ * index and worktree within submodules (and in turn their submodules,
+ * etc)?
+ *
+ * Controlled by the --recurse-submodules-default option, which propagates
+ * --recurse-submodules from the parent git process when recursing.
+ */
+static int config_update_recurse_submodules = RECURSE_SUBMODULES_OFF;
+
 static struct string_list config_name_for_path;
 static struct string_list config_fetch_recurse_submodules_for_name;
 static struct string_list config_ignore_for_name;
-static int config_fetch_recurse_submodules = RECURSE_SUBMODULES_ON_DEMAND;
-static int config_update_recurse_submodules = RECURSE_SUBMODULES_OFF;
 static int option_update_recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
 static struct string_list changed_submodule_paths;
 static int initialized_fetch_ref_tips;
@@ -392,8 +411,6 @@ int parse_update_recurse_submodules_arg(const char *opt, const char *arg)
 	case 0:
 		return RECURSE_SUBMODULES_OFF;
 	default:
-		if (!strcmp(arg, "checkout"))
-			return RECURSE_SUBMODULES_ON;
 		die("bad %s argument: %s", opt, arg);
 	}
 }
