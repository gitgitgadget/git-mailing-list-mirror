From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: [PATCH v2 1/2] sparse checkout: show error messages when worktree
 shaping fails
Date: Thu, 22 Sep 2011 13:57:19 -0600
Message-ID: <4E7B931F.5010600@workspacewhiz.com>
References: <7vk4911ux8.fsf@alter.siamese.dyndns.org> <1316690663-29382-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 22 21:56:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6pNx-0005S4-Oc
	for gcvg-git-2@lo.gmane.org; Thu, 22 Sep 2011 21:56:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753783Ab1IVT4h convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Sep 2011 15:56:37 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:36527 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753739Ab1IVT4g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Sep 2011 15:56:36 -0400
Received: (qmail 19700 invoked by uid 399); 22 Sep 2011 13:56:31 -0600
Received: from unknown (HELO ?192.168.1.10?) (jjensen@workspacewhiz.com@50.8.110.77)
  by hsmail.qwknetllc.com with ESMTPAM; 22 Sep 2011 13:56:31 -0600
X-Originating-IP: 50.8.110.77
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:6.0.2) Gecko/20110902 Thunderbird/6.0.2
In-Reply-To: <1316690663-29382-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181917>

----- Original Message -----
=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy
Date: 9/22/2011 5:24 AM
> diff --git a/unpack-trees.c b/unpack-trees.c
> index cc616c3..fcf40a0 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -1089,6 +1089,7 @@ int unpack_trees(unsigned len, struct tree_desc=
 *t, struct unpack_trees_options
>   		 */
>   		mark_new_skip_worktree(o->el,&o->result, CE_ADDED, CE_SKIP_WORKTR=
EE | CE_NEW_SKIP_WORKTREE);
>
> +		ret =3D 0;
>   		for (i =3D 0; i<  o->result.cache_nr; i++) {
>   			struct cache_entry *ce =3D o->result.cache[i];
>
> @@ -1101,17 +1102,23 @@ int unpack_trees(unsigned len, struct tree_de=
sc *t, struct unpack_trees_options
>   			 * correct CE_NEW_SKIP_WORKTREE
>   			 */
>   			if (ce->ce_flags&  CE_ADDED&&
> -			    verify_absent(ce, ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN, o))
> -					return -1;
> +			    verify_absent(ce, ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN, o))=
 {
> +				if (!o->show_all_errors)
> +					goto return_failed;
> +				ret =3D -1;
> +			}
>
>   			if (apply_sparse_checkout(ce, o)) {
> +				if (!o->show_all_errors)
> +					goto return_failed;
>   				ret =3D -1;
> -				goto done;
>   			}
>   			if (!ce_skip_worktree(ce))
>   				empty_worktree =3D 0;
>
>   		}
> +		if (ret<  0)
> +			goto return_failed;
>   		if (o->result.cache_nr&&  empty_worktree) {
>   			/* dubious---why should this fail??? */
>   			ret =3D unpack_failed(o, "Sparse checkout leaves no entry on wor=
king directory");
I can confirm that this version of the patch works for me with multiple=
=20
untracked files in a sparse checkout.

-Josh
