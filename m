From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC v3 0/6] N-th last checked out branch
Date: Sat, 17 Jan 2009 06:52:22 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901170646560.3586@pacific.mpi-cbg.de>
References: <7v8wpcs38c.fsf@gitster.siamese.dyndns.org> <1232163011-20088-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junio@pobox.com>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Johan Herland <johan@herland.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Jan 17 06:53:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LO47S-0005tl-Er
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 06:53:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751732AbZAQFv2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 00:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751712AbZAQFv2
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 00:51:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:57556 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751689AbZAQFv1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 00:51:27 -0500
Received: (qmail invoked by alias); 17 Jan 2009 05:51:25 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp002) with SMTP; 17 Jan 2009 06:51:25 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/A8NY+IPXA/Ot36b4YoRwazdyvzGBCs7D7o+UqXD
	YQ1G+3fnrpDsWu
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1232163011-20088-1-git-send-email-trast@student.ethz.ch>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106029>

Hi,

On Sat, 17 Jan 2009, Thomas Rast wrote:

>  Documentation/git-checkout.txt  |    4 +
>  Documentation/git-rev-parse.txt |    3 +
>  builtin-checkout.c              |   15 ++-
>  cache.h                         |    1 +
>  refs.c                          |  285 +++++++++++++++++++++++----------------
>  refs.h                          |    1 +
>  sha1_name.c                     |   79 +++++++++++-
>  t/t1505-rev-parse-last.sh       |   71 ++++++++++
>  t/t2012-checkout-last.sh        |   50 +++++++
>  9 files changed, 387 insertions(+), 122 deletions(-)
>  create mode 100755 t/t1505-rev-parse-last.sh
>  create mode 100755 t/t2012-checkout-last.sh

Let's quickly compare that to what Junio sent:

 builtin-checkout.c |   10 +++++-
 cache.h            |    1 +
 sha1_name.c        |   78 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 87 insertions(+), 2 deletions(-)

Granted, the documentation and tests are nice, but why that big change in 
refs.c?  After all, the more you change in one go, the more you can break.

Let's take one step back.  The two things that Junio's patch left to be 
desired (in addition to documentation and tests) are

- reflogs are traversed twice.  While this is not a showstopper, it is 
  easily improved by building a string_list and then picking the one entry 
  we're interested in, and

- the '-' handling you seem to want.

I really have to ask: why did you not work on top of Junio's patch, just 
adding docs, tests, and checkout -?  And then -- maybe -- the 
string_list...

Although I have to admit that I am not _that_ convinced the string_list is 
worth it: reflogs are not evaluated all the time, so it is definitely not 
performance critical.

Ciao,
Dscho
