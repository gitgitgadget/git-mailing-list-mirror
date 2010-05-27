From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: git pull works remotely but not locally
Date: Thu, 27 May 2010 21:53:54 +0200
Message-ID: <201005272153.54239.j6t@kdbg.org>
References: <4BFE750B.5030007@llaisdy.com> <AANLkTimDOOjbCRJMOlW8sTEtiHdI4AqjdOcdFug7MD94@mail.gmail.com> <4BFE9172.9080209@llaisdy.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Ivan Uemlianin <ivan@llaisdy.com>
X-From: git-owner@vger.kernel.org Thu May 27 21:57:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHjCb-0008VX-Ky
	for gcvg-git-2@lo.gmane.org; Thu, 27 May 2010 21:57:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756560Ab0E0T4u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 May 2010 15:56:50 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:47258 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751497Ab0E0T4t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 May 2010 15:56:49 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id CC25EA7EEA;
	Thu, 27 May 2010 21:56:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 4FE7D19F758;
	Thu, 27 May 2010 21:53:54 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <4BFE9172.9080209@llaisdy.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147896>

On Donnerstag, 27. Mai 2010, Ivan Uemlianin wrote:
> - I did configure with prefix=/opt
> - odd thing: nothing was installed into /opt: it all went into /root (I
> might have been root for the whole process, which I know is bad).  I
> just cp'd everything over to /opt, and everything worked OK (until now).

My guess is:

- You built as root.
- I don't know what went wrong with the command that involved prefix=/opt.
- But when you finally build using 'make', it picked the default prefix, which 
is /root when you are root.
- This hard-codes the libexec path to /root/libexec/git-core.
- Even after you copy the stuff to /opt, git looks in /root/libexec/...
- As a normal user you do not have access to /root, ergo, Permission denied.

Rebuild as normal user with

   make prefix=/opt

and install as root with

   make prefix=/opt install

(Yes, prefix must be given also for 'make install'.)

-- Hannes
