From: "Alfred M\. Szmidt" <ams@gnu.org>
Subject: Re: git-svn -- out of memory
Date: Mon, 16 Feb 2009 15:23:40 +0100
Message-ID: <1234794220.676511.4320.nullmailer@beryx.hq.kred>
Reply-To: ams@gnu.org
Cc: normalperson@yhbt.net, git@vger.kernel.org, peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 15:27:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ4Q7-000621-FC
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 15:26:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756383AbZBPOYe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 09:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755263AbZBPOYe
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 09:24:34 -0500
Received: from hq.kreditor.se ([213.136.42.58]:1443 "EHLO auxid.hq.kred"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753870AbZBPOYd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 09:24:33 -0500
Received: by auxid.hq.kred (Postfix, from userid 118)
	id E61DB1379520; Mon, 16 Feb 2009 15:24:24 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on auxid.hq.kred
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=5.0 tests=AWL autolearn=disabled 
	version=3.1.7-deb
Received: from beryx.hq.kred (unknown [10.16.0.106])
	by auxid.hq.kred (Postfix) with SMTP id 77CEA1379598;
	Mon, 16 Feb 2009 15:23:49 +0100 (CET)
Received: (nullmailer pid 4321 invoked by uid 1000);
	Mon, 16 Feb 2009 14:23:40 -0000
In-reply-to: message from Junio C Hamano on Mon, 16 Feb 2009 02:05:54 -0800
References: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110183>

   >    > when doing a `git svn clone' on a subversion repository that contains
   >    > a large file (>1GiB), `git svn' dies with the following:
   >    > 
   >    > ams@trillian:~$ git svn clone REPO -T trunk -b branches -t tags
   >    > [...]
   >    > fatal: Out of memory? mmap failed: Cannot allocate memory
   >    > hash-object -w --stdin-paths: command returned error: 128

   Ding...

   >    > git version 1.6.1.3
   >
   >    Core git requires objects to be able to fit into (virtual) memory.
   >    Adding more swap space should solve the problem for you, but this is not
   >    only a git-svn problem.
   >
   > In this case, the machine has 32G RAM, including ~20G swap.  So I do
   > not think that this is the case, it could be I suppose...

   The hash-object error message sounds like the issue that was fixed with
   915308b (avoid 31-bit truncation in write_loose_object, 2009-01-29).  Does
   v1.6.2-rc1 help?

ams@trillian:~/# git --version
git version 1.6.2.rc1
ams@trillian:~/# git svn clone REPO -T trunk -b branches -t tags
[...]
fatal: Out of memory? mmap failed: Cannot allocate memory
hash-object -w --stdin-paths: command returned error: 128

Nope, behaves the same way.

I'll try adding more swap and see what happens...

Thanks for the help.
