Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF8841D22F
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 23:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787353341; cv=none; b=iH0a8lYVB+x1oKGbxdgp8ihK9Zr2lPmal1I15mrmeeO6PjJ6SXGCdbfY7k52Y2KXaLHP5O+fRVMDJhis/378h+UGQArIu+laVRcXetheomRR9pH3C+B8LKJAdQm69/FHVdOFdbn6yrz1mKNRoN4+fPICVaNgsOJLa7bgGnJf3qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787353341; c=relaxed/simple;
	bh=cSBV2TI157My7SritYRYM764kCf1UO8pNh9hU8FVcNg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KNeEobZ53T5mzrDAFxjIBJstsq9PtH3SDkPPB/8bY+sqvFKlfagRz6aFQ0MUpyXLK6SPQcZQVNBI0u/hVFv6NWbpkoyeOH6qoskF2lXEfaNkkvJfBS+0CuUTQ1B3QNOOl4d700eVNIstf/IBKEcICWAFtTmNbnRLlQPxg3Vr+OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zitro.id; spf=pass smtp.mailfrom=fe-bounces.zitro.id; dkim=pass (1024-bit key) header.d=zitro.id header.i=@zitro.id header.b=C42Q2Gg+; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zitro.id
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.zitro.id
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zitro.id header.i=@zitro.id header.b="C42Q2Gg+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zitro.id;
 h=Content-Transfer-Encoding: Content-Type: MIME-Version: Message-ID: Date:
 Subject: Cc: To: From; q=dns/txt; s=fe-ef2ef2159a; t=1787353339;
 bh=Q7yQMPxarkqz1bDFzDREA+m2cp1YUbf0yvfPt7OlQ8A=;
 b=C42Q2Gg+i4YQAz95Q2xt2nMqFOavcQfg5u5+SI1jUERwvBbCeRTKp+3mVy65BpKRtYLrQGAmE
 iPZVFcqehCPYkA0rlKPhdnAWd9pQDzwFQlTu7vbBBI7WmQwmqqncvLjVZb84b2QWwZAuD8TPHd/
 kcm8DTvdel9p+hb+9BumKqI=
X-Forward-Email-ID: 6a88d8f896141d1f979b2754
X-Forward-Email-Sender: rfc822; 0@zitro.id, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.13.16
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Volodymyr Vriukalo <0@zitro.id>
To: git@vger.kernel.org
Cc: Volodymyr Vriukalo <0@zitro.id>,
	Junio C Hamano <gitster@pobox.com>,
	Atharva Raykar <raykar.ath@gmail.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
	Olamide Caleb Bello <belkid98@gmail.com>,
	Glen Choo <glencbz@gmail.com>,
	Jonathan Tan <jonathantanmy@fastmail.com>
Subject: [PATCH 0/2] branch: fix --recurse-submodules with a nameless start point
Date: Sat, 22 Aug 2026 01:01:40 +0200
Message-ID: <20260822-vv-branch-recurse-no-start-ref-v1-0-46dc140acaa8@zitro.id>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260822-vv-branch-recurse-no-start-ref-31fac1e34eab
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3872; i=0@zitro.id; h=from:subject:message-id; bh=cSBV2TI157My7SritYRYM764kCf1UO8pNh9hU8FVcNg=; b=owGbwMvMwCXWv3ZB/MVrrO8ZT6slMWR1XM9+cNxOdl7JzzMPWqYUSEf/MnI6eEH3cuP+i2b7p hurdaaFdZSyMIhxMciKKbK4+s7Oz2TrnaUx8+A2mDmsTCBDGLg4BWAi6sYM/z3j1kjlTleNb5dz N9okcZf77q2Txla/f/Orfi1z6Nil38LIcI89IoxPS3fvS9Y5TzybBLQd7C68eDjp4s25yTN++Un KcAEA
X-Developer-Key: i=0@zitro.id; a=openpgp; fpr=23DE306A7F9E54C26627EF2975B69E8242090518
Content-Transfer-Encoding: 8bit

vv/branch-recurse-no-start-ref

"git branch" with submodule.propagateBranches enabled mishandled a
start point that names no ref, such as a raw object id.  In a
repository with no submodules it aborted with a BUG after having
already moved the branch; with submodules it failed earlier, when the
helper it invokes rejected a truncated argument list.  Both are the
same missing tracking name, which has been corrected.

I hit the first of these while scripting a branch rewrite -- the sort
that moves a branch to a commit no ref points at yet, which for such a
script is the ordinary case rather than the exception:

    BUG: refspec.c:442: refspec_find_match: need either src or dst
    Aborted (core dumped)

The ref had already been updated.  So the abort is loud and the damage
is quiet, which is the wrong way round: an exit status of 134 on an
operation that in fact completed will fool any caller that checks it,
and one whose error path rolls back will helpfully undo a successful
update.

The exposure is bounded.  submodule.propagateBranches is documented as
experimental, and reproducing it needs all four of that setting,
submodule.recurse, a configured remote, and a start point that is not a
ref name; drop any one and the command succeeds.  Within those bounds
it is not exotic -- a script that moves a branch by object id hits it
on the first attempt, the commit it wants having no ref on it yet,
which is rather the point of moving a branch.  It reproduces
identically on 2.54.0, 2.55.0 and master, which is why this is based on
maint.

Both patches guard at the call site rather than inside the callee.
That follows create_branch(), which already declines the same value
with "if (real_ref && track)", and it leaves setup_tracking()'s own
convention intact: it opens by BUG()ing on a caller that should not
have called it, so absorbing a NULL quietly would contradict that four
lines later.  Neither patch changes anything for a start point that
does name a ref.

This series was written with LLM assistance, recorded as an
"Assisted-by: An LLM." trailer on both patches.  I used it for the
whole change rather than as step-by-step guidance, because at this
size the distinction is irrelevant: two guards and two tests, short
enough to read in full.  I have read the surrounding code and checked
every claim in the commit messages against the source myself.

Two things I would welcome direction on.

dwim_and_setup_tracking() carries the same unguarded call.  It survives
only because its single caller passes BRANCH_TRACK_OVERRIDE, under
which dwim_branch_start() dies rather than returning NULL -- safe by an
argument its caller happens to pass, not by anything in the function
itself.  Nothing enforces that, so a future caller could reintroduce
the same abort.  I left it alone to keep the series to the bug I
actually hit, but I am happy to add a third patch.

The first test uses no submodule, because the bug does not need one.  I
put it in t3207 since create_branches_recursively() is only reached
under submodule.propagateBranches, but t3200 is a perfectly defensible
home and I will move it on request.

The series merges cleanly into next and seen; both merge results build
and pass t3200 and t3207, and the full suite passes on the topic
itself.

---
Volodymyr Vriukalo (2):
      branch: do not track a start point with no ref
      branch: allow recursion with no tracking name

 branch.c                    | 12 ++++++++++--
 builtin/submodule--helper.c |  7 ++++---
 t/t3207-branch-submodule.sh | 30 ++++++++++++++++++++++++++++++
 3 files changed, 44 insertions(+), 5 deletions(-)
---
base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
change-id: 20260822-vv-branch-recurse-no-start-ref-31fac1e34eab

Best regards,
--  
Volodymyr Vriukalo <0@zitro.id>

