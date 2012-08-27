From: Florian Achleitner <florian.achleitner2.6.31@gmail.com>
Subject: Re: [PATCH] vcs-svn: Fix 'fa/remote-svn' and 'fa/vcs-svn' in pu
Date: Mon, 27 Aug 2012 09:44:08 +0200
Message-ID: <22437025.vxzLHcuBYA@flomedio>
References: <50366E9B.7040803@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: florian.achleitner.2.6.31@gmail.com,
	GIT Mailing-list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Mon Aug 27 09:45:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5u0I-0003WA-Bu
	for gcvg-git-2@plane.gmane.org; Mon, 27 Aug 2012 09:44:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753231Ab2H0Hon convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Aug 2012 03:44:43 -0400
Received: from mailrelay.tu-graz.ac.at ([129.27.2.202]:25904 "EHLO
	mailrelay.tugraz.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753108Ab2H0HoR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Aug 2012 03:44:17 -0400
Received: from flomedio.localnet (cm56-227-93.liwest.at [86.56.227.93])
	(authenticated bits=0)
	by mailrelay2.tugraz.at (8.14.4/8.14.4) with ESMTP id q7R7i9UR016072
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 27 Aug 2012 09:44:09 +0200 (CEST)
User-Agent: KMail/4.8.4 (Linux/3.0.0-25-generic; KDE/4.8.4; x86_64; ; )
In-Reply-To: <50366E9B.7040803@ramsay1.demon.co.uk>
X-TUG-Backscatter-control: qyH/vN2riZ/masrHmZoJqQ
X-Spam-Scanner: SpamAssassin 3.003000 
X-Spam-Score-relay: 0.6
X-Scanned-By: MIMEDefang 2.70 on 129.27.10.19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204327>

Hi!

Thanks for your fixups. I'm currently integrating them in a new series.
On what platform did you find that problems?=20
Tried to reproduce them on 64bit Linux. Anyways the fixes look very rea=
sonable.

=46lorian

On Thursday 23 August 2012 18:55:39 Ramsay Jones wrote:
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> ---
>=20
> Hi Florian,
>=20
> The build on pu is currently broken:
>=20
>         CC remote-testsvn.o
>         LINK git-remote-testsvn
>     cc: vcs-svn/lib.a: No such file or directory
>     make: *** [git-remote-testsvn] Error 1
>=20
> This is caused by a dependency missing from the git-remote-testsvn
> link rule. The addition of the $(VCSSVN_LIB) dependency, which should
> be squashed into commit ea1f4afb ("Add git-remote-testsvn to Makefile=
",
> 20-08-2012), fixes the build.
>=20
> However, this leads to a failure of test t9020.5 and (not unrelated)
> compiler warnings:
>=20
>         CC vcs-svn/svndump.o
>     vcs-svn/svndump.c: In function =E2=80=98handle_node=E2=80=99:
>     vcs-svn/svndump.c:246: warning: left shift count >=3D width of ty=
pe
>     vcs-svn/svndump.c:345: warning: format =E2=80=98%lu=E2=80=99 expe=
cts type =E2=80=98long \
>         unsigned int=E2=80=99, but argument 3 has type =E2=80=98uintm=
ax_t=E2=80=99
>=20
> The fix for the shift count warning is to cast the lhs of the shift
> expression to uintmax_t. The format warning is fixed by using the
> PRIuMAX format macro. These fixes should be squashed into commit
> 78d9d4138 ("vcs-svn/svndump: rewrite handle_node(), begin|end_revisio=
n()",
> 20-08-2012).
>=20
> HTH
>=20
> ATB,
> Ramsay Jones
>=20
>  Makefile          | 2 +-
>  vcs-svn/svndump.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/Makefile b/Makefile
> index 9cede84..761ae05 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2356,7 +2356,7 @@ git-http-push$X: revision.o http.o http-push.o
> GIT-LDFLAGS $(GITLIBS) $(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@
> $(ALL_LDFLAGS) $(filter %.o,$^) \ $(LIBS) $(CURL_LIBCURL) $(EXPAT_LIB=
EXPAT)
>=20
> -git-remote-testsvn$X: remote-testsvn.o GIT-LDFLAGS $(GITLIBS)
> +git-remote-testsvn$X: remote-testsvn.o GIT-LDFLAGS $(GITLIBS) $(VCSS=
VN_LIB)
> $(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^=
)
> $(LIBS) \ $(VCSSVN_LIB)
>=20
> diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
> index 28ce2aa..eb97e8e 100644
> --- a/vcs-svn/svndump.c
> +++ b/vcs-svn/svndump.c
> @@ -243,7 +243,7 @@ static void handle_node(struct node_ctx_t *node)
>  	const char *old_data =3D NULL;
>  	uint32_t old_mode =3D REPO_MODE_BLB;
>  	struct strbuf sb =3D STRBUF_INIT;
> -	static uintmax_t blobmark =3D 1UL << (bitsizeof(uintmax_t) - 1);
> +	static uintmax_t blobmark =3D (uintmax_t) 1UL << (bitsizeof(uintmax=
_t) - 1);
>=20
>=20
>  	if (have_text && type =3D=3D REPO_MODE_DIR)
> @@ -342,7 +342,7 @@ static void handle_node(struct node_ctx_t *node)
>  						node->text_length, &input);
>  			}
>=20
> -			strbuf_addf(&sb, ":%lu", blobmark);
> +			strbuf_addf(&sb, ":%"PRIuMAX, blobmark);
>  			node->dataref =3D sb.buf;
>  		}
>  	}
