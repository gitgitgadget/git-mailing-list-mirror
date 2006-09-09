From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: support perl 5.6
Date: Sun, 10 Sep 2006 00:20:09 +0200
Organization: At home
Message-ID: <edveli$p2m$1@sea.gmane.org>
References: <20060909145914.GA25289@liacs.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sun Sep 10 00:20:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMBB7-000531-RS
	for gcvg-git@gmane.org; Sun, 10 Sep 2006 00:19:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964972AbWIIWTw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 9 Sep 2006 18:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964973AbWIIWTw
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Sep 2006 18:19:52 -0400
Received: from main.gmane.org ([80.91.229.2]:62898 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964972AbWIIWTu (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Sep 2006 18:19:50 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GMBAm-0004yE-CT
	for git@vger.kernel.org; Sun, 10 Sep 2006 00:19:36 +0200
Received: from host-81-190-21-28.torun.mm.pl ([81.190.21.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 10 Sep 2006 00:19:36 +0200
Received: from jnareb by host-81-190-21-28.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 10 Sep 2006 00:19:36 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-28.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26772>

Sven Verdoolaege wrote:

> +# returns pipe reading from git command with given arguments
> +sub git_pipe {
> +=A0=A0=A0=A0=A0=A0=A0open my $fd, "-|", join(' ', git_cmd(), @_) or =
return undef;
> +=A0=A0=A0=A0=A0=A0=A0return $fd;
> +}
> +

I'm sorry, but this is not enough. For example the $file_name argument
should be quoted in shell, i.e. in three argument magic open "-|". So
either you return to your old patch, which changes each list form of op=
en
"-|" into old three argument form (which adds penalty of additional she=
ll
invocation, and is prone to shell interpretation of arguments), and
sometimes add quotes (e.g. "... \'$file_name\' ..."), or (what would be
better) to reimplement list form of open "-|" using two argument forkin=
g
open "-|", and doing exec in child, a la "Safe Pipe Opens" in perlipc(3=
pm).

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
