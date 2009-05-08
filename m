From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/5] parseopt: add OPT_NEGBIT
Date: Fri, 8 May 2009 01:01:17 -0400
Message-ID: <20090508050117.GB8909@coredump.intra.peff.net>
References: <1241725380.4772.6.camel@ubuntu.ubuntu-domain> <1241725457.4772.7.camel@ubuntu.ubuntu-domain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Git Mailing List <git@vger.kernel.org>,
	Pierre Habouzit <madcoder@debian.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 08 07:01:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2IDI-0000pS-TN
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 07:01:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752105AbZEHFBR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 May 2009 01:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751813AbZEHFBR
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 01:01:17 -0400
Received: from peff.net ([208.65.91.99]:36859 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751553AbZEHFBR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2009 01:01:17 -0400
Received: (qmail 16230 invoked by uid 107); 8 May 2009 05:01:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 08 May 2009 01:01:35 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 08 May 2009 01:01:17 -0400
Content-Disposition: inline
In-Reply-To: <1241725457.4772.7.camel@ubuntu.ubuntu-domain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118562>

On Thu, May 07, 2009 at 09:44:17PM +0200, Ren=C3=A9 Scharfe wrote:

> Add OPTION_NEGBIT and OPT_NEGBIT, mirroring OPTION_BIT and OPT_BIT.
> OPT_NEGBIT can be used together with OPT_BIT to define two options
> that cancel each other out.

Nice, this neatly fixes the problem with --no-no-empty-directory in
"ls-files" discussed here:

  http://article.gmane.org/gmane.comp.version-control.git/112607

We just need this patch on top of Ren=C3=A9's 1/5:

-- >8 --
Subject: [PATCH] ls-files: make --no-empty-directory properly negatable

This option was specified to parseopt as an OPT_BIT; however, we
actually want to _set_ the bit on --no-empty-directory. Thus the
existing implementation used --no-empty-directory, and required
--no-no-empty-directory to negate it.

Now that OPT_NEGBIT exists, we can properly support it as
--empty-directory and --no-empty-directory (but of course
still defaulting to showing empty directories).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin-ls-files.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index da2daf4..3d59b0e 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -454,7 +454,7 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *prefix)
 		OPT_BIT(0, "directory", &dir.flags,
 			"show 'other' directories' name only",
 			DIR_SHOW_OTHER_DIRECTORIES),
-		OPT_BIT(0, "no-empty-directory", &dir.flags,
+		OPT_NEGBIT(0, "empty-directory", &dir.flags,
 			"don't show empty directories",
 			DIR_HIDE_EMPTY_DIRECTORIES),
 		OPT_BOOLEAN('u', "unmerged", &show_unmerged,
--=20
1.6.3.201.g5d2a4.dirty
