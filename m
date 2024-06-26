Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9712CA92F
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 15:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719416052; cv=none; b=bHCW/DrOeG1D8ZyWA7aPxi5Et+x84FBg04oAbxqreHYFGIeNXuDDfuPf83D1pnnaKUQ+Wpb1DDYqctmvF4kisjqGd+DahbwmNavv32BKFASleg08mipVfTNg64LywcOxQ2elMCZJ/vhaGuts/jCZA5iwa/7wTtpEF8ifrRIoWQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719416052; c=relaxed/simple;
	bh=ngoLqzRDvZpDmX00/gK66P7GJ7OV/1nuu0zRtBB293E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jtzeekxyck4ZNxtB6bZztV4UtX+fPF/7Tm4nm44PnqbcBpdhzb854UdUEmxlabPRTXspLotACSKHRxUBv96WqOOTGJm5nt8bWMSnsM4jucK/d9922tz9NgQGa8i4vfLN/bO85i3OvERVwsYvpHPRBGzhcCp7PyUdqU+usz5sCqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZEJw5hgP; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZEJw5hgP"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D4AE91FD4B;
	Wed, 26 Jun 2024 11:34:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ngoLqzRDvZpDmX00/gK66P7GJ7OV/1nuu0zRtB
	B293E=; b=ZEJw5hgPjp3YuB3CBYy3ODuTYIiep6oLLhUgRsDZ1F4jhNpyRI+OTV
	UQvudse7eJN/cjGEYXKIMG9eyHrvUMFySNIGOy5fGzctN1xHfCbGKNp8IjxAGciB
	iTBUgnnBh+EpBhneDyE4pq2nF8XIVj4LSt/y4uSmP/SkE5FcYh7Bg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id CDDBE1FD48;
	Wed, 26 Jun 2024 11:34:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6C0D81FD12;
	Wed, 26 Jun 2024 11:34:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Abhijeet Sonar <abhijeet.nkt@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>,  
    git@vger.kernel.org,  Paul Millar <paul.millar@desy.de>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Elijah Newren <newren@gmail.com>,  Jeff King <peff@peff.net>
Subject: Re* [PATCH v5] describe: refresh the index when 'broken' flag is used
In-Reply-To: <2e80306e-2474-4254-95eb-c2902a56ffdd@gmail.com> (Abhijeet
	Sonar's message of "Wed, 26 Jun 2024 17:36:25 +0530")
References: <xmqq34p1813n.fsf@gitster.g>
	<20240626065223.28154-1-abhijeet.nkt@gmail.com>
	<CAOLa=ZRz2KEGiBnX1YP6JG1nXXHLfw9A3dHKO3s_ViLhq+bWww@mail.gmail.com>
	<2e80306e-2474-4254-95eb-c2902a56ffdd@gmail.com>
Date: Wed, 26 Jun 2024 08:34:04 -0700
Message-ID: <xmqqikxv4t1v.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 86355BFC-33D1-11EF-BDBB-DFF1FEA446E2-77302942!pb-smtp21.pobox.com

Abhijeet Sonar <abhijeet.nkt@gmail.com> writes:

> On 26/06/24 17:00, Karthik Nayak wrote:
>> Not worth a reroll, but you don't have to create file.new twice.
>
> Actually, now that I think of it, those two were better off being
> separate tests.  It might so happen the first call to describe
> refreshes the index, due to which the second call with the --broken
> option does not bug-out in the way it would if the command was run by
> itself. Having them separate would give them enough isolation so that
> previous command does not interfere with the later.

Good thinking.  Yes, we may end up having a few commands that are
duplicated in these two tests (for setting the stage up, for
example), but it would be better to test these two separately.

>>> Range-diff against v4:
>>> 1:  1da5fa48d9 ! 1:  52f590b70f describe: refresh the index when 'broken' flag is used
>>>      @@ builtin/describe.c: int cmd_describe(int argc, const char **argv, const char *pr
>>>       +			cp.git_cmd = 1;
>>>       +			cp.no_stdin = 1;
>>>       +			cp.no_stdout = 1;
>>>      -+			run_command(&cp);
>>>      -+			strvec_clear(&cp.args);
>>>      ++			if (run_command(&cp))
>>>      ++				child_process_clear(&cp);
>>>       +
>>>        			strvec_pushv(&cp.args, diff_index_args);
>>>        			cp.git_cmd = 1;
>>> --
>>> 2.45.2.606.g9005149a4a.dirty
>> Other than this, this looks good to me.
> I am not sure if I follow this one.  Am I expected to not share the
> struct child_process between the two sub-process calls?

Without reusing and instead of using two, we do not have to worry
about the reusablility of the child_process structure in the first
place, which is a huge plus, but in the longer run we should make
sure it is safe to reuse child_process and document the safe way to
reuse it (run-command.h does document a way to use it once and then
clean it up, but the "clean-up" extends only to not leaking
resources after we are done---it does not guarantee that it is OK to
reuse it).

I think with the updated "we clear cp ourselves if run_command() fails",
it should be safe to reuse, but it probably is even safer to do
something like this:

	... the first run ...
	if (run_command(&cp))
		child_process_clear(&cp);

	child_process_init(&cp);
	
        ... setup for the second run ...
	strvec_pushv(&cp.args, diff_index_args);
	cp.git_cmd = 1;
	... full set-up without relying on anything done earlier ...

The extra child_process_init() call may serve as an extra
documentation that we are reusing the same struct here (we often do
"git grep" for use of a specific API function before tree wide code
clean-up, and child_process_init() would be a good key to look for).

... goes and looks ...

Oh, I found an interesting one.  builtin/fsck.c:cmd_fsck() does this
in a loop:

	struct child_process verify = CHILD_PROCESS_INIT;

	... setup ...
	for (... loop ...) {
		child_process_init(&verify);
		... set up various .members of verify struct ...
		strvec_pushl(&verify.args, ... command line ...);
		if (run_command(&verify))
			errors_found |= ...;
	}

This code clearly assumes that it is safe to reuse the child_process
structure after you run_command() and let it clean-up if you do
another child_process_init().  And I think that is a sensible
assumption.

The code in builtin/fsck.c:cmd_fsck() is buggy when run_command()
fails, I think.  Without doing child_process_clear() there, doesn't
it leak the strvec?

------- >8 ------------- >8 ------------- >8 -------
Subject: [PATCH] fsck: clear child_process after failed run_command()

There are two loops that calls run_command() using the same
child_process struct near the end of cmd_fsck().  4d0984be (fsck: do
not reuse child_process structs, 2018-11-12) tightened these code
paths to reinitialize the structure in order to safely reuse it.

    The run-command API makes no promises about what is left in a struct
    child_process after a command finishes, and it's not safe to simply
    reuse it again for a similar command.

Upon failure, run_command() can return without releasing the
resource held by the child_process structure, which is done by
calling finish_command() which in turn calls child_process_clear().

Reinitializing the structure without calling child_process_clear()
for the next round would leak the .args and .env strvecs.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/fsck.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git c/builtin/fsck.c w/builtin/fsck.c
index d13a226c2e..398b492184 100644
--- c/builtin/fsck.c
+++ w/builtin/fsck.c
@@ -1078,8 +1078,10 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 				strvec_push(&commit_graph_verify.args, "--progress");
 			else
 				strvec_push(&commit_graph_verify.args, "--no-progress");
-			if (run_command(&commit_graph_verify))
+			if (run_command(&commit_graph_verify)) {
+				child_process_clear(&commit_graph_verify);
 				errors_found |= ERROR_COMMIT_GRAPH;
+			}
 		}
 	}
 
@@ -1096,8 +1098,10 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 				strvec_push(&midx_verify.args, "--progress");
 			else
 				strvec_push(&midx_verify.args, "--no-progress");
-			if (run_command(&midx_verify))
+			if (run_command(&midx_verify)) {
+				child_process_clear(&midx_verify);
 				errors_found |= ERROR_MULTI_PACK_INDEX;
+			}
 		}
 	}
 





