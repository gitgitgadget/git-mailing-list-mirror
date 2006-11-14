X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: tracking separate branches with RSS
Date: Tue, 14 Nov 2006 01:54:03 +0100
Organization: At home
Message-ID: <ejb410$nvg$1@sea.gmane.org>
References: <ejb3hh$nvr$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Tue, 14 Nov 2006 00:53:26 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 54
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31331>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GjmY5-0002ot-5Y for gcvg-git@gmane.org; Tue, 14 Nov
 2006 01:53:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933274AbWKNAxK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 13 Nov 2006
 19:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933288AbWKNAxJ
 (ORCPT <rfc822;git-outgoing>); Mon, 13 Nov 2006 19:53:09 -0500
Received: from main.gmane.org ([80.91.229.2]:34797 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S933274AbWKNAxI (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 13 Nov 2006 19:53:08 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GjmXo-0002mG-Tk for git@vger.kernel.org; Tue, 14 Nov 2006 01:52:57 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Tue, 14 Nov 2006 01:52:56 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Tue, 14 Nov 2006
 01:52:56 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Han-Wen Nienhuys wrote:

> I think that the shortlog / RSS support in gitweb is really neat. 
> However, it seems to track only the master branch.
> 
> In our repository (http://git.sv.gnu.org/gitweb/?p=lilypond.git;a=summary),
> we track two completely disparate branches in one repository: we have 
> both the project and the website for the project in branches
> 
>    master
> 
> and
> 
>    web/master
> 
> Unfortunately,  I don't seem to get any updates in my RSS reader when I 
> push something  to web/master. Would it be possible have a separate feed 
> for each branch?  I tried looking at the gitweb script, but my perl-fu 
> is too weak to figure out how to pass an argument from the URL into a 
> git_rss() to replace  the
> 
>    git_get_head_hash($project)
> 
> call.

For quick'n'dirty solution it would be enough to just replace
    git_get_head_hash($project)
with
    $hash || "HEAD"
(or $hash || git_get_head_hash($project)).

Then to track branch 'branch' with RSS just use 
    ?p=project.git;a=rss;h=branch
as a query string.


I started doing it, but the problem is that you have to change also a bit
of contents, for example summary/title, and some links.

git_rss subroutine is one of the few subroutines which didn't get refactored.

> A second possibility -less desirable, but better than nothing- is to 
> have commits from all branches show up in the shortlog and the RSS feed.

Use "--all" as 'h' (hash) parameter.


P.S. What do you think about moving from RSS to Atom for feeds?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

