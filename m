From: "Mario Pareja" <mpareja.dev@gmail.com>
Subject: Re: Locking binary files
Date: Tue, 23 Sep 2008 09:56:57 -0400
Message-ID: <94c1db200809230656q4a9a765dw2354c0058b1d940c@mail.gmail.com>
References: <94c1db200809222333q4953a6b9g8ce0c1cd4b8f5eb4@mail.gmail.com>
	 <94c1db200809222339t7d65081eq7471fef86fb5ec73@mail.gmail.com>
	 <48D8983C.7070506@op5.se>
	 <94c1db200809230054t20e7e61dh5022966d4112eee6@mail.gmail.com>
	 <48D8A97E.8070003@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Andreas Ericsson" <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Sep 23 16:00:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ki8Qq-0002dm-I4
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 16:00:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756604AbYIWN5A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 09:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755681AbYIWN47
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 09:56:59 -0400
Received: from an-out-0708.google.com ([209.85.132.240]:14909 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756592AbYIWN46 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 09:56:58 -0400
Received: by an-out-0708.google.com with SMTP id d40so175933and.103
        for <git@vger.kernel.org>; Tue, 23 Sep 2008 06:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=CNkOK2P9+gB5pmcsN+yXkWl0vo4K4yP0gJ+ZYv2X01c=;
        b=TdNtAdgFm5xaXP3BU59TKEZOPRtPlbUBqcJeY0r9sTh7dZRCDTFP/bIDukdd2JuegZ
         ZZZgZ4r532Scl9jTNytPu0UW7+JRK8ux3ossXuLRpEBgPKzukiqThQpjJVdNmSE9LWvE
         ZZtZ7Tp7KkoN6pf3YAtQlJsd0f+NN3KgylOtg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=AqYqwPhJz16xLJxKhoZlyHQuissMVeRdDGqGAs7XGniVf6yVt1sGYJRtr8rR+W0gRL
         fxVgC7xVBPOvPMIjcx181HmLKFJMsjJJ4qAc0/6kuzlNhHVjtMmFaP9p9o/ezttjUjF/
         CaeP+iYZ0ch4sSBOwUFDANv6G21Li6Shh3Zqc=
Received: by 10.100.120.15 with SMTP id s15mr4321172anc.128.1222178217303;
        Tue, 23 Sep 2008 06:56:57 -0700 (PDT)
Received: by 10.100.207.17 with HTTP; Tue, 23 Sep 2008 06:56:57 -0700 (PDT)
In-Reply-To: <48D8A97E.8070003@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96565>

> So it's a communication issue then.

Yes, but I think the communication of this information needs to happen
as part of a developers normal work-flow rather than requiring them to
remember to check an external system.

> The way I understand locks in svn
> and cvs is that they also only bother you when you want to check in the
> file you've just recently modified, or if multiple people want to lock
> the same file at the same time.

The SVN client will make locked files read-only until a lock is
obtained for them.  This helps "remind" you that a lock should be
obtained before editing such a file. Requiring the developer to obtain
a lock ensures that nobody else is editing the file and prevents
wasted work.  Upon commit, the file is marked as unlocked and the
local file is once again read-only.

>
> Note that locking would be completely advisory though, and nothing
> would prevent people from committing changes to a locked file.

If git were to support locking then it could prevent people from
committing without first locking.  Even if it is not supported
directly by git - perhaps using a lock daemon - a wrapper would need
to be written around git commit/push to prevent developers from
committing/pushing changes that would cause binary merging conflicts.

> Then
> again, insofar as I understand SVN/CVS locking, that's how those
> work too, except that an SVN "checkin" would be the equivalent of
> "git commit && git push" (the push part of the git sequence won't
> work).
>

Generally in SVN you need to lock the file before being able to commit.

Really, I am just curious about how others deal with this issue.  Do
you simply start editing binary files and hope nobody else edits the
same file?  Do you send out an email telling people you are working on
such a file?

Mario
