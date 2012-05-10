From: demerphq <demerphq@gmail.com>
Subject: Re: Git.pm
Date: Thu, 10 May 2012 17:54:38 +0200
Message-ID: <CANgJU+W-FJZRtu_4si7nr96KfNe2rzaiUaDC0GiK_WixudvcxA@mail.gmail.com>
References: <CAB3zAY3-Bn86bCr7Rxqi4vxbYFxUesLwm8gddxyMSexov2tOhw@mail.gmail.com>
	<CAFouetgwRpB1GFJOC8PTVryVY-94S3xa5ZiSaWQWoz070qQ-6g@mail.gmail.com>
	<CAB3zAY0NeXuH-wXyYkbim5U74eANY4hq5D6SsVLu3KeUqHFqzQ@mail.gmail.com>
	<20120426203136.GA15432@burratino>
	<CAB3zAY3VHtUobJfJ7=nSKb_6uJOXLGVHzR18qV6txPkzf54cDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Tim Henigan <tim.henigan@gmail.com>, git <git@vger.kernel.org>
To: Subho Banerjee <subs.zero@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 10 17:54:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSVhU-0003VL-4O
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 17:54:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755969Ab2EJPyj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 11:54:39 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:38481 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754382Ab2EJPyi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 11:54:38 -0400
Received: by gglu4 with SMTP id u4so1026891ggl.19
        for <git@vger.kernel.org>; Thu, 10 May 2012 08:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=4riZAdqv5Ki5uvNNzOcjwm8u68dCGeIi0qBkCiETNh0=;
        b=lrWojLWjFVVqxRaM03oCMqQxwhEwa5Ziz0lWu1YlH4qGqkO0pX+Qut/e8ySfiaa5Fx
         ULOegQk4Zy5NrNFA1h7w+UZMv84cWHUuXOrpRS+JEverPLOOmfYtY4uKZMMX0lhm7TbY
         lEsslwI5/nJ25qGJs0TOwPB3Czd6hjVVaQ7+bPl5gl5nNvHrgr7CqY+hRZDHGMyWJFAC
         5ddWDG0NV553V9Hz8qJNbfUs3nlP0YXlX5inXr/kv/dV9fke3Ys2ZpjJDWHFY77DWDZ4
         upqT8BccD56rueGcHu8uyrelcxAqCwCxmfT5ak98sKfjJOZvB3tEyrRYaKQmEJzR7N/m
         QhSA==
Received: by 10.236.75.234 with SMTP id z70mr6102376yhd.5.1336665278137; Thu,
 10 May 2012 08:54:38 -0700 (PDT)
Received: by 10.236.152.35 with HTTP; Thu, 10 May 2012 08:54:38 -0700 (PDT)
In-Reply-To: <CAB3zAY3VHtUobJfJ7=nSKb_6uJOXLGVHzR18qV6txPkzf54cDw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197589>

On 10 May 2012 15:19, Subho Banerjee <subs.zero@gmail.com> wrote:
> Hello,
> I have started looking into how the error catching mechanism
> implemented right now. I have looked into the more modern error
> catching/throwing mechanisms in use in perl, and I am of the opinion
> that Try::Simple would probably be the best candidate for being the
> new error catching mechanism. I also wanted to discuss some aspects of
> the changes to be made -
> ------- Replacing the Error::Simple stuff should be relatively
> straightforward. It can be achieved with simple changes to the syntax
> of the perl module itself.
>
> ------- What I feel will be more complicated, and will require some
> discussion before it is implemented is the Git::Error module. This has
> modified some of the code in the original Error module and is used
> only when there are calls made to the git system command. Using the
> Try::Tiny will mean that this can be simplfied to a very large extent.
> As a mater of fact I am in favor of getting rid of this completely and
> implementing whatever is required in the Git.pm as required. Because
> the Try::Tiny module no longer requires exception objects to be
> thrown. Its just simply passing strings around.
>
> This I believe is a big decision, and I would like to hear what you
> guys have to say before I actually get along changing and playing
> around with stuff inside the code.

Personally I would prefer it just does error handling like any other
standard Perl code does: either return false, or dies with a useful
error message. One of the things I find annoying about Git.pm is it
forces its authors non-standard preferences for exception handling
onto its users.

Any other approach forces people to use the exception framework you
have chosen. Which is just a pain in the ass.

Similar logic for Try::Tiny. Why bother with it? It is pretty close to
a fancy way to write eval { ...; 1 } or do { .... };  It is just one
more module for people to misunderstand, and then make bugs with.

Why require people coding on your module to learn a new way to eval code?

Yes I know in some circles these are probably controversial points,
but in all the core, heavily used Perl code I know of none of it uses
either exception objects nor Try::Tiny. I think there is a reason why.

So think carefully. Look at DBI.pm for guidance. That module is
probably the single most stable, well maintained and widely used
module in Perl. And it does none of the tricks you discuss here.

Yves




-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
