From: konglu@minatec.inpg.fr
Subject: Re: [PATCH] git-status: Show empty directories
Date: Sat, 09 Jun 2012 22:13:15 +0200
Message-ID: <20120609221315.Horde.fN5FP3wdC4BP065b3FviijA@webmail.minatec.grenoble-inp.fr>
References: <1339270806-65013-1-git-send-email-muhtasib@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Leila Muhtasib <muhtasib@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 09 22:32:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SdSKl-0004nn-5h
	for gcvg-git-2@plane.gmane.org; Sat, 09 Jun 2012 22:32:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751895Ab2FIUbt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Jun 2012 16:31:49 -0400
Received: from v-smtp.minatec.grenoble-inp.fr ([147.173.216.28]:32785 "EHLO
	v-smtp.minatec.grenoble-inp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751299Ab2FIUbs (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Jun 2012 16:31:48 -0400
Received: from localhost (www02.minatec.grenoble-inp.fr [147.173.216.15])
	by v-smtp.minatec.grenoble-inp.fr (Postfix) with ESMTP id 6DEA41A0FEF;
	Sat,  9 Jun 2012 22:13:16 +0200 (CEST)
Received: from reverse.completel.net (reverse.completel.net [92.103.38.66])
 by webmail.minatec.grenoble-inp.fr (Horde Framework) with HTTP; Sat, 09 Jun
 2012 22:13:15 +0200
In-Reply-To: <1339270806-65013-1-git-send-email-muhtasib@gmail.com>
User-Agent: Internet Messaging Program (IMP) H4 (5.0.17)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199556>


Leila Muhtasib <muhtasib@gmail.com> a =E9crit=A0:

>  wt-status.c |   24 +++++++++++++++++++-----
>  1 files changed, 19 insertions(+), 5 deletions(-)

Do not forget to also update the test that need 'git
status'. For example, most of the tests in t7508 are
broken with your patch (the change is not huge, just
adding "and directories" at the end of "untracked files:"
here and there and maybe some other minor details).
Otherwise, the idea seems good to me :).

>  	for (i =3D 0; i < dir.nr; i++) {
>  		struct dir_entry *ent =3D dir.entries[i];
>  		if (cache_name_is_other(ent->name, ent->len) &&
> -		    match_pathspec(s->pathspec, ent->name, ent->len, 0, NULL))
> -			string_list_insert(&s->untracked, ent->name);
> +		    match_pathspec(s->pathspec, ent->name, ent->len, 0, NULL)) {
> +			if (is_empty_dir(ent->name)) {
> +				struct strbuf buf_name =3D STRBUF_INIT;
> +				strbuf_addstr(&buf_name, ent->name);
> +				strbuf_addstr(&buf_name, " (empty directories cannot be added)")=
;
> +				string_list_insert(&s->untracked, buf_name.buf);
> +				strbuf_release(&buf_name);
> +			}
> +			else
> +				string_list_insert(&s->untracked, ent->name);

The structure is
       if (...) {
              /*code*/
       } else {
              /*code*/
       }

Do not forget braces in the "else" part as the firt block needs it.
