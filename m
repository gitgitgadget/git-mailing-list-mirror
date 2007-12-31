From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: How to bypass the post-commit hook?
Date: Tue, 1 Jan 2008 01:53:48 +0800
Message-ID: <46dff0320712310953x13668223iafed07f7d912e6f3@mail.gmail.com>
References: <46dff0320712300712l78c1cdaeya5fa105be01f6b74@mail.gmail.com>
	 <20071230215008.GB20098@efreet.light.src>
	 <46dff0320712302108i61f3b868obb93f89c1c24062c@mail.gmail.com>
	 <20071231093152.GC20098@efreet.light.src>
	 <46dff0320712310222m64d86e95l1499a7ffb1fff65c@mail.gmail.com>
	 <20071231105514.GA9214@efreet.light.src>
	 <46dff0320712310526l2b801ed7xc52b7aae2d65048e@mail.gmail.com>
	 <20071231170532.GB9214@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Jan Hudec" <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Mon Dec 31 18:54:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9OqA-0003Gw-U9
	for gcvg-git-2@gmane.org; Mon, 31 Dec 2007 18:54:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751631AbXLaRxx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Dec 2007 12:53:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751600AbXLaRxx
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Dec 2007 12:53:53 -0500
Received: from an-out-0708.google.com ([209.85.132.241]:34991 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751491AbXLaRxw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2007 12:53:52 -0500
Received: by an-out-0708.google.com with SMTP id d31so845042and.103
        for <git@vger.kernel.org>; Mon, 31 Dec 2007 09:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=RCHhgJxuKi2l7T/xq1JcM2mywUjMuz5po3mnXdj/eaU=;
        b=aHhKyb3LmNzdcb9vzIS6xjUTw414/9/nEj4VAdyONjPd7VU+bDKqRJSKdr+5VSQ05JJAUE1V47vmgaRdAJMcQsYF3GWPpmnCv93pX6WLFbMncfoFZRz2ntm5RjGIOvh+9GJQYzqtac6Eyu0R/OJ/uTNcnC1V4gO5sDRMINHSJEY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Q28Gqc4pkl/vYg3lJK6Fm5hrBb6mIAeUim1irburhYe7DAUlI36ajm2KALNqe41uQSKfM1BfTImwC1D4PpxswMPnCA9ImEECQ7K4T1iVcIGOiCyvdeLACHJAeNs+UTN4s4ot28aKyRzCamAbxAirVPqOGZGo9cnS7yjWBiwAcC8=
Received: by 10.100.228.17 with SMTP id a17mr3984441anh.5.1199123628760;
        Mon, 31 Dec 2007 09:53:48 -0800 (PST)
Received: by 10.35.108.1 with HTTP; Mon, 31 Dec 2007 09:53:48 -0800 (PST)
In-Reply-To: <20071231170532.GB9214@efreet.light.src>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69411>

On Jan 1, 2008 1:05 AM, Jan Hudec <bulb@ucw.cz> wrote:
> On Mon, Dec 31, 2007 at 21:26:21 +0800, Ping Yin wrote:
> > On Dec 31, 2007 6:55 PM, Jan Hudec <bulb@ucw.cz> wrote:
> > > Note, that you can -- and should -- add the foo.css to the commit. But the
> > > file might contain other changes in tree, that are not about to be commited,
> > > so prefered way would be to get the content from the index, modify that and
> > > update the index manually (with git update-index).
> >
> > If pre-commit has modified files to be commited, it will abort this
> > commit and give a message to direct the user to commit again
> > with/without the changed content.
> >
> > AFAIK, git add -i can add selected chunk to the index. As you said,
> > can git-update-index also do this job?
>
> git update-index is the underlying plumbing for git add/git rm.
>
> However, you should change foo.css in index even if the working tree copy
> does not match it and is not selected for commit. Only way I see to do that
> is to prepare a patch and apply it to both the working tree (git apply) and
> to the index (git apply --cached).
>
A little complicated-:). So my way is to abort the commit if
pre-commit actually modified the files ( the working tree, not the
index) to be commited, then 'git add -i'  to add the changes
introduced just by the pre-commit and 'git commit' again.



-- 
Ping Yin
