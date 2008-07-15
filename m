From: Teemu Likonen <tlikonen@iki.fi>
Subject: [PATCH v2] bash: Teach the bash completion about 'git send-email'
Date: Tue, 15 Jul 2008 09:30:34 +0300
Message-ID: <20080715063034.GA3316@mithlond.arda.local>
References: <1216023662-9109-1-git-send-email-tlikonen@iki.fi> <20080715043839.GE2432@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jul 15 08:31:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIe4d-0000kq-HG
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 08:31:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755001AbYGOGao (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 02:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754981AbYGOGao
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 02:30:44 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:50468 "EHLO
	jenni1.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754816AbYGOGan (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 02:30:43 -0400
Received: from mithlond.arda.local (80.220.180.181) by jenni1.rokki.sonera.fi (8.5.014)
        id 487B42D60007163E; Tue, 15 Jul 2008 09:30:35 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1KIe3W-0001G7-72; Tue, 15 Jul 2008 09:30:34 +0300
Content-Disposition: inline
In-Reply-To: <20080715043839.GE2432@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88530>

Add the following long options to be completed with 'git send-email':

    --bcc --cc --cc-cmd --chain-reply-to --compose --dry-run
    --envelope-sender --from --identity --in-reply-to
    --no-chain-reply-to --no-signed-off-by-cc --no-suppress-from
    --no-thread --quiet --signed-off-by-cc --smtp-pass --smtp-server
    --smtp-server-port --smtp-ssl --smtp-user --subject --suppress-cc
    --suppress-from --thread --to

Short ones like --to and --cc are not usable for actual completion
because of the shortness itself and because there are longer ones which
start with same letters (--thread, --compose). It's still useful to have
these shorter options _listed_ when user presses TAB key after typing
two dashes. It gives user an idea what options are available (and --to
and --cc are probably the most commonly used).

Signed-off-by: Teemu Likonen <tlikonen@iki.fi>
---

Shawn O. Pearce wrote (2008-07-15 04:38 +0000):

> Don't use __git_complete_file here.  As far as I remember,
> git-send-email does not accept "origin/maint:some.patch" as an email
> to extract from Git prior to sending.  It looks for files in the local
> filesystem.  So you want standard bash completion for anything not
> starting with --.
> 
> Just use COMPREPLY=() at the end.  See _git_am for an example.

Done. And thanks.

> > +complete -o default -o nospace -F _git_send_email git-send-email

> Hmm.  With dash form commands gone in 1.6 we should remove these.
> 
> But I suspect this completion patch could be shipped in the next 1.5.6
> maint release as its really quite trivial.  Junio, any comment on
> that?

This is a for-1.6 version so the completion for dashed command
(git-send-email) is dropped. I see Shawn already sent a patch which
drops all those.



 contrib/completion/git-completion.bash |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index d268e6f..48ebbf7 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -905,6 +905,24 @@ _git_rebase ()
 	__gitcomp "$(__git_refs)"
 }
 
+_git_send_email ()
+{
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	case "$cur" in
+	--*)
+		__gitcomp "--bcc --cc --cc-cmd --chain-reply-to --compose
+			--dry-run --envelope-sender --from --identity
+			--in-reply-to --no-chain-reply-to --no-signed-off-by-cc
+			--no-suppress-from --no-thread --quiet
+			--signed-off-by-cc --smtp-pass --smtp-server
+			--smtp-server-port --smtp-ssl --smtp-user --subject
+			--suppress-cc --suppress-from --thread --to"
+		return
+		;;
+	esac
+	COMPREPLY=()
+}
+
 _git_config ()
 {
 	local cur="${COMP_WORDS[COMP_CWORD]}"
@@ -1376,6 +1394,7 @@ _git ()
 	rebase)      _git_rebase ;;
 	remote)      _git_remote ;;
 	reset)       _git_reset ;;
+	send-email)  _git_send_email ;;
 	shortlog)    _git_shortlog ;;
 	show)        _git_show ;;
 	show-branch) _git_log ;;
-- 
1.5.6.3.316.g01fc
