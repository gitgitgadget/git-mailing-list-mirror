Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FC318E77D
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 16:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719418670; cv=none; b=NunN2HoITqzbmvuxOkVID9gNFvYX6m7kpfiEUi3jxyouZuRmnYUcYtA5vBB0dOXYPUul0g/WQD/rNoZ1s94ocZjQiyWoI3wU4MUfphJTNj93my1gLT1D1bDDV0eFjRHob5Uiu8dW2YE2fzxs2lyfhTyHQHS0iAauAaYc3iiekhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719418670; c=relaxed/simple;
	bh=0GGmnBM/40yupbkml2QUo/3+25Qasnj+hTooCmTdE1I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Koq3hK4hi8/Mglm1pRDm8bv5ALUSXKNy86BtbGYLaH7cjZe4fKMyuDljpDXR4Fi5jLLiczziSwnQhtTP3pS7ENy/hVy/tyyCXCXNBQ3KmL/6GH+LPAQBZt99rU+r24c/RZ7DalhAP7rwjWR2SeASq1xUBDl6D7VdsKF601nd6+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=NeND6UtR; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NeND6UtR"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 745722024A;
	Wed, 26 Jun 2024 12:17:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=0GGmnBM/40yupbkml2QUo/3+25Qasnj+hTooCm
	TdE1I=; b=NeND6UtRXvNbE5oDKMyWck/c/cEOlz5UlORQCV36GwtYDuT+jaeuUi
	y9E0HOdDtkCeAVDNwKMM9XR5Ko6OPW4eOmNFTo0CTatjKyUhelamHPQZkYpp8nML
	d3+xFOnAz6iWyAzPEaF6M9TEM1x95335JB8OnjmXq/u6Tje2wvC2c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6C4BE20249;
	Wed, 26 Jun 2024 12:17:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0C8BB20248;
	Wed, 26 Jun 2024 12:17:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Abhijeet Sonar <abhijeet.nkt@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,  Paul
 Millar <paul.millar@desy.de>,  Phillip Wood <phillip.wood123@gmail.com>,
  Elijah Newren <newren@gmail.com>,  Jeff King <peff@peff.net>
Subject: Re: Re* [PATCH v5] describe: refresh the index when 'broken' flag
 is used
In-Reply-To: <xmqqikxv4t1v.fsf_-_@gitster.g> (Junio C. Hamano's message of
	"Wed, 26 Jun 2024 08:34:04 -0700")
References: <xmqq34p1813n.fsf@gitster.g>
	<20240626065223.28154-1-abhijeet.nkt@gmail.com>
	<CAOLa=ZRz2KEGiBnX1YP6JG1nXXHLfw9A3dHKO3s_ViLhq+bWww@mail.gmail.com>
	<2e80306e-2474-4254-95eb-c2902a56ffdd@gmail.com>
	<xmqqikxv4t1v.fsf_-_@gitster.g>
Date: Wed, 26 Jun 2024 09:17:37 -0700
Message-ID: <xmqqcyo33cgu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9B71C7B6-33D7-11EF-B545-DFF1FEA446E2-77302942!pb-smtp21.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Subject: [PATCH] fsck: clear child_process after failed run_command()
>
> There are two loops that calls run_command() using the same
> child_process struct near the end of cmd_fsck().  4d0984be (fsck: do
> not reuse child_process structs, 2018-11-12) tightened these code
> paths to reinitialize the structure in order to safely reuse it.
>
>     The run-command API makes no promises about what is left in a struct
>     child_process after a command finishes, and it's not safe to simply
>     reuse it again for a similar command.
>
> Upon failure, run_command() can return without releasing the
> resource held by the child_process structure, which is done by
> calling finish_command() which in turn calls child_process_clear().

Sorry, but I have to take this back.  

The error return code paths in the start_command() function does
seem to call clear_child_process(), which means that there is no
need to call clear_child_process() ourselves after a failed
run_command() call.

The need for reinitializing that established by 4d0984be (fsck: do
not reuse child_process structs, 2018-11-12) still stand, so

	... the first run ...
	run_command(&cp);
	/* no need for separate child_process_clear(&cp) */

	child_process_init(&cp); /* prepare for reuse */
	
        ... setup for the second run ...
	strvec_pushv(&cp.args, diff_index_args);
	cp.git_cmd = 1;
	... full set-up without relying on anything done earlier ...

would still be needed.

Or alternatively, we could do this to ensure that the child_process
structure is always reusable.

 run-command.c | 1 +
 run-command.h | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git c/run-command.c w/run-command.c
index 6ac1d14516..aba250fbe1 100644
--- c/run-command.c
+++ w/run-command.c
@@ -26,6 +26,7 @@ void child_process_clear(struct child_process *child)
 {
 	strvec_clear(&child->args);
 	strvec_clear(&child->env);
+	child_process_init(child);
 }
 
 struct child_to_clean {
diff --git c/run-command.h w/run-command.h
index 55f6631a2a..6e203c22f6 100644
--- c/run-command.h
+++ w/run-command.h
@@ -204,7 +204,8 @@ int start_command(struct child_process *);
 
 /**
  * Wait for the completion of a sub-process that was started with
- * start_command().
+ * start_command().  The child_process structure is cleared and
+ * reinitialized.
  */
 int finish_command(struct child_process *);
 
@@ -214,6 +215,9 @@ int finish_command_in_signal(struct child_process *);
  * A convenience function that encapsulates a sequence of
  * start_command() followed by finish_command(). Takes a pointer
  * to a `struct child_process` that specifies the details.
+ * The child_process structure is cleared and reinitialized,
+ * even when the command fails to start or an error is detected
+ * in finish_command().
  */
 int run_command(struct child_process *);
 

