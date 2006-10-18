From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [BUG] git-log shows first parent and repeated last for octopus merge
Date: Wed, 18 Oct 2006 16:02:36 +0200
Message-ID: <200610181602.36856.jnareb@gmail.com>
References: <eh5242$rar$1@sea.gmane.org> <Pine.LNX.4.63.0610181551150.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 16:02:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaBzx-0008KS-5O
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 16:02:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161020AbWJROCR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 10:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161027AbWJROCR
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 10:02:17 -0400
Received: from qb-out-0506.google.com ([72.14.204.226]:13523 "EHLO
	qb-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1161020AbWJROCR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 10:02:17 -0400
Received: by qb-out-0506.google.com with SMTP id p36so715150qba
        for <git@vger.kernel.org>; Wed, 18 Oct 2006 07:02:16 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=QzIOifigXfkTfUrmg9vFx/r3iOjOOQRFobqpU5mFTjieknvWQ3OhO+yJk7Ep81Daf7prqRNGrFr3DR9QL5WUMxOdhGw7id0JXX6AfScLn3PcnvqUcKcM0CPAcWOX8lOCa0AtUsrTOC/6SQdG4MMv5c+Zhbax+9o8nzXbl28DsN4=
Received: by 10.66.224.3 with SMTP id w3mr11842969ugg;
        Wed, 18 Oct 2006 07:02:01 -0700 (PDT)
Received: from host-81-190-17-207.torun.mm.pl ( [81.190.17.207])
        by mx.google.com with ESMTP id w40sm974333ugc.2006.10.18.07.02.00;
        Wed, 18 Oct 2006 07:02:00 -0700 (PDT)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.63.0610181551150.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29234>

Johannes Schindelin wrote:
> On Wed, 18 Oct 2006, Jakub Narebski wrote:
> 
> > When trying to find how many merges and how many octopus merges (merges with
> > more than two parents) are in git.git repository I have encountered the
> > following strange output of git-log:
> > 
> >  1000:jnareb@roke:~/git> git log --parents --full-history --max-count=1 \
> >    211232bae64bcc60bbf5d1b5e5b2344c22ed767e -- a//b
> >  commit 211232bae64bcc60bbf5d1b5e5b2344c22ed767e <last parent repeated>
> >  Merge: d0d0d0b... d0d0d0b... d0d0d0b... d0d0d0b... d0d0d0b...
> >  [...]
> 
> This happens because a//b rewrites the history, i.e. the parents are 
> edited. IMHO it makes no sense at all to show the parents in such a case, 
> since they are bogus.

Or rather it has no sense to _repeat_ rewritten parent the number of times
the commit has parents originally. Compare git-log and git-rev-list results:

1010:jnareb@roke:~/git> git rev-list --full-history --header --parents \
  --max-count=2 211232bae64bcc60bbf5d1b5e5b2344c22ed767e -- a//b
211232bae64bcc60bbf5d1b5e5b2344c22ed767e d0d0d0bd3c2c4591ffbc292d7e082e8ad8f2057f
tree cdafa88fa4ed7fcc7bb6c64d62e2d7c4d3b65e42
parent fc54a9c30ccad3fde5890d2c0ca2e2acc0848fbc
parent 9e30dd7c0ecc9f10372f31539d0122db97418353
parent c4b83e618f1df7d8ecc9392fa40e5bebccbe6b5a
parent 660265909fc178581ef327076716dfd3550e6e7b
parent b28858bf65d4fd6d8bb070865518ec43817fe7f3
author Junio C Hamano <junkio@cox.net> 1115335014 -0700
committer Junio C Hamano <junkio@cox.net> 1115335014 -0700

    Octopus merge of the following five patches.
    
      Update git-apply-patch-script for symbolic links.
      Make git-prune-script executable again.
      Do not write out new index if nothing has changed.
      diff-cache shows differences for unmerged paths without --cache.
      Update diff engine for symlinks stored in the cache.
    
    Signed-off-by: Junio C Hamano <junkio@cox.net>
d0d0d0bd3c2c4591ffbc292d7e082e8ad8f2057f 54c26fb9d0cdff94c7717125d0a222b324bfea8a
[...]

1014:jnareb@roke:~/git> PAGER= git log --full-history --parents \
  --max-count=2 211232bae64bcc60bbf5d1b5e5b2344c22ed767e -- a//b
commit 211232bae64bcc60bbf5d1b5e5b2344c22ed767e d0d0d0bd3c2c4591ffbc292d7e082e8ad8f2057f d0d0d0bd3c2c4591ffbc292d7e082e8ad8f2057f d0d0d0bd3c2c4591ffbc292d7e082e8ad8f2057f d0d0d0bd3c2c4591ffbc292d7e082e8ad8f2057f d0d0d0bd3c2c4591ffbc292d7e082e8ad8f2057f
Merge: d0d0d0b... d0d0d0b... d0d0d0b... d0d0d0b... d0d0d0b...
Author: Junio C Hamano <junkio@cox.net>
Date:   Thu May 5 16:16:54 2005 -0700

    Octopus merge of the following five patches.
    
      Update git-apply-patch-script for symbolic links.
      Make git-prune-script executable again.
      Do not write out new index if nothing has changed.
      diff-cache shows differences for unmerged paths without --cache.
      Update diff engine for symlinks stored in the cache.
    
    Signed-off-by: Junio C Hamano <junkio@cox.net>

commit d0d0d0bd3c2c4591ffbc292d7e082e8ad8f2057f 54c26fb9d0cdff94c7717125d0a222b324bfea8a 54c26fb9d0cdff94c7717125d0a222b324bfea8a
[...]

-- 
Jakub Narebski
Poland
