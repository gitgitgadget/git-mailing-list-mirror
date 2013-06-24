From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] status: really ignore config with --porcelain
Date: Mon, 24 Jun 2013 12:49:37 -0700
Message-ID: <7vvc5370ha.fsf@alter.siamese.dyndns.org>
References: <1372077912-18625-1-git-send-email-artagnon@gmail.com>
	<1372077912-18625-2-git-send-email-artagnon@gmail.com>
	<vpqhagnwraj.fsf@anie.imag.fr>
	<CALkWK0=F_i95S+53eZmOAJtA+jG=jvi5-sDc3BgW3rNQo=n3Ng@mail.gmail.com>
	<vpqhagnv9xq.fsf@anie.imag.fr>
	<7vk3ljbh5r.fsf@alter.siamese.dyndns.org>
	<vpq7ghjtpv1.fsf@anie.imag.fr>
	<7vk3lj9xwn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 24 21:49:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrCll-0002dk-9X
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 21:49:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146Ab3FXTtl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 15:49:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44476 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750775Ab3FXTtk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 15:49:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B9E472B52A;
	Mon, 24 Jun 2013 19:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fbwDkoYCR05EDBON0rZhhM4V7zc=; b=n4kkjJ
	AKBMXhzPu2uniy2rUsOHdSlvdkVOlRTT5ik+iw/aycC2O5cII4Vty+jEl1rYM5cb
	pZGq048SeNTweVyZsrntqbMiqTuPwACqLR0yeZIjUHgh/OfRQusZ1E3zv4BzAdqA
	tvAyoGHuMCHDV7D8fuOAlGDPYB1dPrS3m4fb8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UZaVwLacv92guTqr8+iOAIydwRwxjCub
	DOj2N6oLwQ0E//avUYMMX0TLF07/mkkWVE7tw+pYfomzgRZ+waPpFcEYTYVvwTqy
	skUL4bDaRijBjV4Hrt5diiL+OqGRwp31uIL6ZNXnVaqCdjDPU2xhB14Jg8jJW7N0
	2mwFzY4fOdY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ADD8E2B529;
	Mon, 24 Jun 2013 19:49:39 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ECD172B527;
	Mon, 24 Jun 2013 19:49:38 +0000 (UTC)
In-Reply-To: <7vk3lj9xwn.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 24 Jun 2013 11:16:56 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 347F46BA-DD07-11E2-B8DA-9B86C9BC06FA-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228908>

Junio C Hamano <gitster@pobox.com> writes:

> We use "unspecified" value to initialize the main variables
> (status_format global and s->show_branch), and also prepare
> "from-config" counterpart variables.  After we read both, we figure
> out which one should be used, while resetting the main variables to
> their default if neither mechanism touched them.
>
>  builtin/commit.c  | 55 ++++++++++++++++++++++++++++++++++++++++++++++---------
>  t/t7508-status.sh |  5 +++++
>  wt-status.c       |  1 +
>  3 files changed, 52 insertions(+), 9 deletions(-)

At least that needs this on top to deal with the late defaulting of
"-z".

We know we do not want deferred configuration values when the
command line says "--porcelain" or "-z".  And after handling the
"-z" to set status_format, we apply config only if we want deferred
configuration and command line left them unspecified.  And finally
we apply the default if both config and command line left them
unspecified.

 builtin/commit.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index a535eb2..6f8cb04 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -977,7 +977,16 @@ static struct status_deferred_config {
 
 static void finalize_deferred_config(struct wt_status *s)
 {
-	int use_deferred_config = (status_format != STATUS_FORMAT_PORCELAIN);
+	int use_deferred_config = (status_format != STATUS_FORMAT_PORCELAIN &&
+				   !s->null_termination);
+
+	if (s->null_termination) {
+		if (status_format == STATUS_FORMAT_NONE ||
+		    status_format == STATUS_FORMAT_UNSPECIFIED)
+			status_format = STATUS_FORMAT_PORCELAIN;
+		else if (status_format == STATUS_FORMAT_LONG)
+			die(_("--long and -z are incompatible"));
+	}
 
 	if (use_deferred_config && status_format == STATUS_FORMAT_UNSPECIFIED)
 		status_format = status_deferred_config.status_format;
@@ -1085,12 +1094,6 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	if (all && argc > 0)
 		die(_("Paths with -a does not make sense."));
 
-	if (s->null_termination) {
-		if (status_format == STATUS_FORMAT_NONE)
-			status_format = STATUS_FORMAT_PORCELAIN;
-		else if (status_format == STATUS_FORMAT_LONG)
-			die(_("--long and -z are incompatible"));
-	}
 	if (status_format != STATUS_FORMAT_NONE)
 		dry_run = 1;
 
@@ -1232,13 +1235,6 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	finalize_colopts(&s.colopts, -1);
 	finalize_deferred_config(&s);
 
-	if (s.null_termination) {
-		if (status_format == STATUS_FORMAT_NONE)
-			status_format = STATUS_FORMAT_PORCELAIN;
-		else if (status_format == STATUS_FORMAT_LONG)
-			die(_("--long and -z are incompatible"));
-	}
-
 	handle_untracked_files_arg(&s);
 	if (show_ignored_in_status)
 		s.show_ignored_files = 1;
