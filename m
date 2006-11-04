X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: If I were redoing git from scratch...
Date: Sat, 04 Nov 2006 13:21:57 +0100
Organization: At home
Message-ID: <eii0kg$1co$1@sea.gmane.org>
References: <7vpsc3xx65.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Sat, 4 Nov 2006 12:22:30 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 53
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30925>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GgKXW-0005Wd-Ty for gcvg-git@gmane.org; Sat, 04 Nov
 2006 13:22:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965384AbWKDMWM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 4 Nov 2006
 07:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965368AbWKDMWM
 (ORCPT <rfc822;git-outgoing>); Sat, 4 Nov 2006 07:22:12 -0500
Received: from main.gmane.org ([80.91.229.2]:5779 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S965384AbWKDMWL (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 4 Nov 2006 07:22:11 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GgKX5-0005Pl-M9 for git@vger.kernel.org; Sat, 04 Nov 2006 13:21:55 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sat, 04 Nov 2006 13:21:55 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sat, 04 Nov 2006
 13:21:55 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:

> * Core data structure
[...]
> The biggest one is that we use too many static (worse, function
> scope static) variables that live for the life of the process,
> which makes many things very nice and easy ("run-once and let
> exit clean up the mess" mentality), but because of this it
> becomes awkward to do certain things.  Examples are:

One of examples that have been only rarely fixed was for_each_ref
forcing callers to using static variable to store gathered data
instead of passing the data as one of arguments.

> * Fetch/Push/Pull/Merge confusion
> 
> Everybody hates the fact that inverse of push is fetch not pull,
> and merge is not a usual Porcelain (while it _is_ usable as a
> regular UI command, it was originally done as a lower layer
> helper to "pull" Porcelain and has a strange parameter order
> with seemingly useless HEAD parameter in the middle).
> 
> If I were doing git from scratch, I would probably avoid any of
> the above words that have loaded meanings from other SCMs.

I'm a bit used to "push", "fetch" and "pull". I consider "pull"
a bit of artifact from times of one branch per repository layout.
The fact that "pull" fetches _all_ the branches but merges one
[usually] with the _current_ branch (unless you configure it other
way)...

I'll leave "push" as is, leave "fetch" as is, and make "pull" to be
"fetch" by default unless you use "--merge[=<branch>]" option.
I'd rename "merge" to "merge-driver" and make new "merge" thanks
to new users wouldn't have to learn to use "git pull . branchA"
to merge current branch with branchA. 

Perhaps would make it possible to specify remote branch a la cogito,
<URL>#<branch>, to pull remote branch without tracking branch, and
for symmetry have "--pull[=<repo>]" or "--fetch[=<repo>]" option.

> * Unified "fetch" and "push" across backends.
>

Very nice idea, but one must remember the limitations of import/export tools
and of course limitations of other SCM... well, and also limitations of
Git, if there are any compared to other SCM ;-)

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

