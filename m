From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Thu, 11 Sep 2008 18:53:52 +0200
Message-ID: <200809111853.53065.jnareb@gmail.com>
References: <20080909132212.GA25476@cuci.nl> <20080911062242.GA23070@cuci.nl> <alpine.LFD.1.10.0809110835070.3384@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Stephen R. van den Berg" <srb@cuci.nl>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Sep 11 18:55:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdpRn-0006dI-SN
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 18:55:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752505AbYIKQyD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 12:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752394AbYIKQyB
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 12:54:01 -0400
Received: from an-out-0708.google.com ([209.85.132.242]:47645 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751717AbYIKQyA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 12:54:00 -0400
Received: by an-out-0708.google.com with SMTP id d40so48754and.103
        for <git@vger.kernel.org>; Thu, 11 Sep 2008 09:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=rkRg4dQSgpp7g6ROh3KL9gxcSoVX3eLk6BGiAhx16vE=;
        b=fbsLXTYEZiuI8RKMrLNdUZSn2BpwGQ/n85O5DRZBh2g4MThZN8hpk6RDH91RkDLS7A
         KbmwX8JbmzzQROKQGj+xzXx3apyx5y/2HvAex1AMsiGJRnnRKEWbL67p/dMRL1xn+IL5
         OLUkiUdC25HPFio9BVmusLfpEhajYv/6UPy3o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=c7nJF9eU3oz60prr+n687TvJyfzVwtx/TpAfmHqGdZRgmZYhpwReovK/Xm9hTVhJgk
         mIftopNGBdnNNN/QLgII4ORoOB/m+DqepgShvoYGtzLJcXYEPNZtjL3T6vSpM9NMRhIh
         hE2O3K8pBn3jFJM/6e0xYxkPR8FmcQCb8g7zM=
Received: by 10.86.31.18 with SMTP id e18mr2230477fge.52.1221152037634;
        Thu, 11 Sep 2008 09:53:57 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.239.193])
        by mx.google.com with ESMTPS id 4sm11200903fgg.4.2008.09.11.09.53.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Sep 2008 09:53:56 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LFD.1.10.0809110835070.3384@nehalem.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95621>

Linus Torvalds wrote:
> On Thu, 11 Sep 2008, Stephen R. van den Berg wrote:
> 
>> If you fetch just branches A, B and C, but not D, the origin link from A
>> to D is dangling.  Once you have fetched D as well [..]
> 
> So I just said we deleted beanch 'D', so there's no way to ever fetch it 
> again.
> 
> Get it?
> 
> The fact is, a big part of git is temporary branches. It's one of the 
> *best* features of git. Throw-away stuff. Those throw-away branches are 
> often done for initial development, and then the final result is often a 
> cleaned-up version. Often using rebase or cherry-picking or any number of 
> things.
> 
> And this is why "git cherry-pick" DOES NOT PUT THE ORIGINAL SHA1 IN THE 
> COMMENT FIELD BY DEFAULT.
> 
> (Although you can use "-x" to make it do so for when you actually _want_ 
> to say "cherry-picked from xyzzy")

And that is why the proposal was to use "-o" option to git-cherry-pick
to add 'origin'/'changeset' header, exactly because git-cherry-pick is
_abused_ to clean up branches and reorder commits; although I think that
"git rebase --interactive" (and patch management interfaces) do replace
using git-cherry-pick for that purpose.

git-revert would add 'origin'/'changeset' header unconditionally,
just like by default it seeds commit message with SHA-1 id of reverted
commit.

> Can you not understand that? The "origin" field is _garbage_. It's garbage 
> for all normal cases. The original commit will not ever even EXIST in the 
> result, because it has long since been thrown away and will never exist 
> anywhere else.
> 
> Garbage should be _avoided_, not added.

Hmmm... the difference between having 'origin' in a commit object header,
and having it in commit mesage is like difference between 'Signed-off-by:'
convention and 'author' header.  First is the matter of workflow, second
is inherent, required and non-avoidable part of revision information.

On the other hand git-cherry and git-blame would then have rely on
parsing correctly free-form part of a commit object, to take advantage
of 'origin' information: something what 'origin' info is for.


P.S. 'generation' header was not added... just saying... :-)

-- 
Jakub Narebski
Poland
