From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] git-config: update doc for --get with multiple values
Date: Sun, 7 Jul 2013 10:50:26 +0100
Message-ID: <20130707095026.GR9161@serenity.lan>
References: <41dc25ceac50731a7c5da753c04b7c13c41c1b51.1372876047.git.john@keeping.me.uk>
 <7vd2qzfpk9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 07 11:50:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uvlc8-0000jN-1q
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 11:50:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751535Ab3GGJug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 05:50:36 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:52446 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321Ab3GGJuf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 05:50:35 -0400
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 9515623A0A;
	Sun,  7 Jul 2013 10:50:34 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ggfzIOigOnXP; Sun,  7 Jul 2013 10:50:33 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id 1A13A23A69;
	Sun,  7 Jul 2013 10:50:28 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <7vd2qzfpk9.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229759>

On Wed, Jul 03, 2013 at 11:47:50AM -0700, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> > Since commit 00b347d (git-config: do not complain about duplicate
> > entries, 2012-10-23), "git config --get" does not exit with an error if
> > there are multiple values for the specified key but instead returns the
> > last value.  Update the documentation to reflect this.
> >
> > Signed-off-by: John Keeping <john@keeping.me.uk>
> > ---
> >  Documentation/git-config.txt | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> > index 19a7be0..fbad05e 100644
> > --- a/Documentation/git-config.txt
> > +++ b/Documentation/git-config.txt
> > @@ -82,7 +82,7 @@ OPTIONS
> >  --get::
> >  	Get the value for a given key (optionally filtered by a regex
> >  	matching the value). Returns error code 1 if the key was not
> > -	found and error code 2 if multiple key values were found.
> > +	found and the last value if multiple key values were found.
> >  
> >  --get-all::
> >  	Like get, but does not fail if the number of values for the key
> 
> Thanks.
> 
> I wondered if we should explain the significance of "last" a bit
> more (like "this results in the value from the most specific
> configuration file to be used, the ones in $GIT_DIR/config
> overriding what is in $HOME/.gitconfig"), but I do not have a strong
> opinion either way.  Let's queue this for 'maint' for now.

I don't think that change belongs here.  How about doing something like
this in the FILES section (the first two hunks are just reordering the
existing list, only the last hunk changes the content):

-- >8 --
diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index fbad05e..99dc497 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -206,12 +206,8 @@ FILES
 If not set explicitly with '--file', there are four files where
 'git config' will search for configuration options:
 
-$GIT_DIR/config::
-	Repository specific configuration file.
-
-~/.gitconfig::
-	User-specific configuration file. Also called "global"
-	configuration file.
+$(prefix)/etc/gitconfig::
+	System-wide configuration file.
 
 $XDG_CONFIG_HOME/git/config::
 	Second user-specific configuration file. If $XDG_CONFIG_HOME is not set
@@ -221,8 +217,12 @@ $XDG_CONFIG_HOME/git/config::
 	you sometimes use older versions of Git, as support for this
 	file was added fairly recently.
 
-$(prefix)/etc/gitconfig::
-	System-wide configuration file.
+~/.gitconfig::
+	User-specific configuration file. Also called "global"
+	configuration file.
+
+$GIT_DIR/config::
+	Repository specific configuration file.
 
 If no further options are given, all reading options will read all of these
 files that are available. If the global or the system-wide configuration
@@ -230,6 +230,10 @@ file are not available they will be ignored. If the repository configuration
 file is not available or readable, 'git config' will exit with a non-zero
 error code. However, in neither case will an error message be issued.
 
+The files are read in the order given above, with last value found taking
+precedence over values read earlier.  When multiple values are taken then all
+values of a key from all files will be used.
+
 All writing options will per default write to the repository specific
 configuration file. Note that this also affects options like '--replace-all'
 and '--unset'. *'git config' will only ever change one file at a time*.
