From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Unanticipated test error
Date: Fri, 21 Jul 2006 09:22:44 +0200
Message-ID: <81b0412b0607210022o562ac326wd149c73cc529f239@mail.gmail.com>
References: <20060720194013.GC24793@bohr.gbar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 21 09:23:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G3pLV-0002MU-K5
	for gcvg-git@gmane.org; Fri, 21 Jul 2006 09:22:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161007AbWGUHWq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Jul 2006 03:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161009AbWGUHWq
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Jul 2006 03:22:46 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:24084 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161007AbWGUHWq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jul 2006 03:22:46 -0400
Received: by ug-out-1314.google.com with SMTP id m3so1159059ugc
        for <git@vger.kernel.org>; Fri, 21 Jul 2006 00:22:44 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HXErHSmM5gUTKOIM1rARTe7G8SGivHaQHHh0UVTVfh+Pl3eZMw5AC0Aq0HGd9acS8r1wciiSbY5ewkWt6NEZfRoeNndVsjNoWCPgsLVPZ1FKI2pm35+M2mMiojlxMCQ7bzGUKwpuzQGF0I7YgCjyK48m7J2+ftWzO1+SR5/gYKk=
Received: by 10.78.122.11 with SMTP id u11mr172466huc;
        Fri, 21 Jul 2006 00:22:44 -0700 (PDT)
Received: by 10.78.160.5 with HTTP; Fri, 21 Jul 2006 00:22:44 -0700 (PDT)
To: "Peter Eriksen" <s022018@student.dtu.dk>
In-Reply-To: <20060720194013.GC24793@bohr.gbar.dtu.dk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24044>

On 7/20/06, Peter Eriksen <s022018@student.dtu.dk> wrote:
> The patch really should not change any semantics at all, since
> it converts instances of
>
>    memcpy(to, from, len);
>    to[len] = 0;
>
> into
>
>    strlcpy(to, from, len);
>
> I need a bit of help troubleshooting this one.  I have tried
> running t0000-basic.sh using "bash -x", but that did not help
> me this time.
>

Well, there are differences. Correct translation from memcpy
to strlcpy (aside the fact with \0 inside the string) would be
something like:

  strlcpy(to, from, len + 1);

assuming your example with memcpy. strlcpy expects size of
storage, and will never write more bytes that it was allowed to.
That'll cut off last character of the source string, unless it is
\0-terminated before the size of storage.
