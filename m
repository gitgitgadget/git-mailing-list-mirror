From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [test failure] t4114 binary file becomes symlink
Date: Sat, 18 Jul 2009 15:45:51 +0200
Message-ID: <20090718134551.GC16708@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 18 15:46:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSAEs-00079f-4V
	for gcvg-git-2@gmane.org; Sat, 18 Jul 2009 15:46:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751846AbZGRNp7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2009 09:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751845AbZGRNp6
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Jul 2009 09:45:58 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:36505 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751715AbZGRNp5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jul 2009 09:45:57 -0400
Received: by ey-out-2122.google.com with SMTP id 9so344482eyd.37
        for <git@vger.kernel.org>; Sat, 18 Jul 2009 06:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:mime-version:content-type:content-disposition
         :user-agent;
        bh=faCAfXU5Da9oHCc+lxVDzcCpspATVg2IKkge7jsnWSE=;
        b=yBwgJ4uNSoyVDCU1w5qj+kQ86TPu95qVkn7sqnxcIweegjdH4BZ07vy7CxpYIH9xTO
         f7aftObe38ArtdhVfW4uMiHz+yTCJVQBhbiRYe2jbev8Fer7XTmirVMrH1GooBCpXg3d
         MXy6zjJA+XobYc/kgnrMZRTivOc0PN4gLu60c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=wAu5jZSgg2ST7HihtFPtBp1xDpuLWdc8XeoYIgD9SNEVRb/X5d+maJt4tS+ZVEdSqh
         Fu8A+rrbKBc/N8tlXOioFqhC97ViwEq0G3zZzYeTSGG7RmP7sRcgRMUxci23htzeYlum
         5EgfsIVA8lIlREuwJHfussWli+6Bp/WyBpw3Y=
Received: by 10.210.42.20 with SMTP id p20mr1145515ebp.60.1247924755919;
        Sat, 18 Jul 2009 06:45:55 -0700 (PDT)
Received: from @ (91-164-151-27.rev.libertysurf.net [91.164.151.27])
        by mx.google.com with ESMTPS id 5sm942181eyf.27.2009.07.18.06.45.53
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 18 Jul 2009 06:45:54 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123520>


Hi,

Running 'sh t4114-apply-typechange.sh --verbose --debug' fails since its
introduction by b67b9612e1a90ae093445abeaeff930e9f4cf936 with this
output:


   * expecting success: 
   	git checkout -f foo-becomes-binary &&
   	git diff-tree -p --binary HEAD foo-symlinked-to-bar > patch &&
   	git apply --index < patch
   	
   ./test-lib.sh: line 234: 26816 Segmentation fault      git checkout -f
   foo-becomes-binary
   * FAIL 8: binary file becomes symlink
   	
   		git checkout -f foo-becomes-binary &&
   		git diff-tree -p --binary HEAD foo-symlinked-to-bar > patch &&
   		git apply --index < patch
   		
   
   diff --git a/foo b/foo
   deleted file mode 120000
   index ba0e162..0000000
   --- a/foo
   +++ /dev/null
   @@ -1 +0,0 @@
   -bar
   \ No newline at end of file
   diff --git a/foo b/foo
   new file mode 100644
   index 0000000..ab26de5
   --- /dev/null
   +++ b/foo
   @@ -0,0 +1 @@
   +how far is the sun?


The filesystem used is ext3 (2.6.26-gentoo-r4-v7).

I guess it's not really expected. So, I'll start my own research but I
don't know this code.

I can provide more tests if needed.

-- 
Nicolas Sebrecht
