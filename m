From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: get git not to care about permissions
Date: Thu, 12 Nov 2009 17:10:43 +0100
Message-ID: <200911121710.44314.trast@student.ethz.ch>
References: <26268938.post@talk.nabble.com> <76718490911112144n6837d02cw94d608bcbc74855a@mail.gmail.com> <3cf217d80911120744g5e020003rc00c460fff0bff1d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jay Soffian <jaysoffian@gmail.com>, <git@vger.kernel.org>
To: Matt Schoen <mtschoen@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 12 17:11:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8cGu-0001dB-Qy
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 17:11:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753422AbZKLQLe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Nov 2009 11:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753305AbZKLQLd
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 11:11:33 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:26942 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753295AbZKLQLd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2009 11:11:33 -0500
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.176.0; Thu, 12 Nov
 2009 17:11:37 +0100
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Thu, 12 Nov
 2009 17:11:27 +0100
User-Agent: KMail/1.12.3 (Linux/2.6.27.29-0.1-default; KDE/4.3.3; x86_64; ; )
In-Reply-To: <3cf217d80911120744g5e020003rc00c460fff0bff1d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132780>

Matt Schoen wrote:
> error: Unable to open
> /ad/eng/courses/ec/ec464/ec464-team03/test.git/HEAD.lock for writing
> 
> ls -al in the directory gives me:
> total 12
> drwx------ 3 schoen root 4096 Nov 12 10:41 .
> d--------- 7 root   root 4096 Nov 12 10:41 ..
> -rwx------ 1 schoen root    0 Nov 12 10:41 HEAD.lock

At least in my current copy, this can only come from

	// lock.c:1371
	lockpath = mkpath("%s.lock", git_HEAD);
	fd = open(lockpath, O_CREAT | O_EXCL | O_WRONLY, 0666);
	if (fd < 0) {
		error("Unable to open %s for writing", lockpath);

It prints an absolute path, so the open() also accesses an absolute
path (though I don't know why it insists on that).

But the above directory listing would indicate that you do not even
have permission to look inside your $(pwd) by absolute path...

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
