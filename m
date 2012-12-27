From: Michael Leal <michaelleal8@gmail.com>
Subject: Re: [PATCH v3 00/19] new git check-ignore sub-command
Date: Thu, 27 Dec 2012 05:15:55 +0000 (UTC)
Message-ID: <loom.20121227T061300-665@post.gmane.org>
References: <1356575558-2674-1-git-send-email-git@adamspiers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 27 06:35:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1To67k-00014f-6g
	for gcvg-git-2@plane.gmane.org; Thu, 27 Dec 2012 06:35:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807Ab2L0Fey (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Dec 2012 00:34:54 -0500
Received: from plane.gmane.org ([80.91.229.3]:60803 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750770Ab2L0Few (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Dec 2012 00:34:52 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1To67T-0000vd-9p
	for git@vger.kernel.org; Thu, 27 Dec 2012 06:35:03 +0100
Received: from 99-92-240-181.lightspeed.rcsntx.sbcglobal.net ([99.92.240.181])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 27 Dec 2012 06:35:03 +0100
Received: from michaelleal8 by 99-92-240-181.lightspeed.rcsntx.sbcglobal.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 27 Dec 2012 06:35:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 99.92.240.181 (Mozilla/5.0 (Linux; U; Android 4.0.3; en-us; HTC_X515C Build/IML74K) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212192>

Adam Spiers <git <at> 
adamspiers.org> writes:

> 
> This v3 re-roll of my check-
ignore series is a reasonably 
substantial
> revamp over v2, and applies on 
top of Junio's current
> nd/attr-match-optim-more 
branch (82dce998c202).
> 
> All feedback and patches from 
the v2 series has been 
incorporated, and
> several other improvements 
too, including:
> 
>   - composite exclude_lists 
have been split up into
>     exclude_list_groups each 
containing one exclude_list per 
source
> 
>   - smaller commits for easier 
review
> 
>   - minor memory leaks have 
been fixed and verified via 
valgrind
> 
>   - t0007-ignores.sh has been 
renumbered to t0008-ignores.sh 
to avoid
>     a conflict with t0007-git-
var.sh
> 
>   - improvements to 
documentation and comments
> 
> For reference, the v2 series 
was announced here:
> 
>     http://thread.gmane.org/
gmane.comp.version-
control.git/204661/
focus=206074
> 
> All tests pass except for t91*, 
since there seems to be some
> pre-existing breakage in 
82dce998c202 relating to git-
svn.
> 
> Adam Spiers (19):
>   api-directory-listing.txt: 
update to match code
>   Improve documentation and 
comments regarding directory 
traversal API
>   dir.c: rename cryptic 'which' 
variable to more consistent 
name
>   dir.c: rename path_excluded() 
to is_path_excluded()
>   dir.c: rename 
excluded_from_list() to 
is_excluded_from_list()
>   dir.c: rename excluded() to 
is_excluded()
>   dir.c: refactor 
is_excluded_from_list()
>   dir.c: refactor is_excluded()
>   dir.c: refactor 
is_path_excluded()
>   dir.c: rename free_excludes() 
to clear_exclude_list()
>   dir.c: use a single struct 
exclude_list per source of 
excludes
>   dir.c: keep track of where 
patterns came from
>   dir.c: provide clear_directory() 
for reclaiming dir_struct memory
>   add.c: refactor treat_gitlinks()
>   add.c: remove unused 
argument from 
validate_pathspec()
>   pathspec.c: move reusable 
code from builtin/add.c
>   pathspec.c: extract new 
validate_path() for reuse
>   setup.c: document 
get_pathspec()
>   Add git-check-ignore sub-
command
> 
>  .gitignore                                        
|   1 +
>  Documentation/git-check-
ignore.txt                |  89 ++++
>  Documentation/gitignore.txt                       
|   6 +-
>  Documentation/technical/api-
directory-listing.txt |  35 +-
>  Makefile                                          
|   3 +
>  attr.c                                            |   
2 +-
>  builtin.h                                         
|   1 +
>  builtin/add.c                                     
|  84 +--
>  builtin/check-ignore.c                            
| 170 +++++++
>  builtin/clean.c                                   
|   3 +-
>  builtin/ls-files.c                                
|  11 +-
>  command-list.txt                                  
|   1 +
>  contrib/completion/git-
completion.bash            |   1 +
>  dir.c                                             | 
243 +++++++--
>  dir.h                                             |  
87 +++-
>  git.c                                             |   
1 +
>  pathspec.c                                        
| 107 ++++
>  pathspec.h                                        
|   6 +
>  setup.c                                           
|  15 +
>  t/t0008-ignores.sh                                
| 595 
++++++++++++++++++++++
>  unpack-trees.c                                    
|  14 +-
>  21 files changed, 1305 
insertions(+), 170 deletions(-)
>  create mode 100644 
Documentation/git-check-
ignore.txt
>  create mode 100644 builtin/
check-ignore.c
>  create mode 100644 
pathspec.c
>  create mode 100644 
pathspec.h
>  create mode 100755 t/t0008-
ignores.sh
> 
