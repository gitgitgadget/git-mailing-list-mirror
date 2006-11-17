X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Cleaning up git user-interface warts
Date: Fri, 17 Nov 2006 14:25:56 +0100
Organization: At home
Message-ID: <ejkd6g$vog$1@sea.gmane.org>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org>	<87hcx1u934.wl%cworth@cworth.org>	<Pine.LNX.4.64.0611141518590.2591@xanadu.home>	<87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org>	<Pine.LNX.4.64.0611141633430.2591@xanadu.home>	<7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.64.0611142007010.2591@xanadu.home>	<7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.64.0611142306090.2591@xanadu.home>	<Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>	<455BBCE9.4050503@xs4all.nl>	<Pine.LNX.4.64.0611151908130.3349@woody.osdl.org>	<455C412D.1030408@xs4all.nl> <7v7ixvbq80.fsf@assigned-by-dhcp.cox.net> <455C618A.7080309@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Fri, 17 Nov 2006 13:25:40 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 44
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31696>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gl3id-0006v3-3S for gcvg-git@gmane.org; Fri, 17 Nov
 2006 14:25:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933604AbWKQNZT convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006 08:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933605AbWKQNZT
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 08:25:19 -0500
Received: from main.gmane.org ([80.91.229.2]:49387 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S933604AbWKQNZS (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 08:25:18 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gl3iM-0006rx-7D for git@vger.kernel.org; Fri, 17 Nov 2006 14:25:06 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 17 Nov 2006 14:25:06 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 17 Nov 2006
 14:25:06 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Han-Wen Nienhuys wrote:

> As another example: =A0annoyances regarding program invocation
>=20
> =A0 - option handling: -x -f -z !=3D -xfz , "--max-count 1" doesn't w=
ork,=20
> but needs an '=3D'

That's true, and the probable cause is that git tries to first, avoid
dependency on options parsers like getopt/getopt_long/argp or popt for
commands in C, getopt for commands in shell, Getopt::Std/Getopt::Long f=
or
commands in Perl, and something for commands in Python (if there are an=
y
left); second, existing options parsers do not deal (I think) with
distinction between arguments to wrapper and arguments to command, '--'=
 to
separate revisions from pathnames not options from arguments, and the w=
hole
revisions and revision list specifying syntax (where "a --not b" is not
equivalent to "--not a b").

That said, perhaps we should craft our own options parsing (or modify
existing one)...

> =A0 - git --help lists an unordered set, which is too long scan quick=
ly.=20

It is one page of alphabetically ordered commands.

git(7) gives whole list of commands, divided into categories, by the wa=
y.

> I'd expect that list to either contain everything or the minimum set =
for=20
> daily use. I.e. the set introduced in a first tutorial. =A0Why are me=
rge,=20
> prune, verify-tag there?
>=20
> Try "bzr help" for comparison.

I wonder why "repack" isn't there, if "prune" is.

> =A0 - --pretty option with wholly uninformative options full, medium,=
=20
> short, raw. =A0It's not even documented what each option does.

And 'oneline' and undocumented 'email'. True, git lacks documentation (=
and
this one of main complaints in git survey).
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

