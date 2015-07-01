From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] log: add log.follow config option
Date: Wed, 01 Jul 2015 23:16:17 +0200
Message-ID: <vpq8uazo9y6.fsf@anie.imag.fr>
References: <1435777439-5002-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 23:16:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAPMp-0007mU-Dt
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 23:16:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753116AbbGAVQY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 17:16:24 -0400
Received: from mx2.imag.fr ([129.88.30.17]:42160 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751982AbbGAVQV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 17:16:21 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t61LGF8G003912
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 1 Jul 2015 23:16:15 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t61LGHeR025650;
	Wed, 1 Jul 2015 23:16:17 +0200
In-Reply-To: <1435777439-5002-1-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Wed, 1 Jul 2015 15:03:59 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 01 Jul 2015 23:16:15 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t61LGF8G003912
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1436390176.57154@baKFs3AxBDafGDw/Gaq6Lg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273204>

David Turner <dturner@twopensource.com> writes:

> diff --git a/builtin/log.c b/builtin/log.c
> index 8781049..11b8d82 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -31,6 +31,7 @@ static const char *default_date_mode = NULL;
>  
>  static int default_abbrev_commit;
>  static int default_show_root = 1;
> +static int default_follow = 0;
>  static int decoration_style;
>  static int decoration_given;
>  static int use_mailmap_config;
> @@ -102,6 +103,8 @@ static void cmd_log_init_defaults(struct rev_info *rev)
>  {
>  	if (fmt_pretty)
>  		get_commit_format(fmt_pretty, rev);
> +	if (default_follow)
> +		DIFF_OPT_SET(&rev->diffopt, FOLLOW_RENAMES);

Doesn't it activate --follow all the time, including when the user
provides several paths?

In this case, you get this:

$ git log --follow *.c
fatal: --follow requires exactly one pathspec

So activating --follow for all "git log" calls would prevent log from
being used with several pathspecs.

Or, do you have a preparation patch that allows --follow with multiple
pathspecs? ;-)

In any case, you have to test "git log -- path1 path2" with the option
activated.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
