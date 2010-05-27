From: Marko Kreen <markokr@gmail.com>
Subject: Re: [PATCH] compat: Add another rudimentary poll() emulation
Date: Thu, 27 May 2010 15:36:43 +0300
Message-ID: <AANLkTinX8nK68rZtN5dwJ-fGQm4gR2G84xo9raxb4vLY@mail.gmail.com>
References: <1274948384-167-1-git-send-email-abcd@gentoo.org>
	<1274948384-167-2-git-send-email-abcd@gentoo.org>
	<20100527101043.GA4390@progeny.tock>
	<AANLkTikYa2vq4PrKrO2QIkHVxYqbhUZRw42kQq875FNT@mail.gmail.com>
	<AANLkTikfaWVEPkHBRF8WHNWmyXIH9f7wRju1wSRC_lwm@mail.gmail.com>
	<AANLkTinXwM1fem6E3RgnLW9vqLD1fV7JvaQnxzZVRakA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jonathan Callen <abcd@gentoo.org>, git@vger.kernel.org,
	mduft@gentoo.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Sixt <j6t@kdbg.org>,
	msysGit <msysgit@googlegroups.com>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Thu May 27 14:36:58 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHcKU-0002EN-BW
	for gcvg-git-2@lo.gmane.org; Thu, 27 May 2010 14:36:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753762Ab0E0Mgp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 May 2010 08:36:45 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:56246 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852Ab0E0Mgo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 May 2010 08:36:44 -0400
Received: by gyg13 with SMTP id 13so3938900gyg.19
        for <git@vger.kernel.org>; Thu, 27 May 2010 05:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=H5XOZcF1bqTcHYrij0+bOQMiDPbHS6F5M/eNTRBp81I=;
        b=YqcAAX3gQ1kwgSa8KboKjtZPlMqksuWvKI1JM1pn/SqI5UItgudBnkVaOsledTiUoc
         u3EkXOHOIAnjPGOvLgcNoVq6S1adoFVCzwx20ZihE2KeMEYTl0OJkqx8MludbgQphINR
         qFxt0WLPNIdaQXmIhSZCGxA6yV+B0HhB2wB8A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=lDJ7zl93GmAS1tnn4ySYNnhBWIMozWLlmkJ90A+Yi5VZFJc2SOt5yLAl9jHJRNKG31
         mPZRp8i/xbrv7UuMTnN1/1mp5ycFYCeZ4wqCO6E017a8IHcoYSHfnsUW5krFfQYHmE7G
         gPvxVnrAGG+CsQcjqv03osjafnHbeSNxViiH0=
Received: by 10.150.170.9 with SMTP id s9mr63606ybe.418.1274963803236; Thu, 27 
	May 2010 05:36:43 -0700 (PDT)
Received: by 10.151.48.11 with HTTP; Thu, 27 May 2010 05:36:43 -0700 (PDT)
In-Reply-To: <AANLkTinXwM1fem6E3RgnLW9vqLD1fV7JvaQnxzZVRakA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147849>

On 5/27/10, Erik Faye-Lund <kusmabite@googlemail.com> wrote:
> On Thu, May 27, 2010 at 1:39 PM, Marko Kreen <markokr@gmail.com> wrote:
>  > On 5/27/10, Erik Faye-Lund <kusmabite@googlemail.com> wrote:
>  >> On Thu, May 27, 2010 at 12:10 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>  >>  > Implement the subset of poll() semantics needed by git in terms of
>  >>  > select(), for use by the Interix port.  Inspired by commit 6ed807f
>  >>  > (Windows: A rudimentary poll() emulation, 2007-12-01).
>  >>  >
>  >>
>  >>
>  >> A possible problem with this approach is that the maximum number of
>  >>  file descriptors poll can handle limited by RLIMIT_NOFILE, whereas the
>  >>  maximum number of file descriptors select can handle is limited by
>  >>  FD_SETSIZE.
>  >>
>  >>  I don't think this is a big problem in reality, though - both values
>  >>  seem to be pretty high in most implementations. And IIRC git-daemon is
>  >>  the only one who needs more than 2, and it doesn't even check
>  >>  RLIMIT_NOFILE.
>  >>
>  >>  If we decide to go this route, perhaps it'd make sense to change to
>  >>  this code for Windows also? Our Windows-implementation of poll() has
>  >>  some annoying limitations...
>  >
>  > Example of poll() compat without FD_SETSIZE limit:
>  >
>  >  http://github.com/markokr/plproxy-dev/blob/master/src/poll_compat.c
>  >
>
>
> How does this code convince FD_SET() that the buffer has increased? It
>  looks to me like it depends on a specific FD_SET() implementation...
>  For instance, Windows' FD_SET() implementation is like this:
>
>  #define FD_SET(fd, set) do { \
>     if (((fd_set FAR *)(set))->fd_count < FD_SETSIZE) \
>         ((fd_set FAR *)(set))->fd_array[((fd_set FAR
>  *)(set))->fd_count++]=(fd);\
>  } while(0)
>
>  ...so unless another set is passed in, it won't add any more fds once
>  fd_count reaches FD_SETSIZE.
>
>  Also, FD_SETSIZE is 64 on Windows. IIRC it's 1024 on Linux, so it is
>  much more likely that we encounter this issue on Windows than on
>  Linux, at least ;)

Hm, good catch.  Seems such compat poll() cannot be done without
OS-specific hacks.

Do you know perhaps what other OS-es have non-bitmap fd_set?

-- 
marko
