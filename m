From: Magnus =?iso-8859-1?Q?B=E4ck?= <baeck@swipnet.se>
Subject: Implementing stat() with FindFirstFile()
Date: Sat, 21 Mar 2009 16:47:38 +0100
Message-ID: <20090321154738.GA27249@jeeves.jpl.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 21 16:49:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ll3Rk-000471-Ig
	for gcvg-git-2@gmane.org; Sat, 21 Mar 2009 16:49:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754069AbZCUPrq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Mar 2009 11:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752915AbZCUPrq
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 11:47:46 -0400
Received: from proxy2.bredband.net ([195.54.101.72]:50712 "EHLO
	proxy2.bredband.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752732AbZCUPrq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2009 11:47:46 -0400
Received: from ironport.bredband.com (195.54.101.120) by proxy2.bredband.net (7.3.139)
        id 49C0BA210013B8DC for git@vger.kernel.org; Sat, 21 Mar 2009 16:47:42 +0100
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AqEsAJaoxElT4/BMPGdsb2JhbACBUJQVAQEBAR4XC74Jg34G
X-IronPort-AV: E=Sophos;i="4.38,399,1233529200"; 
   d="scan'208";a="497887303"
Received: from ua-83-227-240-76.cust.bredbandsbolaget.se (HELO elwood.jpl.local) ([83.227.240.76])
  by ironport1.bredband.com with ESMTP; 21 Mar 2009 16:47:42 +0100
Received: from jeeves.jpl.local (jeeves.jpl.local [192.168.7.3])
	by elwood.jpl.local (Postfix) with ESMTP id A3AFC422AF
	for <git@vger.kernel.org>; Sat, 21 Mar 2009 16:47:41 +0100 (CET)
Received: by jeeves.jpl.local (Postfix, from userid 100)
	id A4C543C2D; Sat, 21 Mar 2009 16:47:39 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114041>

Is there any reason why compat/win32.h uses GetFileAttributesEx()
instead of FindFirstFile() to implement the stat() call on Windows?
The current implementation requires each queried file to be opened
and closed while FindFirstFile() only reads the directory.

I made a couple of test programs that stat()ed the 176k files on my
disk and got the following best times with GetFileAttributesEx() and
=46indFirstFile() respectively:

=2E/getfattr.exe < filelist.txt  1.31s user 9.72s system 27% cpu 40.424=
 total
=2E/findfirst.exe < filelist.txt  1.92s user 13.98s system 95% cpu 16.6=
81 total

I searched the archive and found a couple of threads touching upon the
subject, but nothing conclusive.

I have a (trivial) patch ready if such a change would be interesting.

--=20
Magnus B=E4ck
baeck@swipnet.se
