From: Chris Webb <chris@arachsys.com>
Subject: Re: [PATCH v5 00/14] New remote-hg helper
Date: Sun, 11 Nov 2012 22:17:13 +0000
Message-ID: <20121111221712.GB2774@arachsys.com>
References: <1351571736-4682-1-git-send-email-felipe.contreras@gmail.com>
 <20121030102526.GN4891@arachsys.com>
 <CAMP44s1g8rFGP7UOcvp9BEZ1oiSh3+-gYheciqO8Fmghipot8A@mail.gmail.com>
 <20121030180021.GX26850@arachsys.com>
 <CAMP44s1-VOetN+e49UgJtpbpwYN2EBVYBzw5j_KoqXu6sbbaHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 23:17:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXfqS-0005Ph-UQ
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 23:17:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752780Ab2KKWRX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 17:17:23 -0500
Received: from alpha.arachsys.com ([91.203.57.7]:52512 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752303Ab2KKWRX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 17:17:23 -0500
Received: from [81.2.114.212] (helo=arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.80)
	(envelope-from <chris@arachsys.com>)
	id 1TXfqD-0004VM-RJ; Sun, 11 Nov 2012 22:17:22 +0000
Content-Disposition: inline
In-Reply-To: <CAMP44s1-VOetN+e49UgJtpbpwYN2EBVYBzw5j_KoqXu6sbbaHA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209451>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Implemented now. I'm not handling the 'tip' revision, but most likely
> it's also the '.' revision. In this case a fake 'master' bookmark will
> be created to track that revision.

Hi Felipe. Sorry for the slow response, I've been snowed under with work and
have only just got around to testing your latest version.

The new remote-hg.track-branches=false option is great and does exactly what
I was hoping for. For the benefit of the list archives, one natural way to
use it is

  git clone -c remote-hg.track-branches=false hg::foo

when cloning the relevant repositories, if you don't want the setting
globally for every hg-remote clone.

During testing, I've seen some strange behaviour which I think is caused by
using the . revision instead of tip:

$ hg init h
$ hg init h2
$ ( cd h && touch foo && hg add foo && hg commit -m foo && hg push ../h2 )
pushing to ../h2
searching for changes
adding changesets
adding manifests
adding file changes
added 1 changesets with 1 changes to 1 files
$ git clone hg::h g
Cloning into 'g'...
$ git clone hg::h2 g2
Cloning into 'g2'...
warning: remote HEAD refers to nonexistent ref, unable to checkout.
$

The reason for this is that by default . == null (not tip) in the repo h2
which we pushed into from h. The hg equivalent of a bare repo typically has a
null checkout like this. (Actually, the checkout of HEAD seems to break
whenever . is different from tip, not just when it's null as in this example.)

Apart from this, everything seems solid and works well. Really useful; thanks!

Best wishes,

Chris.
