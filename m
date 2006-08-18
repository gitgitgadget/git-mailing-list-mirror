From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: Unresolved issues #3
Date: Fri, 18 Aug 2006 10:56:50 +0100
Message-ID: <b0943d9e0608180256n6b7077b5r6e854b49d85afcc1@mail.gmail.com>
References: <7vpseyelcw.fsf@assigned-by-dhcp.cox.net> <tnx1wre4e6s.fsf@arm.com>
	 <7vbqqics3g.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 18 11:57:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GE15y-0003Ew-Ka
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 11:56:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbWHRJ4v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 05:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbWHRJ4v
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 05:56:51 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:47894 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751287AbWHRJ4u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Aug 2006 05:56:50 -0400
Received: by py-out-1112.google.com with SMTP id n25so1008769pyg
        for <git@vger.kernel.org>; Fri, 18 Aug 2006 02:56:50 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qEBunWXz/NfnUkDGtPp05zLj+wpxZvkwSeBhET1D06E1c6RyVeyOV3JK1ENQpWlFsrov97Fzj6zqYveK9bcx8e7tfC0wImdWdcV18tcgxTz4hgVueqK8szBMo7aDO0lK+/jGHjuq4cY7ezWooO+vwYQXJMyxk3y61ubX3pjXV+A=
Received: by 10.35.97.17 with SMTP id z17mr5493652pyl;
        Fri, 18 Aug 2006 02:56:50 -0700 (PDT)
Received: by 10.35.37.16 with HTTP; Fri, 18 Aug 2006 02:56:49 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vbqqics3g.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25641>

On 18/08/06, Junio C Hamano <junkio@cox.net> wrote:
> Catalin Marinas <catalin.marinas@arm.com> writes:
> > In StGIT I can configure the merge command and I currently use the
> > attached script (I need to add it to the StGIT repository). It tries
> > diff3 first and, if that fails, invokes emacs' merge (can use xxdiff
> > as well). It also checks whether the file was modified in case I want
> > to exit and solve the conflict later (maybe after getting conflict
> > information for the other files).
>
> Thanks.  That is interesting.  However, the workflow Martin
> wants to use this is a bit different from this.  He wants
> regular diff3/merge to leave conflicted result and have "xxdiff
> -U" to sort out the resulting mess (I do that manually myself
> but without any wrapper).

The problem with this approach is that you lose the ancestor
information. You want "diff3 -E" command to not report conflicts if
the changes are the same but the output no longer has the ancestor
information. The -A option would keep the ancestor (and use "xxdiff
--unmerge3" instead) but it always reports a conflict even if the
changes are the same. Are there any diff3 options I missed?

That's why I prefer to explicitely pass the 3 files to either emacs or xxdiff.

> > # default merger
> > if os.system('diff3 -L current -L ancestor -L patched -m -E '
> >              '"%s" "%s" "%s" > "%s"'
> >              % (branch1, ancestor, branch2, output)):
> >     # interactive merge
> >     if os.path.exists(output):
> >         mtime = os.path.getmtime(output)
> >     else:
> >         mtime = 0
>
> I wonder why you do not error out when "if os.path.exists(output)"
> does not hold true; you are redirecting into it, so the possibilities
> are:

You are right. I was thinking about the file removed in the current
branch but modified in the other. However, this would never invoke
diff3.

Thanks.

-- 
Catalin
