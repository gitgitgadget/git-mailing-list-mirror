From: "Crabtree, Andrew" <andrew.crabtree@hp.com>
Subject: Problem with Git rev-list output
Date: Tue, 12 Aug 2014 01:10:28 +0000
Message-ID: <B82B660D4887C042850326C2BC65FE035D5151C3@G9W0768.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 12 03:12:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XH0dF-0002By-Ls
	for gcvg-git-2@plane.gmane.org; Tue, 12 Aug 2014 03:12:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752087AbaHLBMF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2014 21:12:05 -0400
Received: from g4t3425.houston.hp.com ([15.201.208.53]:34259 "EHLO
	g4t3425.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752001AbaHLBME convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Aug 2014 21:12:04 -0400
Received: from G4W6310.americas.hpqcorp.net (g4w6310.houston.hp.com [16.210.26.217])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by g4t3425.houston.hp.com (Postfix) with ESMTPS id CC1DD99
	for <git@vger.kernel.org>; Tue, 12 Aug 2014 01:12:02 +0000 (UTC)
Received: from G9W3616.americas.hpqcorp.net (16.216.186.51) by
 G4W6310.americas.hpqcorp.net (16.210.26.217) with Microsoft SMTP Server (TLS)
 id 14.3.169.1; Tue, 12 Aug 2014 01:10:30 +0000
Received: from G9W0768.americas.hpqcorp.net ([169.254.4.10]) by
 G9W3616.americas.hpqcorp.net ([16.216.186.51]) with mapi id 14.03.0169.001;
 Tue, 12 Aug 2014 01:10:30 +0000
Thread-Topic: Problem with Git rev-list output
Thread-Index: Ac+1yNdz5Kc+fCv+Rt6vp0zBEz4t1g==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [15.201.58.21]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255143>

I'm seeing some oddity in one of my repositories where the root commit is being output in 'rev-list' even when I pass in a reference that should exclude it from being output.

I've attempted to reproduce the issue in a test environment but so far have failed at that.

Problem details below as best as I can capture them.  

Seeing the issue with versions of git from 1.7 to 2.1.

Thanks,
-Andrew

The root commit is here 

me@myvm:/pnb/software/userrepos/cache/t4_ghs.git  (BARE:titan4_v14_a)$ git cat-file -p 848de9c422c01c1f724d5c3f615bec476911f59f
tree 5be87811b44f560159d9bb6a10a9fe9bd59147b9
author Migration Script <migration@gaia.rose.hp.com> 1318778853 -0700
committer Gustavo Mora Corrales <gustavo.mora.corrales@hp.com> 1318778853 -0700

Initial synchronization commit
me@myvm:/pnb/software/userrepos/cache/t4_ghs.git  (BARE:titan4_v14_a)$ git --version
git version 2.1.0.rc2.3.g67de23d
me@myvm:/pnb/software/userrepos/cache/t4_ghs.git  (BARE:titan4_v14_a)$ git merge-base WALLE-J-14-60-GIT_07-DEC-2011 samrom_t4a
848de9c422c01c1f724d5c3f615bec476911f59f
me@myvm:/pnb/software/userrepos/cache/t4_ghs.git  (BARE:titan4_v14_a)$ git rev-list 848de9c422c01c1f724d5c3f615bec476911f59f
848de9c422c01c1f724d5c3f615bec476911f59f
me@myvm:/pnb/software/userrepos/cache/t4_ghs.git  (BARE:titan4_v14_a)$ git rev-list WALLE-J-14-60-GIT_07-DEC-2011 | wc -l 
2132
me@myvm:/pnb/software/userrepos/cache/t4_ghs.git  (BARE:titan4_v14_a)$ git rev-list samrom_t4a | wc -l
316
me@myvm:/pnb/software/userrepos/cache/t4_ghs.git  (BARE:titan4_v14_a)$ git rev-list WALLE-J-14-60-GIT_07-DEC-2011 samrom_t4a | wc -l
2447

# commit is reachable from both references as expected 

me@myvm:/pnb/software/userrepos/cache/t4_ghs.git  (BARE:titan4_v14_a)$ git rev-list WALLE-J-14-60-GIT_07-DEC-2011 | grep 848de9c422c01c1f724d5c3f615bec476911f59f
848de9c422c01c1f724d5c3f615bec476911f59f
me@myvm:/pnb/software/userrepos/cache/t4_ghs.git  (BARE:titan4_v14_a)$ git rev-list samrom_t4a | grep 848de9c422c01c1f724d5c3f615bec476911f59f
848de9c422c01c1f724d5c3f615bec476911f59f

# Here -I would have expected --preceding the SHA with -boundary specified
me@myvm:/pnb/software/userrepos/cache/t4_ghs.git  (BARE:titan4_v14_a)$ git rev-list --boundary WALLE-J-14-60-GIT_07-DEC-2011 samrom_t4a | grep 848de9c422c01c1f724d5c3f615bec476911f59f
848de9c422c01c1f724d5c3f615bec476911f59f

# here I don't expect the SHA to show up with either command line.
me@myvm:/pnb/software/userrepos/cache/t4_ghs.git  (BARE:titan4_v14_a)$ git rev-list WALLE-J-14-60-GIT_07-DEC-2011 ^samrom_t4a | grep 848de9c422c01c1f724d5c3f615bec476911f59f
848de9c422c01c1f724d5c3f615bec476911f59f
me@myvm:/pnb/software/userrepos/cache/t4_ghs.git  (BARE:titan4_v14_a)$ git rev-list samrom_t4a ^WALLE-J-14-60-GIT_07-DEC-2011 | grep 848de9c422c01c1f724d5c3f615bec476911f59f
me@myvm:/pnb/software/userrepos/cache/t4_ghs.git  (BARE:titan4_v14_a)$
