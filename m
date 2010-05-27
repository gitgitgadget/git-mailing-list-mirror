From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 1/3] Support building on systems without poll(2)
Date: Thu, 27 May 2010 10:51:18 +0200
Message-ID: <4BFE3286.8070508@drmicha.warpmail.net>
References: <1274948384-167-1-git-send-email-abcd@gentoo.org> <1274948384-167-2-git-send-email-abcd@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mduft@gentoo.org, jrnieder@gmail.com
To: Jonathan Callen <abcd@gentoo.org>
X-From: git-owner@vger.kernel.org Thu May 27 10:51:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHYoX-0000iD-H6
	for gcvg-git-2@lo.gmane.org; Thu, 27 May 2010 10:51:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757491Ab0E0Ivg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 May 2010 04:51:36 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:51229 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757336Ab0E0Ivf (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 May 2010 04:51:35 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 6A1F2F6A46;
	Thu, 27 May 2010 04:51:34 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 27 May 2010 04:51:34 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=gaWSMPiG3kJfbk84G8/JfJbPaKk=; b=dpnd67GqKqDSbaKiIc0xA9IfT1R/lfMdskfrqNU8miOMRvZtATaYWBp+NeXk+FgyBwebdEfpoq7OxZxA30TFh6yVXfho1+Ja4HiuAl0D3B0CUzRUnCtvBvFVz9rLNbo8/GdBat/PGXdVLopeR0NqBIfFrPkx5vNLW5syLcIWfwM=
X-Sasl-enc: PDQN9vOHsFtxOs1tiCSlrf7oMhk0OB3ViaQ4kMiystyW 1274950293
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 5099B71012;
	Thu, 27 May 2010 04:51:33 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100526 Lightning/1.0b2pre Lanikai/3.1.1pre
In-Reply-To: <1274948384-167-2-git-send-email-abcd@gentoo.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147838>

Jonathan Callen venit, vidit, dixit 27.05.2010 10:19:
> Some systems do not have sys/poll.h or poll(2).  Don't build
> git-daemon, git-upload-archive, or git-upload-pack on such systems.
> 
> Signed-off-by: Jonathan Callen <abcd@gentoo.org>
> ---
>  Makefile          |   21 ++++++++++++++++-----
>  builtin.h         |    2 ++
>  git-compat-util.h |    2 ++
>  git.c             |    2 ++
>  4 files changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 07cab8f..4b36534 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -62,6 +62,8 @@ all::
>  #
>  # Define NO_MKSTEMPS if you don't have mkstemps in the C library.
>  #
> +# Define NO_POLL if you don't have poll in the C library, or it does not work.
> +#
>  # Define NO_LIBGEN_H if you don't have libgen.h.
>  #
>  # Define NEEDS_LIBGEN if your libgen needs -lgen when linking
> @@ -386,7 +388,6 @@ PROGRAM_OBJS += fast-import.o
>  PROGRAM_OBJS += imap-send.o
>  PROGRAM_OBJS += shell.o
>  PROGRAM_OBJS += show-index.o
> -PROGRAM_OBJS += upload-pack.o
>  PROGRAM_OBJS += http-backend.o
>  
>  PROGRAMS += $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))
> @@ -434,9 +435,7 @@ OTHER_PROGRAMS = git$X
>  
>  # what test wrappers are needed and 'install' will install, in bindir
>  BINDIR_PROGRAMS_NEED_X += git
> -BINDIR_PROGRAMS_NEED_X += git-upload-pack
>  BINDIR_PROGRAMS_NEED_X += git-receive-pack
> -BINDIR_PROGRAMS_NEED_X += git-upload-archive
>  BINDIR_PROGRAMS_NEED_X += git-shell
>  
>  BINDIR_PROGRAMS_NO_X += git-cvsserver
> @@ -722,7 +721,6 @@ BUILTIN_OBJS += builtin/unpack-objects.o
>  BUILTIN_OBJS += builtin/update-index.o
>  BUILTIN_OBJS += builtin/update-ref.o
>  BUILTIN_OBJS += builtin/update-server-info.o
> -BUILTIN_OBJS += builtin/upload-archive.o
>  BUILTIN_OBJS += builtin/var.o
>  BUILTIN_OBJS += builtin/verify-pack.o
>  BUILTIN_OBJS += builtin/verify-tag.o
> @@ -1162,8 +1160,17 @@ ifdef ZLIB_PATH
>  endif
>  EXTLIBS += -lz
>  
> +ifndef NO_POLL
> +	BUILTIN_OBJS += builtin/upload-archive.o
> +	PROGRAM_OBJS += upload-pack.o
> +	BINDIR_PROGRAMS_NEED_X += git-upload-archive
> +	BINDIR_PROGRAMS_NEED_X += git-upload-pack
> +endif
> +
>  ifndef NO_POSIX_ONLY_PROGRAMS
> -	PROGRAM_OBJS += daemon.o
> +	ifndef NO_POLL
> +		PROGRAM_OBJS += daemon.o
> +	endif
>  endif
>  ifndef NO_OPENSSL
>  	OPENSSL_LIBSSL = -lssl
> @@ -1322,6 +1329,10 @@ ifdef OLD_ICONV
>  	BASIC_CFLAGS += -DOLD_ICONV
>  endif
>  
> +ifdef NO_POLL
> +	BASIC_CFLAGS += -DNO_POLL
> +endif
> +
>  ifdef NO_DEFLATE_BOUND
>  	BASIC_CFLAGS += -DNO_DEFLATE_BOUND
>  endif
> diff --git a/builtin.h b/builtin.h
> index 5c887ef..165a748 100644
> --- a/builtin.h
> +++ b/builtin.h
> @@ -127,7 +127,9 @@ extern int cmd_unpack_objects(int argc, const char **argv, const char *prefix);
>  extern int cmd_update_index(int argc, const char **argv, const char *prefix);
>  extern int cmd_update_ref(int argc, const char **argv, const char *prefix);
>  extern int cmd_update_server_info(int argc, const char **argv, const char *prefix);
> +#ifdef NO_POLL
>  extern int cmd_upload_archive(int argc, const char **argv, const char *prefix);
> +#endif

Shouldn't this be "ifndef"? makes me wonder how the test compile worked...

>  extern int cmd_upload_tar(int argc, const char **argv, const char *prefix);
>  extern int cmd_var(int argc, const char **argv, const char *prefix);
>  extern int cmd_verify_tag(int argc, const char **argv, const char *prefix);
> diff --git a/git-compat-util.h b/git-compat-util.h
> index edf352d..c5188e5 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -94,7 +94,9 @@
>  #include <utime.h>
>  #ifndef __MINGW32__
>  #include <sys/wait.h>
> +#ifndef NO_POLL
>  #include <sys/poll.h>
> +#endif
>  #include <sys/socket.h>
>  #include <sys/ioctl.h>
>  #include <termios.h>
> diff --git a/git.c b/git.c
> index 99f0363..8c081db 100644
> --- a/git.c
> +++ b/git.c
> @@ -390,7 +390,9 @@ static void handle_internal_command(int argc, const char **argv)
>  		{ "update-index", cmd_update_index, RUN_SETUP },
>  		{ "update-ref", cmd_update_ref, RUN_SETUP },
>  		{ "update-server-info", cmd_update_server_info, RUN_SETUP },
> +#ifndef NO_POLL
>  		{ "upload-archive", cmd_upload_archive },
> +#endif
>  		{ "var", cmd_var },
>  		{ "verify-tag", cmd_verify_tag, RUN_SETUP },
>  		{ "version", cmd_version },
