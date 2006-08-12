From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How to resolve git-am conflict (possible bug)
Date: Sat, 12 Aug 2006 11:10:40 +0200
Organization: At home
Message-ID: <ebk5tf$31k$1@sea.gmane.org>
References: <ebj7er$64j$1@sea.gmane.org> <7vslk2rbq8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sat Aug 12 11:10:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GBpVo-0006c8-NO
	for gcvg-git@gmane.org; Sat, 12 Aug 2006 11:10:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbWHLJKT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Aug 2006 05:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbWHLJKT
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Aug 2006 05:10:19 -0400
Received: from main.gmane.org ([80.91.229.2]:58037 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932114AbWHLJKR (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Aug 2006 05:10:17 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GBpVW-0006Yq-95
	for git@vger.kernel.org; Sat, 12 Aug 2006 11:10:14 +0200
Received: from host-81-190-24-83.torun.mm.pl ([81.190.24.83])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 12 Aug 2006 11:10:14 +0200
Received: from jnareb by host-81-190-24-83.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 12 Aug 2006 11:10:14 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-83.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25256>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> Third, I wonder why it printed the same error message _twice_.
> 
> Do you have blob 7ea52b1?  Otherwise you would not see two "does
> not apply" messages, so I suspect you do.  Does the patch
> cleanly apply to that blob?
> 
> More likely explanation is that you edited the patch by hand for
> some reason, and made it inapplicable to the base blob the
> "index" line records.

Yes, I have edited "post-sub-rename" patch by hand (by script) in attempt
for it to apply cleanly to the top of "pre-sub-rename" development branch.
BTW patch applies cleanly to merge-base of the branch the patch is from and
the branch it is applied to.

Why do we not record commit id in patch? And how git-rebase deals with this? 

> The first "patch does not apply" comes from ll. 363 of git-am.
> After it fails because the patch does not apply to the version
> of gitweb.perl in your index, since you told it to fall back to
> three-way merge, l. 391 calls fall_back_3way, which inspects the
> patch, finds the "index" line and notices that the patch claims
> to apply to blob 7ea52b1, finds the blob in your repository, and
> prepares a temporary index with "update-index -z --index-info"
> on l. 58 successfully, tries to apply the patch again on l. 63.
> 
> However, the patch contents and the blob object name recorded on
> the index line are not necessarily consistent if you hand edited
> the patch (IOW, the context lines in the patch contents may not
> match blob 7ea52b1).

It would be nice then if git-am was more verbose, for example
"Applying patch to blob 7ea52b1... gitweb/gitweb.perl" or something
like that.

And first complaint still apply: in git-am(1) there is precious few
documentation (or at least references) about _how_ to resolve merge
conflict or failed patch (does git-apply creates *.orig and *.rej 
files?)

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
