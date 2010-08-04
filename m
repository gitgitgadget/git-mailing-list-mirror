From: =?UTF-8?B?Q2zDqW1lbnQgUG91bGFpbg==?= 
	<clement.poulain@ensimag.imag.fr>
Subject: Re: [BUG] git gui blame  fails for multi-word textconv filter
Date: Thu, 05 Aug 2010 01:46:29 +0200
Message-ID: <4C59FBD5.5090209@ensimag.imag.fr>
References: <20100804192525.GA13086@landau.phys.spbu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>, git@vger.kernel.org
To: Kirill Smelkov <kirr@landau.phys.spbu.ru>
X-From: git-owner@vger.kernel.org Thu Aug 05 01:46:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ognfb-00069U-KL
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 01:46:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758490Ab0HDXqf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Aug 2010 19:46:35 -0400
Received: from smtp21.services.sfr.fr ([93.17.128.1]:3209 "EHLO
	smtp21.services.sfr.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756588Ab0HDXqe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Aug 2010 19:46:34 -0400
Received: from filter.sfr.fr (localhost [127.0.0.1])
	by msfrf2119.sfr.fr (SMTP Server) with ESMTP id 83E77700008D;
	Thu,  5 Aug 2010 01:46:32 +0200 (CEST)
Received: from [192.168.1.20] (239.12.94-79.rev.gaoland.net [79.94.12.239])
	by msfrf2119.sfr.fr (SMTP Server) with ESMTP id 4C8E07000084;
	Thu,  5 Aug 2010 01:46:32 +0200 (CEST)
X-SFR-UUID: 20100804234632313.4C8E07000084@msfrf2119.sfr.fr
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; fr; rv:1.9.1.11) Gecko/20100711 Thunderbird/3.0.6
In-Reply-To: <20100804192525.GA13086@landau.phys.spbu.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152612>

Le 04/08/2010 21:25, Kirill Smelkov a =C3=A9crit :
> Hello,
>
> I use
>
>      [diff "astextplain"]
>          textconv =3D run-mailcap --action=3Dcat
>
> in my ~/.gitconfig, and this works for git `git blame` because of 41a=
457
> in git.git (textconv: use shell to run helper), but fails with git gu=
i:
>
>      $ git gui blame 21980.2--=D0=98=D0=9C=D0=A1-=D0=9C=D0=A0231.doc
>      Error in startup script: couldn't execute "run-mailcap --action=3D=
cat": no such file or directory
>   =20
I wonder if spaces can be the reason of this. Looks like Tcl is looking=
=20
for an executable called "run-mailcap --action=3Dcat", and doesn't=20
distinguish path from options.
I do not have much experience with Tcl, so I can't figure out how to=20
solve that. Some help would be appreciate :-)
>          while executing
>      "open |[list $textconv $path] r"
>          (procedure "_load" line 56)
>          invoked from within
>      "_load $this $i_jump"
>          (procedure "blame::new" line 185)
>          invoked from within
>      "blame::new $head $path $jump_spec"
>          ("blame" arm line 6)
>          invoked from within
>      "switch -- $subcommand {
>              browser {
>                      if {$jump_spec ne {}} usage
>                      if {$head eq {}} {
>                              if {$path ne {}&&  [file isdirectory $pa=
th]} {
>                                      set head $..."
>          ("blame" arm line 57)
>          invoked from within
>      "switch -- $subcommand {
>      browser -
>      blame {
>              if {$subcommand eq "blame"} {
>                      set subcommand_args {[--line=3D<num>] rev? path}
>              } else {
>                      set subcommand_a..."
>          (file "/home/kirr/local/git/libexec/git-core/git-gui" line 2=
868)
>
>
>
> Thats is maybe because we use `git cat-file --textconv` only for in .=
git
> entries, but since cat-file lacks support for work-tree git-gui calls
> textconv filter itself manually on initial "$commit eq {}"?
>   =20
Yep, "open |[list $textconv $path] r" is the way we call textconv on th=
e=20
work-tree copy of the concerned file.
> If so, I'd better teach cat-file about worktree, instead of teaching
> git-gui about running textconv filter through shell. Just a wish...
>   =20
This was discussed here: a1ace6b77167a2ad4b4995e8c4d09761@ensimag.fr ,=20
and your suggestion was considered ;-)
