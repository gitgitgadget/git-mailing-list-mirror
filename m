X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Subprojects tasks
Date: Sun, 17 Dec 2006 14:01:09 +0100
Message-ID: <200612171401.10585.jnareb@gmail.com>
References: <7vzm9nelob.fsf@assigned-by-dhcp.cox.net> <200612170101.09615.Josef.Weidendorfer@gmx.de> <20061217114546.GG12411@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 17 Dec 2006 12:58:53 +0000 (UTC)
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=XKy+UUVZUwUoypPg0Ie39Y4ThHaZh8gg+GdZQAKkEEhMObEALA2cRjqsS5t/srK2P4mtbtGNmj83/BbH7DriMHLMbcUa4i7HH98/+dTU5urTT+7/ITbQl/JF3VBf0A0asCwdHRy3CHvaBQZz3t49ukqJJYfPu53vbWkE1CWnBHw=
User-Agent: KMail/1.9.3
In-Reply-To: <20061217114546.GG12411@admingilde.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34687>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvvbJ-00007H-QE for gcvg-git@gmane.org; Sun, 17 Dec
 2006 13:58:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752563AbWLQM6l (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 17 Dec 2006
 07:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752564AbWLQM6l
 (ORCPT <rfc822;git-outgoing>); Sun, 17 Dec 2006 07:58:41 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:20600 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1752563AbWLQM6k (ORCPT <rfc822;git@vger.kernel.org>); Sun, 17 Dec
 2006 07:58:40 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1256257uga for
 <git@vger.kernel.org>; Sun, 17 Dec 2006 04:58:39 -0800 (PST)
Received: by 10.67.91.6 with SMTP id t6mr3303080ugl.1166360319186; Sun, 17
 Dec 2006 04:58:39 -0800 (PST)
Received: from host-81-190-25-107.torun.mm.pl ( [81.190.25.107]) by
 mx.google.com with ESMTP id e23sm7481028ugd.2006.12.17.04.58.38; Sun, 17 Dec
 2006 04:58:39 -0800 (PST)
To: Martin Waitz <tali@admingilde.org>
Sender: git-owner@vger.kernel.org

Martin Waitz wrote:
> On Sun, Dec 17, 2006 at 01:01:09AM +0100, Josef Weidendorfer wrote:

>> IMHO it simply is added flexibility to allow a checkout to be separate from
>> the .git/ directory, same as explicitly setting $GIT_DIR would do.
>> So this .gitlink file is on the one hand one kind of convenience for users
>> which want to keep their repository separate, yet do not want to specify
>> $GIT_DIR all the time in front of git commands.
>> The .gitlink file simply makes the linkage to the separate repository
>> persistent.
> 
> I can see the reason for wanting to use another object database,
> but HEAD and index should always be stored together with the
> checked out directory.  So perhaps we just need some smart way to
> search for the object database, but keep the .git directory.

Well, in the .gitlink proposal you could specify GIT_DIR for checkout,
or separately: GIT_OBJECT_DIRECTORY, GIT_INDEX_FILE, GIT_REFS_DIRECTORY
(does not exist yet), GIT_HEAD_FILE (does not exist yet, and I suppose
it wouldn't be easy to implement it). By the way, that's why I'm for
.gitlink name for the file, not .git -- this way .gitlink can "shadow"
what's in .git, for example specifying in a smart way where to search
(where to find) object database, but HEAD and index would be stored
together with the checked out directory in .git

By the way, I'm rather partial to supermodule following HEAD in submodule,
not specified branch. First, I think it is easier from implementation
point of view: you don't have to remember which branch supermodule should
take submodule commits from; and this cannot be fixed branch name like
'master'. For example 'maint' branch of supermodule could track 'maint'
branch of submodule, 'master' branch of supermodule track 'master'
branch of submodule, 'next' branch of supermodule tranck 'master' (!)
branch of submodule, 'pu' branch of supermodule track 'next' (!) branch
of submodule. 

Second, if you want to do some independent work on the module not related
to work on submodule you should really clone (clone -l -s) submodule
and work in separate checkout; the complaint that with tracking HEAD
you can check-in wrong version of submodule to supermodule commit
doesn't hold, because you still would have problem that _tree_
of supermodule would have wrong version of submodule. And moving to
using single defined branch of submodule brings multitude of other
problems: for example you might usually track 'master' version of
submodule, but for a short time need to track 'next' branch because
it has functionality you need; and another time you need to move
to 'maint' branch or even your own branch because 'master' version
breaks something in supermodule.

Hmmm... I wonder how planned allowing to checking out tags, non-head
branches (e.g. tracking/remote branches) and arbitrary commits but
forbidding committing when HEAD is not a refs/heads/ branch would
affect submodules / subprojects...

-- 
Jakub Narebski
