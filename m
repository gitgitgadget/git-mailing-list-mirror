From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [RFC] Zit: the git-based single file content tracker
Date: Thu, 23 Oct 2008 20:51:53 +0700
Message-ID: <fcaeb9bf0810230651j1c02de13j61238c97661c32e9@mail.gmail.com>
References: <gdok16$vh2$1@ger.gmane.org>
	 <fcaeb9bf0810230550t54813c09m3b1984f065732c0@mail.gmail.com>
	 <cb7bb73a0810230633r9970a50mbb4ecf3a855c3a21@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 23 15:56:10 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kt0d6-0006VP-B2
	for gcvg-git-2@gmane.org; Thu, 23 Oct 2008 15:53:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752469AbYJWNv6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2008 09:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752398AbYJWNv6
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Oct 2008 09:51:58 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:63777 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752368AbYJWNv5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2008 09:51:57 -0400
Received: by gxk9 with SMTP id 9so1402211gxk.13
        for <git@vger.kernel.org>; Thu, 23 Oct 2008 06:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=yRn1OmFguTIXaaylqe789rbsNKanHpNPVeX76NNSjMQ=;
        b=m7g/5zJJyFKfNWgaNZ7GRudafkozjnnojaQPw8uiAFUn4OJVgfebhw37r7zinKXVql
         HhuV1mx1iZh94o2JY7b3uofQebRpEFFGDWSScB2v69vPrGW5ZKLj+KysMtyfPAJR0aPW
         dUWiRZPHhm0LVK5WJT0vOCVmtBoAPjaC4aGKY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=WGbqdsAcq97mFKe8qMl+1sTINGJ+oruVQpNR6DJbWD0idTUqFMGm0sFL1SbbTKuNka
         tHuQzb02JY+/okknJWOWvksMnkycOYUnVYO58NszAMMWZA29Cmwvvltu9JlZTVG3esMK
         GIAZVoeynRc0voDH2GPjnODOmxYRld2m/uqG0=
Received: by 10.86.59.2 with SMTP id h2mr2272254fga.40.1224769913045;
        Thu, 23 Oct 2008 06:51:53 -0700 (PDT)
Received: by 10.86.95.9 with HTTP; Thu, 23 Oct 2008 06:51:52 -0700 (PDT)
In-Reply-To: <cb7bb73a0810230633r9970a50mbb4ecf3a855c3a21@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98965>

On 10/23/08, Giuseppe Bilotta <giuseppe.bilotta@gmail.com> wrote:
> On Thu, Oct 23, 2008 at 2:50 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
>  > On 10/23/08, Giuseppe Bilotta <giuseppe.bilotta@gmail.com> wrote:
>  >>  The principle is extremely simple: when you choose to start tracking a
>  >>  file with Zit,
>  >>
>  >>  zit track file
>  >>
>  >>  Zit will create a directory .zit.file to hold a git repository
>  >>  tracking the single file .zit.file/file, which is just a hard link to
>  >>  file.
>  >
>  > Why not use one .zit repo and track each file on each own branch?.
>
>
> So your proposal is to have a single .zit repo which is actually a git
>  repo and where each additional tracked file becomes its own branch,
>  and zit would take care of switching from branch to branch when zit
>  commands are called?

I don't know if switching is necessary. With one file per pranch, the
index is even not necessary.

>  I think this solution would have a number of problems, apart from
>  being generally quite messy. First of all, moving a file and its
>  history somewhere else means toying around with the history of a much
>  wider repo, whereas the current approach would mean just moving the
>  .zit.file dir together with the file (modulo hardlinks). Non-linear
>  histories for a single file would be more complex to handle, too. And
>  publishing just the history of one file would be damn complex.

The history should be linear. Git (or zit) repository is just a
container for git branches. Each branch contains only one file. Moving
a file history is equivalent to "git push" + "git branch -D".
Something like this (not tested):

cd dst
git init
cd src
git push dst local-branch:remote-branch
git branch -D local-branch
git gc

>  --
>  Giuseppe "Oblomov" Bilotta
>


-- 
Duy
