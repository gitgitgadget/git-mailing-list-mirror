From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Dealing with rewritten upstream
Date: Sat, 1 Oct 2011 12:34:21 +0100
Organization: OPDS
Message-ID: <B877FF8066FE4EC3A1CFEAF4B00D1E31@PhilipOakley>
References: <CAG+J_DwR4vE6iYt475EM7-VDNi4hG3jhdmXWSbJ04Y9fyHeuLw@mail.gmail.com><CAMOZ1Bu-1hq1UN+UQs9HreR4bhJAoxGFLA=jdW8jgoC9g3DJHQ@mail.gmail.com> <CAG+J_Dw9Oa=LH1CSE3Dr_B6de8X-SQfrWGbayPy3OD-UqB6siA@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "git" <git@vger.kernel.org>
To: "Jay Soffian" <jaysoffian@gmail.com>,
	"Michael Witten" <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 01 13:33:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9xop-0004XW-1t
	for gcvg-git-2@lo.gmane.org; Sat, 01 Oct 2011 13:33:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751869Ab1JALdK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Oct 2011 07:33:10 -0400
Received: from out1.ip07ir2.opaltelecom.net ([62.24.128.243]:20239 "EHLO
	out1.ip07ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751375Ab1JALdI (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Oct 2011 07:33:08 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AhQFAFL5hk5cHKZm/2dsb2JhbABBhGWFTZ4AgQaBTgEEAQEFCAEBGRUeAQEhCwIDBQIBAxUDAgIFIQICFAEECBIGBxcGARIIAgECAwGHYgqmFJEtgS2EZDJhBJ4AhyE
X-IronPort-AV: E=Sophos;i="4.68,472,1312153200"; 
   d="scan'208";a="10924568"
Received: from host-92-28-166-102.as13285.net (HELO PhilipOakley) ([92.28.166.102])
  by out1.ip07ir2.opaltelecom.net with SMTP; 01 Oct 2011 12:33:05 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6109
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182547>

From: "Jay Soffian" <jaysoffian@gmail.com>
> On Fri, Sep 30, 2011 at 7:04 PM, Michael Witten <mfwitten@gmail.com> 
> wrote:
>>> Pictorially:
>>>
>>> ---A---B---C---D---E... new-upstream/master
>>>
>>> ---a---b---c---d---e... old-upstream/master
>>> \ \ \
>>> 1---2---3---4---5 master
>>>
>>> The obvious way do deal with this situation is:
>>>
>>> $ git merge -s ours -m "Splice in new-upstream/master" E
>>>
>>> Are there any other/better options I'm missing?
>>>
>>> (Eventually upstream plans to migrate entirely to git, so I can't just
>>> run git-svn myself.)
>>
>> Surely, you'd rather have your master rewritten such that the relevant
>> commits of new-upstream/master are used IN PLACE of the corresponding
>> old-upstream/master. Have you considered ways to achieve that?
>
> My master has over two years of history with its commit-IDs referenced
> in our bug tracker, in old emails, in archived binaries, etc. So no, I
> do not want to rewrite my master.
>
> Now, if you mean, do I want to use something like replacement refs to
> try to more cleanly splice the new upstream into my existing master,
> no I haven't really explored that. git-replace isn't very well
> documented with examples of its intended use case.
>
> I've considered setting up a new repo at a different URL that is
> rewritten to be based on the new upstream, and migrating to that,
> making the old repo read-only.
>
> But I'm not sure that's worth the trouble. There doesn't seem to be
> too much downside to splicing in the new upstream via merge -s ours.
> It barely increases the repo size since the trees are the same. Maybe
> there's some other downsides I'm missing.
>
Surely; one method is to simply create a merge between the Old_master and 
New_master (i.e. have two parallel branches of identical content) at the 
point where the new approach starts. Git-filter-branch (if used) already 
provides the ref to the original, so it's easy to create that special merge.

You have already noted that all the trees for the commits are identical, so 
the storage overhead is minimal for just the new commit objects (though the 
cognitive overhead can be large for some - plan for often/early 
explanations!)

I'm presuming that you will have at some point in the past, a common commit 
(it maybe the initial commit), so that there is still a single root.

The key question is to decide which 'branch' is Parent1, and which is 
Parent2 (at the merge) for any history traversals that may be required in 
the future. After the merge you can rename the branch back to Master if 
required (more cognitive discussions..)

This slightly differs from your original diagram in that you do not have any 
one-to-one links between the old and new commits. The date/time would be the 
same for the old & new so it shouldn't be hard to find one from the other.

Philip
