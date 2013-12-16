From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] difftool: Change prompt to display the number of
 files in the diff queue
Date: Mon, 16 Dec 2013 15:02:21 -0500
Message-ID: <20131216200221.GA23689@sigill.intra.peff.net>
References: <1386286726-26653-1-git-send-email-zoltan.klinger@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, sunshine@sunshineco.com, gitster@pobox.com
To: Zoltan Klinger <zoltan.klinger@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 16 21:02:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VseN2-00082C-2v
	for gcvg-git-2@plane.gmane.org; Mon, 16 Dec 2013 21:02:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188Ab3LPUCY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Dec 2013 15:02:24 -0500
Received: from cloud.peff.net ([50.56.180.127]:45742 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751019Ab3LPUCX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Dec 2013 15:02:23 -0500
Received: (qmail 27240 invoked by uid 102); 16 Dec 2013 20:02:23 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 16 Dec 2013 14:02:23 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Dec 2013 15:02:21 -0500
Content-Disposition: inline
In-Reply-To: <1386286726-26653-1-git-send-email-zoltan.klinger@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239358>

On Fri, Dec 06, 2013 at 10:38:46AM +1100, Zoltan Klinger wrote:

> @@ -2928,7 +2933,14 @@ static void run_external_diff(const char *pgm,
>  	}
>  	*arg = NULL;
>  	fflush(NULL);
> -	retval = run_command_v_opt(spawn_arg, RUN_USING_SHELL);
> +
> +	env[0] = env_counter;
> +	snprintf(env_counter, sizeof(env_counter), "GIT_DIFF_PATH_COUNTER=%d",
> +			++o->diff_path_counter);

I don't think we have a particular rule, but our usual style is to line
up the continued line of arguments with the open-paren of the function,
like:

  foo(arg1, arg2,
      arg3, arg4);

> @@ -3317,6 +3329,8 @@ void diff_setup_done(struct diff_options *options)
>  		options->output_format = DIFF_FORMAT_NO_OUTPUT;
>  		DIFF_OPT_SET(options, EXIT_WITH_STATUS);
>  	}
> +
> +    options->diff_path_counter = 0;

It's hard to see with the email quoting, but this is a 4-space indent
rather than the usual 1-tab (which should be 8-wide on the terminals of
all True Believers).


Both are minor, but worth fixing IMHO (especially the second one). Looks
like it's too late for squashing, so here's a patch that can go on top
(doing it now is still of value, though, as it's less likely to create
conflicts since nobody is building on top yet).

-- >8 --
Subject: diff.c: fix some recent whitespace style violations

These were introduced by ee7fb0b.

Signed-off-by: Jeff King <peff@peff.net>
---
On top of zk/difftool-counts.

 diff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index a7d5a47..d69cc1b 100644
--- a/diff.c
+++ b/diff.c
@@ -2936,7 +2936,7 @@ static void run_external_diff(const char *pgm,
 
 	env[0] = env_counter;
 	snprintf(env_counter, sizeof(env_counter), "GIT_DIFF_PATH_COUNTER=%d",
-			++o->diff_path_counter);
+		 ++o->diff_path_counter);
 	env[1] = env_total;
 	snprintf(env_total, sizeof(env_total), "GIT_DIFF_PATH_TOTAL=%d", q->nr);
 
@@ -3330,7 +3330,7 @@ void diff_setup_done(struct diff_options *options)
 		DIFF_OPT_SET(options, EXIT_WITH_STATUS);
 	}
 
-    options->diff_path_counter = 0;
+	options->diff_path_counter = 0;
 }
 
 static int opt_arg(const char *arg, int arg_short, const char *arg_long, int *val)
-- 
1.8.5.1.399.g900e7cd
