From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: [PATCH] config.mak.in: continue fixing NEEDS_LIBGEN autoconfigure
 feature
Date: Thu, 23 Jul 2009 11:22:34 -0500
Message-ID: <pJGueCmuNgb226XrXo6E-MM775KWLC_yj40cI639W5tahKT6xRtS-g@cipher.nrlssc.navy.mil>
References: <N0R1rELOlDFDG8pOY2LYJHmWygM5WFD8q_fNZgfE1A2QOX1yg6OPCZW4RbX5i03hokq4Bx2zOjM@cipher.nrlssc.navy.mil> <57XXtFYcpNU4ayC2onbxyZE72nxUH64HrjFA1KTX3lvwrSUaKMsqemp5CX0U7W460zAC_hc0GdA@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, j6t@kdbg.org, peff@peff.net, david@syzdek.net,
	jnareb@gmail.com, bonzini@gnu.org, nicolas.s.dev@gmx.fr,
	Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jul 23 18:23:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MU14U-0002is-Iw
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 18:23:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754444AbZGWQW7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2009 12:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752991AbZGWQW6
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jul 2009 12:22:58 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:34692 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754360AbZGWQW6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2009 12:22:58 -0400
Received: by mail.nrlssc.navy.mil id n6NGMY1r030474; Thu, 23 Jul 2009 11:22:34 -0500
In-Reply-To: <57XXtFYcpNU4ayC2onbxyZE72nxUH64HrjFA1KTX3lvwrSUaKMsqemp5CX0U7W460zAC_hc0GdA@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 23 Jul 2009 16:22:34.0455 (UTC) FILETIME=[C91A6E70:01CA0BB1]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123878>


Junio,

I see you squashed this and applied it to master (a1142892), but
since my email was not clear, the commit message is not accurate
(in an unimportant way).

You said

    Without [the addition of NEEDS_LIBGEN to config.mak.in], the
    generated shell script would contain a snippet like this:

       for ac_lib in ; do
         ...

    which is incorrect.

Actually, the "for ac_lib in ; do" snippet is produced with or without
my patch.  I didn't mean to imply that there was a change in that
respect.  It's just that that snippet is what prevents the configure
script from completing successfully on IRIX and Solaris 7 when executing
it with /bin/sh or /bin/ksh.  When bash is used, the configure script
can execute successfully, and then it can be verified that the patched
configure.ac produces a configure script that operates correctly.

Sorry for the confusion.

-brandon


Brandon Casey wrote:
> From: Brandon Casey <drafnel@gmail.com>
> 
> An entry in the config.mak.in file is necessary for the NEEDS_LIBGEN variable
> to appear in the config.mak.autogen file with the value assigned by the
> configure script.
> 
> Signed-off-by: Brandon Casey <drafnel@gmail.com>
> ---
> 
> 
> Junio,
> 
> You probably want to apply or squash this somewhere.
> 
> As I noted in the original patch, the autoconf part was untested.
> I actually did some light testing on this one.  I created the configure file
> on linux and ran it on Solaris and IRIX.  Both produce an error which looks
> something like:
> 
>    configure[1234]: syntax error at line 4806 : `;' unexpected
> 
> And line 4806 looks like:
> 
>    for ac_lib in ; do
>       ...
> 
> It works with bash though, and it works with /bin/sh on Solaris 10.  On
> Solaris 10, the configure script correctly detects that hstrerror cannot be
> used without -lresolv, and basename can be used without -lgen.  In
> config.mak.autogen, NEEDS_RESOLV is set to 'YesPlease' and NEEDS_LIBGEN is
> unset.  On my Solaris 7, bash is not available, but the informational messages
> indicate the same results as for Solaris 10.  On IRIX, hstrerror() can be used
> without -lresolv and basename cannot be used without -lgen.  In
> config.mak.autogen, NEEDS_RESOLV is unset, and NEEDS_LIBGEN is set to
> 'YesPlease'.
> 
> So, I think this patch should be the final one.
> 
> -brandon
> 
> 
>  config.mak.in |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/config.mak.in b/config.mak.in
> index dd60451..67b12f7 100644
> --- a/config.mak.in
> +++ b/config.mak.in
> @@ -34,6 +34,7 @@ NO_LIBGEN_H=@NO_LIBGEN_H@
>  NEEDS_LIBICONV=@NEEDS_LIBICONV@
>  NEEDS_SOCKET=@NEEDS_SOCKET@
>  NEEDS_RESOLV=@NEEDS_RESOLV@
> +NEEDS_LIBGEN=@NEEDS_LIBGEN@
>  NO_SYS_SELECT_H=@NO_SYS_SELECT_H@
>  NO_D_INO_IN_DIRENT=@NO_D_INO_IN_DIRENT@
>  NO_D_TYPE_IN_DIRENT=@NO_D_TYPE_IN_DIRENT@
