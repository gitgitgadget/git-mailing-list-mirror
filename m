Received: from aib29agh122.zrh1.oracleemaildelivery.com (aib29agh122.zrh1.oracleemaildelivery.com [192.29.178.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39F5282FA
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 12:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732278762; cv=none; b=CdTXP2aHfQ+gkm9UuKPH6Qg/rNaOjkzutWpKKX94n2vmayAZy9CxDC6o1m6jSXub9HVpRlzJx84QNuI3+x68zqTakyXqzetwAocLmDuos2raMD04ohLf+WaxwD1wdqbvEdKOJ6kdOGst7Ko2EAR+FfAXSmk2EO1IvvETRfQqhSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732278762; c=relaxed/simple;
	bh=vRhO2xB9G+6FrkiR4xDvKR82Kyh0i2twSpC2x19Cm/Q=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=MslAKPRpKqhF6FdwalXCp7ZSYCENRd02i+FezKStlDoCKiAXHMQO8aHdq07zGyZ00yX04grpgeGMli2w19OUkX67sYpz1wXq0HrG5EqaQWiA+9NCAHiSE6XW4Ehx2O6SGKQ3cfrAfKvbAqF9c2vTnOHHGShjSeCXNAOwgSYsy2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=RTo2z77Q; arc=none smtp.client-ip=192.29.178.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="RTo2z77Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=pzX58ji3XWseYlnCHj7iQPfTvmP1cwXYy0zRjm2DiNc=;
 b=RTo2z77QpZtsTLxi++E31LoWVAwaCB3w3RK1zqfklzbArEgbAUoomMJ5PzDfTRgcA72g8VEGnrLC
   TuHbUi62ukC4wbIb9G0bfv/B6dUotErn2IPQsSYpKkxMn4N3CTtqvMUs0t33ZxBxoYTqm3hBvBDt
   HBcbE8m+zB573ikqDYzke9Dslx86ytQkjeo9jFE1eJoDZjoDO9VJW4xGFwRkVNJlhuDBRlPVLxE8
   KbMVrc1/bevPgs1iKoQzMdaUHCBza5Ee0L3LinW6EfE9wIEgjz/1Zp9YVxywn/JNvQLeF5c+lNV4
   miNQkmgQHlwhMxoNcqossq+1eL2xx6mae9X1uw==
Received: by omta-ad1-fd1-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241024 64bit (built Oct 24
 2024))
 with ESMTPS id <0SNC00MQJQUE7JB0@omta-ad1-fd1-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Fri, 22 Nov 2024 12:32:38 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,	karthik.188@gmail.com,
	Taylor Blau <me@ttaylorr.com>,	Patrick Steinhardt <ps@pks.im>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v15 00/10] set-head/fetch remote/HEAD updates
Date: Fri, 22 Nov 2024 13:28:41 +0100
Message-id: <20241122123138.66960-1-bence@ferdinandy.com>
In-reply-to: <20241121225757.3877852-1-bence@ferdinandy.com>
References: <20241121225757.3877852-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAGN7aBan77MbfXOZPfdOp38TJZ+yLtwIVHmtjoIulUFo1vBC91WQx5I9iiB+PAd
 +OJ1GES+9OUEPUbnbVvjGgvFN/tQ1McXv6agnh/lcKHeIYr9dY6bli7N4KvOjoaT
 9JzX2nHWvEOxdk0bAQ6Bus7bOXcUYW8GfyUCv9xBqdLZJn01MnAd9PVQAalKax5+
 CNsTWBQGPkLNnyYokdmR2eTpYXXQfTiNz75TMTr9l58rKZJyC0AWBOcvlx0sFHXD
 v861ztEv+WsuT6V69JlFnuwUTBV6VelmIGd91WXoEwlJprxRMsu6tiSZTPSaetah
 JtIkQN5i1p5/aSzdSKpfQg2HJlHKwO32dHDk4cONRUNR3dVkbO9zzIRbvvlQ57aM
 HcP+3nYglZnKyEP0qrBEgsneWkbqTNkL0VPuRB4kw/B0ayasg8VqFMv4sFZaH5aR
 HGdhcFLW3p+auPAEi1Fd33HvbNxY/p4VjyUsMDSrVF5+8OU9Q1x/jVya

2/10: use test_must_fail and test_when_finished
3/10: whitespace fix


Bence Ferdinandy (10):
  t/t5505-remote: set default branch to main
  t/t5505-remote: test failure of set-head
  refs: standardize output of refs_read_symbolic_ref
  refs: atomically record overwritten ref in update_symref
  remote set-head: refactor for readability
  remote set-head: better output for --auto
  refs: add TRANSACTION_CREATE_EXISTS error
  refs: add create_only option to refs_update_symref_extended
  fetch: set remote/HEAD if it does not exist
  fetch set_head: handle mirrored bare repositories

 builtin/fetch.c                  |  74 +++++++++++++++++++++
 builtin/remote.c                 |  72 +++++++++++++++------
 refs.c                           |  47 ++++++++++++--
 refs.h                           |  19 +++++-
 refs/files-backend.c             |  31 +++++----
 refs/refs-internal.h             |   5 ++
 refs/reftable-backend.c          |  12 ++--
 t/t4207-log-decoration-colors.sh |   3 +-
 t/t5505-remote.sh                | 107 +++++++++++++++++++++++++++++--
 t/t5510-fetch.sh                 |  24 +++++++
 t/t5512-ls-remote.sh             |   2 +
 t/t5514-fetch-multiple.sh        |  17 ++++-
 t/t5516-fetch-push.sh            |   3 +-
 t/t5527-fetch-odd-refs.sh        |   3 +-
 t/t7900-maintenance.sh           |   3 +-
 t/t9210-scalar.sh                |   5 +-
 t/t9211-scalar-clone.sh          |   6 +-
 t/t9902-completion.sh            |  65 +++++++++++++++++++
 18 files changed, 439 insertions(+), 59 deletions(-)

Range-diff against v14:
 1:  49cfd222d5 =  1:  2e1d001d1a t/t5505-remote: set default branch to main
 2:  54bf9c7fff !  2:  d24e62035a t/t5505-remote: test failure of set-head
    @@ Commit message
      ## Notes ##
         v14: new patch
     
    +    v15: - use test_must_fail and test_when_finished
    +
      ## builtin/remote.c ##
     @@ builtin/remote.c: static int set_head(int argc, const char **argv, const char *prefix)
      		if (!refs_ref_exists(get_main_ref_store(the_repository), buf2.buf))
    @@ t/t5505-remote.sh: test_expect_success 'set-head --auto' '
      '
      
     +test_expect_success REFFILES 'set-head --auto failure' '
    ++	test_when_finished "rm -f test/.git/refs/remotes/origin/HEAD.lock" &&
     +	(
     +		cd test &&
     +		touch .git/refs/remotes/origin/HEAD.lock &&
    -+		git remote set-head --auto origin 2>errormsg ||
    -+		tail -n1 errormsg >output &&
    -+		rm .git/refs/remotes/origin/HEAD.lock &&
    ++		test_must_fail git remote set-head --auto origin 2>err &&
    ++		tail -n1 err >output &&
     +		echo "error: Could not set up refs/remotes/origin/HEAD" >expect &&
     +		test_cmp expect output
     +	)
 3:  c95362236e !  3:  1218d521e5 refs: standardize output of refs_read_symbolic_ref
    @@ Notes
              - rewrote comment in refs-internal.h to point to the one in refs.h
              - created NOT_A_SYMREF=-2 constant
     
    +    v15: fix whitespace issues
    +
      ## refs.h ##
     @@ refs.h: int refs_read_ref_full(struct ref_store *refs, const char *refname,
      
    @@ refs/reftable-backend.c: static int reftable_be_read_symbolic_ref(struct ref_sto
      
      	ret = reftable_stack_read_ref(stack, refname, &ref);
     -	if (ret == 0 && ref.value_type == REFTABLE_REF_SYMREF)
    -+        if (ret)
    -+                ret = -1;
    -+        else if (ref.value_type == REFTABLE_REF_SYMREF)
    ++	if (ret)
    ++		ret = -1;
    ++	else if (ref.value_type == REFTABLE_REF_SYMREF)
      		strbuf_addstr(referent, ref.value.symref);
    --	else
    + 	else
     -		ret = -1;
    -+        else
    -+                ret = NOT_A_SYMREF;
    ++		ret = NOT_A_SYMREF;
      
      	reftable_ref_record_release(&ref);
      	return ret;
 4:  21533e0e6b !  4:  4d5f3f4f01 refs: atomically record overwritten ref in update_symref
    @@ Notes
              - the returned error code by the above was also incorrect and now
                is -2 (and uses NOT_A_SYMREF now)
     
    +    v15: no change
    +
      ## refs.c ##
     @@ refs.c: int peel_iterated_oid(struct repository *r, const struct object_id *base, struct
      
 5:  2455768c24 !  5:  6f2cb51b0b remote set-head: refactor for readability
    @@ Notes
     
         v14: no change
     
    +    v15: no change
    +
      ## builtin/remote.c ##
     @@ builtin/remote.c: static int show(int argc, const char **argv, const char *prefix)
      static int set_head(int argc, const char **argv, const char *prefix)
 6:  396537a598 !  6:  ca8687bae1 remote set-head: better output for --auto
    @@ Notes
         v14: - fixed badly named variable
              - fixed not reporting errors correctly
     
    +    v15: no change
    +
      ## builtin/remote.c ##
     @@ builtin/remote.c: static int show(int argc, const char **argv, const char *prefix)
      	return result;
 7:  05e97155d1 !  7:  45bcb33b52 refs: add TRANSACTION_CREATE_EXISTS error
    @@ Notes
     
         v14: no change
     
    +    v15: no change
    +
      ## refs.h ##
     @@ refs.h: int ref_transaction_verify(struct ref_transaction *transaction,
      
 8:  3ea8b1b8b6 !  8:  a8a522a089 refs: add create_only option to refs_update_symref_extended
    @@ Notes
     
         v14: no change
     
    +    v15: no change
    +
      ## builtin/remote.c ##
     @@ builtin/remote.c: static int set_head(int argc, const char **argv, const char *prefix)
      		goto cleanup;
 9:  287c25b801 !  9:  ff294461d8 fetch: set remote/HEAD if it does not exist
    @@ Notes
         created with an opt out, and the configuration for this will be added in
         a later patch
     
    +    v15: no change
    +
      ## builtin/fetch.c ##
     @@ builtin/fetch.c: static int backfill_tags(struct display_state *display_state,
      	return retcode;
10:  05d8526399 ! 10:  0e96260ab6 fetch set_head: handle mirrored bare repositories
    @@ Notes
     
         v14: no change
     
    +    v15: no change
    +
      ## builtin/fetch.c ##
     @@ builtin/fetch.c: static const char *strip_refshead(const char *name){
      
-- 
2.47.0.298.g52a96ec17b

