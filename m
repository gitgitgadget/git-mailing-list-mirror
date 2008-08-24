From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: Re: [PATCH RESEND] Do not override LESS
Date: Sun, 24 Aug 2008 00:28:32 -0500 (CDT)
Message-ID: <Pine.GSO.4.62.0808240019050.28567@harper.uchicago.edu>
References: <1219407912-32085-1-git-send-email-mail@cup.kalibalik.dk>
 <7vvdxs2t03.fsf@gitster.siamese.dyndns.org> <87k5e8i18c.fsf@cup.kalibalik.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Anders Melchiorsen <mail@cup.kalibalik.dk>
X-From: git-owner@vger.kernel.org Sun Aug 24 07:30:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KX8Av-0000OS-Fi
	for gcvg-git-2@gmane.org; Sun, 24 Aug 2008 07:30:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751580AbYHXF2j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2008 01:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751803AbYHXF2j
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Aug 2008 01:28:39 -0400
Received: from smtp00.uchicago.edu ([128.135.12.76]:44071 "EHLO
	smtp00.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751519AbYHXF2i (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2008 01:28:38 -0400
Received: from harper.uchicago.edu (harper.uchicago.edu [128.135.12.7])
	by smtp00.uchicago.edu (8.13.8/8.13.8) with ESMTP id m7O5SYZx025105;
	Sun, 24 Aug 2008 00:28:34 -0500
Received: from localhost (jrnieder@localhost)
	by harper.uchicago.edu (8.12.10/8.12.10) with ESMTP id m7O5SWNJ028806;
	Sun, 24 Aug 2008 00:28:32 -0500 (CDT)
X-Authentication-Warning: harper.uchicago.edu: jrnieder owned process doing -bs
In-Reply-To: <87k5e8i18c.fsf@cup.kalibalik.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93518>

Hi,

Anders Melchiorsen wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Anders Melchiorsen <mail@cup.kalibalik.dk> writes:
> >
> >> Passing options to "less" with the LESS environment variable can
> >> interfere with existing environment variables.

[...]
> >> 2. Bob sets GIT_PAGER="less -RS", but does not set LESS. Git sets
> >> LESS=FRSX before calling $GIT_PAGER. Now Bob wonders why his pager is
> >> not always paging, when he explicitly tried to clear the F option.
> >
> > 3. Christ has been happily using git with his PAGER set to "less".  He
> >    suddenly notices that output from git linewraps and the pager does not
> >    exit when showing a short output, and gets very unhappy.
> 
> Well, I noted that point already, so I had hoped for a reply
> explaining why it is a big problem. Maybe setting PAGER="less" is more
> common than I think, as I have never seen it.

On system where less is not the default pager (e.g. Solaris), it is
very common.
 
> While I am wary of advocating a patch that makes Christ unhappy, the
> "3." issue is easily fixed by him setting GIT_PAGER="less -FRSX".
> 
> My concern is that without reading the source, it can be confusing to
> figure out what happens with less, $LESS and git.

So perhaps it is a documentation problem.  How about this patch?

-- %< --
Subject: Documentation: clarify pager configuration

The unwary user may not know how to disable the -FRSX options.

Signed-off-by: Jonathan Nieder <jrnieder@uchicago.edu>
---
 Documentation/config.txt |    9 +++++++--
 Documentation/git.txt    |    3 ++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 9020675..88638f7 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -358,8 +358,13 @@ core.editor::
 	`EDITOR` environment variables and then finally `vi`.
 
 core.pager::
-	The command that git will use to paginate output.  Can be overridden
-	with the `GIT_PAGER` environment variable.
+	The command that git will use to paginate output.  Can
+	be overridden with the `GIT_PAGER` environment
+	variable.  Note that git sets the `LESS` environment
+	variable to `FRSX` if it is unset when it runs the
+	pager.  One can change these settings by setting the
+	`LESS` variable to some other value or by giving the
+	`core.pager` option a value such as "`less -+FRSX`".
 
 core.whitespace::
 	A comma separated list of common whitespace problems to
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 1bc295d..363a785 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -497,7 +497,8 @@ other
 'GIT_PAGER'::
 	This environment variable overrides `$PAGER`. If it is set
 	to an empty string or to the value "cat", git will not launch
-	a pager.
+	a pager.  See also the `core.pager` option in
+	linkgit:git-config[1].
 
 'GIT_SSH'::
 	If this environment variable is set then 'git-fetch'
-- 
1.6.0.481.g9ef3
