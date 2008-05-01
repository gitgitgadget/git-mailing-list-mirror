From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: detecting rename->commit->modify->commit
Date: Thu, 1 May 2008 11:50:31 -0400
Message-ID: <32541b130805010850q165fe1d6me05e670ca93b0892@mail.gmail.com>
References: <4819CF50.2020509@tikalk.com> <4819D98E.1040004@tikalk.com>
	 <32541b130805010827r22169651s37c707071f3448f2@mail.gmail.com>
	 <20080501153457.GB11469@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Ittay Dror" <ittayd@tikalk.com>, git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 01 17:51:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jrb47-00062i-CB
	for gcvg-git-2@gmane.org; Thu, 01 May 2008 17:51:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762405AbYEAPue (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2008 11:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762596AbYEAPue
	(ORCPT <rfc822;git-outgoing>); Thu, 1 May 2008 11:50:34 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:61729 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763144AbYEAPud (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2008 11:50:33 -0400
Received: by fg-out-1718.google.com with SMTP id 19so591506fgg.17
        for <git@vger.kernel.org>; Thu, 01 May 2008 08:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=yiwAi3/7+8iLn8H2L0C17O8Vk9415dSSsgkOgKkxniY=;
        b=RxXX04Y4mWmQzj71dTB11gGQJM6QxU7JqDBQx9j5unLVgKL9pxhd/MosbgvAYiefNXz/bopYZn5o5kmoe5zemCydUlmN0XAOVdISBxeNyVCEya7vfvSsxvaUjFFzVfhNzOhLg4WeJ/c+P63AVTMVt1PH4pFqHiPEVJmJ8oFJ7eI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cAn92gMBNoqJ+51JcHJzpM/dKmrRW7x714/80U91EhWRwFWrf8eb3afk4a2T1nkNQuXZQavu1SJx1hoSCxx0Pa7PclPUTVxgz+e8/vTEE/mx/cHAbcK6v0ZWVm4tKf6cp1qPH2FhXufCZY1YnREdOLG+XhEmVna063YOHof2Dhw=
Received: by 10.82.146.10 with SMTP id t10mr247788bud.51.1209657031425;
        Thu, 01 May 2008 08:50:31 -0700 (PDT)
Received: by 10.82.166.12 with HTTP; Thu, 1 May 2008 08:50:31 -0700 (PDT)
In-Reply-To: <20080501153457.GB11469@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80927>

On 5/1/08, Jeff King <peff@peff.net> wrote:
> On Thu, May 01, 2008 at 11:27:34AM -0400, Avery Pennarun wrote:
>
>  > Before you say this is not a realistic use case, I've personally had
>  > this exact problem:
>  >
>  > - I had a project with all of my work in a folder "src"
>  > - I decided that the 'src' folder was redundant, so I moved it all to
>  > the root folder
>  > - Someone else was working on an old maintenance branch which still had 'src'
>  > - When I merged from that person, some new files were created under
>  > 'src', and of course didn't work.
>
>
> Sure. But we've also had the exact case of:
>
>   - there are some files in subdir/ [1], but that is not a good name, and
>     there is something else that you are going to add that would be
>     better named as subdir/.
>   - you rename subdir/ to bettername/ [2]
>   - you create subdir/newfile [3]
>
>  but you _don't_ want newfile to go into bettername/. It's _replacing_
>  what went into bettername/.

I would argue that this is a sort of "directory splitting" operation.
That is, all anyone ever did was add some files to a subdir/ that
already existed [1], *or* move all the files from subdir/ to a
previously-empty bettername/ [2], *or* create a new subdir/ and add
files to it [3]. In each case, no merge operation was necessary and it
is completely obvious by comparing "before and after" trees which case
it was.

I guess my argument here is just that it should be *possible* to
deduce and implement both cases at merge time just fine using git's
existing storage model.  It just hasn't been implemented yet.  (And
incidentally, I think that's totally awesome and I'd never want to go
back to an explicit rename tracking model.)

I should shut up now because the actual merge machinery scares me and
I'm not willing to volunteer to write a patch for this one :)

Have fun,

Avery
