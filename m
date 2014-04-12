From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Cannot push anything via export transport helper after push
 fails.
Date: Sat, 12 Apr 2014 16:22:10 -0500
Message-ID: <5349ae827ef03_285f9032ecd1@nysa.notmuch>
References: <20130511162936.0354e5d7@opensuse.site>
 <CAMP44s1YhQR0o-0CLc2PG-EJTZdN4tha-4BVEUy-K_Av81D=GQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>,
	Andrey Borzenkov <arvidjaar@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 12 23:32:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZ5X8-0005t5-NK
	for gcvg-git-2@plane.gmane.org; Sat, 12 Apr 2014 23:32:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756334AbaDLVcN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2014 17:32:13 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:54699 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755715AbaDLVcM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2014 17:32:12 -0400
Received: by mail-ob0-f170.google.com with SMTP id uz6so7647359obc.1
        for <git@vger.kernel.org>; Sat, 12 Apr 2014 14:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=zWbTo9ZnY2yshsOvX0JzBUQ0ez2S5Bfl35N91vZpIyQ=;
        b=ZI9tQAyPJjONsGLIpFz2rTQGuxPXlUJECpL7QCnX3BW5el71C2BfNnRtvsCnWg5ZjR
         +b/N2fk+f2v8xe+n6UI1LJY0Zm/ccmVCtxZG4qUEl21kI9awil5tH7MlhHIfn8SR2x0C
         lukzYEYQ6/3WzehXpslzXFVYWDrgXaeqWZbEY3QuT2VNXiyvaEDM3g4Z6kuYRPK8YeJG
         uo5fdiQfQQ7eK2lNpRVCexFVvkNwudFkkAIfWSiAxAVEsgnikhqb8WyO6Ixuwcn//Vth
         SuMqWtTBs5u4S0T5irdqcen+VRt9t2wajHhmHG4CEgc4HsH1bQxDCZdyj06y3EF/ix+1
         Xtpw==
X-Received: by 10.182.230.135 with SMTP id sy7mr26633927obc.24.1397338331872;
        Sat, 12 Apr 2014 14:32:11 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id ko3sm49635664oeb.1.2014.04.12.14.32.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Apr 2014 14:32:10 -0700 (PDT)
In-Reply-To: <CAMP44s1YhQR0o-0CLc2PG-EJTZdN4tha-4BVEUy-K_Av81D=GQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246194>

Felipe Contreras wrote:
> On Sat, May 11, 2013 at 7:29 AM, Andrey Borzenkov <arvidjaar@gmail.com> wrote:
> > I noticed that using git-remote-bzr, but as far as I can tell this is
> > generic for all transport helpers using fast-export.
> >
> >
> >
> > What happened was "git push" failed due to merge conflict. So far so
> > good - but from now on git assumes everything is up to date.
> >
> > bor@opensuse:/tmp/test/git> git push origin master
> > To bzr::bzr+ssh://bor@localhost/tmp/test/bzr
> >  ! [rejected]        master -> master (non-fast-forward)
> > error: failed to push some refs to 'bzr::bzr+ssh://bor@localhost/tmp/test/bzr'
> > hint: Updates were rejected because the tip of your current branch is behind
> > hint: its remote counterpart. Merge the remote changes (e.g. 'git pull')
> > hint: before pushing again.
> > hint: See the 'Note about fast-forwards' in 'git push --help' for details.
> > bor@opensuse:/tmp/test/git> git push origin master
> > Everything up-to-date
> > bor@opensuse:/tmp/test/git>
> >
> > The problem seems to be that git fast-export updates marks
> > unconditionally, whether export actually applied or not. So next time
> > it assumes everything is already exported and does nothing.
> >
> > Is it expected behavior?
> 
> Indeed, this is the way it currently works, and it's not easy to fix.
> We would need some way to make fast-export wait until we know the exit
> status of the remote helper, and then tell it when it failed, so the
> marks are not updated.
> 
> However, the way remote-bzr/hg work is that the commits are still
> there anyway. So if you merge the next time you push those commits are
> already converted, so it's not a problem if fast-export is not
> exporting them again.
> 
> So even though it's not ideal, it should work.
> 
> The problem is when the remote-helper crashes and the marks of
> fast-export and the remote-helper are out of sync, and then the user
> is really screwed.

I sent patches that should fix this problem:

http://article.gmane.org/gmane.comp.version-control.git/246187

-- 
Felipe Contreras
