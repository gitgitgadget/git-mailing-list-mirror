From: "John M. Dlugosz" <ngnr63q02@sneakemail.com>
Subject: Re: How to merge from newer branch to older branches?
Date: Tue, 21 Apr 2009 23:46:32 -0500
Message-ID: <gsm7fm$q31$1@ger.gmane.org>
References: <2729632a0904211224x6e2621caxf6c169d90b760530@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 22 06:48:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwUNu-0002mQ-06
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 06:48:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbZDVEq7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 00:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbZDVEq7
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 00:46:59 -0400
Received: from main.gmane.org ([80.91.229.2]:57925 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751240AbZDVEq7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 00:46:59 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LwUMM-0001oH-8A
	for git@vger.kernel.org; Wed, 22 Apr 2009 04:46:58 +0000
Received: from 76-204-212-71.lightspeed.allntx.sbcglobal.net ([76.204.212.71])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 22 Apr 2009 04:46:58 +0000
Received: from ngnr63q02 by 76-204-212-71.lightspeed.allntx.sbcglobal.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 22 Apr 2009 04:46:58 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 76-204-212-71.lightspeed.allntx.sbcglobal.net
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.21) Gecko/20090302 Thunderbird/2.0.0.21 Mnenhy/0.7.5.666
In-Reply-To: <2729632a0904211224x6e2621caxf6c169d90b760530@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117169>

skillzero@gmail.com wrote:
> 
> future o-o-o-o-o-o-o
>         \   \       \
> 1.2          o-o-o   \
>           \           \
> 1.1        o-o-o       \
>                         \
> feature                  o-o-o
>                          a b c
> 
> Is cherry-picking the best way? It seems pretty tedious because I have
> to do each commit in reverse order (although I could script it). I was
> hoping there was a way to say "apply all the changes from when
> "feature" branched up to its tip". I would also like to preserve the
> commit history rather than just making making one big commit of all
> the changes.

I think any other command that "just" moves those deltas would be the exact equivalent of 
cherry picking in terms of the conflicts it sees.

You can, however, collapse a,b,c into one commit and pick that into each place it is 
needed, calling it a good comment for the whole feature.  That might be more difficult to 
merge than doing one at a time, but if not, and the whole string is tedious (i.e. 50 
instead of 3, mostly incremental typo fixes and stuff) I can see the benefit of making it 
a gestalt.

Furthermore... (thinking out loud)... the conflicts are caused by things after the other 
branches, right?  After you do the resolving for (say) 1.2, then instead of picking a,b,c 
again (with the same merge issues), pick the one you put onto 1.2 already.  Work your way 
that way from branches that came off nearest to the original feature, back down toward the 
  root.  Each time pick the one you just planted, because it already contains merges part 
way down.  Then you only have to deal with the changes between those two branches.

So that's what I'd do:  pick a, b, and c onto the most recient other branch (1.2 in your 
drawing), fixing merge as I go.  Then reset mixed back to the original tip before the 
picks, and commit everything with a good name for the feature.  Then, pick that onto the 
next newest branch (1,1 in your drawing), etc.

--John
