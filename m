From: "Dana How" <danahow@gmail.com>
Subject: Re: [FAQ?] Rationale for git's way to manage the index
Date: Sun, 6 May 2007 11:22:09 -0700
Message-ID: <56b7f5510705061122l31304931l8471f11f57f00b19@mail.gmail.com>
References: <vpqwszm9bm9.fsf@bauges.imag.fr>
	 <Pine.LNX.4.64.0705061851411.4015@racer.site>
	 <vpqk5vlamav.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, "Matthieu Moy" <Matthieu.Moy@imag.fr>,
	danahow@gmail.com
X-From: git-owner@vger.kernel.org Sun May 06 20:22:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HklN9-000835-7j
	for gcvg-git@gmane.org; Sun, 06 May 2007 20:22:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754913AbXEFSWM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 14:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754914AbXEFSWM
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 14:22:12 -0400
Received: from nz-out-0506.google.com ([64.233.162.231]:53261 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754913AbXEFSWL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 14:22:11 -0400
Received: by nz-out-0506.google.com with SMTP id o1so1336140nzf
        for <git@vger.kernel.org>; Sun, 06 May 2007 11:22:10 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cn7KzoeQpMQJrjyRy5pNvyvLv4RwaX3smD5FnjQ1axNPMFIW76GQndE6z+YzTMXMuPjgEMZBtrK3Jka5/XlY5tITzE6K5+xJg0WgLAtzUb9560V0+7jMrmHnRcyzZbIUOAaq9J8+w1He9KpFE+8p7P+3DvAI+J/mXEyEIBdqxbo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OlL6FSAMXU5gRHMyC7ONY6JZSj5VdJLVVNkbpyDwezLuGrZK08gRBj/Hk+SZExjv0vUfdgvHy2OvlhQcSZkoDqRJhgejK2iWORoIsXmOYcezMWUn/Om88RRTmFRbY/QNVXExj4YCapbvbYVcDVwAIBscZxZpf8qyp+zNMOIn9LU=
Received: by 10.114.27.20 with SMTP id a20mr1673264waa.1178475729724;
        Sun, 06 May 2007 11:22:09 -0700 (PDT)
Received: by 10.115.58.7 with HTTP; Sun, 6 May 2007 11:22:09 -0700 (PDT)
In-Reply-To: <vpqk5vlamav.fsf@bauges.imag.fr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46357>

You might find it useful to break your question into 2 pieces.

One is what information should be in the index,
which essentially is what Linus addresses.
The way I look at this, at the moment,
is that the index contains whatever's required to make git-write-tree
work without collecting information elsewhere.
I suspect this is the correct historical way to look at this,
but I wasn't on this list then.

The other is how to get information into the index.
I think this is the original thing that seemed strange to you?
It did to me.  But,  in part,  since git has both "git-commit"
and "git-commit -a",  this is somewhat recognized.
I've wondered if there's a way to improve this,  but I don't
have any coherent ideas right now.  Thanks for finding
and posting that thread;  that was helpful.

Also, the idea of an index isn't all that strange.  I need
to use perforce at work,  and it has an index (called "db.have").
But it is stored on the server and has everyone's state mixed
together,  uses the type of file IDs Linus complains about,
and is more difficult to manipulate (hence less useful).
Being on the server is a great performance bottleneck as well.

Dana

On 5/6/07, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > Hi,
> >
> > On Sun, 6 May 2007, Matthieu Moy wrote:
> >
> >> [...]
> >>
> >> % git satus -a
> >> % git commit -a -m "..."
> >>
> >> In the former case, I have more commands to type, and in the second
> >> case, I loose part of the stat-cache benefit: If I run "git status -a"
> >> twice, the second run will actually diff all the files touched since
> >> the last run, since "git status -a" actually updated a temporary
> >> index, and discarded it afterwards, so it doesn't update the stat
> >> information in the index (while "git status" would have).
> >
> > Have you tried "git status" _without_ "-a"?
>
> Reading my message (including the last 5 words of the sentence you're
> quoting) would have told you that ;-).
>
> >> In both cases, I can't really see the benefit.
> >
> > The benefit is a clear distinguishing between DWIM and low level. The
> > index contains _exactly_ what you told it to contain.
>
> In other systems, commit commits _exactly_ the content of files on
> disk. And most people seem happy with that.
>
> > By forcing users to use "-a" with "git commit",
>
> Does this mean that the normal way to use "commit" is to use "-a"?
>
> > you make it clear that a separate update steo is involved,
>
> Well, with those kind of arguments, I could have my web browser not do
> DNS resolution for me, because it would make it clear that a separate
> step from HTTP request is involved. Still, this low-level thing brings
> no benefit to the user, and I know no web browser forcing the user to
> make this distinction.
>
> > and if you made an error (which you see from the file list), you can
> > abort, and start over with the original index.
>
> You don't necessarily see your error from the file list:
>
> % vi foo.c
> % git add foo.c
> % vi foo.c
> % git commit -m foo
> [...]
>  create mode 100644 foo.c
> %
>
> This commited the old content of foo.c, while I hardly see any
> scenario where this is the expected behavior.
>
> Then, being able to repare the error if I made it is interesting, but
> I don't get the reason why the error could not just be avoided.
>
> Well, indeed, I just found a thread talking about this:
>
>   http://lists-archives.org/git/196050-making-git-commit-to-mean-git-commit-a.html
>
> I'll go through it, I might understand better after that ;-).
>
> Thanks,
>
> --
> Matthieu
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
