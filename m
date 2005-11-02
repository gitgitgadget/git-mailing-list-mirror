From: jdl@freescale.com
Subject: New ASCII Art
Date: Wed, 02 Nov 2005 17:40:30 -0600
Message-ID: <E1EXSDW-0005aC-RG@jdl.com>
X-From: git-owner@vger.kernel.org Thu Nov 03 00:41:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXSDo-0002DY-Um
	for gcvg-git@gmane.org; Thu, 03 Nov 2005 00:40:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030206AbVKBXkq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Nov 2005 18:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030208AbVKBXkq
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Nov 2005 18:40:46 -0500
Received: from colo.jdl.com ([66.118.10.122]:57764 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S1030206AbVKBXkp (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Nov 2005 18:40:45 -0500
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1EXSDW-0005aC-RG
	for git@vger.kernel.org; Wed, 02 Nov 2005 17:40:31 -0600
To: git@vger.kernel.org
X-Spam-Score: -105.9 (---------------------------------------------------)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11058>

Junio,

I see my name over on the TODO list:

    31 Documentation
    32 -------------
    33
    34 * Help Jon Loeliger to find place in the documentation to place
    35 his drawing.

So, I have updated drawings for consideration.
See if you buy these.  And if so, let's ponder
where they might go.  Then I'll patch 'em in...

I now have four ASCII Art drawings:

    - Fundamental git operations
    - Git merge operations
    - Git diff types
    - Commit DAG Revision Naming

jdl




Fundamental Git Index Operations
================================

                     commit-tree
                      commit obj
                       +----+
                       |    |
                       |    |
                       V    V
                    +-----------+
                    | Object DB |
                    |  Backing  |
                    |   Store   |
                    +-----------+
                       ^
           write-tree  |     |
             tree obj  |     |
                       |     |  read-tree
                       |     |  tree obj
                             V
                    +-----------+
                    |   Index   |
                    |  "cache"  |
                    +-----------+
         update-index  ^
             blob obj  |     |
                       |     |
    checkout-index -u  |     |  checkout-index
             stat      |     |  blob obj
                             V
                    +-----------+
                    |  Working  |
                    | Directory |
                    +-----------+


Git Merge Operations
====================

                    +-----------+
                    | Object DB |
                    |  Backing  |
                    |   Store   | -------+
                    +-----------+        |
                                         |
                           read-tree -m  |
  +-----+                  tree obj      |
  |patch|                                |
  +-----+           +-----------+        |
     |              |   Index   | <- - - +
     +------------->|  "cache"  | - - - >+
 git-apply --index  +-----------+        |
                                         |
                                         |
                         read-tree -m -u |
 +-----+                        tree obj |
 |patch|                                 |
 +-----+            +-----------+        |
    |               |  Working  |<-------+
    +-------------->| Directory |
  git-apply         +-----------+



Git Diff Types
==============


                      diff-tree
                       +----+
                       |    |
                       |    |
                       V    V
                    +-----------+
                    | Object DB |
                    |  Backing  |
                    |   Store   |
                    +-----------+
                      ^    ^
                      |    |
                      |    |  diff-index --cached
                      |    |
          diff-index  |    V
                      |  +-----------+
                      |  |   Index   |
                      |  |  "cache"  |
                      |  +-----------+
                      |    ^
                      |    |
                      |    |  diff-files
                      |    |
                      V    V
                    +-----------+
                    |  Working  |
                    | Directory |
                    +-----------+


Commit DAG Revision Naming
==========================

Both node B and C are a commit parents of commit node A.
Parent commits are ordered left-to-right.

    G   H   I   J
     \ /     \ /
      D   E   F
       \  |  /
        \ | /
         \|/
          B     C
           \   /
            \ /
             A

    A =      = A^0
    B = A^   = A^1     = A~1
    C = A^2  = A^2
    D = A^^  = A^1^1   = A~2
    E = B^2  = A^^2
    F = B^3  = A^^3
    G = A^^^ = A^1^1^1 = A~3
    H = D^2  = B^^2    = A^^^2  = A~2^2
    I = F^   = B^3^    = A^^3^
    J = F^2  = B^3^2   = A^^3^2

Fixed-point operations:

    A^0 = A^{commit}
    A^{tree}
   
