From: "Nigel Magnay" <nigel.magnay@gmail.com>
Subject: Re: git-svn, merging et al.
Date: Mon, 19 May 2008 10:14:44 +0100
Message-ID: <320075ff0805190214m48a5ceecg8fd19f27a2d98f6@mail.gmail.com>
References: <320075ff0805160850r473582d9qc33f71ba7f56dd51@mail.gmail.com>
	 <05A51125-339A-45A2-B2CF-8035F2FAE741@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 19 11:15:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jy1T4-0005Cu-9f
	for gcvg-git-2@gmane.org; Mon, 19 May 2008 11:15:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbYESJOr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2008 05:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752115AbYESJOr
	(ORCPT <rfc822;git-outgoing>); Mon, 19 May 2008 05:14:47 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:52107 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751441AbYESJOq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2008 05:14:46 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1596900fgg.17
        for <git@vger.kernel.org>; Mon, 19 May 2008 02:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=KSot10Cs1mLMj2aPBXWLDiJLwOLLBxh7Rz7/gdn9X+I=;
        b=xZ/JBKQMSZ45ovVYSmToDAYU1mwL+QEQ32q7+lqIL6jKTi1ensAPPZb+ULvFR0r5/IVG0LfEoiquT/BMEH3ElZUAL8z842xNITuHosSBXvSqL8tWeTT9DZ3P0X6d5F67RaZt1As8spc2r7Ls8czIk0s9OjsdZE+cb7QW6HC/eks=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DOyb+Yp60u9wFgk21LU9UDSK9pUxmMKHj5ImgOonjyJIHwrtaZv7S8JSYgGnlaecKpNKptrWpVXgfRdsvkrf9zukJU4C3YoHFR96gkoiN+08U23HGpt2e3UsEAJZ03zPc7f6d///7RT9C/5ZUhEEOl3guX7uipyJcFiw16FS6Ro=
Received: by 10.82.150.15 with SMTP id x15mr780659bud.23.1211188484459;
        Mon, 19 May 2008 02:14:44 -0700 (PDT)
Received: by 10.82.168.20 with HTTP; Mon, 19 May 2008 02:14:44 -0700 (PDT)
In-Reply-To: <05A51125-339A-45A2-B2CF-8035F2FAE741@sb.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82420>

Ah - useful - I'll tag that for next time.

I ended up doing a git merge --squash in the end. FWIW, it didn't work
correctly initially, until I worked out that some files were getting
munged by core.autocrlf confusing it. Once I turned it off, it was
fine.


On Fri, May 16, 2008 at 6:40 PM, Kevin Ballard <kevin@sb.org> wrote:
> On May 16, 2008, at 11:50 AM, Nigel Magnay wrote:
>
>> Ok - it's Friday and I've got to interact with svn again..
>>
>> I'm using git-svn, and I've not followed the guidance. Development has
>> gone on in git branches and merges - but now I need to commit the
>> changes back into svn, and dcommit is, understandably, not very happy.
>>
>> I'm intending to instead do something like a
>>  git format-patch svn-branch..git-branch
>>  git checkout svn-branch
>> ... apply all the patches ...
>>  git commit
>>  git svn dcommit
>>  # back to the git work
>>  git checkout git-branch
>>  # this shouldn't have to do merging - but it will have the parents
>> to make it clear where the last merge happened from ?
>>  git merge svn-branch
>>
>>
>> I'm happy that I'm bludgeoning changes in one big blob into SVN, as I
>> can reasonably say 'if you want the real details, go look at gitweb)
>>
>> I've tried doing this with
>> git checkout svn-branch
>> git merge --squash git-branch
>>
>> But I don't get the result I'm expecting - what have I missed?
>
> That merge command will produce a single commit, which isn't what you want.
> format-patch + am should work to linearize history, but you could also use
> rebase.
>
> I recommend trying something like
>
>  git checkout -b test svn-branch && git format-patch svn-branch..git-branch
> | git am
>
> Then you can examine your test branch to make sure it's linear, make sure it
> compiles and looks good, then if it's good merge that into svn-branch (which
> will be a fast-forward).
>
> -Kevin Ballard
>
> --
> Kevin Ballard
> http://kevin.sb.org
> kevin@sb.org
> http://www.tildesoft.com
>
>
>
