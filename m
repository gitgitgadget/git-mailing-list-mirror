From: Christian Stimming <stimming@tuhh.de>
Subject: Re: [PATCH 2/5] Internationalization of git-gui
Date: Sun, 22 Jul 2007 14:24:20 +0200
Message-ID: <200707221424.20548.stimming@tuhh.de>
References: <622391.43998.qm@web38909.mail.mud.yahoo.com> <200707211434.56622.stimming@tuhh.de> <20070722074525.GX32566@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Brett Schwarz <brett_schwarz@yahoo.com>, git@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Jul 22 14:24:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICaTw-0006Bx-8Y
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 14:24:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759632AbXGVMYN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 08:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758947AbXGVMYN
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 08:24:13 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:34082 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759632AbXGVMYM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 08:24:12 -0400
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id l6MCO73W006691
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Sun, 22 Jul 2007 14:24:07 +0200
Received: from [192.168.2.102] (p5490117A.dip0.t-ipconnect.de [84.144.17.122])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.1/8.13.1) with ESMTP id l6MCO5A9025420
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 22 Jul 2007 14:24:07 +0200
User-Agent: KMail/1.9.5
In-Reply-To: <20070722074525.GX32566@spearce.org>
Content-Disposition: inline
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53260>

Am Sonntag, 22. Juli 2007 09:45 schrieb Shawn O. Pearce:
> > Here I marked much more strings than in the previous patch, and as
> > discussed the procedure [mc ...] is used for translation. 
>
> Almost.  I noticed two that you did miss, and its because they are
> totally weird.  We may want to rewrite this block of code first...

Yes, I've noticed those two run-time strings as well; I simply deferred them 
to be dealt with at a later point in time. As you already say, they will have 
to be rewritten before they can be translated. Probably an extra layer of 
[format ...] will do.

> > @@ -1682,69 +1682,69 @@ trace add variable current_branch write
> > ".mbar.repository entryconf [.mbar.repos .mbar.repository add separator
> >
> >  .mbar.repository add command \
> > -	-label {Visualize Current Branch's History} \
> > +	-label [mc "Visualize Current Branch's History"] \
> >  	-command {do_gitk $current_branch}
> >  trace add variable current_branch write ".mbar.repository entryconf
> > [.mbar.repository index last] -label \"Visualize \$current_branch's
> > History\" ;#" .mbar.repository add command \
>
> But they are in a double quoted string and will
> be eval'd later by Tcl, so we actually need something like:
>
> - trace add variable current_branch write ".mbar.repository entryconf
> [.mbar.repository index last] -label \"Visualize \$current_branch's
> History\" ;#" + trace add variable current_branch write ".mbar.repository
> entryconf [.mbar.repository index last] -label \[mc \"Visualize
> \$current_branch's History\"\] ;#"

Err... I didn't get the latter one, but as I said, this can be deferred until 
later.

> > -	.mbar.apple add command -label "About [appname]" \
> > +	.mbar.apple add command -label [mc "About %s" appname] \
>
> Bug. This needs to be:
>
> +	.mbar.apple add command -label [mc "About %s" [appname]] \
>
> You lost one level of [] there when you did the replacement.

Oops, sorry, you are right. Also, I didn't test quite thoroughly after the 
s/_/mc/ replacement, compared to the original _ introduction, where I already 
caught this one once before.

> I only noticed this during a fast scan through while deleting text.
> I'll have to reread this patch more carefully later, before I apply
> (or merge) it, to make sure we don't have more such cases.

The appname thing was the only occurrence in this file, but it occurs several 
times.

Christian
