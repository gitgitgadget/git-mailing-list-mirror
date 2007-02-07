From: Junio C Hamano <junkio@cox.net>
Subject: Re: git rebase: unexpected conflict
Date: Wed, 07 Feb 2007 12:13:35 -0800
Message-ID: <7vired7mkw.fsf@assigned-by-dhcp.cox.net>
References: <7vr6t17ohb.fsf@assigned-by-dhcp.cox.net>
	<20070207200508.GE12140@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
X-From: git-owner@vger.kernel.org Wed Feb 07 21:13:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEtAh-0001mQ-P7
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 21:13:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030658AbXBGUNh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 7 Feb 2007 15:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030660AbXBGUNh
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 15:13:37 -0500
Received: from fed1rmmtai15.cox.net ([68.230.241.44]:46922 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030659AbXBGUNg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Feb 2007 15:13:36 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070207201336.OBYS1306.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Wed, 7 Feb 2007 15:13:36 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id LkDb1W00X1kojtg0000000; Wed, 07 Feb 2007 15:13:35 -0500
In-Reply-To: <20070207200508.GE12140@mellanox.co.il> (Michael S. Tsirkin's
	message of "Wed, 7 Feb 2007 22:05:08 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38958>

"Michael S. Tsirkin" <mst@mellanox.co.il> writes:

> Sorry about being dense. What's evil there?

Sorry for being too terse to be useful.

An evil merge is a merge that introduces changes that do not
appear in any parent.

> There seems to have been a merge, and a conflict was resolved.
>
> mst@mst-lt:~/scm/linux-2.6$ git show c45aa055c32b488fc3fd73c760df372b=
09acf69a
> commit c45aa055c32b488fc3fd73c760df372b09acf69a
> Merge: 784f4d5... 8dd851d...
> Author: David Woodhouse <dwmw2@infradead.org>
> Date:   Sun Oct 22 02:17:05 2006 +0100
>
>     Merge git://git.infradead.org/~dwmw2/cafe-2.6
>
>     Conflicts:
>
>         drivers/mtd/nand/Kconfig
>
> diff --cc drivers/mtd/nand/Kconfig
> index b4b1656,5e97e63..564f79d
> --- a/drivers/mtd/nand/Kconfig
> +++ b/drivers/mtd/nand/Kconfig
> @@@ -219,6 -219,6 +219,13 @@@ config MTD_NAND_SHARPS
>         tristate "Support for NAND Flash on Sharp SL Series (C7xx + o=
thers)"
>         depends on MTD_NAND && ARCH_PXA
>
> ++config MTD_NAND_CAFE
> ++       tristate "NAND support for OLPC CAF=C3=89 chip"
> ++       depends on PCI
> ++       help
> ++       Use NAND flash attached to the CAF=C3=89 chip designed for t=
he $100
> ++       laptop.
> ++
>   config MTD_NAND_CS553X
>         tristate "NAND support for CS5535/CS5536 (AMD Geode companion=
 chip)"
>         depends on MTD_NAND && X86_32 && (X86_PC || X86_GENERICARCH)
>

Notice two plus letters?  The copy of the file in either
parents of the merge did not have these 7 lines.  These were
literally _added_ by the merge.

Since git-rebase currently ignores merge commits, while you are
rebasing your branch, your branch does not have these lines
after finishing to rebase the commit just before one.  The
commit that comes on top of this one _expects_ to have NAND_CAFE
already added in the tree, but since you do not have one, you
get a conflict.
