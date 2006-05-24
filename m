From: "Geoff Russell" <geoffrey.russell@gmail.com>
Subject: Re: Incremental cvsimports
Date: Wed, 24 May 2006 20:49:03 +0930
Message-ID: <93c3eada0605240419o48891cdle6c100fc0ac870ff@mail.gmail.com>
References: <93c3eada0605240046t10e00119n4cfc39ec33fe1d92@mail.gmail.com>
	 <46a038f90605240121o117fadb6vf3ce910a3ad3e90@mail.gmail.com>
Reply-To: geoff@austrics.com.au
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_152298_14129277.1148469543378"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 24 13:31:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FirZn-0004ZG-5S
	for gcvg-git@gmane.org; Wed, 24 May 2006 13:30:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932726AbWEXL34 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 May 2006 07:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932695AbWEXL3n
	(ORCPT <rfc822;git-outgoing>); Wed, 24 May 2006 07:29:43 -0400
Received: from wx-out-0102.google.com ([66.249.82.206]:39414 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932697AbWEXLTE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 May 2006 07:19:04 -0400
Received: by wx-out-0102.google.com with SMTP id s6so1184491wxc
        for <git@vger.kernel.org>; Wed, 24 May 2006 04:19:03 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=T6scV3/w3+OvH5VyGBX2NDCM8XtUZS2D9hLsI29nZ6fXQyzeRrRyEoxbf/NqRvtM3Gd6NcyKZfQggfC6fY8JbCCLqTrzcdKz4bXZEL3HSZ2koK0C1HATX+o92MH9Dy/5KAHUNhc13Wa3fvWfoGjF0z7K2ubUHKz/Epq/ZIQlzA0=
Received: by 10.70.104.15 with SMTP id b15mr7582840wxc;
        Wed, 24 May 2006 04:19:03 -0700 (PDT)
Received: by 10.70.32.19 with HTTP; Wed, 24 May 2006 04:19:03 -0700 (PDT)
To: "Martin Langhoff" <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90605240121o117fadb6vf3ce910a3ad3e90@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20679>

------=_Part_152298_14129277.1148469543378
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Dear Martin,


On 5/24/06, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> On 5/24/06, Geoff Russell <geoffrey.russell@gmail.com> wrote:
> > Dear Git,
>
> Dear Geoff,
>
> if you look at the list archive for the last couple of days, you'll
> see there's been quite a bit of activity in tuning cvsimport so that
> it scales better with large imports like yours. We have been playing
> with a gentoo cvs repo with 300K commits / 1.6GB uncompressed.
>
> Don't split up the tree... that'll lead to something rather ackward.
> Instead, fetch and build git from Junio's 'master' branch which seems
> to have collected most (all?) of the patches posted, including one
> from Linus that will repack the repo every 1K commits -- keeping the
> import size down.

I got the latest git and yes, the size is kept down. I've only tried with
a smaller repository but it looks promising. When I ran git-cvsimport witho=
ut a
CVS-module name (wanting the entire repository), it gave me a Usage message
indicating that the CVS-module name was optional - but it isn't :)

I did have to change
2 lines in git-cvsimport to get it to run with my 5.8.0 perl (problems with
POSIX errno). I've attached a patch but my work around isn't as quick as
what it replaced.

Many thanks, I'll have a go with the big repository at work tomorrow!

Cheers,
Geoff Russell

P.S. I've just started to look with git. We have wanted a cvs replacement f=
or
a while but have been too scared to change (until now).



>
> You _will_ need a lot of memory though, as cvsps grows large (working
> on a workaround now) and cvsimport grows a bit over time (where is
> that last leak?!). And a fast machine -- specially fast IO. I've just
> switched from an old test machine to an AMD64 with fast disks, and
> it's importing around 10K commits per hour.

I

>
> You will probably want to run cvsps by hand, and later use the -P flag.
>
> cheers,
>
>
> martin
>
>

------=_Part_152298_14129277.1148469543378
Content-Type: application/octet-stream; name=999
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_enlkwnva
Content-Disposition: attachment; filename="999"

*** git-cvsimport	2006-05-24 20:13:19.000000000 +0930
--- /usr/local/bin/git-cvsimport	2006-05-24 20:22:27.000000000 +0930
*************** use File::Basename qw(basename dirname);
*** 23,29 ****
  use Time::Local;
  use IO::Socket;
  use IO::Pipe;
! use POSIX qw(strftime dup2 :errno_h);
  use IPC::Open2;
  
  $SIG{'PIPE'}="IGNORE";
--- 23,29 ----
  use Time::Local;
  use IO::Socket;
  use IO::Pipe;
! use POSIX qw(strftime dup2);
  use IPC::Open2;
  
  $SIG{'PIPE'}="IGNORE";
*************** sub get_headref ($$) {
*** 446,452 ****
  	    is_sha1($r) or die "Cannot get head id for $name ($r): $!";
  	    return $r;
      }
!     die "unable to open $f: $!" unless $! == POSIX::ENOENT;
      return undef;
  }
  
--- 446,452 ----
  	    is_sha1($r) or die "Cannot get head id for $name ($r): $!";
  	    return $r;
      }
!     die "unable to open $f: $!" if -f $f;
      return undef;
  }
  






------=_Part_152298_14129277.1148469543378--
