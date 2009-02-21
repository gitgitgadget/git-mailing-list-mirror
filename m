From: Bryan Donlan <bdonlan@gmail.com>
Subject: Re: git merge --abort
Date: Sat, 21 Feb 2009 02:28:27 -0500
Message-ID: <3e8340490902202328r7caca98q973c17dc163e2028@mail.gmail.com>
References: <43d8ce650902190205yc2274c5gb8e658c8608267ff@mail.gmail.com>
	 <7v63j6n16s.fsf@gitster.siamese.dyndns.org>
	 <43d8ce650902190534j49e24f86k9b716190ae3d134b@mail.gmail.com>
	 <76718490902191226k7b87f478p9a79b9b2372b464d@mail.gmail.com>
	 <43d8ce650902192047g383a5cc1re6697e8009ad72fc@mail.gmail.com>
	 <7v7i3lk7dp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: John Tapsell <johnflux@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 21 08:30:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LamJp-0007y6-KN
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 08:30:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752133AbZBUH23 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Feb 2009 02:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752116AbZBUH23
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Feb 2009 02:28:29 -0500
Received: from yx-out-2324.google.com ([74.125.44.30]:55218 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752112AbZBUH22 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Feb 2009 02:28:28 -0500
Received: by yx-out-2324.google.com with SMTP id 8so499705yxm.1
        for <git@vger.kernel.org>; Fri, 20 Feb 2009 23:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=pIHZ0sFAVRPbM6L4OipRHmj9SUSR3MR3DccBW2kzDOM=;
        b=E4RDD+xciAJzV2bk2g7E8jUisCzN2/JeqX4lQMwdsd504XVD4Buiwo5nnan4a2r5Te
         5rH0RmYem5qM2l/FzBwtWT8JlOdQBmA9/yooVs3IAC6SBhx2nAd+fGiEcgW/1jjv5vDW
         0ESfIDc8IQbwMIwNO046UuJv2HshUAub9v/C0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=NmtDzQj5O+FFE/hF/VHqDdG7s/MwM5UGNZlyxLcerlDhezfEfMUyxUXwVIcXqTY8Gu
         nXxmPJstTrc0SwQ65nS/QiE4q1Of17mghBdRiDU9YasW+XjKOthkaKYEljc1+FpyYVl4
         KUckJZR+kxUhuYOu3/NLEIYll5BGVYJJonEc8=
Received: by 10.220.96.146 with SMTP id h18mr336558vcn.37.1235201307111; Fri, 
	20 Feb 2009 23:28:27 -0800 (PST)
In-Reply-To: <7v7i3lk7dp.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110930>

On Fri, Feb 20, 2009 at 12:24 AM, Junio C Hamano <gitster@pobox.com> wrote:
> John Tapsell <johnflux@gmail.com> writes:
>
>> 2009/2/19 Jay Soffian <jaysoffian@gmail.com>:
>>> On Thu, Feb 19, 2009 at 8:34 AM, John Tapsell <johnflux@gmail.com> wrote:
>>>> There's no reliable way of getting back to the state before the merge?
>>>
>>> Sure there is. Commit or stash before you merge, so that your index
>>> and working copy are clean.
>>
>> Could a stash be done automatically by the merge command, for just a case?
>
> It cuts both ways.  For people who work on a well organized project
> (i.e. highly modularized) and tend to keep local changes in the work tree
> while doing a lot of merges, running "stash" every time would (1) remove
> the local change from the work tree, which he has to remember to manually
> unstash after resolving conflicts in the merge (which would not have
> conflicted with the local change anyway), which is an additional work for
> no real gain, and (2) clutter his stash.  My gut feeling is that it is a
> change that affects the way the end user has to work that is sufficiently
> different and disruptive for no real gain.

Perhaps a better approach would be to stash the pre-merge state in the
reflog, then? That is, manufacture a pre-merge commit containing all
files changed in the working copy, and add it to the reflog prior to
performing a merge. git merge --abort can then simply check whether
the top reflog entry is a pre-merge state, and if so, reset --hard to
it, then reset the index to the parent of our pre-merge commit.

This would also nicely handle the case where the user tries some
random things before deciding to abort the merge.
