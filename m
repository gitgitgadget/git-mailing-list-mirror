From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH v2 0/4] make open/unlink failures user friendly on
 windows using retry/abort
Date: Sun,  7 Nov 2010 15:56:23 +0100
Message-ID: <cover.1289139299.git.hvoigt@hvoigt.net>
References: <87ocbitd33.fsf@fox.patthoyts.tk> <201009282252.25688.j6t@kdbg.org>
Mime-Version: 1.0
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	msysgit@googlegroups.com,
	git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: msysgit+bncCOrwtbejChCs_NrmBBoEX7Kf3A@googlegroups.com Sun Nov 07 15:57:09 2010
Return-path: <msysgit+bncCOrwtbejChCs_NrmBBoEX7Kf3A@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-fx0-f58.google.com ([209.85.161.58])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCOrwtbejChCs_NrmBBoEX7Kf3A@googlegroups.com>)
	id 1PF6g8-0002Pc-3J
	for gcvm-msysgit@m.gmane.org; Sun, 07 Nov 2010 15:57:08 +0100
Received: by fxm11 with SMTP id 11sf1123881fxm.3
        for <gcvm-msysgit@m.gmane.org>; Sun, 07 Nov 2010 06:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:mime-version:x-beenthere:received
         :received:received:received:received-spf:received:received:from:to
         :cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=Ixj/PD3Uf0HMU8yK7SO66nQFhJnq9Kn684oZWza2YYg=;
        b=a9Z3NrOXAfIZGyROtezQKF61MyXMXZ623Lq29IOvtyjUmPA6wg2jTsaH6RAluybR11
         qgUFlmPwyr7gRmFaUYR7v2ebTyvUHVi1YmZuyxEJtylBzFxEOr0lD/aVh3Hizw0znDTX
         YQ4p9rD+gELoKcCHRgDOD7Bjy3vr1cjflRUFY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        b=V9hz1ivDTaU0Ok34l/tnmryxVJnIUsdPWQgDf2HPdmq218VEoj7l3aB+QqkF5hMJol
         dORo/+VdeOI0DhR6cNz/GI95z5BH/LA3BbsDo2pcaUIToPtJEBjdII2xgslqLrFL6oqa
         cTvq7lisFhWP/9c0lZkKbXE88Ja8fss6EkRZw=
Received: by 10.223.75.203 with SMTP id z11mr130882faj.22.1289141804085;
        Sun, 07 Nov 2010 06:56:44 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.223.145.130 with SMTP id d2ls1045493fav.1.p; Sun, 07 Nov 2010
 06:56:42 -0800 (PST)
Received: by 10.223.114.146 with SMTP id e18mr231840faq.0.1289141802856;
        Sun, 07 Nov 2010 06:56:42 -0800 (PST)
Received: by 10.223.114.146 with SMTP id e18mr231839faq.0.1289141802809;
        Sun, 07 Nov 2010 06:56:42 -0800 (PST)
Received: from darksea.de (darksea.de [83.133.111.250])
        by gmr-mx.google.com with SMTP id b12si947484fah.5.2010.11.07.06.56.42;
        Sun, 07 Nov 2010 06:56:42 -0800 (PST)
Received-SPF: neutral (google.com: 83.133.111.250 is neither permitted nor denied by best guess record for domain of hvoigt@hvoigt.net) client-ip=83.133.111.250;
Received: (qmail 21193 invoked from network); 7 Nov 2010 15:56:41 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 7 Nov 2010 15:56:41 +0100
X-Mailer: git-send-email 1.7.2.2.177.geec0d
In-Reply-To: <201009282252.25688.j6t@kdbg.org>
X-Original-Sender: hvoigt@hvoigt.net
X-Original-Authentication-Results: gmr-mx.google.com; spf=neutral (google.com:
 83.133.111.250 is neither permitted nor denied by best guess record for
 domain of hvoigt@hvoigt.net) smtp.mail=hvoigt@hvoigt.net
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160880>

Hi,

here is a new iteration of my original patch series. This series
replaces the newest patches currently present in 4msysgit.git's master
and does not cleanly apply to git.git's master. Once everybody is happy
with the outcome I will port it to git.git so msysgit can fetch it from
upstream.

On Tue, Sep 28, 2010 at 10:52:25PM +0200, Johannes Sixt wrote:
> > Heiko Voigt (4):
> >       mingw: work around irregular failures of unlink on windows
> 
> The workaround is to retry the unlink() after a delay when it failed with 
> EACCES. What happens if the EACCES is for a good reason? Doesn't this delay 
> the process by 71ms per unlink() invocation? Can't this become a problem if 
> many unlink()s are tried by git code?

I have changed the triggering error code to be ERROR_SHARING_VIOLATION
which seems to be the appropriate code for files that are in use by
another process.

http://msdn.microsoft.com/en-us/library/ms681382%28v=VS.85%29.aspx

Thus we do not need to worry about whether we are retrying on a valid
access error. I have tested this on my windows box and it works here.

j6t: I have not changed your error code in mingw_rename since you
explicitely compare with the windows error code ERROR_ACCESS_DENIED and
do not use the err_win_to_posix() function. Did you do this on purpose or
should I also refer to ERROR_SHARING_VIOLATION ?

> >       mingw: make failures to unlink or move raise a question
> 
> Gaah! But people seem to like it. Since the question is only triggered after 
> all retries fail, I can live with this.
> 
> But isn't the implementation a bit sloppy? Can strlen(answer)-2 be negative? 
> What happens if the user typed more than 4 characters? Wouldn't it leave data 
> in the buffer for the next question?

I have extracted reading of the answer into its own function and made
the reading more robust which should now take care of the above issues.

> >       mingw: add fallback for rmdir in case directory is in use
> 
> Depends on the previous patch. OK.

No changes.

During pick up of the series I had to gather my testing script which can
only be used manually for testing. Is there any place in git.git where
we can store such "manual testing tools" ?

Cheers Heiko

Heiko Voigt (4):
  mingw: move unlink wrapper to mingw.c
  mingw: work around irregular failures of unlink on windows
  mingw: make failures to unlink or move raise a question
  mingw: add fallback for rmdir in case directory is in use

 compat/mingw.c |  139 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 compat/mingw.h |   14 ++---
 2 files changed, 144 insertions(+), 9 deletions(-)

-- 
1.7.2.2.177.geec0d
