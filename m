From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [BUG] Using git-completion with automounted home directories causes bogus NFS mount requests
Date: Thu, 17 Jun 2010 22:02:54 +0200
Message-ID: <201006172202.54879.trast@student.ethz.ch>
References: <B0356A858DE69744B8977A67332BFB2C1FE9CDAD@dc1.mv.cariden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Cesar Crusius <cesar@cariden.com>
X-From: git-owner@vger.kernel.org Thu Jun 17 22:03:09 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPLIo-0000kU-JG
	for gcvg-git-2@lo.gmane.org; Thu, 17 Jun 2010 22:03:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933217Ab0FQUC6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jun 2010 16:02:58 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:39729 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933204Ab0FQUC6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jun 2010 16:02:58 -0400
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Thu, 17 Jun
 2010 22:02:55 +0200
Received: from thomas.localnet (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.254.0; Thu, 17 Jun
 2010 22:02:55 +0200
User-Agent: KMail/1.13.3 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.3; x86_64; ; )
In-Reply-To: <B0356A858DE69744B8977A67332BFB2C1FE9CDAD@dc1.mv.cariden.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149324>

Cesar Crusius wrote:
> Hi all,
> 
> I have tried this with various versions of .git-completion,
> including the most recent one as of today, and whenever I have
> __git_ps1 in my bash prompt, I get messages like this:
> 
> Jun 17 12:05:14 sunray automountd[471]: [ID 834250 daemon.error] Mount of <server>:/export/home/.git on /home/.git: No such file or directory
[...]
> This is probably a result of git/git-completion trying to access the
> directories above, and automount trying to get them from the server
> (we're in an NFS home environment, with wildcard automounts in
> auto_home).

It's not a bug.  Git repositories have only one .git metadata
directory at the root of the repo.  How could git possibly detect
where the repository is, if not by scanning each directory up to the
root for a .git entry?

For a workaround, set GIT_CEILING_DIRECTORIES (available since 1.6.0),
see git(1).  The next released version will most likely default to not
searching across mount points thanks to commit 8030e44 (Add support
for GIT_ONE_FILESYSTEM, 2010-03-17).

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
