From: Dmitry Ivankov <divanorama@gmail.com>
Subject: Re: [PATCH v2 3/3] remote-helpers: export GIT_DIR variable to helpers
Date: Wed, 13 Jul 2011 23:14:31 +0600
Message-ID: <CA+gfSn8=kLvYzFcdB-caNLfK3RQtOP8V=-jdFtDgQ41KG0ngOQ@mail.gmail.com>
References: <1310483428-29833-1-git-send-email-divanorama@gmail.com>
	<1310577055-6347-3-git-send-email-divanorama@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 13 19:14:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qh31B-0007x2-2g
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 19:14:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281Ab1GMROc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jul 2011 13:14:32 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:50611 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932216Ab1GMROc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jul 2011 13:14:32 -0400
Received: by qwk3 with SMTP id 3so2960607qwk.19
        for <git@vger.kernel.org>; Wed, 13 Jul 2011 10:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=S0Mw14gJ11AjvOrZR89QZiAq7GV7vjoI1moh2B7y3DQ=;
        b=nBDNCL+ZJEo+Vtp9e0lX/+SfBVJ4Oba3zxI3GoF4NSlFdOOCzZbxJqpsphh5Z1RtG8
         wFKnLVgQMBsbIaD6iFv8Fe2ijf6XsAL8v0O2EXIN/zRYNzcLFxwSPRA3UA0i6RL+OEnc
         64hZ1OHfgbLCez8TbkPOtBq648+XyLf0u4QMo=
Received: by 10.229.185.211 with SMTP id cp19mr1148366qcb.102.1310577271202;
 Wed, 13 Jul 2011 10:14:31 -0700 (PDT)
Received: by 10.229.63.232 with HTTP; Wed, 13 Jul 2011 10:14:31 -0700 (PDT)
In-Reply-To: <1310577055-6347-3-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177063>

+Sverre
Sorry for the noise.

On Wed, Jul 13, 2011 at 11:10 PM, Dmitry Ivankov <divanorama@gmail.com>=
 wrote:
> The gitdir capability is recognized by git and can be used to tell
> the helper where the .git directory is. But it is not mentioned in
> the documentation and considered worse than if gitdir was passed
> via GIT_DIR environment variable.
>
> Do export GIT_DIR for a remote helper. Switch testgit to use env
> instead of less favoured capability gitdir.
>
> Mention it's possible uses in documentation: data storage, auxiliary
> git commands needed by a helper.
>
> Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
> ---
> Instead of documenting capability gitdir export GIT_DIR. Turned out
> to be quite straightforward.
>
> =A0Documentation/git-remote-helpers.txt | =A0 18 ++++++++++++++++++
> =A0git-remote-testgit.py =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 14 +---=
----------
> =A0transport-helper.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 10 ++=
++++++++
> =A03 files changed, 29 insertions(+), 13 deletions(-)
>
> diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git=
-remote-helpers.txt
> index 58f6ad4..394fc8e 100644
> --- a/Documentation/git-remote-helpers.txt
> +++ b/Documentation/git-remote-helpers.txt
> @@ -47,6 +47,9 @@ arguments. The first argument specifies a remote re=
pository as in git;
> =A0it is either the name of a configured remote or a URL. The second
> =A0argument specifies a URL; it is usually of the form
> =A0'<transport>://<address>', but any arbitrary string is possible.
> +'GIT_DIR' environment variable is set up for the remote helper and
> +can be used to store some additional data or to invoke auxiliary git
> +commands.
>
> =A0When git encounters a URL of the form '<transport>://<address>', w=
here
> =A0'<transport>' is a protocol that it cannot handle natively, it
> @@ -159,6 +162,14 @@ Supported if the helper has the "import" capabil=
ity.
> =A0+
> =A0Supported if the helper has the "connect" capability.
>
> +'gitdir' <path>::
> + =A0 =A0 =A0 Tells helper the location of current repository .git
> + =A0 =A0 =A0 directory. The path is absolute. The command is issued
> + =A0 =A0 =A0 immediately after "gitdir" capability line is read by
> + =A0 =A0 =A0 the caller.
> ++
> +Supported if the helper has the "gitdir" capability.
> +
> =A0If a fatal error occurs, the program writes the error message to
> =A0stderr and exits. The caller should expect that a suitable error
> =A0message has been printed if the child closes the connection withou=
t
> @@ -175,6 +186,7 @@ CAPABILITIES
> =A0'push'::
> =A0'import'::
> =A0'connect'::
> +'gitdir'::
> =A0 =A0 =A0 =A0This helper supports the corresponding command with th=
e same name.
>
> =A0'refspec' 'spec'::
> @@ -187,6 +199,12 @@ CAPABILITIES
> =A0 =A0 =A0 =A0all, it must cover all refs reported by the list comma=
nd; if
> =A0 =A0 =A0 =A0it is not used, it is effectively "{asterisk}:{asteris=
k}"
>
> +'gitdir'::
> + =A0 =A0 =A0 The helper wants to know .git directory location. The g=
itdir
> + =A0 =A0 =A0 command is sent immediately after reading this capabili=
ty.
> + =A0 =A0 =A0 The helper can read it immediately too or it can procee=
d with
> + =A0 =A0 =A0 reporting other capabilities and read it as a next comm=
and.
> +
> =A0REF LIST ATTRIBUTES
> =A0-------------------
>
> diff --git a/git-remote-testgit.py b/git-remote-testgit.py
> index df9d512..df3e37f 100644
> --- a/git-remote-testgit.py
> +++ b/git-remote-testgit.py
> @@ -35,7 +35,7 @@ def get_repo(alias, url):
> =A0 =A0 prefix =3D 'refs/testgit/%s/' % alias
> =A0 =A0 debug("prefix: '%s'", prefix)
>
> - =A0 =A0repo.gitdir =3D ""
> + =A0 =A0repo.gitdir =3D os.environ["GIT_DIR"]
> =A0 =A0 repo.alias =3D alias
> =A0 =A0 repo.prefix =3D prefix
>
> @@ -70,7 +70,6 @@ def do_capabilities(repo, args):
>
> =A0 =A0 print "import"
> =A0 =A0 print "export"
> - =A0 =A0print "gitdir"
> =A0 =A0 print "refspec refs/heads/*:%s*" % repo.prefix
>
> =A0 =A0 print # end capabilities
> @@ -150,22 +149,11 @@ def do_export(repo, args):
> =A0 =A0 repo.non_local.push(repo.gitdir)
>
>
> -def do_gitdir(repo, args):
> - =A0 =A0"""Stores the location of the gitdir.
> - =A0 =A0"""
> -
> - =A0 =A0if not args:
> - =A0 =A0 =A0 =A0die("gitdir needs an argument")
> -
> - =A0 =A0repo.gitdir =3D ' '.join(args)
> -
> -
> =A0COMMANDS =3D {
> =A0 =A0 'capabilities': do_capabilities,
> =A0 =A0 'list': do_list,
> =A0 =A0 'import': do_import,
> =A0 =A0 'export': do_export,
> - =A0 =A0'gitdir': do_gitdir,
> =A0}
>
>
> diff --git a/transport-helper.c b/transport-helper.c
> index 660147f..3282693 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -105,6 +105,12 @@ static struct child_process *get_helper(struct t=
ransport *transport)
> =A0 =A0 =A0 =A0int refspec_alloc =3D 0;
> =A0 =A0 =A0 =A0int duped;
> =A0 =A0 =A0 =A0int code;
> + =A0 =A0 =A0 char git_dir_buf[sizeof(GIT_DIR_ENVIRONMENT) + PATH_MAX=
 + 1];
> + =A0 =A0 =A0 const char *helper_env[] =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 git_dir_buf,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 NULL
> + =A0 =A0 =A0 };
> +
>
> =A0 =A0 =A0 =A0if (data->helper)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return data->helper;
> @@ -120,6 +126,10 @@ static struct child_process *get_helper(struct t=
ransport *transport)
> =A0 =A0 =A0 =A0helper->argv[2] =3D remove_ext_force(transport->url);
> =A0 =A0 =A0 =A0helper->git_cmd =3D 0;
> =A0 =A0 =A0 =A0helper->silent_exec_failure =3D 1;
> +
> + =A0 =A0 =A0 snprintf(git_dir_buf, sizeof(git_dir_buf), "%s=3D%s", G=
IT_DIR_ENVIRONMENT, get_git_dir());
> + =A0 =A0 =A0 helper->env =3D helper_env;
> +
> =A0 =A0 =A0 =A0code =3D start_command(helper);
> =A0 =A0 =A0 =A0if (code < 0 && errno =3D=3D ENOENT)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0die("Unable to find remote helper for =
'%s'", data->name);
> --
> 1.7.3.4
>
>
