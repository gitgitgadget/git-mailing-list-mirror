From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: qgit idea: interface for cherry-picking
Date: Tue, 4 Jul 2006 13:21:08 +0200
Message-ID: <e5bfff550607040421id4e71efw38ee2bd773c949de@mail.gmail.com>
References: <e8954u$srh$1@sea.gmane.org> <e89eqj$npu$1@sea.gmane.org>
	 <e5bfff550607021504l6e7fc8b8ja61f20f630c0f3f@mail.gmail.com>
	 <e89iql$42a$1@sea.gmane.org>
	 <e5bfff550607022245s2ef160fu5ad30a822f06117d@mail.gmail.com>
	 <7vzmfrrxyp.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550607030418n6a46c0cdh1a95155e1feb4356@mail.gmail.com>
	 <7vd5cmqwv3.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550607032322jdf3bc79l3f41c292ebb6d3f7@mail.gmail.com>
	 <7vk66tna71.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 04 13:21:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fxiy0-0003gW-Sr
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 13:21:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbWGDLVL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 07:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbWGDLVL
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 07:21:11 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:3754 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751285AbWGDLVJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jul 2006 07:21:09 -0400
Received: by py-out-1112.google.com with SMTP id t32so1797891pyc
        for <git@vger.kernel.org>; Tue, 04 Jul 2006 04:21:08 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jqOoX07+vIVFY/Zvf8Ys3DN1PrlmBxovzmVlVXmAu1iBZgkW734fyKw53zDtVnVNU4dhy4dlHVPwLNcyEMMDI/1EIxV67FZGRjIdq18Xo9X5HszS9QIpJEQ4QF+9gLHA9TFkGT85zkX+jJXFr4Of4heYmBt8Ma6UmMArRuPIE3U=
Received: by 10.35.9.15 with SMTP id m15mr2085174pyi;
        Tue, 04 Jul 2006 04:21:08 -0700 (PDT)
Received: by 10.35.52.17 with HTTP; Tue, 4 Jul 2006 04:21:08 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vk66tna71.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23286>

On 7/4/06, Junio C Hamano <junkio@cox.net> wrote:
> "Marco Costalba" <mcostalba@gmail.com> writes:
>
>
> Yes, either you (1) need to make sure the user is aware what
> underlying git commands QGit runs for them, so that the user
> knows what workflow to follow when the procedure needs to go
> manual, or (2) hide the underlying git commands QGit runs for
> users, but then you need to make QGit aware of what workflow to
> follow when the procedure needs to go manual, and guide the user
> through that workflow.  I think either is fine approach;
> personally I prefer transparent tools that does (1), which is
> the impression I am getting from your description of QGit.
>

Yes, I prefer way (1) too. QGit as an error reporting infrastructure
to always report by a message box arguments (starting from 0) of
offending command, be it native git or not.


> If you take route (1), using "am --fail" number of times
> involves QGit runs "am --fail" once, guide user to fix things up
> _and_ give control back to QGit, then you run the next "am
> --fail", etc, which would be quite cumbersome to implement.  But
> running multiple am and do reset soft to roll back needed number
> of parents might be easier option to implement in QGit, but you
> still have the same "you give the control to the user but then
> you have to take the control away to proceed" problem when the
> patch does not apply cleanly somewhere (you let the user to hand
> resolve and say "am --resolved", but then when the series is
> depleted, somebody has to run "reset --soft" to roll N commits
> back to realize what you wanted to do, so at that point QGit
> somehow needs to take control back).
>
>

I have started to implement the feature suggested by Jakub (patch in
working dir only, not committed). The core is a loop of git-am, one
for each patch to import, followed by a:

    git-reset --mixed HEAD~<Num of succesfully applied patches>

To note that the above git-reset command is _always_ run be the patch
series apply successfully be it fails at some point, so that in any
case the tree is not dirty up, and you have the working tree with the
information you need in case of manual fixup.

I will plan to push as soon I'm able to reach a "pushable site" ;-)

Comments? could work? not consistent?

     Marco
