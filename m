From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: crlf with git-svn driving me nuts...
Date: Thu, 17 Apr 2008 13:43:42 +0400
Message-ID: <20080417094342.GM3133@dpotapov.dyndns.org>
References: <320075ff0804161210m46f3e83bpf7bf9d1d5816d914@mail.gmail.com> <20080416200107.GG3133@dpotapov.dyndns.org> <32541b130804161320w42c68bc2p9d838dc127a57027@mail.gmail.com> <20080416203923.GH3133@dpotapov.dyndns.org> <320075ff0804161447u25dfbb2bmcd36ea507224d835@mail.gmail.com> <20080416223739.GJ3133@dpotapov.dyndns.org> <320075ff0804161607p3f9e983ehb75aae4e0bfe8837@mail.gmail.com> <20080417004645.GK3133@dpotapov.dyndns.org> <320075ff0804170007k5171eb72n68882679f62fa238@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Nigel Magnay <nigel.magnay@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 17 11:44:47 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmQfc-0007ms-LW
	for gcvg-git-2@gmane.org; Thu, 17 Apr 2008 11:44:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934392AbYDQJn5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2008 05:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933088AbYDQJnz
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 05:43:55 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:14535 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934296AbYDQJnv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 05:43:51 -0400
Received: by ug-out-1314.google.com with SMTP id z38so1102753ugc.16
        for <git@vger.kernel.org>; Thu, 17 Apr 2008 02:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=Bd2r7mQx2Fnf85T11fU3H+J9JvB0QfApgdKaKxPIgDQ=;
        b=Fe+qbNEgvI9ArUNqlMHhTSjX1ViFC/mkf8Qh2WxfKrYZQA4qMEahWZCSo0f1Yhr8clVL2YRt+8wcFisKoCfzHmEGlIsPHo5fEr3zYLCaFZQdwrUcvCy5e7Y4SGE0AXDxM3FwZaMee3aldRkh6GKzoMITY7LVdNUQDCnjsVTcPvM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=Z7dXhjqzLibfV4hz0lejiGFoflG77j9PUSAL2B82NK6LILJi19YEJKYiVdvvcDDbdZ+J5BRDfeenoGfZ8s7fErihlz9L2yCVDSaVv/4M+9uqYJxF4xYE455BS4F3cVsa0ghG2MHAHiveu3WKkW2Z5kl0QOFeIK2YdjJrZSzbgIk=
Received: by 10.67.115.6 with SMTP id s6mr8217506ugm.71.1208425426526;
        Thu, 17 Apr 2008 02:43:46 -0700 (PDT)
Received: from localhost ( [85.141.188.158])
        by mx.google.com with ESMTPS id i40sm4401645ugf.4.2008.04.17.02.43.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 Apr 2008 02:43:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <320075ff0804170007k5171eb72n68882679f62fa238@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79779>

On Thu, Apr 17, 2008 at 08:07:27AM +0100, Nigel Magnay wrote:
> 
> This has nothing to do with changing core.autocrlf after checkout -
> it's a problem with *any* repo with CRLF files, being checked out on a
> core.autocrlf=true machine, which basically is any windows machine.
> 
> The current 'isDirty' check seems to be something like
> 
> isDirty = ( wc.file.mtime > someValue ) && ( repository.file !=
> filter(wc.file) )

Basically, yes.

> 
> I'm saying it ought to be something like
> 
> isDirty = ( wc.file.mtime > someValue ) && (sha1(repository.file) !=
> sha1(wc.file) ) && ( repository.file != filter(wc.file) )

I don't think it is reasonable. Files inside of the repository and
in the work are not meant to be the same. What if I have $Id$ expansion
or something else. What could make sense is to add an additional check:
 && convert_to_work_tree(repository.file) != wc.file
but it should be optional, so it will not penalize those who do need
or do not want this extra check.

> >  >
> >  > But fixing that minor bug still leads to badness for the user. Doing
> >  > (on a core.autocrlf=true machine) a checkout of any revision
> >  > containing a file that is (currently) CRLF in the repository, and your
> >  > WC is *immediately* dirty. However technically correct that is, it
> >  > doesn't fit most people's user model of an SCM, because they haven't
> >  > made any modification.
> >
> >  IMHO, the only sane way is never store CRLF in the Git repository.
> >  You can have whatever ending you like in your work tree, but inside
> >  of Git, LF is the actually marker of the end-of-line.
> >
> 
> Great. I'll go and argue with the team using svn, who don't even
> *notice* this issue, and try to get them to adjust the metadata on
> every single file in the repository.

Maybe, you can teach git-svn to be smarter... I mean storing text files
in Git repo with CRLF is stupid, so, perhaps, git-svn can do a better
job converting CRLF<->LF when it exports and imports from/to SVN.

> 
> Then, for a bonus, I'll try the same with every OSS project that I'm
> tracking with git-svn. :-(
> 
> I get that things are horribly broken if you get CRLF in your
> repository. But it's unreasonable to expect the ability to bend the
> rest of the world to what's convenient for me! Some of our windows
> coders probably even *like* svn:eol-style=CRLF !

You can use Git and have CRLF in your work tree. You just need to
have autocrlf=true for that. _Inside_ of Git, only LF is the end
of line. How you store in SVN, it is a separate issue with git-svn.
I guess, git-svn needs improvement in this area...

Dmitry
