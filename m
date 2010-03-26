From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Tree with leading '0' modes in 1.7.0.3
Date: Fri, 26 Mar 2010 14:56:00 -0700
Message-ID: <20100326215600.GA10910@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git <git@vger.kernel.org>, mike.lifeguard@gmail.com
X-From: git-owner@vger.kernel.org Fri Mar 26 22:56:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvHW8-00038t-8Y
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 22:56:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754108Ab0CZV4H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 17:56:07 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:32872 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752276Ab0CZV4F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 17:56:05 -0400
Received: by gwaa18 with SMTP id a18so2906381gwa.19
        for <git@vger.kernel.org>; Fri, 26 Mar 2010 14:56:03 -0700 (PDT)
Received: by 10.90.2.4 with SMTP id 4mr1201871agb.14.1269640562785;
        Fri, 26 Mar 2010 14:56:02 -0700 (PDT)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 22sm1153873iwn.0.2010.03.26.14.56.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Mar 2010 14:56:01 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143288>

Mike (CC'd) found a bad Git tree today, where the modes for subtrees
where formatted using a leading '0':

  $ od -c tree
  0000000   1   0   0   6   4   4       R   E   A   D   M   E  \0 244  \r
  0000020 233 214 350 375   0 263 374 227 264 343   $ 031 027   ` 373 301
  0000040   !   h   0   4   0   0   0   0       m   o   d   u   l   e   s
  0000060  \0 262   z   K 240   4 377   \ 245   C   c   " 231 377  \n   t
  0000100   ,  \n   O   R   E   0   4   0   0   0   0       s   t   e   w
  0000120   a   r   d   b   o   t  \0 037  \b   5 262 345 234 034 303   C
  0000140 373 335 207 300   u 341 277  \f   ] 320 207
  0000153

The '0' on the 3rd line after '! h' is wrong.  It shouldn't be here.
Likewise the '0' on the 5th line after "O R E" is also wrong.
At least its consistently broken.  But its still broken by fsck
standards:

 $ git fsck --full a39aa6d
 warning in tree a39aa6d4a6dcfd6c14d8f818bbdf1dfcb3e11771: contains zero-padded file modes

Mike claims this tree was created with git-core 1.7.0.3.  This thread
actually started over on Gerrit Code Review's mailing list [1],
because JGit refuses to allow this malformed tree mode to pass its
fsck implementation.

Any ideas?  Why is Git 1.7.0.3 jamming a leading '0' on a file mode?


[1] https://groups.google.com/group/repo-discuss/browse_thread/thread/6ff8d7ffba5a9775

-- 
Shawn.
