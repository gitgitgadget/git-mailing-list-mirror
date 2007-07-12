From: "Carlos Rica" <jasampler@gmail.com>
Subject: Re: [PATCH 2/2] Make git-tag a builtin.
Date: Thu, 12 Jul 2007 23:01:57 +0200
Message-ID: <1b46aba20707121401n12796827n77b7e1d1ccde330c@mail.gmail.com>
References: <46952755.2050307@gmail.com>
	 <7vps2yxjgq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"=?ISO-8859-1?Q?Kristian_H=F8gsberg?=" <krh@redhat.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 12 23:02:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I95nb-0004Ts-LD
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 23:02:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934134AbXGLVCB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 12 Jul 2007 17:02:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934041AbXGLVCB
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 17:02:01 -0400
Received: from nz-out-0506.google.com ([64.233.162.233]:4802 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933888AbXGLVB7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jul 2007 17:01:59 -0400
Received: by nz-out-0506.google.com with SMTP id s18so254547nze
        for <git@vger.kernel.org>; Thu, 12 Jul 2007 14:01:58 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=D3WFvbonVXNoCsGRIcEEagkbbEGskUdiOnCAuqfbMUWvrue5qUQZzsaJMUQ+LbXTuIHvH/x36XvlnBD/qu5uXdHNqltgsDTn2/hnQrIcVqTmBjcLqcbc3oDoWY8ncTF+P4af4dCeihQm+DXX5/A9v/JK7SjxKjR2ZfIGr1cDbcw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=S72fAkiD8RM4Nb17tGLiPgWu5f2Zx+sPdhUbC4z+pkHPCX6VKNpiVSvDvO29VMgeHyDK2Z1CXcb4I6VSvaB3Lyp89cY7fKTYMFYDQG3qceCtXzzgr2IjLFrS+aKBWEHLJvJfWL3mZpgc6rruGnvq8jzrm+twh1kxInxtj1Fg8SM=
Received: by 10.115.18.1 with SMTP id v1mr981499wai.1184274117902;
        Thu, 12 Jul 2007 14:01:57 -0700 (PDT)
Received: by 10.114.57.10 with HTTP; Thu, 12 Jul 2007 14:01:57 -0700 (PDT)
In-Reply-To: <7vps2yxjgq.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52336>

Thank you for your review, Junio, I'm studing all of your suggestions.

2007/7/12, Junio C Hamano <gitster@pobox.com>:
> Carlos Rica <jasampler@gmail.com> writes:
>
> > Mime-Version: 1.0
> > Content-Type: text/plain; charset=3Dwindows-1252
>
> Hmmmmmm.....

> > diff --git a/builtin-tag.c b/builtin-tag.c
> > new file mode 100644
> > index 0000000..1824379
> > --- /dev/null
> > +++ b/builtin-tag.c
> > @@ -0,0 +1,430 @@
> > +/*
> > + * Builtin "git tag"
> > + *
> > + * Copyright (c) 2007 Kristian H??gsberg <krh@redhat.com>,
>
> I do not know how the above would come out, but it surely was
> not H=F8gsberg in the copy I received...

I think it is my fault. My original builtin-tag.c file has the
name encoded in UTF-8, and the patch too, except because
I also added his name in the commit's message in Latin-1 encoding,
and then, programs cannot recode or recognize both. Sorry.

>
> > + *                    Carlos Rica <jasampler@gmail.com>
> > + * Based on git-tag.sh and mktag.c by Linus Torvalds.
> > + */
> > +
> > +#include "cache.h"
> > +#include "builtin.h"
> > +#include "refs.h"
> > +#include "tag.h"
> > +#include "run-command.h"
> > +
> > +static const char builtin_tag_usage[] =3D
> > +  "git-tag [-n [<num>]] -l [<pattern>] | [-a | -s | -u <key-id>] [=
-f | -d | -v] [-m <msg>] <tagname> [<head>]";
> > +
> > +static char signingkey[1000];
> > +static int lines;
> > +
> > +static void launch_editor(const char *path, char **buffer, unsigne=
d long *len)
> > +{
> > +     const char *editor, *terminal;
> > +     struct child_process child;
> > +     const char *args[3];
> > +     int fd;
> > +
> > +     editor =3D getenv("VISUAL");
> > +     if (!editor)
> > +             editor =3D getenv("EDITOR");
> > +
> > +     terminal =3D getenv("TERM");
> > +     if (!editor && (!terminal || !strcmp(terminal, "dumb"))) {
> > +             fprintf(stderr,
> > +             "Terminal is dumb but no VISUAL nor EDITOR defined.\n=
"
> > +             "Please supply the message using either -m or -F opti=
on.\n");
> > +             exit(1);
> > +     }
>
> Ah, this is taken from git-commit.sh ;-) Does your "git tag"
> support the -F option (builtin_tag_usage[] does not seem to
> mention it)?  I wonder what happens when this function migrates
> to editor.c and a new program, other than git-tag and
> git-commit, that is without -F nor -m options wants to call
> this.

I will include that -F option in the builtin_tag_usage and I will also =
find
if documentation already has it.

As I said above, launch_editor is copied and modified from the builtin-=
commit.c
that Kristian is currently writing. Indeed, I removed every mention on
it related
specifically to commits, so it will be difficult to share the code betw=
een both
versions in the current state. Perhaps a raw function not printing out =
errors
(and returning error codes instead) could be the only option to reuse i=
t. I need
to ask Kristian for this.

> > +static int run_verify_tag_command(unsigned char *sha1)
> > +{
> > +     int ret;
> > +     const char *argv_verify_tag[] =3D {"git-verify-tag",
> > +                                     "-v", "SHA1_HEX", NULL};
> > +     argv_verify_tag[2] =3D sha1_to_hex(sha1);
> > +
> > +     ret =3D run_command_v_opt(argv_verify_tag, 0);
> > +
> > +     if (ret <=3D -10000)
> > +             die("unable to run %s\n", argv_verify_tag[0]);
> > +     return -ret;
> > +}
>
> I wonder why you need to differentiate between ERR_RUN_COMMAND_*
> and non-zero exit status...  Also do you need to "return -ret",
> instead of not negating?  In C programs error returns are often
> negative and finish_command() follows that convention.

The point here was to mimic the behaviour of git-tag.sh,
returning the exit status returned by the called script: "git-verify-ta=
g.sh".
However, I didn't realize that git-verify tag.sh was exiting only with =
1 or 0,
so "return ret;" will also work since the call to the function is:
   if (run_verify_tag_command(sha1))
      had_error =3D 1;

When die is called (because of an ERR_RUN_COMMAND_* error condition),
it will return 128 to the system, and won't do more processing to other=
 tags.
Do yo mean that it would be better to remove this "die" call here?

>
> > +     if (!message) {
> > ...
> > +     }
> > +     else {
> > +             buffer =3D message;
> > +             size =3D strlen(message);
> > +     }
> > +
> > +     size =3D stripspace(buffer, size, 1);
> > +
> > +     if (!message && !size)
> > +             die("no tag message?");
>
> Why check 'message' here?

Because the behaviour of git-tag.sh here is not allow empty
messages when the editor is executed, but allow them when
-m or -F options are given (message then will be not NULL).

> > +int cmd_tag(int argc, const char **argv, const char *prefix)
> > +{
> > ...
> > +             if (!strcmp(arg, "-F")) {
> > +                     unsigned long len;
> > +                     annotate =3D 1;
> > +                     i++;
> > +                     if  (i =3D=3D argc)
> > +                             die("option -F needs an argument.");
> > +
> > +                     fd =3D open(argv[i], O_RDONLY);
> > +                     if (fd < 0)
> > +                             die("cannot open %s", argv[1]);
>
> The shell script version relies on the magic "cat -" to read
> from standard input upon "git tag -F -".  It is understandable
> that both of you and Dscho missed it, though.

It should be easy to implement, I will do it.

> > +                     len =3D 1024;
> > +                     message =3D xmalloc(len);
> > +                     if (read_pipe(fd, &message, &len))
> > +                             die("cannot read %s", argv[1]);
> > +                     message =3D xrealloc(message, len + 1);
> > +                     message[len] =3D '\0';
> > +                     continue;
> > +             }
>
> We might be better off if read_pipe() is renamed to read_fd()
> and made internally always NUL-terminate the buffer (but not
> count that NUL as part of length).  I dunno.

I saw an implementation for read_pipe named read_fd from Kristian:
http://article.gmane.org/gmane.comp.version-control.git/51366
but it is only focused on allowing NULL and 0 in pointer and size
parameters. It should be harmless NUL-terminating the buffer
since the routine is already allocating more memory than needed
for efficiency purposes.
