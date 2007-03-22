From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Rename handling
Date: Thu, 22 Mar 2007 03:01:39 +0100
Message-ID: <200703220301.41180.jnareb@gmail.com>
References: <slrnevtdfh.v0v.jgoerzen@katherina.lan.complete.org> <4601B199.9060300@midwinter.com> <46a038f90703211710q168a691cpa282f8e2afc5c8a6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Steven Grimm" <koreth@midwinter.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 22 02:59:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUCZz-0002Ye-1S
	for gcvg-git@gmane.org; Thu, 22 Mar 2007 02:59:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753043AbXCVB6r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Mar 2007 21:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753054AbXCVB6r
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Mar 2007 21:58:47 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:34874 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753026AbXCVB6q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2007 21:58:46 -0400
Received: by ug-out-1314.google.com with SMTP id 44so547482uga
        for <git@vger.kernel.org>; Wed, 21 Mar 2007 18:58:45 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=cz/pCA3Or4kbBsKFZphdB3O5qn6SrM4Pei7BYtSQNDo3HTIsHItqE/SWAvvWiljU/FousT3jN6xZu+Mot6CQ2x8Mdv8Ql7dgVffhn/1lid59zmPLt/Fn6iILdmKwxe13XNUYCEdGsrQUp4zhIdgUmcPvbvBiWgEBxLP0w3vj3DM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=f3CUO2mWSPKW4Fle25vrbcsNbVhdVj7nBfE0HFD6HNhEw+in3lmQJV1sPTAKezw47TJWHEevwteYxHW/Vu7RvXSrqEaxlJC+9P3Da+W++DW3PZcjGwuG2MLiG9WWjCYnIyokk5Ahh0v7cRs28rQWbg2/JZ8O8XwzStSpb2ArLQc=
Received: by 10.66.225.1 with SMTP id x1mr4062317ugg.1174528724803;
        Wed, 21 Mar 2007 18:58:44 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id g8sm407730muf.2007.03.21.18.58.42;
        Wed, 21 Mar 2007 18:58:43 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <46a038f90703211710q168a691cpa282f8e2afc5c8a6@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42831>

Martin Langhoff wrote:
> On 3/22/07, Steven Grimm <koreth@midwinter.com> wrote:
>>
>> Say you're tracking a directory full of video files. Even a slight tweak
>> to one of them (to put a logo in the corner, say, while moving it into
>> an "accessible by the public" directory) will result in a file that has
>> no content in common at all if you look at it as purely a stream of
> 
> In that case, tracking the rename is not useful at all from the POV of
> your SCM. The  reason the SCM needs to understand content-movement (of
> which renames are a special type), it to help you as much as possible
> at merge time.
> 
> So - git as an SCM focusses on tracking your content, and helping you
> merge. It does _that_ probably better than any other SCM. So git
> internat data structures care strictly about the stuff that is needed
> for git's operation as an SCM.
> 
> And in the context of helping you merge, explicit rename tracking is a
> red-herring. This point is arguable - Linus said earlier "you can do
> better by tracking content and ignoring explicit renames" and we are
> now getting there in terms of having code that does better.

Additional issue that we have to think about with respect to rename
support for merges is that git uses 3-way merge, taking into account
_only_ upstream commit (of the branch we want to merge to), side branch
commit (of the branch we want to merge) and common ancestor[*1*] 
(merge base) for merging. What is important is that the intermediate
states, how we got to the current state, does not matter.

Well, one could argue that if we remember explicit (provided by user)
info about renames for example in proposed 'note' field of a commit
object, or in other helper structure (we cannot remember the information
in blob or tree), we can gather and remember information about recorded
explicit renames when finding common ancestor...

Although I think it would be better and easier to just provide rerere2
cache to git-rerere to record corrections to rename detection, and use
it in subsequent merges (this was proposed, but IIRC not implemented)...

> Of course in your case the fact that there was a rename is important
> -- for users. This kind of information is not metadata for the SCM but
> for users. So that goes into the commit message, which is freeform. So
> - working with your scenario, if this happens often, I would suggest
> having a pre-commit hook that prepares a nice commit text message
> listing likely renames if they can be sussed out automatically.
> 
> Or having a custom git-mv that collects mv operations and then your
> pre-commit-hook preps your commit message with that manifest of moved
> files.
> 
> Does it make sense? It is data-for-the-user, so it goes in the commit
> msg. If it's data-for-the-SCM machinery, then it goes into the
> tracking data git handles internally.

Still, it would be nice to have --follow=<file> option to git-log family,
besides path limiting. And this could have take use of explicit recording
of renames (much easier than merge can).


References
==========
[*1*] Well, it can be a bit more complicated if there is more than one
common ancestor; git uses recursive merge strategy.

-- 
Jakub Narebski
Poland
