From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] SQUASH???
Date: Thu, 24 Sep 2015 18:09:44 -0700
Message-ID: <xmqqwpvfticn.fsf@gitster.mtv.corp.google.com>
References: <xmqqzj0cv9v8.fsf@gitster.mtv.corp.google.com>
	<1443129187-18572-1-git-send-email-sbeller@google.com>
	<1443129187-18572-3-git-send-email-sbeller@google.com>
	<xmqqa8sbuxu0.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, ramsay@ramsayjones.plus.com,
	jacob.keller@gmail.com, peff@peff.net, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	vlovich@gmail.com, ericsunshine@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Sep 25 03:09:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfHWI-0003TB-S5
	for gcvg-git-2@plane.gmane.org; Fri, 25 Sep 2015 03:09:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752376AbbIYBJr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 21:09:47 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35505 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751280AbbIYBJq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 21:09:46 -0400
Received: by pacfv12 with SMTP id fv12so90104490pac.2
        for <git@vger.kernel.org>; Thu, 24 Sep 2015 18:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=+zFuMbb7oMOxWIJfZZ0U6MJBY/8PHlRJnOsPHrYVK3k=;
        b=ipqNy4Z2vkAp91lULjWJ3C0t26RG7xqFF28tYDzBiXC8M5YqT0vp4WG1pM82pFdngG
         8s1dNvmYXv2QO8L7DwbkyQShQpoNIUO6QTuc+A5FA4a41b5OEQ4cnJVy1JSi9plzM9NN
         op670G2+oBe0oN1YmO8n92LrB4dn1kXUhyDyO/GSigRCnms+dLGgw5yaW/aC19OQGZIV
         JRjDz20SQYa8WRlfpsz/ANyaLDRxTrUWujvvCHg7i0f/QNs5VEXngZl6vT4/522GYhTt
         dwh0M7LnajANBjNMt4AtCvDVA9I+cI+90y3mWF5H73PAQ+6u6Mj0u5qqO7YNSKDw2UC0
         b6qQ==
X-Received: by 10.68.88.69 with SMTP id be5mr3348384pbb.105.1443143385932;
        Thu, 24 Sep 2015 18:09:45 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:9c11:78a0:634d:a891])
        by smtp.gmail.com with ESMTPSA id xm9sm701420pbc.32.2015.09.24.18.09.45
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Thu, 24 Sep 2015 18:09:45 -0700 (PDT)
In-Reply-To: <xmqqa8sbuxu0.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Thu, 24 Sep 2015 17:49:59 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278644>

Junio C Hamano <gitster@pobox.com> writes:

> I think that is a sensible change.  Don't we want the same for the
> other failure handler, though.  Capture any message from it and
> append it to the output of the process that just finished, or
> something?

Ah, that is already done.  Scratch that "don't we want" part.

>
> By the way, I understand that these two are solely for early review
> and I'll be getting them as either new patches or part of updated
> patches in the next reroll (i.e. you are not expecting me to split
> these apart and do "rebase -i" for you to the last-posted version).
> Asking only to make sure we are on the same wavelength.
>
> Thanks.
>
>>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  run-command.c | 43 ++++++++++++++++++++++++++++++-------------
>>  run-command.h |  1 +
>>  2 files changed, 31 insertions(+), 13 deletions(-)
>>
>> diff --git a/run-command.c b/run-command.c
>> index 494e1f8..0d22291 100644
>> --- a/run-command.c
>> +++ b/run-command.c
>> @@ -907,6 +907,7 @@ void default_start_failure(void *data,
>>  
>>  void default_return_value(void *data,
>>  			  struct child_process *cp,
>> +			  struct strbuf *err,
>>  			  int result)
>>  {
>>  	int i;
>> @@ -977,7 +978,7 @@ static void set_nonblocking(int fd)
>>  			"output will be degraded");
>>  }
>>  
>> -/* returns 1 if a process was started, 0 otherwise */
>> +/* return 0 if get_next_task() ran out of things to do, non-zero otherwise */
>>  static int pp_start_one(struct parallel_processes *pp)
>>  {
>>  	int i;
>> @@ -991,26 +992,30 @@ static int pp_start_one(struct parallel_processes *pp)
>>  	if (!pp->get_next_task(pp->data,
>>  			       &pp->children[i].process,
>>  			       &pp->children[i].err))
>> -		return 1;
>> +		return 0;
>>  
>> -	if (start_command(&pp->children[i].process))
>> +	if (start_command(&pp->children[i].process)) {
>>  		pp->start_failure(pp->data,
>>  				  &pp->children[i].process,
>>  				  &pp->children[i].err);
>> +		strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
>> +		strbuf_reset(&pp->children[i].err);
>> +		return -1;
>> +	}
>>  
>>  	set_nonblocking(pp->children[i].process.err);
>>  
>>  	pp->nr_processes++;
>>  	pp->children[i].in_use = 1;
>>  	pp->pfd[i].fd = pp->children[i].process.err;
>> -	return 0;
>> +	return 1;
>>  }
>>  
>> -static void pp_buffer_stderr(struct parallel_processes *pp)
>> +static void pp_buffer_stderr(struct parallel_processes *pp, int output_timeout)
>>  {
>>  	int i;
>>  
>> -	while ((i = poll(pp->pfd, pp->max_processes, 100)) < 0) {
>> +	while ((i = poll(pp->pfd, pp->max_processes, output_timeout)) < 0) {
>>  		if (errno == EINTR)
>>  			continue;
>>  		pp_cleanup(pp);
>> @@ -1069,7 +1074,8 @@ static void pp_collect_finished(struct parallel_processes *pp)
>>  			error("waitpid is confused (%s)",
>>  			      pp->children[i].process.argv[0]);
>>  
>> -		pp->return_value(pp->data, &pp->children[i].process, code);
>> +		pp->return_value(pp->data, &pp->children[i].process,
>> +				 &pp->children[i].err, code);
>>  
>>  		argv_array_clear(&pp->children[i].process.args);
>>  		argv_array_clear(&pp->children[i].process.env_array);
>> @@ -1111,15 +1117,26 @@ int run_processes_parallel(int n, void *data,
>>  			   return_value_fn return_value)
>>  {
>>  	struct parallel_processes pp;
>> -	pp_init(&pp, n, data, get_next_task, start_failure, return_value);
>>  
>> +	pp_init(&pp, n, data, get_next_task, start_failure, return_value);
>>  	while (1) {
>> -		while (pp.nr_processes < pp.max_processes &&
>> -		       !pp_start_one(&pp))
>> -			; /* nothing */
>> -		if (!pp.nr_processes)
>> +		int no_more_task, cnt;
>> +		int output_timeout = 100;
>> +		int spawn_cap = 4;
>> +
>> +		for (cnt = spawn_cap, no_more_task = 0;
>> +		     cnt && pp.nr_processes < pp.max_processes;
>> +		     cnt--) {
>> +			if (!pp_start_one(&pp)) {
>> +				no_more_task = 1;
>> +				break;
>> +			}
>> +		}
>> +
>> +		if (no_more_task && !pp.nr_processes)
>>  			break;
>> -		pp_buffer_stderr(&pp);
>> +		pp_buffer_stderr(&pp, output_timeout);
>> +
>>  		pp_output(&pp);
>>  		pp_collect_finished(&pp);
>>  	}
>> diff --git a/run-command.h b/run-command.h
>> index 3807fd1..f7035cb 100644
>> --- a/run-command.h
>> +++ b/run-command.h
>> @@ -138,6 +138,7 @@ typedef void (*start_failure_fn)(void *data,
>>  
>>  typedef void (*return_value_fn)(void *data,
>>  				struct child_process *cp,
>> +				struct strbuf *err,
>>  				int result);
>>  
>>  /**
