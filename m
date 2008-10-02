From: "Klas Lindberg" <klas.lindberg@gmail.com>
Subject: Re: How to remove a commit object?
Date: Thu, 2 Oct 2008 15:36:41 +0200
Message-ID: <33f4f4d70810020636g77f4180cm7aa6b7de07ae5beb@mail.gmail.com>
References: <D53D127D-97DD-417C-9109-ABD46BBD4E18@midwinter.com>
	 <48D36DF4.3030607@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Steven Grimm" <koreth@midwinter.com>,
	"Git Users List" <git@vger.kernel.org>
To: "Michael J Gruber" <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Oct 02 15:38:03 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlONQ-0007ar-BE
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 15:37:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755199AbYJBNgo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 09:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753633AbYJBNgo
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 09:36:44 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:30263 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755172AbYJBNgn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 09:36:43 -0400
Received: by ug-out-1314.google.com with SMTP id k3so1016326ugf.37
        for <git@vger.kernel.org>; Thu, 02 Oct 2008 06:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=YLH/7bs06UiQi4rB28IlqgTgJyQRPcmi1in85l3sTrE=;
        b=dDtw4bVBpEyPVJlAVPhY4f8RGGalHCFdxJd0wkFDwAXeqsehwpJAFEETqHBKoviwFY
         7eZI8Rei6kUWtRNZqx52/NoijvzaJBCb8wXI6UqOzizlrtSvwocnoiEG8h4abfodzAph
         zvKvMD6ZiyPCd3HAsletLmsIAcSPQ5Ygcyvxo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=r8+Cacr8O7PKaFJM58paUSg2sdYUT+uXLZT2KxyDoG/2QFnwVKc8REnZ2PLorrH29C
         UNJ59akzJjNnlE9hpaHRiEdPBFR3bQF7KdOjQToVnQC89E0z2lEU2EyB8B3PsagaBQrD
         98XcFFopelWeE9OFFgRefDnjkJWOmmB5JJ9jc=
Received: by 10.86.92.4 with SMTP id p4mr8681911fgb.45.1222954601273;
        Thu, 02 Oct 2008 06:36:41 -0700 (PDT)
Received: by 10.86.84.16 with HTTP; Thu, 2 Oct 2008 06:36:41 -0700 (PDT)
In-Reply-To: <48D36DF4.3030607@drmicha.warpmail.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97326>

This doesn't seem to work for me. I will soon be in a situation where
I need to selectively delete commits in such a way that they become
completely irrecoverable. I.e. it is not enough to revert a commit.
The *original* commit must be removed. And of course, the repo history
is too complex to allow for rebasing followed by garbage collection or
something like that.

The reason is that we consider opening a repository to external
participants, but some commits contain stuff that we'd really rather
not show to anyone else. Making the repository public without loosing
history would then force us to either

 1. Recreate every commit in a new repo, sans the offending commits.
Seems like hard work.
 2. ?

Would it be feasible to write a tool that can selectively replace a
specific commit in the commit DAG, or would that automatically
invalidate every SHA key for every commit that follows the replaced
original?

BR / Klas

On Fri, Sep 19, 2008 at 11:16 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Steven Grimm venit, vidit, dixit 19.09.2008 01:41:
>> I maintain a shared repository a bunch of my coworkers push to for
>> code reviews. It has accumulated a lot of packfiles, so I want to
>> shrink it down a bit, but there's a problem:
>>
>> % git repack -A -d
>> Counting objects: ...
>> error: Could not read 125bf191b65189aaec7a6aa24ff26460d141d587
>> fatal: bad tree object 125bf191b65189aaec7a6aa24ff26460d141d587
>>
>> "git fsck" confirms that the tree object is missing:
>>
>> % git fsck
>> broken link from  commit 1b2f0595bb4a6c2e17ca43a9cc41feec88c72a47
>>                to    tree 125bf191b65189aaec7a6aa24ff26460d141d587
>> ...
>> missing tree 125bf191b65189aaec7a6aa24ff26460d141d587
>>
>> This is a dangling commit, but that's fine; for this particular
>> repository we actually *want* lots of dangling commits since they
>> represent the history of people's code review requests. (Hence me
>> running git-repack with -A instead of -a.)
>>
>> Given that it's dangling, it seems like it'd be safe to just remove
>> entirely (we lose that little bit of code-review history but we've
>> lost it already anyway with the tree object missing). But I'm not sure
>> how to do it. Is it possible to delete a commit object, and if so, how?
>>
>> I don't know how the corruption happened in the first place. There was
>> a short time at one point where the permissions on the object
>> directories were inconsistent, so it's possible someone pushed during
>> that period and managed to create the commit object file in .git/
>> objects but didn't have permission to create the tree object. That's
>> just speculation on my part, though. This is the only corrupt object
>> in the repository according to git-fsck, so at this point I just want
>> to know how to get rid of it so I can do the repack.
>
> git prune should delete dangling commits. Is that commit already in a
> pack? Then the -f option to repack may help.
>
> Michael
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
