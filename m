From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <Uwe.Kleine-Koenig@digi.com>
Subject: Re: bash completion only provides revs, not paths
Date: Wed, 23 Apr 2008 07:56:37 +0200
Message-ID: <20080423055637.GA25446@digi.com>
References: <20080422112129.GA30923@digi.com> <20080423015236.GM29771@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Apr 23 08:06:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoY6b-0007fw-5M
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 08:05:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752284AbYDWGEY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Apr 2008 02:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752133AbYDWGEX
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 02:04:23 -0400
Received: from mail164.messagelabs.com ([216.82.253.131]:20192 "EHLO
	mail164.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757AbYDWGEW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 02:04:22 -0400
X-VirusChecked: Checked
X-Env-Sender: Uwe.Kleine-Koenig@digi.com
X-Msg-Ref: server-7.tower-164.messagelabs.com!1208930603!4533652!4
X-StarScan-Version: 5.5.12.14.2; banners=-,-,-
X-Originating-IP: [66.77.174.14]
Received: (qmail 6383 invoked from network); 23 Apr 2008 06:03:25 -0000
Received: from mail.mx2.digi.com (HELO mcl-sms-ns2.DIGI.COM) (66.77.174.14)
  by server-7.tower-164.messagelabs.com with RC4-SHA encrypted SMTP; 23 Apr 2008 06:03:25 -0000
Received: from mcl-sms-exch01.digi.com (10.5.8.50) by mail.mx2.digi.com
 (172.16.1.14) with Microsoft SMTP Server (TLS) id 8.1.263.0; Wed, 23 Apr 2008
 01:02:30 -0500
Received: from mtk-sms-mail01.digi.com (10.10.8.120) by
 mcl-sms-exch01.digi.com (10.5.8.50) with Microsoft SMTP Server id 8.1.263.0;
 Wed, 23 Apr 2008 01:03:23 -0500
Received: from dor-sms-mail1.digi.com ([10.49.1.105]) by
 mtk-sms-mail01.digi.com with Microsoft SMTPSVC(6.0.3790.3959);	 Wed, 23 Apr
 2008 00:56:40 -0500
Received: from zentaur.digi.com ([10.100.10.144]) by dor-sms-mail1.digi.com
 with Microsoft SMTPSVC(6.0.3790.3959);	 Wed, 23 Apr 2008 07:56:37 +0200
Received: by zentaur.digi.com (Postfix, from userid 1080)	id 8C0692AB12; Wed,
 23 Apr 2008 07:56:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080423015236.GM29771@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-OriginalArrivalTime: 23 Apr 2008 05:56:38.0031 (UTC) FILETIME=[CB5CE9F0:01C8A506]
X-TM-AS-Product-Ver: SMEX-8.0.0.1181-5.500.1026-15866.004
X-TM-AS-Result: No--21.759000-8.000000-31
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80189>

Hello Shawn,

Shawn O. Pearce wrote:
> Uwe Kleine-Knig <Uwe.Kleine-Koenig@digi.com> wrote:
> > currently autocompletion in=20
> >=20
> > 	ukleinek@zentaur:~/gsrc/linux-2.6 git log ar<tab>
> >=20
> > only yields "armltd/" (i.e. the prefix of some remote tracking bran=
ches)
> > but most of the time I want it to complete to "arch/".
>=20
> Right.  It favors refs over paths.  Why?  Because I complete refs
> more than I complete paths.
> =20
> > I don't understand that autocompletion stuff, but probably to fix t=
hat
> > several __git_complete_revlist should be replaced by a
> > __git_complete_revlist_or_path.  The harder part is to implement th=
e
> > latter function.  An optimal implementation would only give back pa=
ths
> > if there is a "--" somewhere before the cursor.
>=20
> Its ugly, but if we only do path name completion after a -- then
> we can just return "" as the options to bash, and it will go off
> and do the path name completion itself.  If we do path names and
> and refs at the same time, that's a disaster waiting to happen.
> We would have to do the path name completion ourselves.
I thought compgen can be used for that:

	ukleinek@zentaur:~/gsrc/linux-2.6$ compgen -f ar
	arch

> How is this?
I like it and have already applied it.
=20
> --8<--
> bash completion: Completely only path names after -- in options
>=20
> If the user has inserted a -- before the current argument we are
> being asked to complete they are most likely trying to force Git into
> treating this argument as a path name, and not as a ref.  We should
> allow bash to complete it as a path from the local working directory.
>=20
> Suggested-by: Uwe Kleine-Knig <Uwe.Kleine-Koenig@digi.com>
There is a letter missing in my name.  I wonder why it's always the onl=
y
non-ascii one :-)

Best regards and thanks,
Uwe

--=20
Uwe Kleine-K=F6nig, Software Engineer
Digi International GmbH Branch Breisach, K=FCferstrasse 8, 79206 Breisa=
ch, Germany
Tax: 315/5781/0242 / VAT: DE153662976 / Reg. Amtsgericht Dortmund HRB 1=
3962
