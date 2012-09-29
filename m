From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: Re: [PATCH 2/3] revision: add --grep-reflog to filter commits by reflog messages
Date: Sat, 29 Sep 2012 11:41:26 +0700
Message-ID: <1348893689-20240-1-git-send-email-pclouds@gmail.com>
References: <7vr4pmm3qz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 29 06:49:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THozJ-0007XM-NJ
	for gcvg-git-2@plane.gmane.org; Sat, 29 Sep 2012 06:49:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751535Ab2I2EsW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 29 Sep 2012 00:48:22 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:38785 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751483Ab2I2EsU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2012 00:48:20 -0400
Received: by padhz1 with SMTP id hz1so2808444pad.19
        for <git@vger.kernel.org>; Fri, 28 Sep 2012 21:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=9Ta1g+kuRaNReGsMgB4Aosl/IHl1ZYxBuJCmaz4FTtk=;
        b=j/38+tpNabsoV9jFxXujdRhIZJFH1JdEqThOa7pixd2QNatatGRHEtFDrzxq5HnPXP
         C2sowmW2AwadM2DV4oKQp6d1GtbxN7VKmljLadZz/BA1tRsv6gFPCqhKMO+5D99Ja6TI
         0bkmQdSgs07Bknl2hsCz7HL1/C9UwBGgWoqQu2EdtpTqleHLiyU/wNrrJRPGx+dI4Gdu
         JoynS5yAD+cSAG7kBqE+JTsQ6YmehN807h6iCaBPp/4d5YoGGb9nwfMHSJSnYsvOODpY
         Pqn6wD8WbVy3HO1em+UEzdMW16VVCsVhPx4QW508xXHU/n8mBgMDA8+wIEO4XaBUWhOF
         To2w==
Received: by 10.68.203.195 with SMTP id ks3mr25415273pbc.79.1348894100250;
        Fri, 28 Sep 2012 21:48:20 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.51.2])
        by mx.google.com with ESMTPS id rz10sm6670857pbc.32.2012.09.28.21.48.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 28 Sep 2012 21:48:19 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 29 Sep 2012 11:41:31 +0700
X-Mailer: git-send-email 1.7.12.1.406.g6ab07c4
In-Reply-To: <7vr4pmm3qz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206619>

On Sat, Sep 29, 2012 at 12:55 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> For that to happen, the code _must_ know what kind of headers we
> would support; discarding the existing enum is going in a wrong
> direction.

Or what kind of manipulation is required for a header. The caller can
decide if it wants such manipulation or not. Somebody might want to
grep committer's date, for example.

> When we introduce "git log --header=3Dfrotz:xyzzy" option that looks
> for a generic "frotz " header and tries to see if "xyzzy" textually
> appears in the field, we may want to add a generic "this is not a
> header that we have special treatment for" enum to the mix.  But for
> known kinds of headers, we would need a list of what each header is
> and what semantics it wants.
>
> So please reconsider undoing [1/3], and rerolling [2/3] that depends
> on it.

Done. The enum is kept. I added a few tests about grepping timestamp
in 1/3 to keep people (or myself) from making the same mistake I did.

3/3 is reposted for completeness, I don't care much about notes (so
far). It's up to you to take or drop it.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (3):
  grep: prepare for new header field filter
  revision: add --grep-reflog to filter commits by reflog messages
  revision: make --grep search in notes too if shown

 Documentation/rev-list-options.txt |  8 ++++++++
 grep.c                             | 10 +++++++++-
 grep.h                             |  7 +++++--
 revision.c                         | 26 ++++++++++++++++++++++++--
 t/t7810-grep.sh                    | 38 ++++++++++++++++++++++++++++++=
++++++++
 5 files changed, 84 insertions(+), 5 deletions(-)

--=20
1.7.12.1.406.g6ab07c4
