From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFH] Exploration of an alternative diff_delta() algorithm
Date: Sun, 09 Apr 2006 13:14:31 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0604091307460.2215@localhost.localdomain>
References: <20060409143117.GA23908@erlang.gbar.dtu.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 09 19:14:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FSdUi-0008FG-2I
	for gcvg-git@gmane.org; Sun, 09 Apr 2006 19:14:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWDIROd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Apr 2006 13:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbWDIROd
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Apr 2006 13:14:33 -0400
Received: from relais.videotron.ca ([24.201.245.36]:19310 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1750761AbWDIROc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Apr 2006 13:14:32 -0400
Received: from xanadu.home ([74.56.105.38]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IXG0042RT879460@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 09 Apr 2006 13:14:32 -0400 (EDT)
In-reply-to: <20060409143117.GA23908@erlang.gbar.dtu.dk>
X-X-Sender: nico@localhost.localdomain
To: Peter Eriksen <s022018@student.dtu.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18551>

On Sun, 9 Apr 2006, Peter Eriksen wrote:

> Greetings Gitlings,
> 
> I've been trying to implement an alternative algorithm
> for diff_delta().  I'm getting close to something that
> works, but now I'm stuck!  I think it has something to
> do with pack-objects.c, but I'm not sure.  Here's the
> first test that fails:
> 
> *** t5500-fetch-pack.sh ***
> * FAIL 1: 1st pull
>         git-fetch-pack -v .. B A > log.txt 2>&1
> * FAIL 2: fsck
>         git-fsck-objects --full > fsck.txt 2>&1
> * FAIL 3: new object count after 1st pull
>         test 33 = 0
> * FAIL 4: minimal count
>         test 33 = 0
> * FAIL 5: repack && prune-packed in client
>         (git-repack && git-prune-packed)2>>log.txt
> *   ok 5: 2nd pull
> *   ok 6: fsck
> * FAIL 7: new object count after 2nd pull
>         test 192 = 198
> * FAIL 8: minimal count
>         test 192 = 198
> * FAIL 9: repack && prune-packed in client
>         (git-repack && git-prune-packed)2>>log.txt
> *   ok 9: 3rd pull
> *   ok 10: fsck
> * FAIL 11: new object count after 3rd pull
>         test 3 = 228
> * FAIL 12: minimal count
>         test 3 = 30
> * failed 8 among 12 test(s)
> 
> I've been looking all around the current diff_delta(), and I
> can't see, what I'm missing.  Any ideas?  The file is meant to
> replace the current diff-delta.c.

Nothing outside diff-delta.c and patch-delta.c is aware of the delta 
data format.  So if your version is meant to be a transparent 
replacement then it should pass all tests.  If it doesn't then it is 
broken.

To help you play around you could try the test-delta utility (make 
test-delta to build it).

So:

	test-delta -d file1 file2 delta_file
	test-delta -p file1 delta_file file3
	cmp file2 file3

You should always have file3 identical to file2.


Nicolas
