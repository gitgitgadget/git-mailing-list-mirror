From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: git branch --switch?
Date: Tue, 17 Apr 2007 19:00:18 +0200
Message-ID: <8c5c35580704171000g74d8944w7c7b3d07228cac2@mail.gmail.com>
References: <4624CD58.90103@gmail.com>
	 <C940520E-732A-4F6E-A7F2-0215FD534455@silverinsanity.com>
	 <4624EAAA.6040000@gmail.com>
	 <8c5c35580704170855ke426d86vac6e9b3b67fea5ea@mail.gmail.com>
	 <4624F18F.6070906@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Brian Gernhardt" <benji@silverinsanity.com>, git@vger.kernel.org
To: "Rene Herman" <rene.herman@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 19:00:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hdr2W-0006NH-Ts
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 19:00:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031201AbXDQRAV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 13:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031141AbXDQRAV
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 13:00:21 -0400
Received: from wr-out-0506.google.com ([64.233.184.228]:1309 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031201AbXDQRAU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 13:00:20 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1865872wra
        for <git@vger.kernel.org>; Tue, 17 Apr 2007 10:00:19 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UHy40WgakDBT1+evZtW54ksEk1v3XLpiuuAKJ1L51Qs0J34nEdAnoa39ZXaxemUTOwtRjVt6Jf0YSTOIJQfDKRG5TAaREIyuxqhCOwqC+mKzVocvjCOFCL9GvNJ0to+dfctBmkO955q3T3SGPY5JFtiRVokhdJbq1g3EbqRdZ0o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=j5VljWc6mUOc9ROzHyt7Srn515qQHVfWPA5iX8phYm3Zyg65+3iIeezXG03YMhbeMwk5x7HpHZ7sllS34NY7MB+vKrFWjKeiE16u9n4+lKCT+FlNTVQ5QDgb6O6Dxfqibtmx/M3PiEKqTWviijMe4qjPK35MCzdH1Kfnrpstfd4=
Received: by 10.114.25.3 with SMTP id 3mr2508037way.1176829218933;
        Tue, 17 Apr 2007 10:00:18 -0700 (PDT)
Received: by 10.114.234.19 with HTTP; Tue, 17 Apr 2007 10:00:18 -0700 (PDT)
In-Reply-To: <4624F18F.6070906@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44798>

On 4/17/07, Rene Herman <rene.herman@gmail.com> wrote:
> On 04/17/2007 05:55 PM, Lars Hjemli wrote:
> > I might have misunderstood your goal, but have you tried
> >
> > git clone -l -s -n <a local linux repo> local
> > git branch a v2.6.20
> > git branch b a
> > git branch c a
> >
> > Now a, b and c all point at v2.6.20, while HEAD points as master.
>
> Well, yes, they do, and I could also do
>
> git branch b v2.6.20
> git branch c v2.6.20
>
> directly then (right?)

Yes


> but I do want that "v20" branch in the middle. The
> cloned repo is a linus repo, and that v20 is where I'll be pulling 2.6.20.y
> updates into; a merge branch will then merge v20, a, b and c into what I
> will be compiling.

Ok. Then maybe you want to try something like this:

$ git clone -l -s -n ../linux-2.6 rene
$ cd rene
$ git remote add v20
git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.20.y
$ git fetch v20

This gives you a tracking branch for 2.6.20.y, named as "v20/master".
That branch can then be used as a starting point for your a, b and c
branches, like:

$ git checkout -b a v20/master    # this _will_ take some time...

After applying some changes on branch a, you can then merge the latest
changes on the v20-branch like this

$ git fetch v20
$ git merge v20/master

If you want the merge to occur on a separate branch, do this first:

$ git checkout -b tmp a


--
larsh
