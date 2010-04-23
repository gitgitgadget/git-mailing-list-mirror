From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: Case sensitivity on Windows for absolute paths.
Date: Fri, 23 Apr 2010 21:46:56 +0200
Message-ID: <201004232146.56424.j6t@kdbg.org>
References: <o2v7eeb06461004230712i2c8c1e61l4c50a73a4f6c83d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ricky Clarkson <ricky.clarkson@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 23 21:49:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5Osf-0005fz-PF
	for gcvg-git-2@lo.gmane.org; Fri, 23 Apr 2010 21:49:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756228Ab0DWTtZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Apr 2010 15:49:25 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:41894 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754924Ab0DWTtY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Apr 2010 15:49:24 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 69CD3CDF83;
	Fri, 23 Apr 2010 21:49:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 8115819F611;
	Fri, 23 Apr 2010 21:46:56 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <o2v7eeb06461004230712i2c8c1e61l4c50a73a4f6c83d@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145637>

On Freitag, 23. April 2010, Ricky Clarkson wrote:
> I noticed that if I have a git repository at C:\foo, and there is a
> file in there named bar, git add bar works fine, git add C:\foo/bar
> works fine but git add c:\foo/bar does not.  git reports that the file
> 'is outside repository'.  Looking at setup.c it seems that string
> comparisons are being used to determine whether a file is within the
> repository.

Yes, we should be a bit more liberal when drive letters are compared; they 
should be treated in a case-insensitive manner, but currently we are strict.

> For my purposes I can probably make a Windows build that does it while
> ignoring the case, but is there a more proper way that git should do
> it?  I'm not familiar enough with the POSIX file routines to know.

My guess is that it is sufficient that

1. the internal version of GIT_DIR is recorded with an uppercase drive letter;

2. normalize_path_copy() upper-cases the drive letter.

Then the comparison in prefix_path() should do the right thing.

-- Hannes
