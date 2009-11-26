From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH/RFC 00/11] daemon-win32
Date: Thu, 26 Nov 2009 01:43:04 +0100
Message-ID: <40aa078e0911251643m7837cd82g8ea9d631c012d62@mail.gmail.com>
References: <1259195958-2372-1-git-send-email-kusmabite@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, dotzenlabs@gmail.com,
	Erik Faye-Lund <kusmabite@gmail.com>
To: msysgit@googlecode.com
X-From: git-owner@vger.kernel.org Thu Nov 26 01:43:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDSS0-0000ei-36
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 01:43:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759669AbZKZAnA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Nov 2009 19:43:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753592AbZKZAm7
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 19:42:59 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:41520 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753404AbZKZAm7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Nov 2009 19:42:59 -0500
Received: by ewy19 with SMTP id 19so297816ewy.21
        for <git@vger.kernel.org>; Wed, 25 Nov 2009 16:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=V/pT8YADRRDbJUw3YgHFob2T1lHbjfkTlMJtzbspofw=;
        b=USDfvnM2pzg2CSvlbk9f3sgDBVrY1+uVFDBqxIhK7lSQAlhN8JU3PzXuenishgD7zR
         pvQl8KUhvZL8OfxjdT5tco/qaV4I72vVFQF3N+tYtwMdfpryA7rnLGN5mi0NRB3avWrh
         6Lg/Gv+ZUeDXdJEi7fwXkforX27pjPofrVc48=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=Wb2WJAUu7LTyXndGypcZRhLXbTLpm7TPzuGeZfmCPnoT5l/EGhJrO8lzKPEaVFQCQa
         uZnQUKL1ObSrsxDGteGGsyuSCAQjnA4IqKk8zTIJBrELy3OLJaw+raHSYPBTo8mWTK1N
         T3uAG1/sJUGURywBZBJPdY/g4TvT5zrLHxvTs=
Received: by 10.216.93.12 with SMTP id k12mr2564406wef.195.1259196184378; Wed, 
	25 Nov 2009 16:43:04 -0800 (PST)
In-Reply-To: <1259195958-2372-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133730>

Awww, sorry people. I managed to send this one to the wrong
msysgit-account. I'll repost, as I think it's important to get that
list involved as well.

On Thu, Nov 26, 2009 at 1:39 AM, Erik Faye-Lund
<kusmabite@googlemail.com> wrote:
> This is my stab at cleaning up Mike Pape's patches for git-daemon
> on Windows for submission, plus some of my own.
>
> * Patch 1-4 originate from Mike Pape, but have been cleaned up quite
> =A0a lot by me. I hope Mike won't hate me. Credit have been retained,
> =A0as all important code here were written by Mike. The commit
> =A0messages were written mostly by me.
>
> * Patch 5 is a trivial old-style function declaration fix.
>
> * Patch 6 introduces two new functions to the run-command API,
> =A0kill_async() and is_async_alive().
>
> * Patch 7-8 removes the stdin/stdout redirection for the service
> =A0functions, as redirecting won't work for the threaded version.
>
> * Patch 9 converts the daemon-code to use the run-command API. This
> =A0is the patch I expect to be the most controversial.
>
> * Patch 10 is about using line-buffered mode instead of full-buffered
> =A0mode for stderr.
>
> * Patch 11 finally enables compilation of git-daemon on MinGW.
>
> Let the flames begin!
>
> Erik Faye-Lund (7):
> =A0inet_ntop: fix a couple of old-style decls
> =A0run-command: add kill_async() and is_async_alive()
> =A0run-command: support input-fd
> =A0daemon: use explicit file descriptor
> =A0daemon: use run-command api for async serving
> =A0daemon: use full buffered mode for stderr
> =A0mingw: compile git-daemon
>
> Mike Pape (4):
> =A0mingw: add network-wrappers for daemon
> =A0strbuf: add non-variadic function strbuf_vaddf()
> =A0mingw: implement syslog
> =A0compat: add inet_pton and inet_ntop prototypes
>
> =A0Makefile =A0 =A0 =A0 =A0 =A0 | =A0 =A08 ++-
> =A0compat/inet_ntop.c | =A0 22 ++------
> =A0compat/inet_pton.c | =A0 =A08 ++-
> =A0compat/mingw.c =A0 =A0 | =A0111 ++++++++++++++++++++++++++++++++++=
+++++++--
> =A0compat/mingw.h =A0 =A0 | =A0 32 ++++++++++++
> =A0daemon.c =A0 =A0 =A0 =A0 =A0 | =A0134 ++++++++++++++++++++++++++--=
------------------------
> =A0git-compat-util.h =A0| =A0 =A09 ++++
> =A0run-command.c =A0 =A0 =A0| =A0 32 ++++++++++++-
> =A0run-command.h =A0 =A0 =A0| =A0 =A02 +
> =A0strbuf.c =A0 =A0 =A0 =A0 =A0 | =A0 15 ++++--
> =A0strbuf.h =A0 =A0 =A0 =A0 =A0 | =A0 =A01 +
> =A011 files changed, 274 insertions(+), 100 deletions(-)
>
>



--=20
Erik "kusma" Faye-Lund
