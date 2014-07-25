From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/4] Consolidate ref parsing code
Date: Fri, 25 Jul 2014 17:43:55 +0700
Message-ID: <1406285039-22469-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 25 12:44:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAcyy-0003v9-WD
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 12:44:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760045AbaGYKoI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jul 2014 06:44:08 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:33719 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478AbaGYKoG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2014 06:44:06 -0400
Received: by mail-pd0-f175.google.com with SMTP id r10so5491918pdi.20
        for <git@vger.kernel.org>; Fri, 25 Jul 2014 03:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=8gs2EEUpl1GPgAmL1TSKe9WhZzFMeoyrhiDTf4Pe3FQ=;
        b=MKiRGIDVBV10/+wdOv/SYvK7t0zij6WSoGG8W4EqhcLlx+SbzI3qKYDVLkUpbNsmZj
         RbTZmbeCXnCuCkeIYDOIU9pzc3lHqEjD1W3dmPeprYVgwoMPWD6B0K7MYGloFsu/9YSr
         6Ib732ZcBl62ZTbSAweIZGcXQayPKRJJkO+gkqGGJLbwJ3Y3Jop31VJY5/rulhX4HkfS
         vUNC9/KfgPyfJEDA6Z639N1URLE2CDVa9hoZ7RgSP2LoZTYqg0T8ADhD4MfR6KVpU3Yq
         F+18JusMyZpPOscM4un1+yqmh9WUl/MoKxv5xPbfqSW4L4BD2Xvu4tdOlS7Dxi00FaDC
         0tKg==
X-Received: by 10.66.176.97 with SMTP id ch1mr9662979pac.101.1406285046122;
        Fri, 25 Jul 2014 03:44:06 -0700 (PDT)
Received: from lanh ([115.73.251.194])
        by mx.google.com with ESMTPSA id dk1sm11166572pdb.20.2014.07.25.03.44.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jul 2014 03:44:05 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 25 Jul 2014 17:44:02 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254203>

On Thu, Jul 24, 2014 at 4:16 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
>  - .... three places now knows what a
>    textual symref looks like (i.e. begins with "ref:", zero or more
>    whitespaces, the target ref and then zero or more trailing
>    whitespaces).  Perhaps we need to consolidate the code further,
>    so that this knowledge does not leak out of refs.c?

I started on top of nd/multiple-work-trees but it conflicts badly with
rs/ref-transaction-0 because this is basically code move. So I think
we should make it a separate topic instead, based on latest 'master'.
Junio, you still hit conflicts when merging this with nd/multiple-work-=
trees,
but that's simpler to resolve (git_snpath -> strbuf_git_path). I
promise to replace the "ref:" code in checkout.c later when both
topics graduate.

So.. first cut. The end result looks nice.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (4):
  strbuf.c: keep errno in strbuf_read_file()
  refs.c: refactor resolve_ref_unsafe() to use strbuf internally
  refs.c: move ref parsing code out of resolve_ref()
  refs.c: rewrite resolve_gitlink_ref() to use parse_ref()

 cache.h  |  12 +++
 refs.c   | 332 ++++++++++++++++++++++++++++++++-----------------------=
--------
 strbuf.c |   7 +-
 3 files changed, 188 insertions(+), 163 deletions(-)

--=20
1.9.1.346.ga2b5940
