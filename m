From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH nd/split-index] fixup! read-cache: new API write_locked_index
 instead of write_index/write_cache
Date: Mon, 02 Jun 2014 16:12:01 +0100
Message-ID: <538C9441.3010804@ramsay1.demon.co.uk>
References: <CACsJy8Ad+hfmJSgKX6O9FTXggUjyMkpJLzf=awnV5oFACsX+vQ@mail.gmail.com> <1401583635-1332-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 02 17:12:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrTuG-0002PN-Nw
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jun 2014 17:12:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752289AbaFBPMI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Jun 2014 11:12:08 -0400
Received: from mdfmta005.mxout.tch.inty.net ([91.221.169.46]:58994 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751848AbaFBPMH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2014 11:12:07 -0400
Received: from mdfmta005.tch.inty.net (unknown [127.0.0.1])
	by mdfmta005.tch.inty.net (Postfix) with ESMTP id 4CE5C18CDBC;
	Mon,  2 Jun 2014 16:12:04 +0100 (BST)
Received: from mdfmta005.tch.inty.net (unknown [127.0.0.1])
	by mdfmta005.tch.inty.net (Postfix) with ESMTP id 0824418CDDA;
	Mon,  2 Jun 2014 16:12:04 +0100 (BST)
Received: from [192.168.254.3] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta005.tch.inty.net (Postfix) with ESMTP;
	Mon,  2 Jun 2014 16:12:03 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <1401583635-1332-1-git-send-email-pclouds@gmail.com>
X-MDF-HostID: 18
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250569>

On 01/06/14 01:47, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  I intended it resend the series after the comments I received, but i=
t
>  looks like Junio has picked up all comments except this one, so
>  here's the fix.
>=20
>  sequencer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/sequencer.c b/sequencer.c
> index 377c877..4b709db 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -672,7 +672,7 @@ static void prepare_revs(struct replay_opts *opts=
)
>  static void read_and_refresh_cache(struct replay_opts *opts)
>  {
>  	static struct lock_file index_lock;
> -	hold_locked_index(&index_lock, 0);
> +	int index_fd =3D hold_locked_index(&index_lock, 0);
>  	if (read_index_preload(&the_index, NULL) < 0)
>  		die(_("git %s: failed to read the index"), action_name(opts));
>  	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, NULL, NUL=
L, NULL);
>=20

Yep, this silences sparse. I would have declared the variable to be
(say) fd (and changed the _use_ site as well, of course!), rather
than once again hiding the index_fd() global function. However, this
is perfectly fine as-is.

The actual culprit is the index_fd() global function, but renaming it
now is probably not worth the code churn (and I'm lazy). ;-)

Thanks!

ATB,
Ramsay Jones
