From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Suggestion for improving the manual page for "git submodule"
Date: Fri, 03 May 2013 22:48:18 +0200
Message-ID: <51842292.9040400@web.de>
References: <201305030123.r431Nt6w015228@freeze.ariadne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Dale R. Worley" <worley@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri May 03 22:48:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYMu7-0004Ou-67
	for gcvg-git-2@plane.gmane.org; Fri, 03 May 2013 22:48:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763627Ab3ECUsX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 May 2013 16:48:23 -0400
Received: from mout.web.de ([212.227.17.11]:65220 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763616Ab3ECUsW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 May 2013 16:48:22 -0400
Received: from [192.168.178.41] ([91.3.169.194]) by smtp.web.de (mrweb003)
 with ESMTPA (Nemesis) id 0LlWFD-1Tz2Hc0piJ-00adWU; Fri, 03 May 2013 22:48:19
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <201305030123.r431Nt6w015228@freeze.ariadne.com>
X-Enigmail-Version: 1.5.1
X-Provags-ID: V02:K0:7c1+wLewzrlBZNBkSURGA4Sc/O7cFxNA24CoBF5txTq
 SyvDS1U+XNJkLeZgBn18KaKnWAeO7mkOrCytLI0BdAQxURj2fv
 Z+HkkYqeOEFrLOTmZKM+F8zafaYHY7zgcufOVWHVnqvOO+Sa+E
 uy/hwBJW5igw5HBuVgwAoTZKQQlp41FkZ8w66AyolWfwwFtZNV
 7HgoGEMvCGZgMDg9+U1og==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223320>

Am 03.05.2013 03:23, schrieb Dale R. Worley:
> Several people have made similar mistakes in beliving that "git
> submodule init" can be used for adding submodules to a working
> directory, whereas "git submodule add" is the command that should be
> used.  That *is* documented at the top of the manual page for "git
> submodule", but my error was enhanced by a subtle error in the
> documentation of "init".

Thanks for bringing this up.

> The text as it is written suggests that init's behavior is driven by
> the contents of .submodules.  But in fact, its behavior is driven by
> the existing gitlinks in the file tree, possibly limited by the <path=
>
> arguments.  (Which is *why* "git submodule init" can't *add*
> submodules; it only processes *existing* submodules.)

That's correct (but I think "index" should be used here instead of
"file tree").

> I would like to suggest that the manual page be updated to remove the
> error in the description of the init subcommand, along with another
> addition to tell the submodule logical name that is used by the "add"
> subcommand:

Good idea, care to provide a patch? ;-)
(If so, please see Documentation/SubmittingPatches on how to do that)

> --- man1	2013-04-26 12:02:16.752702146 -0400
> +++ man3	2013-05-02 21:06:00.020353100 -0400
> @@ -61,6 +61,8 @@
>             to exist in the superproject. If <path> is not given, the
>             "humanish" part of the source repository is used ("repo" =
for
>             "/path/to/repo.git" and "foo" for "host.xz:foo/.git").
> +           The <path> is used as the submodule's logical name in its
> +           configuration entries.

Nice, but I think you should append "unless the --name option is used
to provide a different name" or such to that sentence.

>             <repository> is the URL of the new submodule=E2=80=99s or=
igin repository.
>             This may be either an absolute URL, or (if it begins with=
 ./ or
> @@ -109,7 +111,9 @@
>             too (and can also report changes to a submodule=E2=80=99s=
 work tree).
> =20
>         init
> -           Initialize the submodules, i.e. register each submodule n=
ame and
> +           Initialize the submodules, i.e. register each submodule f=
or which
> +           there is a gitlink recorded (or the specific gitlinks spe=
cified by
> +           <path> ...) by copying the name and

This sounds very technical ... maybe we should rephrase that like this?

-           Initialize the submodules, i.e. register each submodule nam=
e and
+           Initialize the submodules recorded in the index (by having =
been
+           added and committed somewhere else), i.e. register each sub=
module
+           name and

(Not being a native speaker I would appreciate if somebody else comes u=
p
with a better wording. I think we should talk about the fact that someb=
ody
else already "add"ed this submodule in his work tree; I'm not sure talk=
ing
about a gitlink here would help someone new to submodules that much, as=
 this
topic seems to be about confusing "init" and "add".)

>             url found in .gitmodules into .git/config. The key used i=
n
>             .git/config is submodule.$name.url. This command does not=
 alter
>             existing information in .git/config. You can then customi=
ze the
> @@ -118,6 +122,10 @@
>             submodule update --init without the explicit init step if=
 you do
>             not intend to customize any submodule locations.
> =20
> +           (Because init only operates on existing gitlinks, it cann=
ot
> +           be used to create submodules, regardless of the contents =
of
> +           .gitmodules.  Use the add subcommand to create submodules=
=2E)
> +

I'm not sure we need this anymore when we clarify the description above=
=2E

>         update
>             Update the registered submodules, i.e. clone missing subm=
odules and
>             checkout the commit specified in the index of the contain=
ing
