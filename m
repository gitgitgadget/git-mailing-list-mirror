From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Question about 'branch -d' safety
Date: Sun, 11 Jul 2010 09:16:26 +0200
Message-ID: <201007110916.29567.jnareb@gmail.com>
References: <20091230065442.6117@nanako3.lavabit.com> <m3lj9jknlr.fsf@localhost.localdomain> <20100711065505.GA19606@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sun Jul 11 09:16:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXqmP-0000LA-5e
	for gcvg-git-2@lo.gmane.org; Sun, 11 Jul 2010 09:16:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751859Ab0GKHQo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Jul 2010 03:16:44 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:42735 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751500Ab0GKHQn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jul 2010 03:16:43 -0400
Received: by bwz1 with SMTP id 1so1834117bwz.19
        for <git@vger.kernel.org>; Sun, 11 Jul 2010 00:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=6GgIiS+PRNqHWnnK/lSIuELhfdbGTe5dWID02DoMJJg=;
        b=GPURYlv9p3BRza56LXWJfxwV5xlmG8G26TWuj5Lx3FDTp8smJbfHUFm9ensu4DRcPL
         yp373d8rGeWoZ/kOyy5fhcBFB8xX+NXl+obzEpEmVotfj4eP5Cl5cN0nllbxaE1yRa0O
         IQbzJGQ2y+R/gmCEqaMwXqA6Ag0AAK6R2nnVk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=xV4WNUbqF76Y8gRjq/6g/KrEAaEgHBpqDnmtc+wPokYdE9HHTE2KoZw8qxndk9f67z
         jCXNSEeryq6JNM7/TnX0wDZhPJoVc08Dad2Akmm2nb1UeR55VM5WztCav6+6qMe8KI8v
         HVp+kqjcEdVTfuj+NdldIkGsF0LldOQqSjdq0=
Received: by 10.204.6.68 with SMTP id 4mr2668442bky.28.1278832601492;
        Sun, 11 Jul 2010 00:16:41 -0700 (PDT)
Received: from [192.168.1.13] (abwj181.neoplus.adsl.tpnet.pl [83.8.233.181])
        by mx.google.com with ESMTPS id o20sm12296819bkw.15.2010.07.11.00.16.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 Jul 2010 00:16:40 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20100711065505.GA19606@localhost>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150765>

Dnia niedziela 11. lipca 2010 08:55, Clemens Buchacher napisa=B3:
> On Sat, Jul 10, 2010 at 02:57:35PM -0700, Jakub Narebski wrote:
> >=20
> > It's unfortunately not so easy.  The problem you have to solve is D=
/F
> > conflict: if you have 'foo/bar' branch, you can't create 'foo' bran=
ch,
> > but after deleting 'foo/bar' you want to be able to create 'foo'
> > branch and reflog for 'foo' branch.
>=20
> I'm going to read up on Jonathan's pointers. But I do not really
> see the problem above. If the reflog already exists, the new branch
> simpliy continues using it. So if the branch is re-created, it's as
> if the branch had never been deleted.

The problem is, that when you have 'foo/bar' branch, then you have
'foo/bar' reflog.  When you delete branch 'foo/bar', but do not delete
'foo/bar' reflog (only add to it branch deletion event), and then you
want to create 'foo' branch, git wouldn't be able to create reflog
fo 'foo' because of directory / file (D/F) conflict: there is 'foo/'
directory preventing file 'foo' from being created.
=20
> Or possibly we add a special reflog entry which points the branch
> to a zero sha to signify that the branch had been deleted.

That is a good idea anyway.
--=20
Jakub Narebski
Poland
