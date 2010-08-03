From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC/PATCH] git-compat-util.h: Don't define NORETURN under __clang__
Date: Tue, 03 Aug 2010 15:18:41 +0200
Message-ID: <4C581731.7060808@drmicha.warpmail.net>
References: <1280840883-24540-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 03 15:18:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgHO8-0003l0-GU
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 15:18:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755314Ab0HCNSb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Aug 2010 09:18:31 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:41819 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751668Ab0HCNSa (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Aug 2010 09:18:30 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 316161A2975;
	Tue,  3 Aug 2010 09:18:30 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 03 Aug 2010 09:18:30 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=YLMPbbQyuiWBDMZu8TMzBwN2PtU=; b=pSRuZdOeDcHyiGECbh5woE9+7vNDh3q6/vTzsuVWGZ8p7el/r/ONg9TvxU1bnPxKWZe4HTJnqIwI8Kc9xAQfQrdozYGRno/UiGxdgw2VHK5xmLQFU4AAJOMzqgKq8um2XCYsyIg710kCFyC1+zvbAOXWlOsuuUZJCT9dRXzzue0=
X-Sasl-enc: H0rgXTtGyJZv3VucZBF7BiWiCB9neD6VsntWQXQ5BO56 1280841509
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 631044EB1B2;
	Tue,  3 Aug 2010 09:18:29 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.8pre) Gecko/20100714 Lightning/1.0b2pre Lanikai/3.1.2pre
In-Reply-To: <1280840883-24540-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152514>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason venit, vidit, dixit 03.08.2010 1=
5:08:
> clang version 1.0 on Debian testing x86_64 defines __GNUC__, but barf=
s
> on `void __attribute__((__noreturn__))'. E.g.:
>=20
>     usage.c:56:1: error: function declared 'noreturn' should not retu=
rn [-Winvalid-noreturn]
>     }
>     ^
>     1 diagnostic generated.
>     make: *** [usage.o] Error 1
>=20
> There it's dying on `void __attribute__((__noreturn__)) usagef(const
> char *err, ...)' in usage.c, which doesn't return.
>=20
> Change the header to define NORETURN to nothing under clang. This was
> the default behavior for non-GNU and non-MSC compilers already. Havin=
g
> NORETURN_PTR defined to the GNU C value has no effect on clang
> however.
>=20
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.c=
om>
> ---
>=20
> I have no experience with Clang so this may not be sane, but on my
> system clang compiles with it and passes all tests. It still spews a
> lot of warnings though:
>    =20
>     GITGUI_VERSION =3D 0.12.0.64.g89d61
>         * new build flags or prefix
>     config.c:297:1: warning: control may reach end of non-void functi=
on [-Wreturn-type]
>     }
>     ^
>     1 diagnostic generated.
>     connect.c:151:1: warning: control may reach end of non-void funct=
ion [-Wreturn-type]
>     }
>     ^
>     1 diagnostic generated.
>     date.c:678:1: warning: control may reach end of non-void function=
 [-Wreturn-type]
>     }
>     ^
>     1 diagnostic generated.
>     diff.c:429:1: warning: control may reach end of non-void function=
 [-Wreturn-type]
>     }
>     ^
>     1 diagnostic generated.
>=20
> These are valid, as control may not return the advertised type if we
> call die() inside them.
>=20
>     log-tree.c:297:21: warning: field width should have type 'int', b=
ut argument has type 'unsigned int' [-Wformat]
>                              "Subject: [%s %0*d/%d] ",
>                                              ^
>     1 diagnostic generated.
>     notes.c:632:25: warning: field precision should have type 'int', =
but argument has type 'unsigned int' [-Wformat]
>             strbuf_addf(buf, "%o %.*s%c", mode, path_len, path, '\0')=
;
>                                    ^            ~~~~~~~~
>     1 diagnostic generated.
>=20
> Should these (and some below) just cast to (int) ?
>=20
>     object.c:44:1: warning: control may reach end of non-void functio=
n [-Wreturn-type]
>     }
>     ^
>     1 diagnostic generated.
>     parse-options.c:155:1: warning: control may reach end of non-void=
 function [-Wreturn-type]
>     }
>     ^
>     1 diagnostic generated.
>     read-cache.c:1361:1: warning: control may reach end of non-void f=
unction [-Wreturn-type]
>     }
>     ^
>     1 diagnostic generated.
>     remote.c:658:1: warning: control may reach end of non-void functi=
on [-Wreturn-type]
>     }
>     ^
>     1 diagnostic generated.
>     revision.c:253:1: warning: control may reach end of non-void func=
tion [-Wreturn-type]
>     }
>     ^
>     1 diagnostic generated.
>     setup.c:79:1: warning: control may reach end of non-void function=
 [-Wreturn-type]
>     }
>     ^
>     1 diagnostic generated.
>     sideband.c:97:25: warning: field precision should have type 'int'=
, but argument has type 'unsigned int' [-Wformat]
>                                             fprintf(stderr, "%.*s", b=
rk + sf, b);
>                                                                ^    ~=
~~~~~~~
>     1 diagnostic generated.
>     transport.c:1133:1: warning: control may reach end of non-void fu=
nction [-Wreturn-type]
>     }
>     ^
>     1 diagnostic generated.
>     imap-send.c:548:27: warning: more data arguments than '%' convers=
ions [-Wformat-extra-args]
>                                cmd->tag, cmd->cmd, cmd->cb.dlen);
>                                                    ^
>     1 diagnostic generated.
>     Writing perl.mak for Git
>     GIT_VERSION =3D 1.7.2.1.7.gb44c1
>     builtin/blame.c:1984:1: warning: control may reach end of non-voi=
d function [-Wreturn-type]
>     }
>     ^
>     1 diagnostic generated.
>     builtin/bundle.c:67:1: warning: control may reach end of non-void=
 function [-Wreturn-type]
>     }
>     ^
>     1 diagnostic generated.
>     builtin/commit.c:832:1: warning: control may reach end of non-voi=
d function [-Wreturn-type]
>     }
>     ^
>     1 diagnostic generated.
>     builtin/fetch-pack.c:209:1: warning: control may reach end of non=
-void function [-Wreturn-type]
>     }
>     ^
>     1 diagnostic generated.
>     builtin/grep.c:704:1: warning: control may reach end of non-void =
function [-Wreturn-type]
>     }
>     ^
>     1 diagnostic generated.
>     builtin/help.c:58:1: warning: control may reach end of non-void f=
unction [-Wreturn-type]
>     }
>     ^
>     1 diagnostic generated.
>     builtin/pack-redundant.c:584:1: warning: control may reach end of=
 non-void function [-Wreturn-type]
>     }
>     ^
>     1 diagnostic generated.
>     builtin/push.c:252:1: warning: control may reach end of non-void =
function [-Wreturn-type]
>     }
>     ^
>     1 diagnostic generated.
>     builtin/reflog.c:782:1: warning: control may reach end of non-voi=
d function [-Wreturn-type]
>     }
>     ^
>     1 diagnostic generated.
>    =20
>  git-compat-util.h |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
>=20
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 02a73ee..c651cb7 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -183,7 +183,10 @@ extern char *gitbasename(char *);
>  #define is_dir_sep(c) ((c) =3D=3D '/')
>  #endif
> =20
> -#ifdef __GNUC__
> +#ifdef __clang__
> +#define NORETURN
> +#define NORETURN_PTR __attribute__((__noreturn__))
> +#elif __GNUC__

__GNUC__ should be true if defined, but maybe you still want

+#elif defined(__GNUC__)

instead to make this really equivalent in the GNUC case.

>  #define NORETURN __attribute__((__noreturn__))
>  #define NORETURN_PTR __attribute__((__noreturn__))
>  #elif defined(_MSC_VER)

Michael
