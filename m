From: Nicolas Pitre <nico@cam.org>
Subject: Re: [Bug?] compiler warning with gcc >= 4.2
Date: Tue, 03 Jul 2007 10:18:52 -0400 (EDT)
Message-ID: <alpine.LFD.0.999.0707030957160.26459@xanadu.home>
References: <20070703125844.GL12721@planck.djpig.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_LkgqRgYHnzldikNDtnvO/Q)"
Cc: Git Mailing List <git@vger.kernel.org>
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Tue Jul 03 16:18:57 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5jDV-0004Ip-0W
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 16:18:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756036AbXGCOSy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 10:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755090AbXGCOSy
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 10:18:54 -0400
Received: from relais.videotron.ca ([24.201.245.36]:30933 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754560AbXGCOSx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 10:18:53 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JKL003SOX3GJ6C0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 03 Jul 2007 10:18:53 -0400 (EDT)
In-reply-to: <20070703125844.GL12721@planck.djpig.de>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51497>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_LkgqRgYHnzldikNDtnvO/Q)
Content-type: TEXT/PLAIN; charset=iso-2022-jp
Content-transfer-encoding: 7BIT

On Tue, 3 Jul 2007, Frank Lichtenheld wrote:

> Hi,
> 
> while testing for an (probably) unrelated miscompilation bug,
> I got the following warning while compiling git:
> 
> gcc-4.2 -o sha1_file.o -c -g -O2 -Wall  -DSHA1_HEADER='<openssl/sha.h>'
> -DETC_GITCONFIG='"/home/djpig/etc/gitconfig"' -DNO_STRLCPY sha1_file.c
> sha1_file.c: In function ‘check_packed_git_idx’:
> sha1_file.c:523: warning: assuming signed overflow does not occur when assuming that (X + c) < X is always false
> sha1_file.c:523: warning: assuming signed overflow does not occur when assuming that (X + c) < X is always false
> 
> This comes from the new -Wstrict-overflow which warns about the fact
> that with -fstrict-overflow, which is activated by default with -O2,
> the if clause referenced in the warning will be optimised away.
> 
> So I would be interested to know
> a) if the compiler optimising this check away (which seems to be a check
>    about whether signed overflow can occour) can lead to unwanted results

Of course it can if the compiler blindly optimizes the test away.

In this particular case, the answer can be determined at compile time 
though, since all values to perform the test are constants.  So in this 
case the warning is rather obnoxious.

However it would be completely wrong if the compiler optimized away the 
if from index-pack.c on line 104, or from builtin-pack-objects.c on line 
579.  Even warning about it without actually optimizing it away would be 
bad in those cases.

> b) if not a), if it would make sense trying to suppress that warning, so
>    that other people don't end up wondering the same as me

I really wonder what's the point for gcc to warn about such things.  
Sure the warning should go away, but not by compromizing the test that 
we need performed on the actual definition of off_t.


Nicolas

--Boundary_(ID_LkgqRgYHnzldikNDtnvO/Q)--
