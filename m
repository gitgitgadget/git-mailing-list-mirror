From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Can't find the revelant commit with git-log
Date: Tue, 01 Feb 2011 13:28:32 -0800
Message-ID: <7vr5brzbpb.fsf@alter.siamese.dyndns.org>
References: <m2ipxd2w78.fsf@gmail.com> <4D3EF650.20407@lsrfire.ath.cx>
 <m2ipxc27zi.fsf@gmail.com> <m239og12pe.fsf@gmail.com>
 <4D4063EC.7090509@lsrfire.ath.cx> <4D432735.8000208@lsrfire.ath.cx>
 <7v1v3wd1al.fsf@alter.siamese.dyndns.org> <4D437CA0.1070006@lsrfire.ath.cx>
 <7vsjwcb6rh.fsf@alter.siamese.dyndns.org> <4D4477E4.6020006@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Francis Moreau <francis.moro@gmail.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Feb 01 22:28:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkNmP-0005Zd-4y
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 22:28:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753168Ab1BAV2q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Feb 2011 16:28:46 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52286 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752974Ab1BAV2p convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Feb 2011 16:28:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4544545D2;
	Tue,  1 Feb 2011 16:29:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=SNmAz0IEbOJUtbr7WGETDwm3Q
	tc=; b=cF6DQ7BSXR4pvoOeb0UQ5gUG2oci5WvmKYaED71GwtGnySJzakSxiErO3
	olNEYIHGxDHUTS8IbPCXWJ0r2sTtThpEkWzLLkHSWEmgo7Ddankmi2zbe3M9g3sM
	eXx01Es89LzDSGapRlYeSFE5utBa1yQxPEGy06aKguEB5594Nw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=B8tbh6e0yEymOD5Xfli
	GGcTCq48r/ft4bnY8MgRp6Ru0GXsW4sXAtF8bmNxQdeXR3LJ0/V0nIOaugxEKEFv
	jM4jA+FXgOk1gHFcoArHT63YgAST2yVC6soqsJBgNYlIGY5quP/D3/43XxJRaPno
	XB8HPVfTOKFXKBU66AcBeOwo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 05B8745CC;
	Tue,  1 Feb 2011 16:29:33 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 539E745C6; Tue,  1 Feb 2011
 16:29:26 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5C1BFCD6-2E4A-11E0-B7E7-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165859>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Subject: revision: let --full-history keep half-interesting merges
>
> Don't simplify merges away that have at least one parent with changes=
 in
> the interesting subset of files if --full-history has been specified.
> The previous behaviour hid merges with one uninteresting parent, whic=
h
> could lead to history that removed code to become undetectable.

I think this patch makes a lot more sense than what I've seen in this
thread (including mine).

> E.g., this command run against the Linux kernel repo only found one
> merge that brought the specified function in (and the regular commit
> which added it in the first place), but missed the 92 merges that
> removed it, as well as 67 other merges that added it back:
>
> 	$ git log -m --full-history -Sblacklist_iommu \
> 		v2.6.26..v2.6.29 -- drivers/pci/intel-iommu.c
>
> Reported-by: Francis Moreau <francis.moro@gmail.com>
> Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>

Thanks.

> ---
>  revision.c                                 |    2 ++
>  t/t6016-rev-list-graph-simplify-history.sh |    1 +
>  2 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/revision.c b/revision.c
> index 7b9eaef..84c231b 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -434,6 +434,8 @@ static void try_to_simplify_commit(struct rev_inf=
o *revs, struct commit *commit)
>  		case REV_TREE_OLD:
>  		case REV_TREE_DIFFERENT:
>  			tree_changed =3D 1;
> +			if (!revs->simplify_history)
> +				return;
>  			pp =3D &parent->next;
>  			continue;
>  		}
> diff --git a/t/t6016-rev-list-graph-simplify-history.sh b/t/t6016-rev=
-list-graph-simplify-history.sh
> index f7181d1..50ffcf4 100755
> --- a/t/t6016-rev-list-graph-simplify-history.sh
> +++ b/t/t6016-rev-list-graph-simplify-history.sh
> @@ -168,6 +168,7 @@ test_expect_success '--graph --full-history --sim=
plify-merges -- bar.txt' '
>  	echo "|\\  " >> expected &&
>  	echo "| * $C4" >> expected &&
>  	echo "* | $A5" >> expected &&
> +	echo "* | $A4" >> expected &&
>  	echo "* | $A3" >> expected &&
>  	echo "|/  " >> expected &&
>  	echo "* $A2" >> expected &&
> --=20
> 1.7.3.4
