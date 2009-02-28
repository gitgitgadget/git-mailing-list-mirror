From: David Syzdek <david@syzdek.net>
Subject: [PATCH] autoconf: Add limited support for --htmldir
Date: Fri, 27 Feb 2009 22:23:38 -0900
Message-ID: <9a0027270902272323y44091bfakcb640f168c33a824@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Tim Visher <tim.visher@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 28 08:25:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdJZQ-0002Ql-7C
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 08:25:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430AbZB1HXn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Feb 2009 02:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbZB1HXm
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Feb 2009 02:23:42 -0500
Received: from an-out-0708.google.com ([209.85.132.243]:53846 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831AbZB1HXl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Feb 2009 02:23:41 -0500
Received: by an-out-0708.google.com with SMTP id c2so1147445anc.1
        for <git@vger.kernel.org>; Fri, 27 Feb 2009 23:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=unR/lo2iE+TzhkTU90KuKLJjAj9y+jeNbr5VXmbiTdM=;
        b=Zv1yXvklN8KFuCqOVq9IkKypJzaulGbkNtarIDy/lq6R95T1HmoDWJR0haqql0NLkz
         z1KJ5brPZmyfN0IByHBUbIWjqnv2oOVBgFt9zlVkzdSsayqpRcLzTK77d6ddv8OUtTwl
         I/RL/01nJxqvbhs3stere8PGX+UEMVIdsLNYI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        b=vvssrPC+1B1g6B4ydo/rEQDURC3SDPs7V56a9jvgNnt4VmkyYybQQJrCP3NPiQw5mb
         GweH1FQPWGwxNrhXE7SwFtpp0gbYrmdU4vcAiMQD7dtP5HPJ+fUABxK6esEXNYTok3zd
         AYz7j4lQVe1YxbCy1oL0kH8/x2vKEt9vPyZyE=
Received: by 10.231.20.5 with SMTP id d5mr2647185ibb.14.1235805818858; Fri, 27 
	Feb 2009 23:23:38 -0800 (PST)
X-Google-Sender-Auth: 7bec8334b0168b87
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111752>

On Fri, Feb 27, 2009 at 4:57 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> On Sat, 28 Feb 2009, David Syzdek wrote:
>> On Fri, Feb 27, 2009 at 3:33 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>>> On Thu, 26 Feb 2009, Jeff King wrote:
>>>> On Thu, Feb 26, 2009 at 09:48:29AM -0500, Tim Visher wrote:
>>>>
>>>>> I'm working on getting git 1.6.2-rc2 built.  I have a bin, man, info,
>>>>> and html directory in my home folder that I'd like to use as the
>>>>> defaults for git.  I attempted to do this through
>>>>>
>>>>>     make configure
>>>>>     ./configure --XXdir=/full/path/to/dir
>>>>>     make all man info html
>>>>>     make install install-man install-info install-html
> [...]
>
>>>> The configure support is notoriously incomplete (AFAIK, very few of the
>>>> active developers use it regularly). Probably you need something like
>>>> this (but I didn't test it):
>>>>
>>>> diff --git a/config.mak.in b/config.mak.in
>>>> index 7cce0c1..505d5c7 100644
>>>> --- a/config.mak.in
>>>> +++ b/config.mak.in
>>>> @@ -18,6 +18,8 @@ datarootdir = @datarootdir@
>>>>  template_dir = @datadir@/git-core/templates
>>>>
>>>>  mandir=@mandir@
>>>> +htmldir=@htmldir@
>>>> +infodir=@infodir@
>>>>
>>>>  srcdir = @srcdir@
>>>>  VPATH = @srcdir@
>>>
>>> Well, the infodir part works trivially, because autoconf (and
>>> therefore ./configure script) has support for --infodir=DIR.
>>> Below there is patch that adds that, with the commit message.
>>>
>>> But it is more difficult with respect to --htmldir. I am not autoconf
>>> hacker, so I don't know how to add support for having --htmldir=DIR in
>>> ./configure (in configure.ac).  What can be done is to derive htmldir
>>> in config.mak.in from other sources, for example:
>>
>> Autoconf add support for --htmldir in version 2.60.  Here is a snippet from
>> the help message from a configure script generated with 2.60:
>>
>> --datarootdir=DIR       read-only arch.-independent data root [PREFIX/share]
>>
>> --docdir=DIR            documentation root [DATAROOTDIR/doc/PROJECT_TARNAME]
>>
>> --htmldir=DIR           html documentation [DOCDIR]
>>
>>
>> The current configure.ac requires autoconf version>= 2.59, bumping the
>> requirement to autoconf>= 2.60 would allow the autoconf variable $(htmldir)
>> to be used.  Bumping the required version of autoconf will affect users with
>> older linux installations who use git to upgrade git; and may affect the
>> maintainer's ability to create a "release" tarball if he has an older
>> version of autoconf.
>
> Well, I have autoconf 2.59, so I cannot test the following patch
> (and I am not sure if it is welcome). And of course it needs commit
> message, at least with explanation why bumping required version of
> autoconf was needed.

I tested the below patch using autoconf 2.59 and autoconf 2.62.  If
the version of autoconf used to create the configure script supports
the `--htmldir' option then the htmldir is set by either autoconf or
the user defined value.  If the version of autoconf does not support
the `--htmldir' option, then htmldir defaults to [DATADIR/doc/git].

This way a newer version of autoconf is not required for users on
distros more than a year or so old, however users on newer distros are
able to use the '--html' flag.

-- >8 --
Add support for --htmdir=DIR [DATAROOT/doc/git] if the configure
script is created with autoconf 2.60 or higher. htmldir defaults to
[DATADIR/doc/git] if the configure script is created with autoconf
2.59 or lower.

Signed-off-by: David M. Syzdek <david@syzdek.net>
---
 config.mak.in |    1 +
 configure.ac  |    7 +++++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/config.mak.in b/config.mak.in
index 7cce0c1..5ae076e 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -18,6 +18,7 @@ datarootdir = @datarootdir@
 template_dir = @datadir@/git-core/templates

 mandir=@mandir@
+htmldir=@htmldir@

 srcdir = @srcdir@
 VPATH = @srcdir@
diff --git a/configure.ac b/configure.ac
index 082a03d..6e16034 100644
--- a/configure.ac
+++ b/configure.ac
@@ -107,6 +107,13 @@ AS_HELP_STRING([],[Bare --with-tcltk will make
the GUI part only if])
 AS_HELP_STRING([],[Tcl/Tk interpreter will be found in a system.]),\
 GIT_PARSE_WITH(tcltk))
 #
+# Define ${htmldir} if the configure script was created with a version of
+# autoconf older than 2.60.
+if test "x${htmldir}" = "x";then
+   htmldir="${datadir}/doc/${PACKAGE_TARNAME}"
+   AC_SUBST(htmldir, [${htmldir}])
+fi
+#


 ## Checks for programs.
-- 
1.6.2.rc2.268.g13cc9
