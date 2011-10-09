From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 1/3] traverse_trees(): allow pruning with pathspec
Date: Sun, 09 Oct 2011 17:39:29 +0200
Message-ID: <4E91C031.9030205@alum.mit.edu>
References: <7vty9054qr.fsf@alter.siamese.dyndns.org> <1314653603-7533-1-git-send-email-gitster@pobox.com> <1314653603-7533-2-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 09 17:39:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCvTg-0001tl-H4
	for gcvg-git-2@lo.gmane.org; Sun, 09 Oct 2011 17:39:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751906Ab1JIPjk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Oct 2011 11:39:40 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:54611 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751726Ab1JIPjk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Oct 2011 11:39:40 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.134] (p54BEDFD0.dip.t-dialin.net [84.190.223.208])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p99FdVe3024801
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 9 Oct 2011 17:39:32 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
In-Reply-To: <1314653603-7533-2-git-send-email-gitster@pobox.com>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183203>

On 08/29/2011 11:33 PM, Junio C Hamano wrote:
> diff --git a/tree-walk.c b/tree-walk.c
> index 33f749e..808bb55 100644
> --- a/tree-walk.c
> +++ b/tree-walk.c
> [...]
> @@ -376,16 +396,22 @@ int traverse_trees(int n, struct tree_desc *t, =
struct traverse_info *info)
>  			mask |=3D 1ul << i;
>  			if (S_ISDIR(entry[i].mode))
>  				dirmask |=3D 1ul << i;
> +			e =3D &entry[i];
>  		}
>  		if (!mask)
>  			break;
> -		ret =3D info->fn(n, mask, dirmask, entry, info);
> -		if (ret < 0) {
> -			error =3D ret;
> -			if (!info->show_all_errors)
> -				break;
> +		interesting =3D prune_traversal(e, info, &base, interesting);

According to gcc 4.2.4 (though, strangely, not gcc 4.4.3):

tree-walk.c: In function =91traverse_trees=92:
tree-walk.c:347: warning: =91e=92 may be used uninitialized in this fun=
ction

Michael

--=20
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
