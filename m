From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Add local time and timezone to git_print_authorship
Date: Wed, 30 Aug 2006 11:47:12 +0200
Organization: At home
Message-ID: <ed3mqc$n6k$1@sea.gmane.org>
References: <Pine.LNX.4.64.0608281016380.27779@g5.osdl.org> <11567998513000-git-send-email-jnareb@gmail.com> <7vveocpfa3.fsf@assigned-by-dhcp.cox.net> <ed0ths$okn$1@sea.gmane.org> <7vu03voqss.fsf@assigned-by-dhcp.cox.net> <ed142v$fbi$1@sea.gmane.org> <7vlkp6kfwh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Wed Aug 30 11:52:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GIMj1-00048t-Pq
	for gcvg-git@gmane.org; Wed, 30 Aug 2006 11:51:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbWH3JvH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 30 Aug 2006 05:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbWH3JvH
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Aug 2006 05:51:07 -0400
Received: from main.gmane.org ([80.91.229.2]:17607 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750818AbWH3JvE (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Aug 2006 05:51:04 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GIMhp-0003bk-6n
	for git@vger.kernel.org; Wed, 30 Aug 2006 11:49:57 +0200
Received: from host-81-190-21-28.torun.mm.pl ([81.190.21.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 30 Aug 2006 11:49:57 +0200
Received: from jnareb by host-81-190-21-28.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 30 Aug 2006 11:49:57 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-28.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26225>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
>=20
>> Junio C Hamano wrote:
>>
>>> =A0(3) I'd like to eventually get rid of the abbreviated commit
>>> =A0 =A0 =A0object name from blame output, so the setting in gitweb.=
css
>>> =A0 =A0 =A0for table.blame td.age[012] (different colors and font
>>> =A0 =A0 =A0styles) is not appropriate for what I am shooting at.
>>
>> What do you want to replace it with? Link can be to "commit"=20
>> or "commitdiff" view, but some marker for commit=20
>> (perhaps 'git-name-rev --tags'?) is needed.
>=20
> I was hoping I can get away with a narrow single column of solid
> color that says nothing.  8 hexadecimal digits do not mean much
> to humans and it is taking 8-column or so of screen real estate
> that could otherwise be used to show the source lines instead.

I don't think that is much an issue. Source code is usually (read:
should be) 80-columns wide, and with default font size there is
certainly place for 8-column revision number. Anything more, and
much more (like e.g. default git_blame a.k.a. git_annotate output)
and it is less readable.

> I've tried doing that (just set $rev to a single space, and make
> the "Commit" column narrower in sub blame2 {}).  One drawback is
> that while 8 hexadecimal digits do not mean anything they do
> help to match lines that came from the same rev (i.e. "I do not
> know what this 8fad7343 mean but this group of lines and that
> group are tagged together with that same 8fad7343 so they must
> come from the same revision").

So what you need is to solve graph coloring problem (which is not
map coloring, as the same revisions needs the same color) for=20
revisions ;-)=20

I have an idea to use first character of commit hash together with
dark/light (odd/even) class to color blocks of lines in the same=20
revisions, 16 colors (we could reduce it to e.g. 6 or 8 colors)
with darker/lighter version.

The problem is to reduce hash to 16 or 8 bits with as small number of
collisions as possible (in average).


Yet another blame improvement idea would be to "highlight" whole _block=
_
on hover (on mouseover), but it needs changing blame output format from
table to divs (like "blob" view). BTW. table view should be I think
reserved for tabular data, i.e. when sorting by at least some of column=
s
have sense.
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
