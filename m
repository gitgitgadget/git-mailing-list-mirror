From: "Marcel M. Cary" <marcel@earth.care2.com>
Subject: Re: parallel dev. with email
Date: Tue, 3 Mar 2009 09:20:27 -0800
Message-ID: <49AD66DB.1090903@earth.care2.com>
References: <20090303153141.246620@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "stoecher@gmx.at" <stoecher@gmx.at>
X-From: git-owner@vger.kernel.org Tue Mar 03 18:27:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeYOa-0005WA-Dq
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 18:27:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755268AbZCCRZe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 12:25:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755221AbZCCRZe
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 12:25:34 -0500
Received: from autodiscover.earth.care2.com ([38.99.18.107]:14901 "EHLO
	exchange01.earth.care2.com" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1754578AbZCCRZd (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2009 12:25:33 -0500
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Mar 2009 12:25:33 EST
Received: from [10.100.1.59] (38.99.217.18) by exchange01.earth.care2.com
 (10.102.0.107) with Microsoft SMTP Server id 8.0.813.0; Tue, 3 Mar 2009
 09:20:27 -0800
User-Agent: Thunderbird 2.0.0.19 (X11/20081209)
In-Reply-To: <20090303153141.246620@gmx.net>
X-PureMessage: [Scanned]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112127>

stoecher@gmx.at wrote:
> Hi,
> 
> I am new to git and I am wondering what git commands to use for 
 > this szenario: two developers without the possibility of sharing
 > a server communicate their changes via email.
 >
> This is how far I have come reading the online docu:
> * Each developer can create the diff-info of his commits with
>   git format-patch
> * and the other developer can incorporate these changes with
>   git am
> 
> After creating the patches with format-patch one could set a tag:
>   git tag -f patchesDone
> so next time one wants to create patches, this tag can be used as the starting point:
>   git format-patch patchesDone..

I wonder if it would be easier to maintain a separate branch containing 
changes which you have both integrated.  Suppose you call it "master". 
And then do your own work on another branch called "private".  Then when 
you want to send all your new work, you can just do:

   git format-patch master..private

possibly threading the messages, etc.

When your collaborator has acknowledged receipt of the patches, you put 
them on your master also, and rebase your "private" branch.  If the 
patch doesn't apply cleanly for your collaborator, you'd need to apply 
your collaborator's resolution to your master instead of your original 
patch.  Or you could apply whatever work your collaborator has that is 
conflicting with your own patch, and resolve the conflict yourself.

I would expect you can periodically verify that your "master" source 
code is synchronized by comparing tree hashes, even though the commit 
hashes may differ.

I imagine you might find that your patches might sometimes have a 
different order than your collaborator's if your emails cross, and their 
commit hashes may differ.  But I expect that would mostly work out ok. 
You could probably verify that your "master" source code is synchronized 
by comparing tree hashes from time to time, even though the commit 
hashes may differ.

You could even split your work among several "feature branches".  But 
one piece of information that "git format-patch" does not advertise, but 
which "git push" does, is the branch that a patch should be applied to. 
  So if your protocol is email-only, and you want to share many branches 
with your collaborator, you'd have to communicate that explicity in the 
email.

> But what if in the meantime one has incorporated the other 
 > developer's changes with git am? Then these changes will also
 > be among the patches created with format-patch. What will
 > happen, if these patches are sent to the other developer,
> who does not need his own changes again. Will his own changes 
 > be silently ignored by git am?

Yes, provided the actual code changes in the duplicate patch are exactly 
the same, git am will skip it, even if the committer, timestamps, or 
comment are slightly different.

Marcel
