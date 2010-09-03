From: Andreas Gruenbacher <agruen@suse.de>
Subject: Re: [bug-patch] [BUG?] rename patch accepted with --dry-run, rejected without (Re: [PATCH V3] arm & sh: factorised duplicated clkdev.c)
Date: Sat, 4 Sep 2010 00:58:17 +0200
Organization: SUSE Labs
Message-ID: <201009040058.18028.agruen@suse.de>
References: <1283431716-21540-1-git-send-email-plagnioj@jcrosoft.com> <20100903182323.GA17152@pengutronix.de> <20100903184351.GC2341@burratino>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: bug-patch@gnu.org,
	"Uwe =?utf-8?q?Kleine-K=C3=B6nig?=" <u.kleine-koenig@pengutronix.de>,
	linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	"Jean-Christophe PLAGNIOL-VILLARD" <plagnioj@jcrosoft.com>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: linux-sh-owner@vger.kernel.org Sat Sep 04 01:04:10 2010
Return-path: <linux-sh-owner@vger.kernel.org>
Envelope-to: glps-linuxsh-dev@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-sh-owner@vger.kernel.org>)
	id 1OrfIn-0005vR-Nm
	for glps-linuxsh-dev@lo.gmane.org; Sat, 04 Sep 2010 01:04:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753105Ab0ICXEI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glps-linuxsh-dev@m.gmane.org>);
	Fri, 3 Sep 2010 19:04:08 -0400
Received: from cantor.suse.de ([195.135.220.2]:48509 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752399Ab0ICXEH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sh@vger.kernel.org>); Fri, 3 Sep 2010 19:04:07 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id EEC0F93987;
	Sat,  4 Sep 2010 01:04:05 +0200 (CEST)
User-Agent: KMail/1.12.4 (Linux/2.6.31.12-0.2-desktop; KDE/4.3.5; i686; ; )
In-Reply-To: <20100903184351.GC2341@burratino>
Sender: linux-sh-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155282>

Hi,

On Friday 03 September 2010 20:43:51 Jonathan Nieder wrote:
> Uwe Kleine-K=C3=B6nig wrote:
> > On Fri, Sep 03, 2010 at 07:18:43PM +0900, Magnus Damm wrote:
>=20
> >> Using --dry-run is fine, but omitting dry-run gives me:
> >>=20
> >> ...
> >> patching file arch/arm/common/clkdev.c
> >> patching file arch/sh/include/asm/clkdev.h
> >> Hunk #1 FAILED at 1.
> >> Hunk #2 FAILED at 11.
> >> 2 out of 2 hunks FAILED -- saving rejects to file
> >> arch/sh/include/asm/clkdev.h.rej
> >>=20
> >> I guess this is caused by the last "renaming" hunk, see below.
>=20
> Yep, I can reproduce this.  Patch applies with "git apply",
> "patch --dry-run -p1" accepts it, "patch -p1" fails.
>=20
>  $ patch --version | head -1
>  GNU patch 2.6.1.85-423d
>  $ cd ~/src/linux-2.6
>  $ git checkout 2bfc96a12
>  $ git clean -fd
>  $ wget http://download.gmane.org/gmane.linux.ports.sh.devel/8747/874=
8
> [...]

something pretty bizarre is going on here.  The wget output modifies th=
e same=20
file twice, but both patches to this file have the same source sha1 (56=
45f35):

> diff --git a/arch/sh/include/asm/clkdev.h b/arch/sh/include/asm/clkde=
v.h
> dissimilarity index 69%
> index 5645f35..6ba9186 100644
> --- a/arch/sh/include/asm/clkdev.h
> +++ b/arch/sh/include/asm/clkdev.h

> diff --git a/arch/sh/include/asm/clkdev.h b/include/linux/clkdev.h
> similarity index 85%
> rename from arch/sh/include/asm/clkdev.h
> rename to include/linux/clkdev.h
> index 5645f35..457bcb0 100644

So "git apply" and "patch --dry-run" seem to work only by accident.

How was this patch generated: with git itself?

The fact that "patch --dry-run" may not work for patches that modify th=
e same=20
file twice is a known defect.  I don't know how to solve this in a reas=
onably=20
elegant way.  Luckily the problem only triggers when people are doing=20
something "strange" such as concatenating patches.

Andreas
