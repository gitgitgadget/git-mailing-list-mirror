From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 6/6] mktree --missing: allow missing objects
Date: Mon, 11 May 2009 00:13:41 +0200
Message-ID: <4A075195.5020508@lsrfire.ath.cx>
References: <1241981391-19639-1-git-send-email-gitster@pobox.com> <1241981391-19639-2-git-send-email-gitster@pobox.com> <1241981391-19639-3-git-send-email-gitster@pobox.com> <1241981391-19639-4-git-send-email-gitster@pobox.com> <1241981391-19639-5-git-send-email-gitster@pobox.com> <1241981391-19639-6-git-send-email-gitster@pobox.com> <1241981391-19639-7-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 11 00:14:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3HHd-00026Q-UV
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 00:14:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753341AbZEJWN7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 May 2009 18:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752504AbZEJWN6
	(ORCPT <rfc822;git-outgoing>); Sun, 10 May 2009 18:13:58 -0400
Received: from india601.server4you.de ([85.25.151.105]:55139 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751480AbZEJWN6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2009 18:13:58 -0400
Received: from [10.0.1.101] (p57B7FBC9.dip.t-dialin.net [87.183.251.201])
	by india601.server4you.de (Postfix) with ESMTPSA id B71312F8062;
	Mon, 11 May 2009 00:13:55 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <1241981391-19639-7-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118752>

Junio C Hamano schrieb:
> -static void mktree_line(char *buf, size_t len, int line_termination)
> +static void mktree_line(char *buf, size_t len, int line_termination,=
 int allow_missing)
>  {
>  	char *ptr, *ntr;
>  	unsigned mode;
> @@ -92,9 +92,12 @@ static void mktree_line(char *buf, size_t len, int=
 line_termination)
> =20
>  	/* It is perfectly normal if we do not have a commit from a submodu=
le */
>  	if (!S_ISGITLINK(mode))
> +		allow_missing =3D 1;
> +
> +	if (!allow_missing)
>  		type =3D sha1_object_info(sha1, NULL);
>  	else
> -		type =3D OBJ_COMMIT;
> +		type =3D object_type(mode);
> =20
>  	if (type < 0)
>  		die("object %s unavailable", sha1_to_hex(sha1));

Don't you need this, above?

-  	if (!S_ISGITLINK(mode))
+	if (S_ISGITLINK(mode))

Ren=E9
