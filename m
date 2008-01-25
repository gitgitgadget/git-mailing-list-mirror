From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [Btrfs-devel] btrfs and git-reflog
Date: Fri, 25 Jan 2008 09:09:05 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801250905570.14161@hp.linux-foundation.org>
References: <873asmcodd.fsf@burly.wgtn.ondioline.org> <200801251050.16697.chris.mason@oracle.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: btrfs-devel@oss.oracle.com,
	Paul Collins <paul@burly.ondioline.org>, git@vger.kernel.org
To: Chris Mason <chris.mason@oracle.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 18:10:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIS41-0007Iv-7P
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 18:10:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754511AbYAYRJ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2008 12:09:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754501AbYAYRJZ
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 12:09:25 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:41184 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754163AbYAYRJY (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Jan 2008 12:09:24 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0PH96RF031251
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 25 Jan 2008 09:09:07 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0PH95pH024531;
	Fri, 25 Jan 2008 09:09:06 -0800
In-Reply-To: <200801251050.16697.chris.mason@oracle.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.223 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71720>



On Fri, 25 Jan 2008, Chris Mason wrote:
> 
> The btrfs patch below changes my readdir code to force the
> directory f_pos field to the max offset allowed when we've
> seen all the directory entries.  This prevents the readdir
> call from looping forever in the face of newly added files.

I think such a change may be sensible if we also taught the Linux VFS 
layer about it (so that we could avoid the costly parts of readdir() 
getting a semaphore etc the next call), but in this particular format it's 
just an ugly hack for what is a git bug.

> But, git might want to add some checks to see if it has
> already processed things.

Yes indeed. This is clearly git mis-using "readdir()", and should be 
fixed. It could happen on other filesystems, and very much including ones 
where there is no option of just "fixing" the filesystem (including 
Linux: not everybody can upgrade their kernels just because git makes 
some broken assumptions).

		Linus
