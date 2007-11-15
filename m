From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: How to change a submodue as a subdirectory?
Date: Fri, 16 Nov 2007 00:41:05 +0800
Message-ID: <46dff0320711150841g1ec2a238r7fe5650e8cfaee03@mail.gmail.com>
References: <46dff0320711140637s51e1368fv3f632b6f04d093d5@mail.gmail.com>
	 <20071114202651.GC3973@steel.home>
	 <46dff0320711142136r2c70d698vd380c02188f95507@mail.gmail.com>
	 <Pine.LNX.4.64.0711150614380.4362@racer.site>
	 <46dff0320711150014x4a35975eqc53ef1fce7d40b18@mail.gmail.com>
	 <Pine.LNX.4.64.0711151322590.16728@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Alex Riesen" <raa.lkml@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 15 17:41:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IshmS-0003cd-KD
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 17:41:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758703AbXKOQlL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 11:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758606AbXKOQlL
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 11:41:11 -0500
Received: from ik-out-1112.google.com ([66.249.90.182]:13690 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758599AbXKOQlJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 11:41:09 -0500
Received: by ik-out-1112.google.com with SMTP id c28so334229ika
        for <git@vger.kernel.org>; Thu, 15 Nov 2007 08:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=X/al77keOYUiAjg6pNntH52VGljMyn+KDS+eiGhFPZY=;
        b=djPpChqsyG3JZebCSLe3zjE/j85MjO7Bg5bpwmLlRoxR/aWOO3NR4gJL21juruJ2L7zktZ0ON1cWFX3bk+QvL9Q9K3t08QjO2ij5P07h8b2QLL9tiVjy3jRSMUxOwOPca3P2XJ/hzfkD6UxkPqzAQO21D9cG4Dce4+FKCCPxFHI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Rc3XyZve27Yy1DhgDh0jnOk0EHFEhxTnnHlA5t4VZz6JMc1OeZmEWoRGdHIdKiAxtg3ZRLGiUuK/kuRUUcTY3yShP+zsIPIHl2JwSfUL/tl0fQfOFmTG5pLAppn/hqRjEhrx697ZLWNsLwps6wVFCkWevTlG8v8ZXKQEcxjfH2g=
Received: by 10.150.203.8 with SMTP id a8mr84541ybg.1195144866078;
        Thu, 15 Nov 2007 08:41:06 -0800 (PST)
Received: by 10.35.108.1 with HTTP; Thu, 15 Nov 2007 08:41:05 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0711151322590.16728@wbgn129.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65137>

On Nov 15, 2007 8:28 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

>
> > 1. move submodule subB outside
> >     mv subB /newpath/to/subB
> >     git-commit subB
>
> Strictly speaking, you do not have to move it outside.
Hmm, you're right. I can just just remove it after fetch subB as a
branch of superA.
>
> > 2. git-filter-branch to rename all files in subA repository to subB
> > directory (say subB/subB).
> >
> >        cd newpath/to/subB &&
> >        git filter-branch --index-filter \
> >                'git ls-files -s | sed "s-\t-&subB/-" |
> >                        GIT_INDEX_FILE=$GIT_INDEX_FILE.new \
> >                                git update-index --index-info &&
> >                 mv $GIT_INDEX_FILE.new $GIT_INDEX_FILE' HEAD
>
> No need to play games with GIT_INDEX_FILE, as far as I can tell.
I just follow the example of git-filter-branch manual page. If not
using GIT_INDEX_FILE.new, the GIT_INDEX_FILE will be read and wirtten
at the same time since it is read and writtern at the same in a pipe.
Will this be ok?
>
> > 3. in directory of super project superA, git-fetch repository subB to
> > branch subB
> >    cd path/to/superA && git-fetch /newpath/to/subB master:subB
>
> If you plan to do away with subB, you do not need to specify it... Just
> use FETCH_HEAD, directly after the fetch.
Hmm, using FETCH_HEAD is really better.

> The git-cherry call is not really necessary, right?  The two repos have no
> common history (not even common patches).
>
> Besides, I think that what you did is just a complicated way of doing a
> rebase.
I tried rebase, wonderful!

>
> Ciao,
> Dscho
>
>



-- 
Ping Yin
