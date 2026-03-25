Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0FD2BE655
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 06:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774419240; cv=none; b=ca9/AzLU1hKjvF5D56xJTjcXuHWOtWAE8QlHltwj15OK68jkcuyTE4bWhs2mOHRhSUJ7+lbtuOhM6Ow9Lht0dRGsqTNfJF7gw9GMItjzm9Bp6AC5pSaCzNTfKOO8AvgDZB3Lr6wc4B521IwF3Ggpco/M3vy/tJgqTmwlP1vioPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774419240; c=relaxed/simple;
	bh=N0ppZMqlOdXCT0y+I9pVUZyvkz8QIzmMg+8Bhj7GC7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HqUmTZDR1i+Q4NJvnmEf8V0LL8KkZPfSJlKsrCAPT0c6KVL5P9Z+8Y2doC3KlYS0aKsjBopWnreFngFpy7lGHOyTbt6LobBs8q9UaO793l30OZKDhF/PnU71ld8VHy5Fq2R9ySC9VEPcA0AncIZIrJFPTNImNIC3anMSq7fjuCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=cILv0f4i; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="cILv0f4i"
Received: (qmail 135459 invoked by uid 106); 25 Mar 2026 06:13:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=N0ppZMqlOdXCT0y+I9pVUZyvkz8QIzmMg+8Bhj7GC7U=; b=cILv0f4ioTwShbRvza8wJF6EU9vuVN0hRg9Ho+Z2A0caL77TkOnci3H9QfqeTR+u2JfERhk58ShcyQbnNfxGbrOIfjePRCtqQ1ldLNTOrB8aMDQ0Lba2uyCbURQYc9NemTpxDbaZvjExwj+X6v0L2dc9u9BS61cnU2vONM/ziSj8Qcm4rjooOTIJdvSuu8DZOL2xUG6Yrz+Q5a6c+82efLhy+7qz+A6r3o/R30Jy6vJ5q8qF0rtsX1WyXZ9GAsWvGFV8BTnytvTvvDBmhXxmHDmrxwcUHhnOf4OtAG56/xCy1FAQTTAXzmv8Axh+FmHw/pgpgXhR585MfUeK4D9k5w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 25 Mar 2026 06:13:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 181696 invoked by uid 111); 25 Mar 2026 06:13:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 25 Mar 2026 02:13:57 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 25 Mar 2026 02:13:57 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2026, #10)
Message-ID: <20260325061357.GA3772970@coredump.intra.peff.net>
References: <xmqqldfgy1ye.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqldfgy1ye.fsf@gitster.g>

On Tue, Mar 24, 2026 at 09:20:41PM -0700, Junio C Hamano wrote:

> * aa/reap-transport-child-processes (2026-03-12) 1 commit
>  . transport-helper, connect: use clean_on_exit to reap children on abnormal exit
> 
>  A few code paths that spawned child processes for network
>  connection weren't wait(2)ing for their children and letting "init"
>  reap them instead; they have been tightened.
> 
>  CI failures on Windows in t0061.24?
>  cf. <20260318040423.GA2858991@coredump.intra.peff.net>
>  source: <20260312214945.4050010-1-cshung@gmail.com>

After a grueling session with tmate to connect to a GitHub Actions
Windows runner, I can confirm that the patch below fixes the failure.

I had a lingering worry that maybe the test was a canary in the coal
mine, telling us that other real-world cases may be mad about getting
kill()ed. But after looking at it, I'm not sure. The fake ssh command is
_so_ fake here that it produces garbage output immediately and is
killed before even doing its logging. A real failure would happen
farther along in the process. And presumably a real ssh client that has
cleanup to do would catch the signal and do that cleanup.

So...it's probably OK to fix the test and proceed with graduating the
topic, I think?

Anyway, here's the fix I came up with. But see below the --- line, too.

-- >8 --
Subject: [PATCH] t0061: simplify .bat test

The test added by 71f4960b91 (t0061: fix test for argv[0] with spaces
(MINGW only), 2019-10-01) checks that we can use a .bat file with spaces
as GIT_SSH.

This is a good test in the sense that it's how the original bug was
detected. And as the commit message there describes, there are some
elements of the bug that are likely to come up with GIT_SSH and not
elsewhere: namely that in addition to the .bat file having spaces, we
must pass an argument with spaces (which happens naturally with ssh,
since we pass the upload-pack shell command for the other side to run).

But using GIT_SSH does complicate matters:

  1. We actually run the ssh command _twice_, once to probe the ssh
     variant with "-G" in fill_ssh_args(), and then a second time to
     actually make the connection. So we have to account for that when
     checking the output.

  2. Our fake ssh .bat file does not actually run ssh. So we expect the
     command to fail, but not before the .bat file has touched the "out"
     marker file that tells us it has run.

     This works now, but is fragile. In particular, the .bat file by
     default will echo commands it runs to stdout. From the perspective
     of the parent Git process, this is protocol-breaking garbage, and
     upon seeing it will die().

     That is OK for now because we don't bother to do any cleanup of the
     child process. But there is a patch under discussion, dd3693eb08
     (transport-helper, connect: use clean_on_exit to reap children on
     abnormal exit, 2026-03-12), which causes us to kill() the .bat
     process. This happens before it actually touches the "out" file,
     causing the test to fail.

We can simplify this by just using the "test-tool run-command" helper.
That lets us run whatever command we like with the arguments we want.
The argument here has a space, which is enough to trigger the original
bug that 71f4960b91 was testing. I verified that by reverting eb7c786314
(mingw: support spawning programs containing spaces in their names,
2019-07-16), the original fix, and confirming that the test fails (but
succeeds without the revert).

Signed-off-by: Jeff King <peff@peff.net>
---
One thing that puzzled me but that I figured out while writing the
commit message above is why the .bat file was writing garbage to stdout
in the first place. But then through the haze of DOS memories, I
recalled the horror of having to put "@echo off" at the top of every
batch file.

So probably the smallest fix is to just add that to the start of the
.bat file, or even just put "@" at the start of the single command in
the file. That would suppress the extra stdout, and Git would not
realize the bogus ssh command is failing until it exits without writing
anything (which is after it has touched the "out" file).

I didn't have the stomach or patience to spin up the tmate environment
again and test it, though. I do like how much simpler the test gets with
the t/helper program, but arguably using GIT_SSH is more realistic. I
dunno.

 t/t0061-run-command.sh | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index 2f77fde0d9..60cfe65979 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -287,16 +287,8 @@ test_expect_success MINGW 'can spawn .bat with argv[0] containing spaces' '
 	rm -f out &&
 	echo "echo %* >>out" >"$bat" &&
 
-	# Ask git to invoke .bat; clone will fail due to fake SSH helper
-	test_must_fail env GIT_SSH="$bat" git clone myhost:src ssh-clone &&
-
-	# Spawning .bat can fail if there are two quoted cmd.exe arguments.
-	# .bat itself is first (due to spaces in name), so just one more is
-	# needed to verify. GIT_SSH will invoke .bat multiple times:
-	# 1) -G myhost
-	# 2) myhost "git-upload-pack src"
-	# First invocation will always succeed. Test the second one.
-	grep "git-upload-pack" out
+	test-tool run-command run-command "$bat" "arg with spaces" &&
+	test_grep "arg with spaces" out
 '
 
 test_done
-- 
2.53.0.1057.g8b84bc5fb6

