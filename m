X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] xdiff: add xdl_merge() (was: (unknown))
Date: Wed, 22 Nov 2006 00:15:09 +0100
Organization: At home
Message-ID: <ek0170$h53$1@sea.gmane.org>
References: <Pine.LNX.4.63.0611212316080.26827@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Tue, 21 Nov 2006 23:14:08 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 52
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32056>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmeoV-0002pv-9X for gcvg-git@gmane.org; Wed, 22 Nov
 2006 00:14:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754883AbWKUXN7 convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006 18:13:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754886AbWKUXN7
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 18:13:59 -0500
Received: from main.gmane.org ([80.91.229.2]:19407 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1754883AbWKUXN6 (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 18:13:58 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GmeoL-0002nL-6P for git@vger.kernel.org; Wed, 22 Nov 2006 00:13:53 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Wed, 22 Nov 2006 00:13:53 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 22 Nov 2006
 00:13:53 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Johannes Schindelin wrote:

> [PATCH] xdiff: add xdl_merge()

Shouldn't this be in the subject of message?

> This new function implements the functionality of RCS merge, but
> in-memory. It returns < 0 on error, otherwise the number of conflicts=
=2E

Only RCS merge, or can you implement whole diff3 (from GNU diffutils)
functionality with that?

> Finding the conflicting lines can be a very expensive task. You can
> control the eagerness of this algorithm:
>=20
> - a level value of 0 means that all overlapping changes are treated
> =A0 as conflicts,
> - a value of 1 means that if the overlapping changes are identical,
> =A0 it is not treated as a conflict.
> - If you set level to 2, overlapping changes will be analyzed, so tha=
t
> =A0 almost identical changes will not result in huge conflicts. Rathe=
r,
> =A0 only the conflicting lines will be shown inside conflict markers.
>=20
> With each increasing level, the algorithm gets slower, but more accur=
ate.
> Note that the code for level 2 depends on the simple definition of
> mmfile_t specific to git, and therefore it will be harder to port tha=
t
> to LibXDiff.

How it compares performance with RCS merge/GNU diff3?


It is really nice to have that. Bram Cohen (of Codeville, SCM built aro=
und
sophisticated merge algorithm) wrote about recursive three-way merge in
http://revctrl.org/CrissCrossMerge

   Recursive three-way merge _usually_ provides the right answer, howev=
er
   there are some edge cases. For example, conflict markers can be matc=
hed
   incorrectly, because they aren't given any special semantic meaning =
for
   the merge algorithm, and are simply treated as lines. In particular,
   there are (somewhat complicated) cases where the conflict markers of=
 two
   unrelated conflicts get matched against each other, even though the
   content sections of them are totally unrelated.

I'm not sure if he has specific examples, or is it just theoretical tal=
k,
but having built-in merge would certainly help revursive merge strategy
(and perhaps also git-rerere).

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

