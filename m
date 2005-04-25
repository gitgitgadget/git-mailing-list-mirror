From: Matt Domsch <Matt_Domsch@dell.com>
Subject: Re: Git-commits mailing list feed.
Date: Sun, 24 Apr 2005 21:34:20 -0500
Message-ID: <20050425023420.GA14696@lists.us.dell.com>
References: <1114266083.3419.40.camel@localhost.localdomain> <426A5BFC.1020507@ppp0.net> <1114266907.3419.43.camel@localhost.localdomain> <Pine.LNX.4.58.0504231010580.2344@ppc970.osdl.org> <20050423175422.GA7100@cip.informatik.uni-erlangen.de> <Pine.LNX.4.58.0504231125330.2344@ppc970.osdl.org> <2911.10.10.10.24.1114279589.squirrel@linux1> <Pine.LNX.4.58.0504231234550.2344@ppc970.osdl.org> <Pine.LNX.4.62.0504250008370.14200@sheen.jakma.org> <426C4168.6030008@dwheeler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Jakma <paul@clubi.ie>, Linus Torvalds <torvalds@osdl.org>,
	Sean <seanlkml@sympatico.ca>,
	Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	David Woodhouse <dwmw2@infradead.org>,
	Jan Dittmer <jdittmer@ppp0.net>, Greg KH <greg@kroah.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 25 04:31:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPtN3-0000ym-RR
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 04:30:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262463AbVDYCfj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 22:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262465AbVDYCff
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 22:35:35 -0400
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:4902 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S262459AbVDYCfW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2005 22:35:22 -0400
Received: from lists.us.dell.com (143.166.224.162)
  by ausc60pc101.us.dell.com with ESMTP; 24 Apr 2005 21:34:21 -0500
X-IronPort-AV: i="3.92,127,1112590800"; 
   d="scan'208"; a="252136203:sNHT27718624"
To: "David A. Wheeler" <dwheeler@dwheeler.com>
Content-Disposition: inline
In-Reply-To: <426C4168.6030008@dwheeler.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 24, 2005 at 09:01:28PM -0400, David A. Wheeler wrote:
> It may be better to have them as simple detached signatures, which are
> completely separate files (see gpg --detached).
> Yeah, gpg currently implements detached signatures
> by repeating what gets signed, which is unfortunate,
> but the _idea_ is the right one.

I solve this with two simple scripts, "sign" calls "cutsig".

--------------
sign

#!/bin/sh

DEFAULT_KEY="my-private-key-string"
CUTSIG=~/bin/cutsig.pl
usage()
{
    echo "usage: $0 filename"
    echo " produces filename.sign"
}

if [ $# -lt 1 ]; then
   usage
   exit 1;
fi

gpg --armor --clearsign --detach-sign --default-key "${DEFAULT_KEY} -v -v -o - ${1} | \
${CUTSIG} > ${1}.sign

exit 0


-----------------
cutsig


#!/usr/bin/perl -w

do {
    $line = <STDIN>;
} until $line =~ "-----BEGIN PGP SIGNATURE-----";


print $line;
while ( $line = <STDIN>) {
    print $line;
}

exit 0;
