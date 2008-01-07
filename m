From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: CRLF problems with Git on Win32
Date: Mon, 7 Jan 2008 10:57:52 +0100
Message-ID: <5C0F88FD-AB2F-4BAD-ADEC-75428F14260F@zib.de>
References: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Peter Karlsson <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Mon Jan 07 10:57:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBojT-0001vU-2d
	for gcvg-git-2@gmane.org; Mon, 07 Jan 2008 10:57:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753338AbYAGJ4u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2008 04:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753458AbYAGJ4u
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 04:56:50 -0500
Received: from mailer.zib.de ([130.73.108.11]:60980 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752958AbYAGJ4t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2008 04:56:49 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m079ukvV025845;
	Mon, 7 Jan 2008 10:56:46 +0100 (CET)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m079ujiE004562
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 7 Jan 2008 10:56:46 +0100 (MET)
In-Reply-To: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69776>


On Jan 7, 2008, at 10:16 AM, Peter Karlsson wrote:

> When I clone git://git.debian.org/git/turqstat/turqstat.git using the
> msys-Windows version of git (1.5.4-rc2), some but not all the files  
> get
> autoconverted to CRLF. Is it possible to set properties for the files
> that are text, to make sure they are converted properly?

Per default, CRLF conversion is disabled in msysgit.  Git should
not convert a single file.  Does it really convert some?

You can verify that CRLF conversion is off by running

     git config core.autocrlf

which should just print an empty line.

You can enable automatic conversion for all text files by running

     git config core.autocrlf true

(this can be set on a per-repository basis or you can set a
  default for your account if you pass the '--global' option.)

A difficulty you'll run into is that you need to set
"core.autocrlf true" before you checkout.  But because git clone
fuses git init, git fetch, and git checkout into a single
operation, you can't use it as is if you like to enable CRLF
on a per-repository basis (it works if you set a global default).

You can either use

     git clone -n URL  # -n tells clone to stop before checkout
     cd turqstat
     git config core.autocrlf true
     git checkout -b master origin/master

or you can manually do what clone would do for you, i.e.

     mkdir turqstat
     cd turqstat
     git init
     git config core.autocrlf true
     git remote add origin git://git.debian.org/git/turqstat/ 
turqstat.git
     git fetch origin
     git checkout -b master origin/master

(this is what I typically do).

BTW, I think that git clone should be improved to avoid the
workaround described above.  Maybe it could ask the user if it
should set up a specific line ending conversion before checkout.
Unfortunately, I had no time to write a patch, yet.

	Steffen
