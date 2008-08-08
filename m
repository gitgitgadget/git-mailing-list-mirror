From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: git reset --hard isn't resetting
Date: Fri, 8 Aug 2008 10:40:03 -0400
Message-ID: <32541b130808080740q249cb0f6t4395cc2623e67c5a@mail.gmail.com>
References: <1c5969370808060941q59cb8f7fhabee3ef3c5107715@mail.gmail.com>
	 <32541b130808061102q752076a8ydc02fef4e799491f@mail.gmail.com>
	 <1c5969370808071806g1f989260n55a4b8bebfedb6e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Eric Wong" <normalperson@yhbt.net>
To: "Matt Graham" <mdg149@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 08 16:41:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRT9Q-0005JE-FM
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 16:41:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752055AbYHHOkG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 10:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752002AbYHHOkG
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 10:40:06 -0400
Received: from an-out-0708.google.com ([209.85.132.245]:1198 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751892AbYHHOkE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 10:40:04 -0400
Received: by an-out-0708.google.com with SMTP id d40so163155and.103
        for <git@vger.kernel.org>; Fri, 08 Aug 2008 07:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=sRs5iNljy84I1sgFWGfxnSWC8+IXTtxaXJJPsKycplA=;
        b=JIhvGATVEBwIw3RV4ajltwPYa3v8S7MV0zrIR4x+DCRjCBFt3xw21LsnBXGLUCURg1
         zcSJ/LzmgmYHYj/l6KcsFo615LFPocQoC3wL9UPZsLz0aw+nWAYvrjzHtHc7gU7aDQ+3
         3pSMQexlUtBy91iXRkSH6ejHWrMJ6H6sfveL4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=HYaVzTzWOjvb/BnVwkyCLepQ3oVurpCvvCTgoeuBnXb9I52PQ1OsCwKk4BUUhmdGj6
         +y1ijC9mPu8Bs7GvVcJybnKyEx5hajbnyPQsH9nSI2mml/YbrvsSMx9XFGcpKADGFrfg
         asEJSJlAv7onMIV7RN3Zinml+mnYVmhMomQLA=
Received: by 10.100.228.17 with SMTP id a17mr3791871anh.82.1218206403501;
        Fri, 08 Aug 2008 07:40:03 -0700 (PDT)
Received: by 10.100.8.19 with HTTP; Fri, 8 Aug 2008 07:40:03 -0700 (PDT)
In-Reply-To: <1c5969370808071806g1f989260n55a4b8bebfedb6e@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91673>

On Thu, Aug 7, 2008 at 9:06 PM, Matt Graham <mdg149@gmail.com> wrote:
> On Wed, Aug 6, 2008 at 2:02 PM, Avery Pennarun <apenwarr@gmail.com> wrote:
>> Try:
>>   git log --name-only
>> to see which patches change which files.  It's a virtual certainty
>> that they were renamed in svn at some point.
>
> They weren't "renamed".  Further investigation w/ the hated svn tools
> showed that the upper case was removed, then many commits later, the
> lowercase was added.

Hmm.  Well, one possibly important thing is that if you take a diff
between the version before the old files were removed, and the version
after the new files were added, it will *look* like a rename because
git doesn't look at the intermediate revisions.  And note that this
sort of thing will be happen if you "git checkout" the before and
after versions.

> Indeed that was the problem.  In fact, l now noticed that my linux
> machine has both versions as well.  Being case sensitive, it didn't
> mind and the problem wasn't obvious.

Did your Linux machine import the data using git-svn, or did it clone
a repo from Windows that imported using git-svn?

I can imagine a situation where git-svn on Windows could get confused
and add the wrong filenames (although it would be kind of unlikely if
they really were removed in one revision, then readded in another; why
would git-svn even think about the old names in that case?).  However,
there's no explanation for a Linux system introducing such a mistake,
since the two files are just unrelated as far as Linux is concerned.

> This worked fine exactly as you said.  I'm curious what will happen when I do
>   git svn dcommit
> These aren't my files and I'm sort of using git svn on the sly.  I'd
> prefer to not have something weird happen to the svn repository due to
> this.  Due to the schedule, our tolerance for screwing things up b/c I
> want to use git will be low.  And my argument that we should have used
> git from the outset probably won't help any.

If your git-svn repo doesn't reflect *exactly* the set of files in
your real svn repo, then you've hit a pretty bad bug and you're almost
certainly going to have problems with dcommit.  On the other hand,
you're unlikely to manage to screw up your svn repo, assuming the
files you deleted were the ones that weren't supposed to be there;
"extra deleting" them from svn wouldn't be dangerous.  I'd expect git
svn dcommit to just fail with a weird error.

>> I'm not really sure what git should do better in this case, although
>> the current behaviour is obviously a bit confusing.
>
> Yes, if SVN is going to have both versions, it's understandable that
> git wouldn't know what to do.  Unfortunately, it looks like SVN only
> had one version at a time.  So it seems git somehow revived the
> uppercase version when the lowercase one was readded through git svn.

Since this seems virtually impossible, it would be nice if you could
double check your SVN repo to make sure the problem really doesn't
exist there in *any* version.  It just doesn't seem likely that git
would have had this problem if the files were cleanly removed in one
revision, then added in a later one.  I could imagine it if they were
renamed all in one revision, though, or if there was *ever* an svn
revision where both files existed at once.  In all those cases we
effectively have a bug in git-svn, but at least in the latter cases
it's an explainable one :)

Beware that svn doesn't reliably sort its filename lists, so you might
find that two different files in the *same* directory are in totally
different places in the list; perhaps you missed a filename that way.

Good luck,

Avery
