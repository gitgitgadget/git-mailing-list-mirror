From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@fzi.de>
Subject: Re: [PATCH v3] build: add default aliases
Date: Tue, 24 Sep 2013 17:21:40 +0200
Message-ID: <20130924152140.GA4259@goldbirke>
References: <1379791221-29925-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 24 17:21:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOUQx-0002hL-3z
	for gcvg-git-2@plane.gmane.org; Tue, 24 Sep 2013 17:21:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753153Ab3IXPVr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Sep 2013 11:21:47 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:50968 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752809Ab3IXPVq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Sep 2013 11:21:46 -0400
Received: from localhost6.localdomain6 (94-21-232-163.pool.digikabel.hu [94.21.232.163])
	by mrelayeu.kundenserver.de (node=mreu4) with ESMTP (Nemesis)
	id 0LmAly-1Vy6AJ0fOE-00Zuhn; Tue, 24 Sep 2013 17:21:41 +0200
Content-Disposition: inline
In-Reply-To: <1379791221-29925-1-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:lNYGTPqPnq7w6KrHvg754b/TdClnxqpD8/1xQq3Xu6/
 9r2WaVL1PsHdunVpXZ1JHFF43NJWLm+OzY64twwvZKtkxQa9y0
 pQj7IxpiE2ZLUIvHBsiwijn137X38wC3y7WreCr1/3Sd/VJLSz
 AF63F+z6STX1J0Gm+yzNN+0CcX1hsrUFkaqO3FtRYtjGxjANd+
 JGx6QyyAi6k6V7aZswYAhqZGUwd6N6pBZygqy5xV3AQfitwXBi
 rGeNLOSDE58yBKQwD5R42xPtxD9w4Tx/crfi+7UZgJNurgvLwc
 V2maZ9rpJSq8otIuXE6cJfDG1uR/bs6KIQG/cQhxitm7G9PuCC
 gei392v09LYejf2xRhbQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235304>

The subject line needs to be updated.

On Sat, Sep 21, 2013 at 02:20:21PM -0500, Felipe Contreras wrote:
> For now simply add a few common aliases.
>=20
>   co =3D checkout
>   ci =3D commit
>   rb =3D rebase
>   st =3D status
>=20
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---

[...]

> diff --git a/alias.c b/alias.c
> index eb9f08b..d6bad69 100644
> --- a/alias.c
> +++ b/alias.c
> @@ -14,11 +14,28 @@ static int alias_lookup_cb(const char *k, const c=
har *v, void *cb)
>  	return 0;
>  }
> =20
> +static struct {
> +	const char *key;
> +	const char *val;
> +} default_aliases[] =3D {
> +	{ "co", "checkout" },
> +	{ "ci", "checkout" },
> +	{ "rb", "rebase" },
> +	{ "st", "status" },
> +};
> +
>  char *alias_lookup(const char *alias)
>  {
> +	int i;
>  	alias_key =3D alias;
>  	alias_val =3D NULL;
>  	git_config(alias_lookup_cb, NULL);
> +	if (alias_val)
> +		return alias_val;
> +	for (i =3D 0; i < ARRAY_SIZE(default_aliases); i++) {
> +		if (!strcmp(alias, default_aliases[i].key))
> +			return xstrdup(default_aliases[i].val);
> +	}
>  	return alias_val;
>  }

Aliases implemented this way don't work the same way as "normal"
aliases do:

  $ # which aliases do I have?
  $ ./bin-wrappers/git config --get-regexp "alias\..*"
  $ # no aliases at all
  $ # does completion work?
  $ ./bin-wrappers/git co ma<TAB>
  mailmap.c      mailmap.h      mailmap.o      match-trees.c  match-tre=
es.o
  $ # no refs completion
  $ # let's see a real alias
  $ git config alias.co checkout
  $ ./bin-wrappers/git config --get-regexp "alias\..*"
  alias.co checkout
  $ ./bin-wrappers/git co ma<TAB>
  maint    master
  $ # as expected


Best,
G=E1bor
