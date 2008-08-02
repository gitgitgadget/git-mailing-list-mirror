From: "Matt Pearson" <404emailnotfound@gmail.com>
Subject: Re: git-pull sets write bit, git-push does not
Date: Sat, 2 Aug 2008 19:18:15 -0400
Message-ID: <706b4240808021618y5604b7c9h915237c30d87dace@mail.gmail.com>
References: <ee521d6f0808021532k66bc5b24ma2eeb51021fb5f36@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Alexander E Genaud" <alex@genaud.net>
X-From: git-owner@vger.kernel.org Sun Aug 03 01:19:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPQNb-0004yd-HR
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 01:19:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751022AbYHBXSS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2008 19:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751017AbYHBXSS
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Aug 2008 19:18:18 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:29369 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934AbYHBXSR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2008 19:18:17 -0400
Received: by yw-out-2324.google.com with SMTP id 9so905094ywe.1
        for <git@vger.kernel.org>; Sat, 02 Aug 2008 16:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Ww74FgZdwCB8LD/RBqEfBtgWC90GUXhm2dTbuRY6S1c=;
        b=tu3VWUEIUyl+sVKKQu7IVkmTvIdG2AGJXrqMEVK9RsxbslYb6TpL2/Ft9dpZt+n8I5
         jY8ixU1lBh0/CtwsbMZMd4Zxp3zVxiZGKfUceiYwY7pFaiTA0NmkeABhLtbjjjMlUVbG
         R04Qnb8DvMbGCPhZpvE/RX+5MybB9GRtk72go=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=enBxWx4I5T6A3lJHFCSadr8dBdr88s1IOXRjZuxuNjLCXi56U3Yk0HP8rQeixPtYdU
         /L+ZKmREyMdraWTGJwKnIBRYwpGLQpUhyVsM4ZaACJxWipbBn2uYdqoLZ0KIBYHG2Z/5
         x/+w9cHQIVFYm0xJ9sGObQJhafAxjsab/df0I=
Received: by 10.150.83.22 with SMTP id g22mr5714787ybb.146.1217719095315;
        Sat, 02 Aug 2008 16:18:15 -0700 (PDT)
Received: by 10.151.99.15 with HTTP; Sat, 2 Aug 2008 16:18:15 -0700 (PDT)
In-Reply-To: <ee521d6f0808021532k66bc5b24ma2eeb51021fb5f36@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91194>

On Sat, Aug 2, 2008 at 6:32 PM, Alexander E Genaud <alex@genaud.net> wrote:
> git-pull sets write bit, git-push does not
>
> Hello,
>
> Background: I am using Git locally with ClearCase upstream. I
> initialized a Git repository on top of a ClearCase snapshot view,
> while my work branches are in a clone. As ClearCase is particular
> about the write bit, I have come to depend on an undocumented feature
> of Git. Namely, that git-push preserves read only permissions, while
> git-pull sets modified files writable.
>
> Can git-push be relied upon to preserve the write bit (readonly)? Why
> is git-pull different? Is it a side effect of the plumbing?

Push and pull are not opposite operations: the opposite of push is
fetch. This is because pull updates the working copy, while push does
not (like fetch, it only modifies the ref).

>
> Thanks,
> Alex
>
> http://genaud.net/2008/08/clearcase-globally-git-locally/
>
>
> Simplified case:
>
> echo --
> echo create a repo r1 with files A and B committed
> echo --
> mkdir r1
> cd r1
> echo A > A
> echo B > B
> git init
> git add .
> git commit -m init
>
> echo --
> echo create an identical repo r2 whose files are readonly
> echo --
> cp -r ../r1 ../r2
> chmod u-w ../r2/[AB]
>
> echo --
> echo push a modification of A from r1 to r2
> echo --
> echo AA > A
> git commit -a -m modA
> git push ../r2
>
> echo --
> echo pull a modification of B from r1 to r2
> echo --
> echo BB > B
> git commit -a -m modB
> cd ../r2
> git pull ../r1
>
> echo --
> echo notice that pushed A remains readonly
> echo while pulled B has become writable
> echo --
> ls -l
>
After running this:
$ cat A
A
$ cat ../r1/A
AA

The working copy in r2 was not updated with the changes you pushed to
it (both the content and the mode change).
