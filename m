Received: from avasout-ptp-002.plus.net (avasout-ptp-002.plus.net [84.93.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDC11D9A68
	for <git@vger.kernel.org>; Fri,  4 Oct 2024 14:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728053416; cv=none; b=aUqKyO+blX1Vol/BMFaOup9H0a9SMiKmG4Ql4z3SRsRdQ3LnZuDSCfkPj3c7XditaqaI95/0BAwKYC5g+WbOtQVJmRiW6psLp+l39gWOkNhTO9XnyG2vsp9u//TajsS2frvLVrXiuFrjh74HwQ2EIPoGrEoxCe4OVlB2LOXDbLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728053416; c=relaxed/simple;
	bh=zoykC2dzF9f/3GPOImYuE1kXzn0XhOI1AdX2/5J+QP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oPgT54cKB+1D3LNuib0nPyQCBVtlmSIkp547RTawDIiCaUue4FHFYqbTk+H9tGF206pZPrpc1gq6aVdtOqs94KuWXGuXxlZ/KaNpQPWORNHvDSXQi0XTD4FAPYryb1O5+ompuhUCg9++629BFyP+HPAE33WA3x1nVxFNLJ+Qa5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=ORe2K/2L; arc=none smtp.client-ip=84.93.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="ORe2K/2L"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id wja9syiQv5TbIwjaAsiJBv; Fri, 04 Oct 2024 15:47:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1728053223; bh=xbiTMaIvhic8u/QZe4OKpI9a7HLIWObkWKR0N+sDVO8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ORe2K/2L9H9EF88gJ5PLY6c2meYAXBlD8qOFYaMZX1NJFDj1NHTCdm2jpzUWxp+BT
	 03077KiRDeI/dxXiC7TWzPSfeFvXHiUlyGYhAYPn7ORN8tI2ouJ7/eHm/+iTiBljYO
	 ciz+lwhC+ehNmf161PkTDZZWTnFVi7FvL4lVLt4RomoOdxMOPKR57eXEoEB96EORCP
	 QNotHgIebadfZJSBZnydNfiB6WUBPCOZMh2MpHC8ebG1xMsSF1qHyf37v4jLCdIKWe
	 Wm0AMR/pVxyM1QsBJE2kL4WznY7izbdmXf+8zsSiwUx3B/yG9dE4XhEh6smWfZRatq
	 MmtdWqTtJhinA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=K5mBHDWI c=1 sm=1 tr=0 ts=66ffffe7
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=WarJ2IpTZMuriM8-Rn8A:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <277c243f-7179-4946-99c8-b19ad5c85412@ramsayjones.plus.com>
Date: Fri, 4 Oct 2024 15:47:01 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] t0610: work around flaky test with concurrent writers
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, Jeff King <peff@peff.net>,
 Josh Steadmon <steadmon@google.com>
References: <b1b5fb40-f6c2-4621-b58c-9b7c8c64cc01@ramsayjones.plus.com>
 <f83e23f1e76454a80e3e53cd02b3bb5bba6b8da1.1728044178.git.ps@pks.im>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <f83e23f1e76454a80e3e53cd02b3bb5bba6b8da1.1728044178.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfP4UPMn29iGKWmYDygdBLQiXBnuY5usduY80ZpClm2TJ9s9JehCds78IKxvbepaF2Xvi7vbo7G6YmdqI5DN2whC5iFGw9lLbT8WgnWPe7NRPyjFZ4np6
 XsDgZRUHKMcBQkMB7NQfC/h1GLPIJOnHXYmYMvF9c0+BIccvwNGP5XCMNUmqqmBfftXG+1+C7MsWlZ8KlMrqXxC1uWvPrndu0FY=

Hi Patrick,

On 04/10/2024 13:16, Patrick Steinhardt wrote:
[snip]

> Now the two reports are somewhat different from one another:
> 
>   - On Cygwin we hit timeouts because we fail to lock the "tables.list"
>     file within 10 seconds. The renames themselves succeed even when the
>     target file is open because Cygwin provides extensive compatibility
>     logic to make them work even when the target file is open already.

Hmm, not so much for me! :(

> 
>   - On MinGW we hit I/O errors on rename. While we do have some retry
>     logic in place to make the rename work in some cases, this is
>     seemingly not sufficient when there is this much contention around
>     the files.

I am seeing I/O errors.

> 
> Neither of these cases is a regression: the logic didn't work before the
> mentioned commit, and after the commit it performs well on Linux, macOS
> and in Cygwin, and at least a bit better with MinGW. But the tests show
> that we need to put more thought into how to make this work properly on
> MinGW systems.

OK

> 
> The fact that Cygwin can work around this issue with better emulation of
> POSIX-style atomic renames shows that we can in theory make MinGW work
> better, as well. But doing so likely requires quite some fiddling with
> Windows internals, and Git v2.47 is about to be released in a couple
> days. This makes any potential fix quite risky as it would have to
> happen deep down in our rename(3P) implementation in "compat/mingw.c".
> 
> Let's instead work around both issues by disabling the test on MinGW
> and by significantly increasing the locking timeout for Cygwin. This
> bumped timeout also helps when running with e.g. the address and memory
> sanitizers, which also tend to significantly extend the runtime of this
> test.

This doesn't work for me.

> 
> This should be revisited after Git v2.47 is out.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---

[PATCH snipped]

As I said last night, the first thing I tried was increasing the timeout
ten-fold (ie, to 100000), but that didn't change the outcome.

I am also on windows 10 (on an *old* 4th gen core i5): 
 
  $ uname -a
  CYGWIN_NT-10.0-19045 satellite 3.5.4-1.x86_64 2024-08-25 16:52 UTC x86_64 Cygwin
  $ 

I don't know why we appear to be seeing different behaviour. Since I had
already edited this test to up the timeout, I increased it again to match
the value in this (redacted) patch (ie I didn't actually apply your patch):

  $ git diff
  diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
  index 2d951c8ceb..7b6ded1c6a 100755
  --- a/t/t0610-reftable-basics.sh
  +++ b/t/t0610-reftable-basics.sh
  @@ -458,7 +458,7 @@ test_expect_success 'ref transaction: many concurrent writers' '
                  # Set a high timeout such that a busy CI machine will not abort
                  # early. 10 seconds should hopefully be ample of time to make
                  # this non-flaky.
  -               git config set reftable.lockTimeout 10000 &&
  +               git config set reftable.lockTimeout 300000 &&
                  test_commit --no-tag initial &&
   
                  head=$(git rev-parse HEAD) &&
  $ 

However, apart from less debugging output, the result was essentially the
same:

  ...
  
  ++ wait
  ++ git update-ref refs/heads/branch-100 HEAD
  fatal: update_ref failed for ref 'refs/heads/branch-97': reftable: transaction failure: I/O error
  fatal: update_ref failed for ref 'refs/heads/branch-87': reftable: transaction prepare: I/O error
  ++ git for-each-ref --sort=v:refname
  ++ test_cmp expect actual
  ++ test 2 -ne 2
  ++ eval 'diff -u' '"$@"'
  +++ diff -u expect actual
  --- expect      2024-10-04 13:31:42.450969800 +0000
  +++ actual      2024-10-04 13:32:07.097150600 +0000
  @@ -84,7 +84,6 @@
   68d032e9edd3481ac96382786ececc37ec28709e commit        refs/heads/branch-84
   68d032e9edd3481ac96382786ececc37ec28709e commit        refs/heads/branch-85
   68d032e9edd3481ac96382786ececc37ec28709e commit        refs/heads/branch-86
  -68d032e9edd3481ac96382786ececc37ec28709e commit        refs/heads/branch-87
   68d032e9edd3481ac96382786ececc37ec28709e commit        refs/heads/branch-88
   68d032e9edd3481ac96382786ececc37ec28709e commit        refs/heads/branch-89
   68d032e9edd3481ac96382786ececc37ec28709e commit        refs/heads/branch-90
  error: last command exited with $?=1
  not ok 47 - ref transaction: many concurrent writers
 
  ...

In an earlier email you suggested a timeout of -1, thus:

  $ git diff
  diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
  index 2d951c8ceb..9ab37a8d69 100755
  --- a/t/t0610-reftable-basics.sh
  +++ b/t/t0610-reftable-basics.sh
  @@ -458,7 +458,7 @@ test_expect_success 'ref transaction: many concurrent writers' '
                  # Set a high timeout such that a busy CI machine will not abort
                  # early. 10 seconds should hopefully be ample of time to make
                  # this non-flaky.
  -               git config set reftable.lockTimeout 10000 &&
  +               git config set reftable.lockTimeout -1 &&
                  test_commit --no-tag initial &&
   
                  head=$(git rev-parse HEAD) &&
  $ 

The result looks familiar:
  
  ++ wait
  ++ git update-ref refs/heads/branch-100 HEAD
  fatal: update_ref failed for ref 'refs/heads/branch-46': reftable: transaction prepare: I/O error
  ++ git for-each-ref --sort=v:refname
  ++ test_cmp expect actual
  ++ test 2 -ne 2
  ++ eval 'diff -u' '"$@"'
  +++ diff -u expect actual
  --- expect	2024-10-04 14:35:20.159564800 +0000
  +++ actual	2024-10-04 14:35:43.304762500 +0000
  @@ -43,7 +43,6 @@
   68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-43
   68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-44
   68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-45
  -68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-46
   68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-47
   68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-48
   68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-49
  error: last command exited with $?=1
  not ok 47 - ref transaction: many concurrent writers

Can you think of anything else to try?
  
I would strongly suggest skipping this test on cygwin as well as MINGW.

ATB,
Ramsay Jones

 
