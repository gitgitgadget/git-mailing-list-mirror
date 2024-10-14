Received: from aib29agh127.zrh1.oracleemaildelivery.com (aib29agh127.zrh1.oracleemaildelivery.com [192.29.178.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706E51D150C
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 22:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728946533; cv=none; b=QT0YG0bQ+bRxw7c1MQIJm8O+VPh5ECeKhe2bCgDILLoC44cTpZjmoN4P8uPK1y4Y75Ib8+8RYA8g4LWi3iBttwsRJ2H7t6AHGqnh6zT7ImGm2oiZ2cIdPs1+XxjPRnXjXwfohqHbNt18HhH1ECQWQ2oKkAM3kq+JaDzcFz8cLyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728946533; c=relaxed/simple;
	bh=NObRA7YfeiC4vdgaUYEgaOs1+dZX3WScecpz3WznnzY=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version:Content-type; b=DjeNcMyVLe8HbZ5hxlViRdH93htrZV25ricav+Jia4Ceea9Zv9o+KeAlZn1l6N6HxN6ijj+6hVqHHT4i1bXW+UTUgLnlp17iriV5xFrRXF0sZixp53VDDL2uymeTU7iyZsJy29fkVLu6wce6f4SgEmPP+/avIxUnypLdBLlbXXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=hsxsjCq1; arc=none smtp.client-ip=192.29.178.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="hsxsjCq1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=QYoDg302HSEcBWHcX7HZWDVIIK/gkXZAha19FptcHfM=;
 b=hsxsjCq1f1hKdu6csNuCE3+ystORMRy+4vYrAQUD66jccKNUrcu4YZCnTidmPTfNr7eeXPGt+lDA
   EuV1pH+bF8NDKbuMgODrZPK1ul/xx5z2N0zLg6HVMCW4N9bFOqGKS8yPqWySU//Ky8v6KYdZpTzd
   4nFVYxWVF9kvL7X7OE7UXXd9bA2Tps6q12Dd/zrtXicgMiAG3290fbZBdBQ55L2NLc2WHmiqYgua
   HG3jjBHjBaNxOmcLWhXZpF/e4hFRxLmYGytAcAlX6Sh+q14iu6Ql5soTyUwnzupJ4jmEUPIjsisg
   z71qcCr/ZbTib/mahn3vtGV2umQK8SdVJMjd2w==
Received: by omta-ad1-fd3-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SLD00OQ6BOCQJ50@omta-ad1-fd3-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Mon, 14 Oct 2024 22:55:24 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	Taylor Blau <me@ttaylorr.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,	Bence Ferdinandy <bence@ferdinandy.com>,
	karthik.188@gmail.com
Subject: [PATCH v8 0/6] set-head/fetch remote/HEAD updates, small change from v7
Date: Tue, 15 Oct 2024 00:53:09 +0200
Message-id: <20241014225431.1394565-1-bence@ferdinandy.com>
In-reply-to: <20241012230428.3259229-1-bence@ferdinandy.com>
References: <20241012230428.3259229-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAGcuVeOwkX3W2cLsPbVZLkAlTmB2rPTAs2X0MxsxKf4JHeph2UTvCBUpG9DynqP
 BAMwpCbQX7N2fsaWFaM7ub7VRSd+4CjzMyWYjw3LT41mwPtPklRuo/KZy/fxKo/j
 44sYF273pBVBEJZ5Jz58tvJpT62pD4WlWZ9VC6n/ewFjjQlKEyAbumReTux2By3y
 omq+Xqw4jTwoSQo7HOEqwtKMMTy0rPYdCqMW77XmQSyz63nCSO/TOWk18FxaAEsv
 Lmrx0KG49dpwBEPrKbwojCUmLc8exU9h1EAsz/WuO5phppr+Os1BEb9SRtqQyabp
 Awzc7oPpfod6CHi3RvziYpbr8IL2KRKTkydfIJANElwt03iaG1/HatuzpZmlx/YO
 UlSV70WgJfZOt56QHBdC8Cm3UL0iHgksb9ZxlHdkhPRf6LrDijk5oG7rQ4V/vRNp
 w1ozpk6kIuoD6QzS4qroibc9AgdTNh3SqblzmPE85Blqlk98CoM7xCac

v8 is minor non-functional fix from v7


❯ git range-diff v7~6..v7 v8~6..v8
1:  e4a2d01bca = 1:  e4a2d01bca refs: atomically record overwritten ref in update_symref
2:  e6c40ef04c = 2:  e6c40ef04c remote set-head: add new variable for readability
3:  aefa49aa0d = 3:  aefa49aa0d remote set-head: better output for --auto
4:  ad8907c6a3 = 4:  ad8907c6a3 refs: add TRANSACTION_CREATE_EXISTS error
5:  ff616d8b77 = 5:  ff616d8b77 refs: add create_only option to refs_update_symref
6:  35b93f454c ! 6:  7b844b1dbb fetch: set remote/HEAD if it does not exist
    @@ Notes

         v7: - no change

    +    v8: - changed logmsg in call to refs_update_symref from "remote
    +          set-head" to "fetch"
    +
      ## builtin/fetch.c ##
     @@ builtin/fetch.c: static int backfill_tags(struct display_state *display_state,
        return retcode;
    @@ builtin/fetch.c: static int backfill_tags(struct display_state *display_state,
     +          if (!refs_ref_exists(refs, b_remote_head.buf))
     +                  result = 1;
     +          else if (refs_update_symref(refs, b_head.buf, b_remote_head.buf,
    -+                                  "remote set-head", &b_local_head, 1))
    ++                                  "fetch", &b_local_head, 1))
     +                  result = 1;
     +          else
     +                  report_set_head(remote, head_name, &b_local_head);

Bence Ferdinandy (6):
  refs: atomically record overwritten ref in update_symref
  remote set-head: add new variable for readability
  remote set-head: better output for --auto
  refs: add TRANSACTION_CREATE_EXISTS error
  refs: add create_only option to refs_update_symref
  fetch: set remote/HEAD if it does not exist

 builtin/branch.c                 |   2 +-
 builtin/checkout.c               |   5 +-
 builtin/clone.c                  |   8 +-
 builtin/fetch.c                  |  82 +++++++++++
 builtin/notes.c                  |   3 +-
 builtin/remote.c                 |  47 +++++--
 builtin/symbolic-ref.c           |   2 +-
 builtin/worktree.c               |   2 +-
 refs.c                           |  38 +++--
 refs.h                           |   7 +-
 refs/files-backend.c             |  24 ++--
 refs/reftable-backend.c          |   6 +-
 reset.c                          |   2 +-
 sequencer.c                      |   3 +-
 setup.c                          |   3 +-
 t/helper/test-ref-store.c        |   2 +-
 t/t4207-log-decoration-colors.sh |   3 +-
 t/t5505-remote.sh                |  62 ++++++++-
 t/t5510-fetch.sh                 | 229 ++++++++++++++++---------------
 t/t5512-ls-remote.sh             |   2 +
 t/t5514-fetch-multiple.sh        |  17 ++-
 t/t5516-fetch-push.sh            |   3 +-
 t/t5527-fetch-odd-refs.sh        |   3 +-
 t/t7900-maintenance.sh           |   3 +-
 t/t9210-scalar.sh                |   5 +-
 t/t9211-scalar-clone.sh          |   6 +-
 t/t9902-completion.sh            |  65 +++++++++
 27 files changed, 469 insertions(+), 165 deletions(-)

-- 
2.47.0.7.g072c39eddb.dirty

