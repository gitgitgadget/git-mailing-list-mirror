From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/8] gitweb: We do longer need the --parents flag in rev-list.
Date: Mon, 25 Dec 2006 23:49:27 +0100
Organization: At home
Message-ID: <empkcf$qp$1@sea.gmane.org>
References: <11669707092427-git-send-email-robfitz@273k.net> <11669707094097-git-send-email-robfitz@273k.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Mon Dec 25 23:47:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GyybT-00040B-Lx
	for gcvg-git@gmane.org; Mon, 25 Dec 2006 23:47:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754550AbWLYWrZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 25 Dec 2006 17:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754556AbWLYWrZ
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Dec 2006 17:47:25 -0500
Received: from main.gmane.org ([80.91.229.2]:47841 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754550AbWLYWrY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Dec 2006 17:47:24 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Gyyb8-00048F-E7
	for git@vger.kernel.org; Mon, 25 Dec 2006 23:47:10 +0100
Received: from host-81-190-19-121.torun.mm.pl ([81.190.19.121])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 25 Dec 2006 23:47:10 +0100
Received: from jnareb by host-81-190-19-121.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 25 Dec 2006 23:47:10 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-19-121.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35398>

Robert Fitzsimons wrote:

> We only want to know the direct parents of a given commit object,
> these parents are available in the --header output of rev-list. =A0If
> --parents is supplied with --full-history the output includes merge
> commits that aren't relevant.

Actually --header output gives us original parents. Rewritten parents
(available with --parents) include also grafts and shallow clone grafts=
=2E
=46or parse_commit we want --parents, for parse_commits we don't want i=
t
because --parents affects --full-history.

The problem is that we cannot detect if git-rev-list was called with
--parents and commit is root commit (parentless), or we didn't use
--parents option.

In few other places we pass options specifying subroutine behavior
as hash after all other requred parameters, e.g.=20
  esc_html($line, -nbsp=3D>1),
  parse_ls_tree_line($line, -z=3D>1),=20
  git_print_log($co{'comment'}, -final_empty_line=3D> 1, -remove_title =
=3D> 1);
In this case it wouldn't work (unless we pass reference to array,
via parse_commit_text( [ <$fd> ], -parents=3D>1);

Perhaps it would be better to use reference to hash of options as _firs=
t_
parameter, e.g. parse_commit_text({-parents=3D>1}, <$fd>);, and use som=
ething
like if (ref($[0]) =3D=3D 'HASH') { $opts =3D shift @_; } to get option=
s.

So for now gitweb might not show what we want in very rare cases of
repositories with grafts or shallow clones.


But apart from this small matter, this series is excellent work. Thanks=
!=20
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
