From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: http-push: double free or corruption (!prev): 0x09fedb50
Date: Wed, 25 Feb 2009 09:18:50 +0100 (CET)
Message-ID: <alpine.DEB.1.10.0902250912470.28808@yvahk2.pbagnpgbe.fr>
References: <94a0d4530902241545h6781aefbne275f8017d65c8ee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 25 09:24:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcF3a-0005Qw-CV
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 09:23:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756515AbZBYIWJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 03:22:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754056AbZBYIWI
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 03:22:08 -0500
Received: from kluster1.contactor.se ([91.191.140.11]:60029 "EHLO
	kluster1.contactor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754548AbZBYIWH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 03:22:07 -0500
Received: from linux2.contactor.se (linux2.contactor.se [91.191.140.14])
	by kluster1.contactor.se (8.13.8/8.13.8/Debian-3) with ESMTP id n1P8Lx5J022825
	for <git@vger.kernel.org>; Wed, 25 Feb 2009 09:21:59 +0100
X-X-Sender: dast@linux2.contactor.se
In-Reply-To: <94a0d4530902241545h6781aefbne275f8017d65c8ee@mail.gmail.com>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111389>

On Wed, 25 Feb 2009, Felipe Contreras wrote:

> I'm trying to push over https and I keep getting a crash. "curl -netrc 
> https://server/repo/HEAD" seems to work fine.

> I'm attaching the output of valgrind and this is the backtrace (not on
> the same run):

> #6  0x064d5b37 in PR_Free (ptr=0x0) at
> ../../../mozilla/nsprpub/pr/src/malloc/prmem.c:490
> #7  0x00df72f8 in nss_ZRealloc (pointer=0x9fedb58, newSize=4096) at arena.c:1076
> #8  0x00de579b in pem_CreateObject (fwInstance=0x8109ba0,
> fwSession=0x810bac8, mdToken=0x8109cf8, pTemplate=0xbfffd6e4,
> ulAttributeCount=4, pError=0xbfffd608) at pobject.c:1080

[...]

> Any ideas?

You didn't mention what libcurl version you use, but clearly this is built to 
use NSS for the SSL layer so I guess you're using a Fedora-provided library.

There's already at least one NSS-libcurl-git related bug report[*] for Fedora 
submitted and I think you'll have a reason to follow that to see if you can 
help them or they can help you. To me this looks like at least one NSS bug.

In the mean time I suggest you attempt a work-around: build a new libcurl 
powered by another SSL library such as OpenSSL or GnuTLS. It's just a matter 
of running libcurl's configure with the proper command line

[*] = https://bugzilla.redhat.com/show_bug.cgi?id=483222

-- 

  / daniel.haxx.se
