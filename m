From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] test-run-command: Increase test coverage
Date: Tue, 20 Oct 2015 11:53:33 -0700
Message-ID: <xmqq1tcp8j82.fsf@gitster.mtv.corp.google.com>
References: <1445279086-31066-1-git-send-email-sbeller@google.com>
	<1445279086-31066-6-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Oct 20 20:53:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zoc2W-00073z-Cx
	for gcvg-git-2@plane.gmane.org; Tue, 20 Oct 2015 20:53:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752427AbbJTSxg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2015 14:53:36 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35206 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751518AbbJTSxf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2015 14:53:35 -0400
Received: by pasz6 with SMTP id z6so29100088pas.2
        for <git@vger.kernel.org>; Tue, 20 Oct 2015 11:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=gg3B0/mAVzlb1LodT9Q5WhJfxliGOhQkDN8+urP07TY=;
        b=RKrcQ9HxIVpINgZUkCL0+W/d1RqR2R7t9xGw9XaqYec8Etfwm4OmS1syokkUtzT1Wg
         zsFNHrckGMpJj05yHKNlf6siiNzC0d/n9pwITTxiQEJbh2AOef7JOX5kS2syjdrct1CD
         JjCrEUgAETe1Ee+Mkhy48ygCiIJt8O/jarI0ZnVGU1yuSyNl4K00d1eTur51RpXrwfcH
         LbYdxaPQQMnAelTFlAbl1f1YU/UYnQXsAc8ySYUHO1qz5mloopHE8Ni0T4bmpPZB7ewP
         gVkhQwP3sJ0a3vfw94rzk0Xj9oDyA+JLpt1zHZ/GLFdqGRBKll65scuGc/JsSMUd/Lyb
         ThBg==
X-Received: by 10.68.242.2 with SMTP id wm2mr5626139pbc.31.1445367215208;
        Tue, 20 Oct 2015 11:53:35 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:e1b1:e6e0:dc10:8032])
        by smtp.gmail.com with ESMTPSA id po4sm5050283pbb.64.2015.10.20.11.53.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 20 Oct 2015 11:53:34 -0700 (PDT)
In-Reply-To: <1445279086-31066-6-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 19 Oct 2015 11:24:46 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279933>

Stefan Beller <sbeller@google.com> writes:

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  t/t0061-run-command.sh | 16 +++++++++++++---
>  test-run-command.c     | 12 ++++++++----
>  2 files changed, 21 insertions(+), 7 deletions(-)
>
> diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
> index 0af77cd..f27ada7 100755
> --- a/t/t0061-run-command.sh
> +++ b/t/t0061-run-command.sh
> @@ -62,8 +62,18 @@ Hello
>  World
>  EOF
>  
> -test_expect_success 'run_command runs in parallel' '
> -	test-run-command run-command-parallel-4 sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
> +test_expect_success 'run_command runs in parallel with more jobs available than tasks' '
> +	test-run-command run-command-parallel 5 sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'run_command runs in parallel with as many jobs as tasks' '
> +	test-run-command run-command-parallel 4 sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'run_command runs in parallel with more tasks than jobs available' '
> +	test-run-command run-command-parallel 3 sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
>  	test_cmp expect actual
>  '
>  
> @@ -77,7 +87,7 @@ asking for a quick stop
>  EOF
>  
>  test_expect_success 'run_command is asked to abort gracefully' '
> -	test-run-command run-command-abort-3 false 2>actual &&
> +	test-run-command run-command-abort 3 false 2>actual &&
>  	test_cmp expect actual
>  '
>  
> diff --git a/test-run-command.c b/test-run-command.c
> index 4b59482..44710c3 100644
> --- a/test-run-command.c
> +++ b/test-run-command.c
> @@ -47,6 +47,7 @@ static int task_finished(int result,
>  int main(int argc, char **argv)
>  {
>  	struct child_process proc = CHILD_PROCESS_INIT;
> +	int jobs;
>  
>  	if (argc < 3)
>  		return 1;
> @@ -61,12 +62,15 @@ int main(int argc, char **argv)
>  	if (!strcmp(argv[1], "run-command"))
>  		exit(run_command(&proc));
>  
> -	if (!strcmp(argv[1], "run-command-parallel-4"))
> -		exit(run_processes_parallel(4, parallel_next,
> +	jobs = atoi(argv[2]);
> +	proc.argv = (const char **)argv+3;

	proc.argv = (const char **)argv + 3;

or

	proc.argv = (const char **)&argv[3];

Given the line immediately before refers to argv[2], the latter
might be easier on the eyes to follow.

In what way does this "Increase" test coverage?  By allowing the
caller to specify arbitrarily higher parallelism?

> +
> +	if (!strcmp(argv[1], "run-command-parallel"))
> +		exit(run_processes_parallel(jobs, parallel_next,
>  					    NULL, NULL, &proc));
>  
> -	if (!strcmp(argv[1], "run-command-abort-3"))
> -		exit(run_processes_parallel(3, parallel_next,
> +	if (!strcmp(argv[1], "run-command-abort"))
> +		exit(run_processes_parallel(jobs, parallel_next,
>  					    NULL, task_finished, &proc));
>  
>  	fprintf(stderr, "check usage\n");
