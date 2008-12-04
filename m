From: "Wade Berrier" <wberrier@gmail.com>
Subject: git-svn feature request: exclude certain subpaths on clone
Date: Thu, 4 Dec 2008 09:43:47 -0700
Message-ID: <bbbeeccd0812040843p3e5547c4tac88b0d01562a37f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 04 17:45:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8HK7-0006u7-Jq
	for gcvg-git-2@gmane.org; Thu, 04 Dec 2008 17:45:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751730AbYLDQnv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2008 11:43:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752056AbYLDQnu
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Dec 2008 11:43:50 -0500
Received: from rv-out-0506.google.com ([209.85.198.228]:1491 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751708AbYLDQnu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2008 11:43:50 -0500
Received: by rv-out-0506.google.com with SMTP id k40so4059198rvb.1
        for <git@vger.kernel.org>; Thu, 04 Dec 2008 08:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=sAOct0X+vJW6tbOBdJQWk+BPm0RoecsnkGTpAoaZ2EY=;
        b=euBm2qXCFVC7YEr4S2INIL0b+Xzlh2nj7XoNCJe0USk/3DR2BMinDWRg3H5DfEbmcs
         /bIIkiHjXsL9JKQVl36xE9KJJmBiLp0RwUij4PDuujzqfReBkSUSO4hYmUc0gepkQKNh
         bWZtx/teoEYCJA72NxSuvPD/mxUUTGeLv5W2c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=C+moC4crQv8moobI5BNIjATCtaqZzAx5Y6rywa1ZUw13ydsOifsvjySA08uB+WBGIa
         jqo13NVCDwil1+a0h3CSAwoyI6aMb+K0d70JSc5NkDH68at7g6331t3IXbZz7Ik7pZ3f
         vYO9HpQ10gpMl/bqRDG9IdefldedlCbG3SnFE=
Received: by 10.141.136.4 with SMTP id o4mr7033848rvn.13.1228409027604;
        Thu, 04 Dec 2008 08:43:47 -0800 (PST)
Received: by 10.141.34.14 with HTTP; Thu, 4 Dec 2008 08:43:47 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102349>

Hi,

Consider the following example layout:

trunk/src
trunk/big_fat_binary_blobs
trunk/doc

I think it would be really nice to be able to tell git-svn to ignore
'big_fat_binary_blobs' while keeping 'src' and 'doc'.

I know someone is thinking, "Why did you check in
'big_fat_binary_blobs' in the first place?"  In this case, the
repository is out of my control.  For the svn users, it's not that big
of a deal since they only get one HEAD version of the binary_blobs.
But when trying to clone with git-svn, I repeatedly get out of memory
and packing errors (every 1000 commits) when packing several revisions
of these binary_blobs.  (Now, that may be a bug in of itself... which
can reproduced by creating an svn repo with several revisions of
KNOPPIX at the same path, followed by a git svn clone )

Anyway, I still think it may be useful to be able to ignore certain
paths on a clone.  In thinking about the implementation details, I
figure probably the best approach would be to manually purge the
unwanted path after it has been fetched, but before it is committed.
That way, if a commit contains changes in paths that are both wanted
and unwanted, the commit could be 'pruned'.

I've looked at the git-svn script a little, but wanted to solicit
feedback and ideas before continuing further.

Thoughts?

Wade
