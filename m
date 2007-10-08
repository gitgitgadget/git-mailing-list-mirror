From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/2] rev-list: implement --bisect-all
Date: Mon, 8 Oct 2007 07:08:45 +0200
Message-ID: <200710080708.46579.chriscool@tuxfamily.org>
References: <20071008053438.6a829b91.chriscool@tuxfamily.org> <Pine.LNX.4.64.0710080442420.4174@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio Hamano <junkio@cox.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 08 07:02:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeklB-0002cd-8t
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 07:02:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbXJHFBi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Oct 2007 01:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbXJHFBh
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Oct 2007 01:01:37 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:49934 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751138AbXJHFBg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Oct 2007 01:01:36 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 6EE0F1AB2C0;
	Mon,  8 Oct 2007 07:01:35 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 527031AB2AB;
	Mon,  8 Oct 2007 07:01:35 +0200 (CEST)
User-Agent: KMail/1.9.7
In-Reply-To: <Pine.LNX.4.64.0710080442420.4174@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60289>

Hi Dscho,

Le lundi 8 octobre 2007, Johannes Schindelin a =E9crit :
> Hi,
>
> On Mon, 8 Oct 2007, Christian Couder wrote:
> > This option makes it possible to see all the potential bisection
> > points. The best ones are displayed first.
>
> Would it not be better to pass --bisect-vars a list of commits that w=
e do
> not want to see?  It could then mark them as "DUNNO", and still just
> output a single commit.

The problem is that after --bisect-vars we already pass some "good" and=
 then=20
a bad commit. So we have to use another flag like --bisect-dunno and pu=
t=20
the dunno commits after this one.

Then there is the problem that revision.c reorders arguments and doesn'=
t=20
know about "--bisect-*" flags. It is also used by a lot of other comman=
ds.

After struggling with revision.c for some time, I thought it would be=20
simpler and safer to come up first with something in shell.

Also please note that in some cases we cannot just output a single comm=
it,=20
because we just dunno which commit is the first bad one.

> IMHO such a logic does not belong into a shell script, but into the C
> core.

There is a lot of the bisect logic implemented in git-bisect.sh already=
=2E The=20
long term plan is to rewrite it in C, but I am not sure that the "dunno=
"=20
logic should be the first part of it to be done in C.

Also I thought it was still fine to prototype new features in shell.

Best regards,
Christian.
