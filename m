From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: bug in bash completion for git-branch --set-upstream-to on OSX
Date: Sun, 22 Mar 2015 12:06:12 +0100
Message-ID: <20150322120612.Horde.LAxCkP-VMKE3Ur7ZXII3Hg1@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jason Karns <karns.17@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 22 12:07:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZdie-0002OL-Jc
	for gcvg-git-2@plane.gmane.org; Sun, 22 Mar 2015 12:07:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751669AbbCVLG4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Mar 2015 07:06:56 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:48927 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751070AbbCVLGz convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2015 07:06:55 -0400
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1YZdiY-0005AE-2h; Sun, 22 Mar 2015 12:06:54 +0100
Received: from apache by webmail.ira.uka.de with local (Exim 4.72)
	(envelope-from <szeder@ira.uka.de>)
	id 1YZdi2-0005Ue-Ce; Sun, 22 Mar 2015 12:06:22 +0100
Received: from x590d7fa5.dyn.telefonica.de (x590d7fa5.dyn.telefonica.de
 [89.13.127.165]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Sun, 22 Mar 2015 12:06:12 +0100
User-Agent: Internet Messaging Program (IMP) H5 (6.2.2)
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1427022414.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266067>


Hi,

Quoting Jason Karns <karns.17@gmail.com>:

> There appears to be a bug in the bash completion for git-branch when
> attempting to complete the remote ref argument for --set-upstream-to=3D
>
> When:
>
> $ git branch --set-upstream-to=3Dorigin/mast<TAB>
>
> I would expect it to complete to:
>
> $ git branch --set-upstream-to=3Dorigin/master
>
> However, the completion for --set-upstream-to=3D completes the ref
> correctly, but completely wipes the --set-upstream option; resulting
> in:
>
> $ git branch origin/master

Strange.

The code in question

    case "$cur" in
    --set-upstream-to=3D*)
            __gitcomp "$(__git_refs)" "" "${cur##--set-upstream-to=3D}"
            ;;

looks unsuspicious, this is the "standard" way to complete
'--option=3D<TAB>' (except that we should use __gitcomp_nl() for =20
completing refs, but that should have no effect on this issue).  Does =20
the same issue affect other 'git cmd --option=3D<TAB>' completions as =20
well, e.g. 'git log --date=3D<TAB>' or 'git commit --reuse-message=3D<T=
AB>'?

We had a similar issue with ':' on the command line a looong while
ago, see v1.5.6.4~9^2 (bash completion: Resolve git show ref:path<tab>
losing ref: portion, 2008-07-15).  Maybe we are dealing with the same =20
issue here, just a different character?

What does

    printf "$COMP_WORDBREAKS" |tr ' \t\n' STN

print out?  Is the '=3D' missing, perhaps?  If that's indeed the case,
does adding it back (COMP_WORDBREAKS=3D"$COMP_WORDBREAKS"=3D) fix the i=
ssue?

G=C3=A1bor
