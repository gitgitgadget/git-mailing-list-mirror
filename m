From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Subject: [BUG] git gui blame  fails for multi-word textconv filter
Date: Wed, 4 Aug 2010 23:25:25 +0400
Message-ID: <20100804192525.GA13086@landau.phys.spbu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Clment Poulain <clement.poulain@ensimag.imag.fr>,
	git@vger.kernel.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Wed Aug 04 21:45:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgjuI-0006gz-Gg
	for gcvg-git-2@lo.gmane.org; Wed, 04 Aug 2010 21:45:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758651Ab0HDTpg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Aug 2010 15:45:36 -0400
Received: from landau.phys.spbu.ru ([195.19.235.38]:34447 "EHLO
	landau.phys.spbu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758643Ab0HDTpg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Aug 2010 15:45:36 -0400
X-Greylist: delayed 1207 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Aug 2010 15:45:36 EDT
Received: by landau.phys.spbu.ru (Postfix, from userid 506)
	id 9BCE6FF659; Wed,  4 Aug 2010 23:25:25 +0400 (MSD)
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152598>

Hello,

I use

    [diff "astextplain"]
        textconv =3D run-mailcap --action=3Dcat

in my ~/.gitconfig, and this works for git `git blame` because of 41a45=
7
in git.git (textconv: use shell to run helper), but fails with git gui:

    $ git gui blame 21980.2--=D0=98=D0=9C=D0=A1-=D0=9C=D0=A0231.doc
    Error in startup script: couldn't execute "run-mailcap --action=3Dc=
at": no such file or directory
        while executing
    "open |[list $textconv $path] r"
        (procedure "_load" line 56)
        invoked from within
    "_load $this $i_jump"
        (procedure "blame::new" line 185)
        invoked from within
    "blame::new $head $path $jump_spec"
        ("blame" arm line 6)
        invoked from within
    "switch -- $subcommand {
            browser {
                    if {$jump_spec ne {}} usage
                    if {$head eq {}} {
                            if {$path ne {} && [file isdirectory $path]=
} {
                                    set head $..."
        ("blame" arm line 57)
        invoked from within
    "switch -- $subcommand {
    browser -
    blame {
            if {$subcommand eq "blame"} {
                    set subcommand_args {[--line=3D<num>] rev? path}
            } else {
                    set subcommand_a..."
        (file "/home/kirr/local/git/libexec/git-core/git-gui" line 2868=
)



Thats is maybe because we use `git cat-file --textconv` only for in .gi=
t
entries, but since cat-file lacks support for work-tree git-gui calls
textconv filter itself manually on initial "$commit eq {}"?

If so, I'd better teach cat-file about worktree, instead of teaching
git-gui about running textconv filter through shell. Just a wish...


Thanks,
Kirill


P.S. And thanks for finally collecting all those git-gui patches.
