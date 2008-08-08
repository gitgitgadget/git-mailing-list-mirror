From: "Matt Graham" <mdg149@gmail.com>
Subject: Re: git reset --hard isn't resetting
Date: Thu, 7 Aug 2008 21:06:27 -0400
Message-ID: <1c5969370808071806g1f989260n55a4b8bebfedb6e@mail.gmail.com>
References: <1c5969370808060941q59cb8f7fhabee3ef3c5107715@mail.gmail.com>
	 <32541b130808061102q752076a8ydc02fef4e799491f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 08 03:07:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRGS2-0003tn-BE
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 03:07:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbYHHBG3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2008 21:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbYHHBG2
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Aug 2008 21:06:28 -0400
Received: from wf-out-1314.google.com ([209.85.200.172]:33287 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751096AbYHHBG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2008 21:06:28 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1203370wfd.4
        for <git@vger.kernel.org>; Thu, 07 Aug 2008 18:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=PjtgWwtU9/xAOIlVTYLJERZiQQ9izo2Skp+0RobWznY=;
        b=tepa4Lj2Pdygc3ZpLavMlfdcZur8nlzXg2bYscPBGX9kcZ+FAkJIHbnfxrN2yPU17L
         adsXLtiNAnrj6ivmVNB0m2C51EsDM4fygG3ddHU10qjToBR4kUvbO3vxSGzkVtHP118p
         5p5V7HlwI5QFJCSE0/cG/uvb9eG4UQ66LOQZM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=m1SRofmp0kPj11ex5c6wdXKeYeIqG/a3p2/jfMQsf8Wy+j32tXHSeG8EMDIYC9gf8+
         iF5YFZnkMPsB0nMSdlNH5drRV10epeFE/uww5SZhEjLw8vmHm8FFIBcIJPOAYAPsPqdB
         wGhLUNW0vDNC72frUM9VIsZ6+O+QFH91fmhsI=
Received: by 10.142.170.6 with SMTP id s6mr710412wfe.228.1218157587495;
        Thu, 07 Aug 2008 18:06:27 -0700 (PDT)
Received: by 10.142.204.21 with HTTP; Thu, 7 Aug 2008 18:06:27 -0700 (PDT)
In-Reply-To: <32541b130808061102q752076a8ydc02fef4e799491f@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91616>

On Wed, Aug 6, 2008 at 2:02 PM, Avery Pennarun <apenwarr@gmail.com> wrote:
> On 8/6/08, Matt Graham <mdg149@gmail.com> wrote:
>>  I'm using a git svn tree in Cygwin.  I tried doing an svn rebase and
>>  got in some weird state with local changes I can't get rid of.  It's
>>  not an issue w/ the same repository on my linux machine.
>>
>>  git reset --hard
>>  toggles 4 files between capitalization.  The files don't appear to
>>  have changed case in svn, but it's a huge repository and not easy to
>>  determine with certainty.
>
> Try:
>   git log --name-only
> to see which patches change which files.  It's a virtual certainty
> that they were renamed in svn at some point.

They weren't "renamed".  Further investigation w/ the hated svn tools
showed that the upper case was removed, then many commits later, the
lowercase was added.

> git doesn't handle case-munging filesystems perfectly, and gets into
> the situation you describe.  First, you need to figure out whether you
> have files with *both* cases accidentally added to your index (if git
> reset toggles the capitalization, this is almost certainly the case):
>
>    git ls-tree HEAD
>
> If you see the same files with different case, that's your problem.

Indeed that was the problem.  In fact, l now noticed that my linux
machine has both versions as well.  Being case sensitive, it didn't
mind and the problem wasn't obvious.

> Now just 'git rm' the ones with the case you don't want, and commit
> the result.  (Do *not* use commit -a!)  'git status' will give you
> some funny messages indicating that files you *didn't* 'git rm' have
> gone away in the filesystem; it's true, of course, but don't worry
> about that.  Now 'git reset --hard HEAD' and you should be okay.

This worked fine exactly as you said.  I'm curious what will happen when I do
   git svn dcommit
These aren't my files and I'm sort of using git svn on the sly.  I'd
prefer to not have something weird happen to the svn repository due to
this.  Due to the schedule, our tolerance for screwing things up b/c I
want to use git will be low.  And my argument that we should have used
git from the outset probably won't help any.

> I'm not really sure what git should do better in this case, although
> the current behaviour is obviously a bit confusing.

Yes, if SVN is going to have both versions, it's understandable that
git wouldn't know what to do.  Unfortunately, it looks like SVN only
had one version at a time.  So it seems git somehow revived the
uppercase version when the lowercase one was readded through git svn.

This happened on both the cygwin and linux versions, although it only
caused an obvious problem on the cygwin version.  I don't know git
well enough to speculate why this happened, but it looks like it's a
real bug that shouldn't have happened in this case.

On cygwin I'm using 1.5.5.1 and the repository only used that version.
On linux, I currently have 1.6.0.rc0.79.gb0320 but the repo may have
been originally cloned w/ earlier versions.
