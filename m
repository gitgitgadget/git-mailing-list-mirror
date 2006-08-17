From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [Possible bug] diff-tree --stat info does not count copies
Date: Thu, 17 Aug 2006 11:19:06 +0200
Message-ID: <e5bfff550608170219q12fcb34ewf93a195eabe0b94a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "GIT list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 17 11:19:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDe1z-0001mw-59
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 11:19:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbWHQJTK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Aug 2006 05:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932409AbWHQJTK
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Aug 2006 05:19:10 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:30997 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932393AbWHQJTH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Aug 2006 05:19:07 -0400
Received: by py-out-1112.google.com with SMTP id z74so1349863pyg
        for <git@vger.kernel.org>; Thu, 17 Aug 2006 02:19:06 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=HHWv4491+EAoAhWFSYwNBlwmOL/0940ortPeiaGgWveEn/b05kKpSfRFgKVGUubaEKYPWs4Vu3g62cKmmOjtIFV/D0jutn3o9JpCus14M8L2n3fE1EMQGjp6ijA7STmddkbvEjFhddJWInezUNr44YQNjoOT80G7JvyCLofUO5M=
Received: by 10.35.9.15 with SMTP id m15mr3237231pyi;
        Thu, 17 Aug 2006 02:19:06 -0700 (PDT)
Received: by 10.35.95.9 with HTTP; Thu, 17 Aug 2006 02:19:06 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25563>

While testing qgit with the new rename/copy support  I found this
(possible) bug playing on git tree.

$ git-diff-tree -r --stat 6973dca
6973dcaee76ef7b7bfcabd2f26e76205aae07858
  Makefile                      |    2
 diff-files.c                  |  212 +----
 diff-lib.c                    | 1862 ++---------------------------------------
 diff.c                        | 1795 ++++++++++++++++++++++++++++++++++++++++
 diff.h                        |    7
 t/t1001-read-tree-m-2way.sh   |    2
 t/t1002-read-tree-m-u-2way.sh |    2
 7 files changed, 1929 insertions(+), 1953 deletions(-)

$ git-diff-tree -r --stat -C 6973dca
6973dcaee76ef7b7bfcabd2f26e76205aae07858
  Makefile                      |    2
 diff-files.c                  |  212 +----
 diff-lib.c                    | 1862 ++---------------------------------------
 diff-lib.c => diff.c          |    0
 diff.h                        |    7
 t/t1001-read-tree-m-2way.sh   |    2
 t/t1002-read-tree-m-u-2way.sh |    2
 7 files changed, 134 insertions(+), 1953 deletions(-)

IMHO the bug is

   "diff-lib.c => diff.c          |    0"

instead of

   "diff-lib.c => diff.c          |    1795"

because, after the patch applied, in the repository we have
1953-1929=24 lines of code more, not 1953-134= 1819 less.

Thanks
Marco
