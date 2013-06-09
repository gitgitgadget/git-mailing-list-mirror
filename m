From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH v4 20/45] cherry-pick: copy notes and run hooks
Date: Sun, 9 Jun 2013 19:22:48 +0200
Message-ID: <871u8bdwrb.fsf@hexa.v.cablecom.net>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
	<1370796057-25312-21-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	"Ramkumar Ramachandra" <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 19:23:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UljKa-0007Kg-27
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 19:23:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260Ab3FIRWw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 13:22:52 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:36676 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751184Ab3FIRWw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 13:22:52 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 9 Jun
 2013 19:22:35 +0200
Received: from hexa.v.cablecom.net.ethz.ch (46.126.8.85) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 9 Jun
 2013 19:22:49 +0200
In-Reply-To: <1370796057-25312-21-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Sun, 9 Jun 2013 11:40:32 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227034>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> +static void finish(struct replay_opts *opts)
> +{
> +	if (opts->action != REPLAY_PICK)
> +		return;
> +
> +	run_rewrite_hook(&rewritten, "cherry-pick");
> +	copy_rewrite_notes(&rewritten, "cherry-pick");
> +}
> +

Ok, so I see that with the previous two commits, you automatically get
handling of the notes.rewrite.cherry-pick variable and friends.  This is
good.

However, there are some open points:

* The docs in git-config(1) "notes.rewrite.cherry-pick" and githooks(5)
  "post-rewrite" and are now stale in so far as they contain a list of
  commands doing rewriting.

* This pretends to be cherry-pick even when the hook is called from
  rebase.

  We could claim (and document) that git-rebase with certain options
  shall be the same as running cherry-pick with some other options.
  However, git-am already goes out of its way to ensure that it only
  does the rewriting/post-rewrite if called from rebase (so that the
  user-facing git-am command is not affected).  So it's more consistent
  to ensure that git-cherry-pick, when called from rebase, also pretends
  to be rebase.

* githooks(5) documents explicitly that by the time post-rewrite is
  called, the notes have been rewritten.  Your change does it in the
  opposite order.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
