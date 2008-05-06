From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: merge renamed files/directories?
Date: Mon, 5 May 2008 21:58:50 -0400
Message-ID: <32541b130805051858u7b8f1cd7qd34fdf50c1f849d0@mail.gmail.com>
References: <4819CF50.2020509@tikalk.com> <481D52CC.1030503@tikalk.com>
	 <32541b130805050940x1297e907ofc67ee65494897eb@mail.gmail.com>
	 <200805052349.35867.robin.rosenberg.lists@dewire.com>
	 <alpine.LFD.1.10.0805051512060.32269@woody.linux-foundation.org>
	 <32541b130805051838k367c44bau715774b46f7894cb@mail.gmail.com>
	 <20080506014636.GM29038@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Robin Rosenberg" <robin.rosenberg.lists@dewire.com>,
	"Ittay Dror" <ittayd@tikalk.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue May 06 03:59:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtCSz-0004iT-QR
	for gcvg-git-2@gmane.org; Tue, 06 May 2008 03:59:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756954AbYEFB6x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 21:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756793AbYEFB6x
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 21:58:53 -0400
Received: from fk-out-0910.google.com ([209.85.128.191]:46715 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755155AbYEFB6w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 21:58:52 -0400
Received: by fk-out-0910.google.com with SMTP id 18so943810fkq.5
        for <git@vger.kernel.org>; Mon, 05 May 2008 18:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=xlAR7Ft1eGlMDDde7bRAg7rL5kBhla6TAZ+vU0S0Yak=;
        b=Y7QPZRaFaRGB4TLgITw+JYElB+1ZUsCz27s9LK4+tkMxo9zjq1GAfgptt6x2ynnjLDWNT3d7mtV2DtAvlmyv+vjVyMGKDWBWE51KeGCN7fTCeDDN9p+0uQAdEiFlu4jCMEAlHXA4cDyGnMmy99vfiIjKOlyg7Bj5YgVB3aaU5oI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=T/ahywkkJZmPAj9fcMfT0eisFFFUMLdKi3nXD3BkSHK0VmQpKyMUMLuKTqdEeMeqtZaXu9hb5zBVX+CmuhOe4ZeBJH+WkN3R8UxZaAXpri7+uKG8lYHrbzmJ4zirBS8A0xoe1+S5SXo5ZZ9/836Y+HVmLFNryG/19ka9GAkZZ64=
Received: by 10.82.188.14 with SMTP id l14mr11334buf.85.1210039130525;
        Mon, 05 May 2008 18:58:50 -0700 (PDT)
Received: by 10.82.166.12 with HTTP; Mon, 5 May 2008 18:58:50 -0700 (PDT)
In-Reply-To: <20080506014636.GM29038@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81321>

On 5/5/08, Shawn O. Pearce <spearce@spearce.org> wrote:
> Avery Pennarun <apenwarr@gmail.com> wrote:
>  >
>  > I have a branch called 'mylib' with my library project in its root
>  > directory.  What I wanted was to maintain my library in the 'mylib'
>  > branch, then merge my library into the "libs/mylib" directory of my
>
> > application, which is in the 'myapp' branch. [...]
>
> >
>  > This actually works like magic in git - except when you create a file
>  > in the 'mylib' branch, in which case it gets merged to the wrong path
>  > every single time.  It seems to me like it should be very easy to put
>  > it in the right place instead, making one more interesting use case
>  > possible.
>  >
>  > I realize git-submodule is the way you're supposed to do something
>  > like this, but git-submodule doesn't really do what I want (yet) for
>  > reasons discussed in other threads.
>
> `git pull -s subtree mylib` ?

First, I thought: wow!  How can that possibly work?  These guys are geniuses!

Then I found out that git-merge-subtree is a git builtin, and git.c says this:

  { "merge-recursive", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE },
  { "merge-subtree", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE },

And then my head exploded. :)

Still scraping the pieces of my brain back off the floor... but does
this mean the subtree merge strategy would fail exactly like
merge-recursive when new files are created?

Have fun,

Avery
