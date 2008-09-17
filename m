From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH] Convert "sink" to the new infrastructure
Date: Wed, 17 Sep 2008 17:09:46 +0100
Message-ID: <b0943d9e0809170909j4fce34acr8f0b844d0cb5281d@mail.gmail.com>
References: <20080912215613.10270.20599.stgit@localhost.localdomain>
	 <20080914085118.GC30664@diana.vm.bytemark.co.uk>
	 <b0943d9e0809141419q6facb21at627e658805f1d223@mail.gmail.com>
	 <20080915075740.GB14452@diana.vm.bytemark.co.uk>
	 <b0943d9e0809150944o71acafe7ndeda500b1fba97df@mail.gmail.com>
	 <20080916074024.GA2454@diana.vm.bytemark.co.uk>
	 <b0943d9e0809160759w5c9be510t3b33d5d983bff5a7@mail.gmail.com>
	 <20080916193647.GA12513@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Sep 17 18:11:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfzdE-0002IQ-1N
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 18:11:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752711AbYIQQJs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Sep 2008 12:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752352AbYIQQJr
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 12:09:47 -0400
Received: from rv-out-0506.google.com ([209.85.198.235]:57270 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801AbYIQQJr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Sep 2008 12:09:47 -0400
Received: by rv-out-0506.google.com with SMTP id k40so3242562rvb.1
        for <git@vger.kernel.org>; Wed, 17 Sep 2008 09:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=06HflCVsOx0GCF63E0hVp18vv/rxSQAzy7pOltlR6pU=;
        b=sWWVkSWrsSjcnMGYESzzLz+8xRJnsDCEx51YTl5BlpagqMGWLl9DNEHbUcEa04HBuJ
         YZWhgaLfW5T+4ePgbqMUBFx3tNSNIMsWJFPYYCPaVd4zLJeTFlkXOt9WcPE5dFauA/vQ
         NJScF7NjK/GL8zx7qvtAQPpNp6m+VCPCvc+V0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=V/2qnWwMulvcq+jGE6Tm3gYkfeDq9UJDz49956STMfAzYniSK19Bx4LTHRcnYF9fmT
         q8sczF9QOLYeURwRjDA7tLMkyQyEXvIwBLAyE7vXMWBGp1nj+aSmM7pIS4CTXJQ5zOqA
         oq+bZtIGOj+tmGCEpHFRI+szCfzp3bavIjlXM=
Received: by 10.140.134.15 with SMTP id h15mr6658849rvd.65.1221667786537;
        Wed, 17 Sep 2008 09:09:46 -0700 (PDT)
Received: by 10.140.199.1 with HTTP; Wed, 17 Sep 2008 09:09:46 -0700 (PDT)
In-Reply-To: <20080916193647.GA12513@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96125>

2008/9/16 Karl Hasselstr=F6m <kha@treskal.com>:
> On 2008-09-16 15:59:31 +0100, Catalin Marinas wrote:
>
>> 2008/9/16 Karl Hasselstr=F6m <kha@treskal.com>:
>>
>> > iw is the index+worktree object. The idea is that you provide one
>> > if your branch is checked out, and not if not. Operations that
>> > have no need of index+worktree, like pop, and push in case
>> > automatic merging succeeds, will just work anyway, while
>> > operations that need index+worktree, such as a conflicting push,
>> > will cause the whole transaction to abort.
>>
>> Ah, that's the difference. I thought that even if iw isn't passed,
>> it uses the default one.
>
> It wouldn't be clean of it to do that -- it would be accessing
> non-local state it had no business knowing about. I try hard to avoid
> that kind of thing.

I'm still confused by this and I don't think your new flag would help.
The meaning of stop_before_conflict is that it won't push the
conflicting patch but actually leave the stack with several patches
pushed or popped.

What I want for sink (and float afterwards) is by default to cancel
the whole transaction if there is a conflict and revert the stack to
it's original state prior to the "stg sink" command. What I have in my
code:

    iw =3D stack.repository.default_iw
    trans =3D transaction.StackTransaction(stack, 'sink')

    try:
        trans.reorder_patches(applied, unapplied, hidden, iw)
    except transaction.TransactionHalted:
        if not options.conflict:
            ??? here it needs to check out the previous iw
            raise

    return trans.run(iw)

It runs as expected if --conflict is given but in the default case, if
there is a conflict, it keeps the original patchorder (as expected)
but the worktree isn't clean. What do I replace ??? with to clean the
work tree?

BTW, much shorter with reorder_patches.

--=20
Catalin
