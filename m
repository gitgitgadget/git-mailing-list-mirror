From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: Re* git commit fails under some circumstances
Date: Tue, 05 Apr 2011 09:14:55 +0100
Message-ID: <1301991295.2320.11.camel@wpalmer.simply-domain>
References: <AANLkTikHRM10p9e8XCzuiih7cYtQRG7Az2Qn5qtPzhZJ@mail.gmail.com>
	 <7vhbagh3aw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Laszlo Papp <djszapi@archlinux.us>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 05 10:15:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q71Pr-0000Wh-16
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 10:15:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753047Ab1DEIPF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2011 04:15:05 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:49614 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752077Ab1DEIPB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2011 04:15:01 -0400
Received: by fxm17 with SMTP id 17so98711fxm.19
        for <git@vger.kernel.org>; Tue, 05 Apr 2011 01:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:from:to:cc:in-reply-to:references
         :content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=p8pzWtWm79c4DxAHmb0ketMA7vG1JaZ3UH005JUXpyY=;
        b=dJOUvg+qqA6v3SK8cFlFB4qDmC0BvOi7Z8RgKyRCExZMx3x4d7M20q2m9gGDgu60eF
         4QUGWC8VvbsXVIEk720L/CGNM+OSenkOkJr6eo2bWfGCoRtFpz6svCeujPk4rauomKW/
         kpsH/EPxAU5IIBux4p/ng+FqGbI+lsCMS6Js0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=FXVqaL4Mj7hK7rOJ9FfAQRpv1u8VhFE9kNi4amHpxaQDE0c8NInFQVo5dlzC0c66IR
         qzgzdvmDkt6OLsreWkVdKzrv5CzNqCS51MksiIMDb88xi73mO9LAbham0VSSlZ7dk/Lb
         vRY9jrzPr8SDCdoEbRp4WRnZgi5v0hulQ6lXo=
Received: by 10.223.75.1 with SMTP id w1mr5434252faj.17.1301991300614;
        Tue, 05 Apr 2011 01:15:00 -0700 (PDT)
Received: from [192.168.2.128] (tontine65c.demon.co.uk [80.176.141.31])
        by mx.google.com with ESMTPS id 21sm1992267fav.17.2011.04.05.01.14.57
        (version=SSLv3 cipher=OTHER);
        Tue, 05 Apr 2011 01:14:58 -0700 (PDT)
In-Reply-To: <7vhbagh3aw.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170874>

On Sat, 2011-04-02 at 12:16 -0700, Junio C Hamano wrote:
> Laszlo Papp <djszapi@archlinux.us> writes:
> > 3) It would be nice to have one command (with no (git) alias for sure)
> > to see the difference like "git diff" but also the new files.
> 
> Doesn't "git diff" show the difference for files you told git about via
> the "add -N" interface?  After the above "addition" of RENAMING, if I ask
> "git diff" (or "git diff HEAD"), I get what I expect to see (addition of
> the contents taken from the whole file in the working tree).
> 
> Again, please describe what you think should be the right output if it
> differs from your expectation.
> 

To give some context: the problem here is that "git add -N" was being
used as a glorified way of saying "show the content of a file I have
just added in "git diff" output along with unstaged content", as is
described in the manual for "git add" as one of the purposes of -N. All
the other problems are somewhat invented issues stemming from this one.
That is, a result of blindly following instructions to "try git add -N
if you want to see the output in diff", without the implications having
been explained first.
The alternative, "git add everything else, then use git diff --cached" I
believe is unsuitable because the goal is to have "git diff" 'just work'
in future runs, without the need for additional commands being run.
Honestly I do not quite understand the exact use-case.

An option such as --treat-new-as-unstaged might solve this better, but
of course suffers from the problem of having a terrible name. I greatly
suspect that the name being terrible is a sign of the idea not being
fleshed-out enough yet. There are also various cases involving renames
where it would not be clear at all how to handle things.

-- Will

> Also having said that, I notice that "git diff --cached" behaves as if an
> empty blob is added in such a case.  I am not sure if we want to special
> case this.  After all paths marked with "git add -N" does _not_ have a
> concrete contents in the index by definition (as the user told "I'll tell
> you later" but hasn't done so), and may want to behave more like unmerged
> entries for certain operations (i.e. the path does exist, but comparing
> something with it does not have a usual meaning, etc.)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
