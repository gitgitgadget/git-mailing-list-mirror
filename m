X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [BUG] StGit removed git branch of the same name as StGit branch
Date: Tue, 21 Nov 2006 10:06:30 +0000
Message-ID: <tnx64d9xgex.fsf@arm.com>
References: <200611202201.45521.jnareb@gmail.com>
	<20061120222812.GE12285@fieldses.org> <ejtal6$p8s$1@sea.gmane.org>
	<20061120224800.GF12285@fieldses.org> <ejtbph$tod$1@sea.gmane.org>
	<87y7q5y8s6.wl%cworth@cworth.org>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 21 Nov 2006 10:07:09 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <87y7q5y8s6.wl%cworth@cworth.org> (Carl Worth's message of
 "Mon, 20 Nov 2006 15:53:45 -0800")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 21 Nov 2006 10:06:48.0410 (UTC) FILETIME=[C1DABBA0:01C70D54]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31981>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmSWr-00061z-7y for gcvg-git@gmane.org; Tue, 21 Nov
 2006 11:07:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030811AbWKUKGk (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 05:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030810AbWKUKGk
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 05:06:40 -0500
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:62197 "EHLO
 cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP id
 S1030811AbWKUKGj (ORCPT <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006
 05:06:39 -0500
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.105.18]) by
 cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id kALA6W4b016310;
 Tue, 21 Nov 2006 10:06:32 GMT
Received: from localhost.localdomain ([10.1.255.211]) by
 cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.0); Tue, 21 Nov 2006
 10:06:48 +0000
To: Carl Worth <cworth@cworth.org>
Sender: git-owner@vger.kernel.org

Carl Worth <cworth@cworth.org> wrote:
> From my inspection, StGit works just fine in its "standalone SCM"
> role, but falls over somewhat if using it as an additional tool
> alongside git itself for a few reasons:
>
> * There's a two-world-view problem with extra commands just to
>   translate back and forth (assimilate, commit, uncommit, etc.)

I initially opposed to commands like "uncommit" since people shouldn't
modify the history. I currently see the assimilate/uncommit only as a
way to fix mistakes of committing with GIT when you actually wanted an
StGIT patch. I rarely use these commands.

I use StGIT in maintainer mode as well and the only additional command
is "commit" to permanently store the patches and freeze the history
before pushing the changes to the public repository.

> * The new references that StGit introduces can lead to collisions, (it
>   happened to me anyway---I ended up having to rm -r .git/refs/bases
>   or whatever just to make the ambiguity go away and let me get work
>   done with git again).

I find the refs/bases useful, for example when invoking gitk I can see
where the base of the stack is. You can also use the base in plain
"git" commands.

> So, for use as something separate from git, StGit might be just
> fine. Otherwise, for being just another tool for users of "git" the
> command-line tool, I agree that the current StGit design is a
> mistake.

I personally don't like mixing StGIT and GIT commands unnecessarily,
unless there is no other option (like "git log" since "stg log" has a
different meaning). There are people (including me) who use StGIT
almost exclusively, without relying on the GIT commands. That's why I
duplicated some of the GIT commands.

I don't think there is a problem with StGIT's design but rather a
workflow one (which neither GIT nor StGIT have clearly documented it,
you can see many people writing their own scripts to do the things
they need). For example, I thought "uncommit" only as a way to fix a
mistaken commit but someone posted a bug report that it wasn't
possible to uncommit hundreds of commits and going over merges. This
was not the intended behaviour but you can't force people not to be
inventive :-).

> I'd much prefer to have a minimal set of new "git" sub-commands that
> introduce the new functionality without a separate command namespace
> and several sub-commands with redundant functionality compared to
> existing git sub-commands.

I find the GIT command space to be pretty cramped and without a clear
separation between low-level commands and porcelain ones. Adding even
more functionality for patch management would scare beginners even
more (had the GNU Arch experience where you need a steep learning
curve).

-- 
