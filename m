From: Pat Thoyts <patthoyts@gmail.com>
Subject: Re: [PATCH] git-gui: provide question helper for retry fallback on Windows
Date: Thu, 24 Mar 2011 00:06:32 +0000
Message-ID: <AANLkTikwa=PikZvAtvo_5FNuhG_D1052WsL5FraJMwic@mail.gmail.com>
References: <20110323203119.GA23905@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pat Thoyts <patthoyts@googlemail.com>, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Thu Mar 24 01:06:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2Y4W-0006Fe-M7
	for gcvg-git-2@lo.gmane.org; Thu, 24 Mar 2011 01:06:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933377Ab1CXAGg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Mar 2011 20:06:36 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:36044 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932887Ab1CXAGd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Mar 2011 20:06:33 -0400
Received: by mail-iy0-f174.google.com with SMTP id 26so9094360iyb.19
        for <git@vger.kernel.org>; Wed, 23 Mar 2011 17:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=N0q1CXfDvxRLj2oHTnv+DB7WzZKgAmm/wMdnCRP/CV4=;
        b=EMQAFuRf1R80167VqW9/2j0TNNW3rsqOKLA9ZNdu3uOxtu0FaDrL2+mKlvnHdsxi4E
         yBjGCG3bvy/1GK+qfzSqZuUYM3Lf+gN3gwaZMc43hHoT6598OxLPyTJl/dvZn43MjtEq
         xgQJOZ8q1XaLwhoITwGUxRFivDKk6dVakRML4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Z8pK9ru0NZ9yDuEiw7YKkBNbam8ynAVhUQvZdZYpmrd57Aqne/qbklSafC/0Ywz7Wr
         H9f3qEGhNdIUE5pezFK83x3AvL45moD1ltIwzuqqf+bq+T68Pz0MMo60o/5iaSrOIyon
         0UXsazbuTQ3+E6KhvZ/e2RVDw/3XGnU2/uR/8=
Received: by 10.43.55.83 with SMTP id vx19mr3840931icb.24.1300925193112; Wed,
 23 Mar 2011 17:06:33 -0700 (PDT)
Received: by 10.231.208.7 with HTTP; Wed, 23 Mar 2011 17:06:32 -0700 (PDT)
In-Reply-To: <20110323203119.GA23905@book.hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169880>

On 23 March 2011 20:31, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> Make use of the new environment variable GIT_ASK_YESNO to support the
> recently implemented fallback in case unlink, rename or rmdir fail fo=
r
> files in use on Windows. The added dialog will present a yes/no quest=
ion
> to the the user which will currently be used by the windows compat la=
yer
> to let the user retry a failed file operation.
>
> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
> ---
>
> Since the infrastructure for this is now in Junio's master lets also =
add
> it to git-gui. This patch contains a fix of the question helper which
> correctly wraps long lines in questions. I also disabled the
> resizeability of the dialog because the text would not be rewrapped
> anyway.
>
> Cheers Heiko
>
> =C2=A0Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0| =C2=A0 =C2=A02 +
> =C2=A0git-gui.sh =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| =C2=A0 =C2=A03 ++
> =C2=A0git-gui/git-gui--askyesno | =C2=A0 52 +++++++++++++++++++++++++=
++++++++++++++++++++
> =C2=A03 files changed, 57 insertions(+), 0 deletions(-)
> =C2=A0create mode 100755 git-gui/git-gui--askyesno
>
> diff --git a/Makefile b/Makefile
> index e22ba5c..d50b455 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -290,6 +290,7 @@ install: all
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$(QUIET)$(INSTALL_D0)'$(DESTDIR_SQ)$(gitex=
ecdir_SQ)' $(INSTALL_D1)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$(QUIET)$(INSTALL_X0)git-gui $(INSTALL_X1)=
 '$(DESTDIR_SQ)$(gitexecdir_SQ)'
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$(QUIET)$(INSTALL_X0)git-gui--askpass $(IN=
STALL_X1) '$(DESTDIR_SQ)$(gitexecdir_SQ)'
> + =C2=A0 =C2=A0 =C2=A0 $(QUIET)$(INSTALL_X0)git-gui--askyesno $(INSTA=
LL_X1) '$(DESTDIR_SQ)$(gitexecdir_SQ)'
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$(QUIET)$(foreach p,$(GITGUI_BUILT_INS), $=
(INSTALL_L0)'$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' $(INSTALL_L1)'$(DESTDIR_=
SQ)$(gitexecdir_SQ)/git-gui' $(INSTALL_L2)'$(DESTDIR_SQ)$(gitexecdir_SQ=
)/$p' $(INSTALL_L3) &&) true
> =C2=A0ifdef GITGUI_WINDOWS_WRAPPER
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$(QUIET)$(INSTALL_R0)git-gui.tcl $(INSTALL=
_R1) '$(DESTDIR_SQ)$(gitexecdir_SQ)'
> @@ -308,6 +309,7 @@ uninstall:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$(QUIET)$(CLEAN_DST) '$(DESTDIR_SQ)$(gitex=
ecdir_SQ)'
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$(QUIET)$(REMOVE_F0)'$(DESTDIR_SQ)$(gitexe=
cdir_SQ)'/git-gui $(REMOVE_F1)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$(QUIET)$(REMOVE_F0)'$(DESTDIR_SQ)$(gitexe=
cdir_SQ)'/git-gui--askpass $(REMOVE_F1)
> + =C2=A0 =C2=A0 =C2=A0 $(QUIET)$(REMOVE_F0)'$(DESTDIR_SQ)$(gitexecdir=
_SQ)'/git-gui--askyesno $(REMOVE_F1)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$(QUIET)$(foreach p,$(GITGUI_BUILT_INS), $=
(REMOVE_F0)'$(DESTDIR_SQ)$(gitexecdir_SQ)'/$p $(REMOVE_F1) &&) true
> =C2=A0ifdef GITGUI_WINDOWS_WRAPPER
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$(QUIET)$(REMOVE_F0)'$(DESTDIR_SQ)$(gitexe=
cdir_SQ)'/git-gui.tcl $(REMOVE_F1)
> diff --git a/git-gui.sh b/git-gui.sh
> index d96df63..049bc70 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -1158,6 +1158,9 @@ set have_tk85 [expr {[package vcompare $tk_vers=
ion "8.5"] >=3D 0}]
> =C2=A0if {![info exists env(SSH_ASKPASS)]} {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0set env(SSH_ASKPASS) [gitexec git-gui--ask=
pass]
> =C2=A0}
> +if {![info exists env(GIT_ASK_YESNO)]} {
> + =C2=A0 =C2=A0 =C2=A0 set env(GIT_ASK_YESNO) [gitexec git-gui--askye=
sno]
> +}
>
> =C2=A0###############################################################=
#######
> =C2=A0##
> diff --git a/git-gui/git-gui--askyesno b/git-gui/git-gui--askyesno
> new file mode 100755
> index 0000000..7604610
> --- /dev/null
> +++ b/git-gui/git-gui--askyesno
> @@ -0,0 +1,52 @@
> +#!/bin/sh
> +# Tcl ignores the next line -*- tcl -*- \
> +exec wish "$0" -- "$@"
> +
> +# This is an implementation of a simple yes no dialog
> +# which is injected into the git commandline by git gui
> +# in case a yesno question needs to be answered.
> +
> +set NS {}
> +set use_ttk [package vsatisfies [package provide Tk] 8.5]
> +if {$use_ttk} {
> + =C2=A0 =C2=A0 =C2=A0 set NS ttk
> +}
> +
> +if {$argc < 1} {
> + =C2=A0 =C2=A0 =C2=A0 puts stderr "Usage: $argv0 <question>"
> + =C2=A0 =C2=A0 =C2=A0 exit 1
> +} else {
> + =C2=A0 =C2=A0 =C2=A0 set prompt [join $argv " "]
> +}
> +
> +${NS}::frame .t
> +${NS}::label .t.m -text $prompt -justify left -width 40
> +pack .t.m -side top -fill x -padx 20 -pady 20 -expand 1
> +pack .t -side top -fill x -ipadx 20 -ipady 20 -expand 1
> +bind .t.m <Map> {.t.m configure -wraplength [winfo width .t.m]}
> +
> +${NS}::frame .b
> +${NS}::frame .b.left -width 200
> +${NS}::button .b.yes -text Yes -command yes
> +${NS}::button .b.no =C2=A0-text No =C2=A0-command no
> +
> +
> +pack .b.left -side left -expand 1 -fill x
> +pack .b.yes -side left -expand 1
> +pack .b.no -side right -expand 1 -ipadx 5
> +pack .b -side bottom -fill x -ipadx 20 -ipady 15
> +
> +bind . <Key-Return> {exit 0}
> +bind . <Key-Escape> {exit 1}
> +
> +proc no {} {
> + =C2=A0 =C2=A0 =C2=A0 exit 1
> +}
> +
> +proc yes {} {
> + =C2=A0 =C2=A0 =C2=A0 exit 0
> +}
> +
> +wm title . "Question?"
> +wm resizable . 0 0
> +tk::PlaceWindow .
> --
> 1.7.4.rc3.9.gbf3bd
>
>

Why not use the built-in message box function? This will then provide
the correct system defined look (or a suitable dialog on unix).

package require Tk
proc main {message {title "Question?"}} {
	wm withdraw .
	set r [tk_messageBox -icon question -type yesno -title $title \
			   -message $message]
	exit [expr {$r eq "yes" ? 0 : 1}]
}
eval [linsert $argv 0 main]

would seem to be equivalent.
I put up an image of the two (standard messagebox on top) at
http://www.patthoyts.tk/screenshots/happy.png

Pat.
