From: Nicolas Pitre <nico@cam.org>
Subject: Re: git packs
Date: Sun, 11 Nov 2007 23:21:58 -0500 (EST)
Message-ID: <alpine.LFD.0.9999.0711112307070.21255@xanadu.home>
References: <F6DD8DCD-416B-4DDF-B384-7213C9ED5565@mac.com>
 <alpine.LFD.0.9999.0711100011150.21255@xanadu.home>
 <FC175E4F-D9BE-42CC-B0BB-561B2EDCD941@mac.com>
 <alpine.LFD.0.999.0711092211250.15101@woody.linux-foundation.org>
 <B20E1D71-BCDB-4189-952F-3B809A342870@mac.com>
 <alpine.LFD.0.9999.0711102331270.21255@xanadu.home>
 <B298202C-3D54-498D-A348-0338914FBA46@mac.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: bob <kranki@mac.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 05:22:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrQoX-0001CP-74
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 05:22:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752814AbXKLEWA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 23:22:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752108AbXKLEWA
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 23:22:00 -0500
Received: from relais.videotron.ca ([24.201.245.36]:46859 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170AbXKLEV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 23:21:59 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JRD00CYDLGMN3I0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 11 Nov 2007 23:21:58 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <B298202C-3D54-498D-A348-0338914FBA46@mac.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64557>

On Sun, 11 Nov 2007, bob wrote:

> I applied the patch and these commands:
> 
> cd rmwHtmlOld
> rm -fr .git
> git init
> git config core.compression 0
> git add .

Note that I did "git config core.compression 0" simply to disable 
zlib compression altogether when creating the test repo just so it gets 
created faster.  even then, auto-generating and cloning a 8GB test 
repository isn't particularly quick.

> I then got the same error as before, "Bus error".  Rats!

Do you get that with a 32-bit or 64-bit build of Git?

> Then I modified your script since I do not have seq or
> your test-genrandom.

test-genrandom is built with Git.  It is just not installed anywhere.

> I substituted:
> 
> dd count=XX  if=/dev/random of=file_$i
> 
> where XX is adjusted to meet dd's requirements.  Also,

Again I used test-genrandom instead of /dev/random or /dev/urandom 
simply because the former is much faster.

> I found after searching for a while, that the following
> works just like your seq command:
> 
> xyzzy="1 2 3 4"
> for i in $xyzzy
> do
> ...
> done
> 
> Your script then ran flawlessly.

However 'seq -w 1 2 63' should be replaced  with "01 03 05 07 09 11 13 
15" and so on up to 63, and 'seq -w 2 2 64' is "02 04 06 08 10 12 16" 
and so on.

> I looked through index-pack.c some more, but it is
> very hard to figure it out without doing a lot of research
> since there doesn't seem to be anything that describes
> the layout of a pack.  The link towards the end of the user's
> manual doesn't work for me.

Look at Documentation/technical/pack-format.txt in the Git source tree.

> The difference between your test and my data is that
> instead of having a few large files, I have 11,500 files
> of varying sizes.  On average though, the file size is
> about 370k.

Are you saying that the test repo with big files works for you but not 
your own data set?

Would you please recap what your problem is?

With my one line patch you should not get the "serious inflate 
inconsistency" error anymore.  The bus error must be another issue.


Nicolas
