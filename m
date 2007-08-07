From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: Problem with bisect
Date: Tue, 7 Aug 2007 03:50:50 +0200
Message-ID: <200708070350.50419.chriscool@tuxfamily.org>
References: <46B5F48D.7020907@lwfinger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Larry Finger <Larry.Finger@lwfinger.net>
X-From: git-owner@vger.kernel.org Tue Aug 07 03:43:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIE6j-0001iS-BQ
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 03:43:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761761AbXHGBne convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 6 Aug 2007 21:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763046AbXHGBnd
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 21:43:33 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:36640 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759052AbXHGBnd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Aug 2007 21:43:33 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id C9D731AB2B9;
	Tue,  7 Aug 2007 03:43:31 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id ACE1A1AB2B6;
	Tue,  7 Aug 2007 03:43:31 +0200 (CEST)
User-Agent: KMail/1.9.5
In-Reply-To: <46B5F48D.7020907@lwfinger.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55196>

Le dimanche 5 ao=FBt 2007 18:02, Larry Finger a =E9crit :
> I'm helping someone find what looks like a regression in bcm43xx-mac8=
0211
> between v2.6.22 and v2.6.23-rc1. This driver is not in the mainstream
> kernel, but is found in John Linville's wireless-dev git tree. When w=
e do
> the first bisection between the current state and v2.6.22, we obtain =
a
> kernel whose Makefile says it is v2.6.22; however, it's code is based=
 on
> a state before bcm43xx-mac80211 was introduced into this tree.=20

You use "git bisect good v2.6.22", but this is not true because the=20
tag "v2.6.22" is on the mainstream kernel branch and the driver is not=20
there.

If the v2.6.22 kernel that used to work came directly from John Linvill=
e's=20
wireless-dev git tree, not from a patch, then you should find the exact=
=20
commit in John Linville's tree that worked and say "git bisect good <th=
is=20
commit>".

But if the driver that worked with a mainstream v2.6.22 kernel had been=
=20
patched, and now doesn't work when the same patch is applied to mainstr=
eam=20
v2.6.23-rc1 kernel, then you can perhaps use:

git bisect start
git bisect bad v2.6.23-rc1
git bisect good v2.6.22

and then:

1) patch the kernel with the driver patch,
2) test the patched kernel,
3) remove the patch,
4) say "git bisect good" or "git bisect bad"
5) go to step 1) until the commit that broke the driver is found

Best regards,
Christian.
