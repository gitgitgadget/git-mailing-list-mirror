From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: [PATCHv3] daemon: give friendlier error messages to clients
Date: Sat, 15 Oct 2011 05:09:33 +0530
Message-ID: <CAMK1S_g0aKUa=+ndAm7rqeoPAobjVb6oJ1Z4DqSeNrdauXNH3w@mail.gmail.com>
References: <7vsjn9etm3.fsf@alter.siamese.dyndns.org>
	<1317678909-19383-1-git-send-email-pclouds@gmail.com>
	<20111012200916.GA1502@sigill.intra.peff.net>
	<20111013044544.GA27890@duynguyen-vnpc.dek-tpc.internal>
	<20111013182816.GA17573@sigill.intra.peff.net>
	<7vvcrs181e.fsf@alter.siamese.dyndns.org>
	<20111014131041.GC7808@sigill.intra.peff.net>
	<20111014192326.GA7713@sigill.intra.peff.net>
	<20111014210251.GD16371@elie.hsd1.il.comcast.net>
	<20111014211244.GA16429@sigill.intra.peff.net>
	<20111014211921.GB16429@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Oct 15 01:39:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RErLo-0000mt-4f
	for gcvg-git-2@lo.gmane.org; Sat, 15 Oct 2011 01:39:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754431Ab1JNXjf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Oct 2011 19:39:35 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:55119 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753902Ab1JNXje convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Oct 2011 19:39:34 -0400
Received: by qadb15 with SMTP id b15so1239520qad.19
        for <git@vger.kernel.org>; Fri, 14 Oct 2011 16:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Xhvya5UeIQW2Qy0JPNJYpQuiaB3K+9Nv/s2UQh+KhNY=;
        b=AdbCKXsjCqFZRUSNL+EzK11uSu6shd8Cm92rcTybBeIKe+v7D+fsCwNO1c5FP4CzfX
         l+VLxcqDOgx7sUaVffMz4XDoWip5sW9WjpOscUtbKZ6KGEChd1+8Vj4pDyIcK0X6CHid
         YCoNdU1TIogwphz1kOn4K2/BnHQmO1E4LdpyE=
Received: by 10.224.26.211 with SMTP id f19mr8832422qac.95.1318635574042; Fri,
 14 Oct 2011 16:39:34 -0700 (PDT)
Received: by 10.224.20.67 with HTTP; Fri, 14 Oct 2011 16:39:33 -0700 (PDT)
In-Reply-To: <20111014211921.GB16429@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183632>

On Sat, Oct 15, 2011 at 2:49 AM, Jeff King <peff@peff.net> wrote:
> When the git-daemon is asked about an inaccessible
> repository, it simply hangs up the connection without saying
> anything further. This makes it hard to distinguish between
> a repository we cannot access (e.g., due to typo), and a
> service or network outage.
>
> Instead, let's print an "ERR" line, which git clients
> understand since v1.6.1 (2008-12-24).
>
> Because there is a risk of leaking information about
> non-exported repositories, by default all errors simply say
> "access denied". Sites which don't have hidden repositories,

I suggest that even the "secure" version of the message say something
like "access denied or repository not exported".  You're still not
leaking anything, but it reduces confusion to the user, who otherwise
may not realise it *could be* the latter.

regards

sitaram

> or don't care, can pass a flag to turn on more specific
> messages.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Minor tweaks to the documentation and code style to make Jonathan hap=
py.
> :)
>
> Note: I labeled this "v3", as it is the third one posted, but the pri=
or
> ones were not labeled with versions at all.
>
> =C2=A0Documentation/git-daemon.txt | =C2=A0 10 ++++++++++
> =C2=A0daemon.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 | =C2=A0 25 +++++++++++++++++++++----
> =C2=A02 files changed, 31 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.=
txt
> index 69a1e4a..31b28fc 100644
> --- a/Documentation/git-daemon.txt
> +++ b/Documentation/git-daemon.txt
> @@ -161,6 +161,16 @@ the facility of inet daemon to achieve the same =
before spawning
> =C2=A0 =C2=A0 =C2=A0 =C2=A0repository configuration. =C2=A0By default=
, all the services
> =C2=A0 =C2=A0 =C2=A0 =C2=A0are overridable.
>
> +--informative-errors::
> +--no-informative-errors::
> + =C2=A0 =C2=A0 =C2=A0 When informative errors are turned on, git-dae=
mon will report
> + =C2=A0 =C2=A0 =C2=A0 more verbose errors to the client, differentia=
ting conditions
> + =C2=A0 =C2=A0 =C2=A0 like "no such repository" from "repository not=
 exported". This
> + =C2=A0 =C2=A0 =C2=A0 is more convenient for clients, but may leak i=
nformation about
> + =C2=A0 =C2=A0 =C2=A0 the existence of unexported repositories. =C2=A0=
When informative
> + =C2=A0 =C2=A0 =C2=A0 errors are not enabled, all errors report "acc=
ess denied" to the
> + =C2=A0 =C2=A0 =C2=A0 client. The default is --no-informative-errors=
=2E
> +
> =C2=A0<directory>::
> =C2=A0 =C2=A0 =C2=A0 =C2=A0A directory to add to the whitelist of all=
owed directories. Unless
> =C2=A0 =C2=A0 =C2=A0 =C2=A0--strict-paths is specified this will also=
 include subdirectories
> diff --git a/daemon.c b/daemon.c
> index 4c8346d..6f111af 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -20,6 +20,7 @@
> =C2=A0static int log_syslog;
> =C2=A0static int verbose;
> =C2=A0static int reuseaddr;
> +static int informative_errors;
>
> =C2=A0static const char daemon_usage[] =3D
> =C2=A0"git daemon [--verbose] [--syslog] [--export-all]\n"
> @@ -247,6 +248,14 @@ static int git_daemon_config(const char *var, co=
nst char *value, void *cb)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> =C2=A0}
>
> +static int daemon_error(const char *dir, const char *msg)
> +{
> + =C2=A0 =C2=A0 =C2=A0 if (!informative_errors)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg =3D "access de=
nied";
> + =C2=A0 =C2=A0 =C2=A0 packet_write(1, "ERR %s: %s", msg, dir);
> + =C2=A0 =C2=A0 =C2=A0 return -1;
> +}
> +
> =C2=A0static int run_service(char *dir, struct daemon_service *servic=
e)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *path;
> @@ -257,11 +266,11 @@ static int run_service(char *dir, struct daemon=
_service *service)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!enabled && !service->overridable) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0logerror("'%s'=
: service not enabled.", service->name);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0errno =3D EACC=
ES;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return daemon_erro=
r(dir, "service not enabled");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!(path =3D path_ok(dir)))
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return daemon_erro=
r(dir, "no such repository");
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Security on the cheap.
> @@ -277,7 +286,7 @@ static int run_service(char *dir, struct daemon_s=
ervice *service)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!export_all_trees && access("git-daemo=
n-export-ok", F_OK)) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0logerror("'%s'=
: repository not exported.", path);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0errno =3D EACC=
ES;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return daemon_erro=
r(dir, "repository not exported");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (service->overridable) {
> @@ -291,7 +300,7 @@ static int run_service(char *dir, struct daemon_s=
ervice *service)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0logerror("'%s'=
: service not enabled for '%s'",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 service->name, path);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0errno =3D EACC=
ES;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return daemon_erro=
r(dir, "service not enabled");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
> @@ -1167,6 +1176,14 @@ int main(int argc, char **argv)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0make_service_overridable(arg + 18, 0);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0continue;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!prefixcmp(arg=
, "--informative-errors")) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 informative_errors =3D 1;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 continue;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!prefixcmp(arg=
, "--no-informative-errors")) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 informative_errors =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 continue;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!strcmp(ar=
g, "--")) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0ok_paths =3D &argv[i+1];
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0break;
> --
> 1.7.6.4.37.g43b58b
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>



--=20
Sitaram
