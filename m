From: "Wesley J. Landaker" <wjl@icecavern.net>
Subject: Re: git fsck not identifying corrupted packs
Date: Mon, 19 Oct 2009 13:07:56 -0600
Organization: icecavern.net
Message-ID: <200910191307.56989.wjl@icecavern.net>
References: <loom.20091019T094924-194@post.gmane.org> <4ADC2D45.3020803@viscovery.net> <4ADC45C7.6090907@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Sergio Callegari <sergio.callegari@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 19 21:08:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mzxad-00057b-Hu
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 21:08:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757231AbZJSTIJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 15:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756721AbZJSTII
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 15:08:08 -0400
Received: from rinoa.icecavern.net ([92.243.7.152]:45153 "EHLO icecavern.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756561AbZJSTIH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Oct 2009 15:08:07 -0400
Received: from tonberry.icecavern.net (c-76-113-110-228.hsd1.nm.comcast.net [76.113.110.228])
	by icecavern.net (Postfix) with ESMTPSA id 0B7CD359E4;
	Mon, 19 Oct 2009 21:08:05 +0200 (CEST)
User-Agent: KMail/1.12.0 (Linux/2.6.29-2-amd64; KDE/4.3.0; x86_64; ; )
In-Reply-To: <4ADC45C7.6090907@gmail.com>
X-Face: #;qMWg=Msk*d]z]X1P2-t9]~6+RoGF$nJo89f%|Y`^whfl3Wj$X2Q_1u)ZAW@Hx|g)J]!)
 =?utf-8?q?=0A=09Br0=3FK3Imj?=)np=]r*QN,Q8].V99^Og'xl-d9FM~$yaSGB"mfXb>x[QNi[()
 =?utf-8?q?oob=60/4M42=26We=0A=09cC1jq=3DQ=5CS?=@ck\>H@
 =?utf-8?q?t=26Y7Y=3Apub=3DHOWqY=7D-d=5CwrCxvsTo7k1Ek=7DqQO=5D5=7EngK=5E=25?=
 =?utf-8?q?cT5IzmmG=5BQ=0A=09Nha=7D=5DAmI=60R-6m84VcWT4=236c?=)1`>t{$~l6:gZMtv18ge'!d[Yk-/?T3>C5O-|6On4(
 =?utf-8?q?N=7BAV=23=0A=094Eyw52=5B=3A=25Z?=>#"c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130728>

On Monday 19 October 2009 04:56:07 Sergio Callegari wrote:
> Johannes Sixt wrote:
> > Sergio Callegari schrieb:
> >> Is there a means to have fsck to a truly full check on the sanity of a
> >> repo?
> >
> > git fsck --full
> >
> > RTFM, please.
>
> Right... sorry for the noise, I mismatched --strict for --full in a
> script.
>
> BTW, the short help for fsck at --full only says "consider objects in
> alternate repositories".

Until I read this thread, I didn't realize you needed --full to check
objects in packs.

Since just every git repository I ever use has 99%+ of it's objects in
packs, this means every time I've run "git fsck" it's essentially been
a no-op and I didn't know it. I imagine this is a common confusion.

Also, having --full mean both "check alternate object pools", and "check
objects in packs" seems to be rolling up two orthogonal issues.

But anyway, here is a patch that at least fixes the short option help to
match the manual and the current behavior:

--- 8< ---
From 8fc3cd68d496bf00faad4f0a7b6ae4fee9437e68 Mon Sep 17 00:00:00 2001
From: Wesley J. Landaker <wjl@icecavern.net>
Date: Mon, 19 Oct 2009 12:48:07 -0600
Subject: [PATCH] Update git fsck --full short description to mention packs

The '--full' option to git fsck does two things:

  1) Check objects in packs
  2) Check alternate objects

This is documented in the git fsck manual; this patch reflects that in
the short git fsck option help message as well.

Signed-off-by: Wesley J. Landaker <wjl@icecavern.net>
---
 builtin-fsck.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-fsck.c b/builtin-fsck.c
index c58b0e3..63212ea 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -576,7 +576,7 @@ static struct option fsck_opts[] = {
 	OPT_BOOLEAN(0, "root", &show_root, "report root nodes"),
 	OPT_BOOLEAN(0, "cache", &keep_cache_objects, "make index objects head nodes"),
 	OPT_BOOLEAN(0, "reflogs", &include_reflogs, "make reflogs head nodes (default)"),
-	OPT_BOOLEAN(0, "full", &check_full, "also consider alternate objects"),
+	OPT_BOOLEAN(0, "full", &check_full, "also consider packs and alternate objects"),
 	OPT_BOOLEAN(0, "strict", &check_strict, "enable more strict checking"),
 	OPT_BOOLEAN(0, "lost-found", &write_lost_and_found,
 				"write dangling objects in .git/lost-found"),
-- 
1.6.5
