From: "Franck Bui-Huu" <vagabon.xyz@gmail.com>
Subject: Re: [PATCH 1/2] Add git-archive
Date: Thu, 7 Sep 2006 08:32:02 +0200
Message-ID: <cda58cb80609062332p356bd26bw852e31211c43d1ac@mail.gmail.com>
References: <cda58cb80609050516v699338b9y57fd54f50c66e49e@mail.gmail.com>
	 <7vfyf6ce29.fsf@assigned-by-dhcp.cox.net>
	 <44FED12E.7010409@innova-card.com>
	 <7vac5c7jty.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 07 08:32:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLDQs-0004jg-Sd
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 08:32:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbWIGGcH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 02:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbWIGGcH
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 02:32:07 -0400
Received: from wx-out-0506.google.com ([66.249.82.237]:28010 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750732AbWIGGcD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Sep 2006 02:32:03 -0400
Received: by wx-out-0506.google.com with SMTP id s14so127885wxc
        for <git@vger.kernel.org>; Wed, 06 Sep 2006 23:32:02 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AN0PzVYxfwR9spNH+YjDzoMRFRHKuTPTqfw184KqSwHqJ22asurwJrqEvojaqPGq1wX6tlXT/4xhgcRRdxPGLxEOT6f1GdOSNbZ3o/4pule5BZiB7UJoId8AkgfdswUd2Iy6zjetM2wDtt62Bc2BC+mxE2TiV0GDnEzXa1FyTPk=
Received: by 10.70.70.7 with SMTP id s7mr652685wxa;
        Wed, 06 Sep 2006 23:32:02 -0700 (PDT)
Received: by 10.70.72.5 with HTTP; Wed, 6 Sep 2006 23:32:01 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vac5c7jty.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26599>

2006/9/6, Junio C Hamano <junkio@cox.net>:
> Franck Bui-Huu <vagabon.xyz@gmail.com> writes:
>
> > Interesting, could you explain why static variables are not nice ?
>
> Mostly taste and a little bit of re-entrancy worries.
>

OK.

> > You might have missed my second patch:
> >
> >               "[PATCH 2/2] Add git-upload-archive"
> >
> > Basically the server can also use 'reason' to report a failure
> > description during NACK. I find it more useful than the simple
> > "server sent EOF" error message.
>
> That's a good intention, but we would also need to convey the
> "server side found problem and died with these error() output"
> anyway,

OK.

>
> > One bad side is that we need to malloc this embedded structure.
>
> Not at all, if you read the example I did you would notice that
> I changed parse_extra for each backend to return this structure
> allocated for that particular backend.
>

sorry I wasn't clear. My point was that the structure need to be
'mallocated'. Which funtion allocate it doesn't matter, we will need
to free it later. That's what I tried to avoid with the alternative I
sent you in my previous email. Do you think we could use it ?

> >>> +static int run_remote_archiver(struct archiver_struct *ar, int argc,
> >>> +                          const char **argv)
> >>> +{
> >>> +   char *url, buf[1024];
> >>> +   pid_t pid;
> >>> +   int fd[2];
> >>> +   int len, rv;
> >>> +
> >>> +   sprintf(buf, "git-upload-%s", ar->name);
> >>
> >> Are you calling git-upload-{tar,zip,rar,...} here?
> >
> > yes. Actually git-upload-{tar,zip,...} commands are going to be
> > removed, but git-daemon know them as a daemon service.
>
> That would break "git-archive --remove=ssh://site/repo treeish"
> wouldn't it?
>

Yes. But couldn't we make some alias like:

alias git-upload-tar='git-upload-archive --format=tar'
alias git-upload-zip='git-upload-zip --format=zip'

and the same could be done if we plan to remote git-tar-tree command:

alias git-tar-tree='git-archive --format=tar'

These alias would be internal to git (always defined)

-- 
               Franck
