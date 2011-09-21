From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: [PATCH 1/2] sparse checkout: show error messages when worktree
 shaping fails
Date: Wed, 21 Sep 2011 13:15:29 -0600
Message-ID: <4E7A37D1.1020501@workspacewhiz.com>
References: <1316602259-22576-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	git@drmicha.warpmail.net
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 21 21:14:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6SFs-00051T-RD
	for gcvg-git-2@lo.gmane.org; Wed, 21 Sep 2011 21:14:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752185Ab1IUTOn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Sep 2011 15:14:43 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:51318 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751565Ab1IUTOn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Sep 2011 15:14:43 -0400
Received: (qmail 21274 invoked by uid 399); 21 Sep 2011 13:14:41 -0600
Received: from unknown (HELO ?192.168.1.101?) (jjensen@workspacewhiz.com@71.199.50.180)
  by hsmail.qwknetllc.com with ESMTPAM; 21 Sep 2011 13:14:41 -0600
X-Originating-IP: 71.199.50.180
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:6.0.2) Gecko/20110902 Thunderbird/6.0.2
In-Reply-To: <1316602259-22576-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181856>

----- Original Message -----
=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy
Date: 9/21/2011 4:50 AM
>   			if (ce->ce_flags&  CE_ADDED&&
>   			verify_absent(ce, ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN, o))
> -					return -1;
> +				goto return_failed;
>
> -			if (apply_sparse_checkout(ce, o)) {
> -				ret =3D -1;
> -				goto done;
> -			}
> +			if (apply_sparse_checkout(ce, o))
> +				goto return_failed;
>   			if (!ce_skip_worktree(ce))
>   				empty_worktree =3D 0;
Unfortunately, this patch only collects and displays the first untracke=
d=20
file for me.  It does not display all of the files that would be=20
overwritten (desired behavior, IMHO).

This script illustrates:

#!/bin/sh

rm -Rf utest || exit 1
mkdir utest || exit 1
cd utest || exit 1
git init
git config core.sparseCheckout true
echo *>.git/info/sparse-checkout
echo tracked>a
git add a
git commit -m a a
git branch side
echo tracked>b
echo tracked>c
git add b c
git commit -m bc
cat b
git checkout side
cat b
echo untracked>b
echo untracked>c
cat b
git checkout master
cat b

-Josh
