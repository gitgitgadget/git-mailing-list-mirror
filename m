From: Amadeusz =?utf-8?B?xbtvxYJub3dza2k=?= <aidecoe@aidecoe.name>
Subject: Re: [PATCH] git-p4.py: Make submit working on bare repository
Date: Sat, 20 Feb 2016 11:00:16 +0000
Message-ID: <87fuwnd4u7.fsf@freja.aidecoe.name>
References: <CAPig+cQA4sJ2RneG8zRsUx+bDPAMYVtmhFjZx5SOGDqnsKNUaQ@mail.gmail.com> <1455919074-5683-1-git-send-email-aidecoe@aidecoe.name> <xmqq7fi0b9rt.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Cc: git@vger.kernel.org, Luke Diamand <luke@diamand.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 20 12:00:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aX5H4-0002pf-Hv
	for gcvg-git-2@plane.gmane.org; Sat, 20 Feb 2016 12:00:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1949987AbcBTLA1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2016 06:00:27 -0500
Received: from jim.zolnowski.name ([188.116.54.122]:46564 "EHLO
	jim.zolnowski.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751400AbcBTLA0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2016 06:00:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aidecoe.name; s=jim;
	h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From; bh=e0k18diZoKI3YmJTugqiYECnaenQOjWUdeqO+C/0SsY=;
	b=EohVhTf3AtqSD4D+KPz6y/aSefuVXcVFbW7B9R2PkWpg1Tl3JhIvowi/AF2JU5fqhP41dymMrhFW/AP6X3TW9dACjeCZwNmmItgsamvSVoD/n0mXwMw3rFeJkFh3kxwnIaOv/SRWSlXvfG5S3ElAuZoi5diMFGRksm8IEKrBhDnCkcn27B8Qwy1JG/p0SZeAM6x0blIOdQx692hWExs77rP9mtvszBhhYWUjYn4FksFRKpLfj3PWoDL210KldnnYQr0eXB6GdnlPRxwf4NNI1kZSxUSwK7m05DyJCyEY71ANkwsjHKwLbjgpCMmFJg9iphpdTAADMpHXunbqzkxdWA==;
Received: from cpc92302-cmbg19-2-0-cust189.5-4.cable.virginm.net ([82.1.208.190] helo=localhost)
	by jim.zolnowski.name with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.85)
	(envelope-from <aidecoe@aidecoe.name>)
	id 1aX5Gw-0005dO-7P; Sat, 20 Feb 2016 12:00:23 +0100
In-Reply-To: <xmqq7fi0b9rt.fsf@gitster.mtv.corp.google.com>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/24.5.1 (x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286778>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

To submit changes from master branch to Perforce, new commits should be
based on a remote branch p4/master:

(1)
                  E'---F' master
                 /
    A---B---C---D p4/master

Commits from A to D map to Perforce changelists. These commits include
additional metadata in commit message which most important is changelist
number.

On submit git-p4 prepares changelists for commits E'-F' and submits
these to Perforce repository. After this operation it syncs back remote
branch p4/master. This is the common part for both bare and non-bare
repository.

(2)
                  E'---F' master
                 /
    A---B---C---D---E---F p4/master

In non-bare repository git rebase is performed and it results in
following state:

(3)
    A---B---C---D---E---F p4/master, master

In bare repository this operation cannot be performed, so it remains in
state (2).

With special care state (2) can be transformed to state (3) with manual
update of refs/heads/master with refs/remotes/p4/master.

I understand that implementing rebase for bare repository is unsafe and
it wouldn't be appreciated. Therefore we have to resort to such a
barbarity and git-p4 submit shouldn't attempt to perform a rebase
operation itself. Especially because it performs other operations before
and we end up in the intermediate state (2) anyway.

Is this explanation satisfactory? If yes, I'll include it in patch
description.


Kind regards,

=2D-=20
Amadeusz =C5=BBo=C5=82nowski

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1

iQJ8BAEBCgBmBQJWyEdAXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCMzcyRTFENjI5NUM1MzYwQTQwODQyRUZD
QkNDODAyM0Y1OUUxNzA0AAoJEMvMgCP1nhcE1ZEP/1If/o+KFJUuleVOQFTgXX5y
VOtHM+2QdVa3J4QpUaR62t3cmnSsPeGYxuotIgj8eHlWb58PRPCcsKpo0XsStHWX
4P+TlLMJcpv/b4oaEomxqYopNCuXoNrWL8yu/i185YEdOakN8XF5+C/Zp1Oye8i2
Ms3MltyMgex/EdZd713lryL9TX34Q7tmjTNZqOVMKmCyV3+t97EQJk33BjfEH2Dv
4vQEUUDNUTHu1gUuAjq4yn/RBV8KDtCRAN8VkVFl1ggK6U7tsup4+gkax0Mc7KgP
owF/lbRQMKE/V05fupJ7ZFXWqcCi6OhtizvOQHG6ujUMxXd4/51VfnL4Or6Byngd
rrJwQyibrltFA1bIryxJnkixcHGSjQKEH7YpOJom0i5S5wWcPhInhng4PLLgZtwb
ucg7VwhtZr44TLUfPPb5iad7UZp6kvIJm8qXHZL9pM+0WPgynRKGYhL+I7PrYP9e
iZtG1HkfewPcdvdUOLkWyct4QTYCVXgEqD1u05m/9EJOwD+2aKdYKy97wxU03tPH
jL5cJx1Rj4KDJFfT48Qxjufj/nVce847vbFTtzIy5WGorHa/ydexaP/hBC0e0tqu
DxR4fsfURY12VjbOMjolTgVS9TJTCZagbYmNPXTfAWS+GAWrCWx3P67dgRYuFbYt
8jpbOB8i1tfJveX5VniW
=Sxgr
-----END PGP SIGNATURE-----
--=-=-=--
