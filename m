From: Johan Herland <johan@herland.net>
Subject: Re: [BUG?] How to make a shared/restricted repo?
Date: Wed, 25 Mar 2009 03:11:56 +0100
Message-ID: <200903250311.56300.johan@herland.net>
References: <200903250105.05808.johan@herland.net>
 <7vvdpybf9i.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 03:13:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmIce-0003We-Ad
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 03:13:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755881AbZCYCMF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 22:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755812AbZCYCMC
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 22:12:02 -0400
Received: from mx.getmail.no ([84.208.15.66]:41933 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754109AbZCYCMA (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Mar 2009 22:12:00 -0400
Content-disposition: inline
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KH100JOXI3XN800@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 25 Mar 2009 03:11:57 +0100 (MET)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KH100A4OI3WICA0@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 25 Mar 2009 03:11:57 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.3.25.15816
User-Agent: KMail/1.11.1 (Linux/2.6.28-ARCH; KDE/4.2.1; x86_64; ; )
In-reply-to: <7vvdpybf9i.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114539>

On Wednesday 25 March 2009, Junio C Hamano wrote:
> You might like to try a patch like this (untested).
>
>  path.c |   17 +++++------------
>  1 files changed, 5 insertions(+), 12 deletions(-)

Thanks!

This works much better :)

However, there are still some questions/issues:

- t1301-shared-repo.sh fails:
    Oops, .git/HEAD is not 0664 but -rw-rw---- [...]
    * FAIL 3: shared=1 does not clear bits preset by umask 022
  (I guess this is expected, as your patch changes the assumptions)

- Loose objects and pack files are still world-readable.

- Shared repos are no longer world-readable by default (requires
  "--shared=all" to be world-readable). This might be
  confusing to old users with lenient umasks, and should probably be
  mentioned in the documentation. AFAICS, it also has nasty effects
  on existing repos with core.sharedRepository == 1. We should probably
  re-roll the patch adding a new keyword (e.g. "group-only"), instead of
  changing the semantics of existing keywords/modes.

- Files/dirs copied from template directory are still world-readable.
  (This is not a big deal at all)


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
