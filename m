From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/8] Resurrect "diff-lib.c: adjust position of i-t-a entries in diff"
Date: Sat, 22 Aug 2015 08:08:03 +0700
Message-ID: <1440205700-19749-1-git-send-email-pclouds@gmail.com>
References: <xmqqy4j80wdb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, phiggins@google.com,
	snoksrud@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 22 03:08:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSxIT-0004fx-5h
	for gcvg-git-2@plane.gmane.org; Sat, 22 Aug 2015 03:08:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752612AbbHVBId convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Aug 2015 21:08:33 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:35880 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752028AbbHVBIc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 21:08:32 -0400
Received: by pdbmi9 with SMTP id mi9so31928325pdb.3
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 18:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=RzFTAp8Xus8MestEEN/Q1avRcwaIe6JpenWJf5gKAAA=;
        b=M8/V+ZqZaOhj0tn4SdmWfx3Em5Czo4kYKfQoagdjfIBhSCYoX1oOpX638S5//X7ux8
         EOC4pFYEKJ2q6JReoam+FdCD7Tgq/ubuzR5egy7ond9ePntkGp1UZMZHKN4kvTaBwZoI
         fcE/Swi6B5EG5ue17eIIbPKxzXzFiufndu7CqxHjjbCCCQ2msNjBD95WttiH+u4GzD0j
         JwfNm4iXKpV7F13cHqYiI2OlPqpgAc6zS40KCthn/ZQ/f19LeOTxAnmCxtdhXMF04XPA
         zPRL4Bw+r7gBbCQFynNSEHibVA3AU86g57nfFPiGtp04SVQEwSEHCnbeCJjB0YuKieDn
         rBYQ==
X-Received: by 10.70.91.14 with SMTP id ca14mr22781705pdb.79.1440205711967;
        Fri, 21 Aug 2015 18:08:31 -0700 (PDT)
Received: from lanh ([171.232.84.126])
        by smtp.gmail.com with ESMTPSA id la4sm9109393pbc.76.2015.08.21.18.08.28
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2015 18:08:30 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 22 Aug 2015 08:08:27 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <xmqqy4j80wdb.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276352>

On Thu, Jun 25, 2015 at 8:07 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
>>> Perhaps a good and safe way forward to resurrect what d95d728a
>>> wanted to do is to first add an option to tell run_diff_index() and
>>> run_diff_files() which behaviour the caller wants to see, add that
>>> only to the caller in wt-status.c? =C2=A0Then incrementally pass th=
at
>>> option from more callsites that we are absolutely certain that want
>>> this different worldview with respect to i-t-a?
>>
>> Agreed.
>
> OK. =C2=A0Perhaps then first I should do that revert and we'll
> incrementally rebuild on top.

Here comes the rebuild. This adds --shift-ita option (and an internal
flag) to enable this behavior. Those only take the last two patches.
The remaining is to make sure we handle i-t-a entries correctly in
some commands.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (8):
  blame: remove obsolete comment
  Add and use convenient macro ce_intent_to_add()
  apply: fix adding new files on i-t-a entries
  apply: make sure check_preimage() does not leave empty file on error
  checkout(-index): do not checkout i-t-a entries
  grep: make it clear i-t-a entries are ignored
  diff.h: extend "flags" field to 64 bits because we're out of bits
  Resurrect "diff-lib.c: adjust position of i-t-a entries in diff"

 Documentation/diff-options.txt |  6 +++
 builtin/apply.c                | 13 ++++---
 builtin/blame.c                |  5 ---
 builtin/checkout-index.c       |  5 ++-
 builtin/checkout.c             |  2 +
 builtin/commit.c               |  2 +-
 builtin/grep.c                 |  2 +-
 builtin/rm.c                   |  2 +-
 cache-tree.c                   |  2 +-
 cache.h                        |  1 +
 diff-lib.c                     | 18 ++++++++-
 diff.c                         |  4 +-
 diff.h                         |  9 +++--
 read-cache.c                   |  4 +-
 t/t2203-add-intent.sh          | 83 ++++++++++++++++++++++++++++++++++=
+++++++-
 wt-status.c                    |  2 +
 16 files changed, 134 insertions(+), 26 deletions(-)

--=20
2.3.0.rc1.137.g477eb31
