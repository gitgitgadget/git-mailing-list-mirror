From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH v2] status: always report ignored tracked directories
Date: Mon, 07 Jan 2013 18:21:13 +0100
Message-ID: <50EB0409.1090307@web.de>
References: <20130105230303.GA5195@sigill.intra.peff.net> <1357510179-22852-1-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, tboegi@web.de, git@vger.kernel.org
To: Antoine Pelisse <apelisse@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 07 18:21:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsGOS-0000YL-7T
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jan 2013 18:21:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502Ab3AGRV0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Jan 2013 12:21:26 -0500
Received: from mout.web.de ([212.227.17.11]:56850 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754644Ab3AGRVZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2013 12:21:25 -0500
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb102)
 with ESMTPA (Nemesis) id 0MTPit-1TSF5U1jJX-00SZHd; Mon, 07 Jan 2013 18:21:12
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <1357510179-22852-1-git-send-email-apelisse@gmail.com>
X-Provags-ID: V02:K0:pEh3pWEbefcbhMUNjyss6SPbGLTXhoxGTBY/ndMcpYc
 L8+TLHN5a4APkdIYGri3+rDB2I5XEWOhRdaLhgFeCpjnGyqUw5
 WjPRi9i3xoGC8ua8YcFPIPzubxtOuGfkyGAMJpwFGl9Q2w8jMP
 2sj9PmBh8375K2ZyhxbB5CSTYqPEQAejo3kaDkpUK7Uc5vTP1g
 x3SFIo4SdHkb4DzdOsWhA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212905>

On 06.01.13 23:09, Antoine Pelisse wrote:
[snip]
> Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
> ---
>  dir.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/dir.c b/dir.c
> index 9b80348..f836590 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -672,7 +672,8 @@ static struct dir_entry *dir_entry_new(const char=
 *pathname, int len)
>
>  static struct dir_entry *dir_add_name(struct dir_struct *dir, const =
char *pathname, int len)
>  {
> -	if (cache_name_exists(pathname, len, ignore_case))
> +	if (!(dir->flags & DIR_SHOW_IGNORED) &&
> +	    cache_name_exists(pathname, len, ignore_case))
>  		return NULL;
>
>  	ALLOC_GROW(dir->entries, dir->nr+1, dir->alloc);
> @@ -877,11 +878,7 @@ static int treat_file(struct dir_struct *dir, st=
ruct strbuf *path, int exclude,
>  	if (exclude)
>  		exclude_file =3D !(dir->flags & DIR_SHOW_IGNORED);
>  	else if (dir->flags & DIR_SHOW_IGNORED) {
> -		/*
> -		 * Optimization:
> -		 * Don't spend time on indexed files, they won't be
> -		 * added to the list anyway
> -		 */
> +		/* Always exclude indexed files */
>  		struct cache_entry *ce =3D index_name_exists(&the_index,
>  		    path->buf, path->len, ignore_case);
>
> --
> 1.7.12.4.3.g90f5e2d
>
The bad news: the patch does not apply.
The good news: t7061 passes on pu,
and dir.c seems to be changes as needed:

commit 1f4e17c6c9833f17dc6bbf045f8a8d6378dcb417
Merge: dee1fa4 cc37e5b
Author: Junio C Hamano <gitster@pobox.com>
Date: Sun Jan 6 23:46:29 2013 -0800

Merge branch 'nd/parse-pathspec' into pu

which comes from Duy:

commit cc37e5bf18ca11d9a884bddfebcdff61df3e6279
Author: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
Date: Sun Jan 6 13:21:08 2013 +0700

Convert more init_pathspec() to parse_pathspec()
