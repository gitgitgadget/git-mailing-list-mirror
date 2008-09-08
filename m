From: Jan Engelhardt <jengelh@medozas.de>
Subject: Re: Gitk and --no-walk don't play together
Date: Mon, 8 Sep 2008 13:25:12 -0400 (EDT)
Message-ID: <alpine.LNX.1.10.0809081310260.1621@fbirervta.pbzchgretzou.qr>
References: <alpine.LNX.1.10.0809081223360.1621@fbirervta.pbzchgretzou.qr> <adf1fd3d0809080934s67b2a8b1w19aeb3d8e5f8b4ab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Santi Bejar <santi@agolina.net>
X-From: git-owner@vger.kernel.org Mon Sep 08 19:26:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KckVV-0005aM-Lq
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 19:26:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753243AbYIHRZQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 13:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752624AbYIHRZQ
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 13:25:16 -0400
Received: from sovereign.computergmbh.de ([85.214.69.204]:46752 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752617AbYIHRZO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 13:25:14 -0400
Received: by sovereign.computergmbh.de (Postfix, from userid 25121)
	id BCEB818032C94; Mon,  8 Sep 2008 19:25:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by sovereign.computergmbh.de (Postfix) with ESMTP id AECB41D1145B4;
	Mon,  8 Sep 2008 13:25:12 -0400 (EDT)
In-Reply-To: <adf1fd3d0809080934s67b2a8b1w19aeb3d8e5f8b4ab@mail.gmail.com>
User-Agent: Alpine 1.10 (LNX 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95275>


On Monday 2008-09-08 12:34, Santi Bejar wrote:
>
>> in an attempt to only show only the tags in the graph, gitk barfs:
>
>Use the "List references" in the file menu.

Nope, the intention was to have gitk display something like

* Linux 2.6.26
|
* Linux 2.6.25

without any intermediate commits.

>> $ gitk --no-walk v2.6.25 v2.6.26
>> [ Error reading commits: child killed: segmentation violation ]
>
>At least, you should say the git version, the OS and platform.

Right you are. gitk 1.5.4.3 and Linux 2.6.24.7.

>It is the child process that segfaults, you could try "git rev-list
>--no-walk v2.6.25 v2.6.26" directly and even try to debug it?

rev-list completes without any problems. I straced gitk, and see:

	git log --no-color -z --pretty=raw --topo-order
	--parents --boundary --no-walk v2.6.25 v2.6.26

To reproduce:

	git log [with all that arguments] >/dev/null; echo $?
	Segmentation fault
	139

It is fixed in v1.6.0.1-267-gec3a4ba. Bisect identified that 
3131b71 fixed it:

    Add "--show-all" revision walker flag for debugging


So case closed and thank you ;-)
Jan
