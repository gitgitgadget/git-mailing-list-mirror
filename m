From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v2 2/2] gc: config option for running --auto in background
Date: Mon, 10 Feb 2014 12:03:08 +0100
Message-ID: <CABPQNSb3=i8F+vPEG3RmH+snZVZ-xrPtcVY2Nx9uvyTCLXcy6g@mail.gmail.com>
References: <xmqqd2j2afup.fsf@gitster.dls.corp.google.com> <1391843332-20583-1-git-send-email-pclouds@gmail.com>
 <1391843332-20583-2-git-send-email-pclouds@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, jugg@hotmail.com
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 10 12:03:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCoeY-0005qb-Am
	for gcvg-git-2@plane.gmane.org; Mon, 10 Feb 2014 12:03:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752147AbaBJLDu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Feb 2014 06:03:50 -0500
Received: from mail-ob0-f170.google.com ([209.85.214.170]:33347 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751889AbaBJLDt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Feb 2014 06:03:49 -0500
Received: by mail-ob0-f170.google.com with SMTP id va2so7043453obc.1
        for <git@vger.kernel.org>; Mon, 10 Feb 2014 03:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=MeJo/jbmWyjVI7GDko1nzP3KceeI0ygqBWueX7/3RrA=;
        b=n24CFAnAnX2itI8mQTYWDlSMaoNmnSoKVnVdwCUMEOYJqM6PUy3BSaMCXcFO9MW0ko
         1kRrAWkH7SwQTl5cR9l3azcPZE21wXPQM9XAaIHALx/qVqJyZ1pl3DBkIZPVVEilT28Y
         YfCVUiSzS4APLhbEh6k1KeL+mTUCvHc1/pK6eviIUkfAq/pdxyDaF5YLz0nqQi5BCbmx
         80DG1+VlgoOTSrhElzzLzgGUqOQX4k2MAGjD+Vhd7e9aJvYRGRRflhyDK4AvPm0etQ0X
         SpqzPxnrk/srB2lBFwX//PWfGGCRYN2kunnErhQzoLzOoYhdkjlMDe8mJA+JgiDgIfLg
         jAlg==
X-Received: by 10.60.142.166 with SMTP id rx6mr658357oeb.57.1392030228647;
 Mon, 10 Feb 2014 03:03:48 -0800 (PST)
Received: by 10.76.85.103 with HTTP; Mon, 10 Feb 2014 03:03:08 -0800 (PST)
In-Reply-To: <1391843332-20583-2-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241907>

On Sat, Feb 8, 2014 at 8:08 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> `gc --auto` takes time and can block the user temporarily (but not an=
y
> less annoyingly). Make it run in background on systems that support
> it. The only thing lost with running in background is printouts. But
> gc output is not really interesting. You can keep it in foreground by
> changing gc.autodetach.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Documentation/config.txt |  4 ++++
>  builtin/gc.c             | 23 ++++++++++++++++++-----
>  t/t5400-send-pack.sh     |  1 +
>  3 files changed, 23 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 5f4d793..4781773 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1167,6 +1167,10 @@ gc.autopacklimit::
>         --auto` consolidates them into one larger pack.  The
>         default value is 50.  Setting this to 0 disables it.
>
> +gc.autodetach::
> +       Make `git gc --auto` return immediately andrun in background
> +       if the system supports it. Default is true.
> +
>  gc.packrefs::
>         Running `git pack-refs` in a repository renders it
>         unclonable by Git versions prior to 1.5.1.2 over dumb
> diff --git a/builtin/gc.c b/builtin/gc.c
> index c19545d..ed5cc3c 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -29,6 +29,7 @@ static int pack_refs =3D 1;
>  static int aggressive_window =3D 250;
>  static int gc_auto_threshold =3D 6700;
>  static int gc_auto_pack_limit =3D 50;
> +static int detach_auto =3D 1;
>  static const char *prune_expire =3D "2.weeks.ago";
>
>  static struct argv_array pack_refs_cmd =3D ARGV_ARRAY_INIT;
> @@ -73,6 +74,10 @@ static int gc_config(const char *var, const char *=
value, void *cb)
>                 gc_auto_pack_limit =3D git_config_int(var, value);
>                 return 0;
>         }
> +       if (!strcmp(var, "gc.autodetach")) {
> +               detach_auto =3D git_config_bool(var, value);
> +               return 0;
> +       }
>         if (!strcmp(var, "gc.pruneexpire")) {
>                 if (value && strcmp(value, "now")) {
>                         unsigned long now =3D approxidate("now");
> @@ -301,11 +306,19 @@ int cmd_gc(int argc, const char **argv, const c=
har *prefix)
>                  */
>                 if (!need_to_gc())
>                         return 0;
> -               if (!quiet)
> -                       fprintf(stderr,
> -                                       _("Auto packing the repositor=
y for optimum performance. You may also\n"
> -                                       "run \"git gc\" manually. See=
 "
> -                                       "\"git help gc\" for more inf=
ormation.\n"));
> +               if (!quiet) {
> +                       if (detach_auto)
> +                               fprintf(stderr, _("Auto packing the r=
epository in background for optimum performance.\n"));
> +                       else
> +                               fprintf(stderr, _("Auto packing the r=
epository for optimum performance.\n"));
> +                       fprintf(stderr, _("See \"git help gc\" for ma=
nual housekeeping.\n"));
> +               }
> +               if (detach_auto)
> +                       /*
> +                        * failure to daemonize is ok, we'll continue
> +                        * in foreground
> +                        */
> +                       daemonize();

While I agree that it should be OK, shouldn't we warn the user?
