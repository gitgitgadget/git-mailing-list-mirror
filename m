From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 8/8] git submodule update: Have a dedicated helper for cloning
Date: Wed, 21 Oct 2015 14:06:37 -0700
Message-ID: <CAGZ79kaa6b49rDW204ydtY0cf4NugSKOm+sBHKBYYoEsVugVfw@mail.gmail.com>
References: <1445381030-23912-1-git-send-email-sbeller@google.com>
	<1445381030-23912-9-git-send-email-sbeller@google.com>
	<xmqqd1w8uewx.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Eric Sunshine <ericsunshine@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 21 23:06:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zp0ap-00016V-Fb
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 23:06:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755641AbbJUVGj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2015 17:06:39 -0400
Received: from mail-yk0-f178.google.com ([209.85.160.178]:33990 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751508AbbJUVGi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2015 17:06:38 -0400
Received: by ykdr3 with SMTP id r3so63080864ykd.1
        for <git@vger.kernel.org>; Wed, 21 Oct 2015 14:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=NeMaQtOanBL8n0RkkHszZpayOyt6CW3v4+5ruGNVJTU=;
        b=OlVzKTAd6RLChYxHrUrcorH0QY3sodRaZIRaBj0I6Ze/y5JJaUYfAQJb1rqnVChPPJ
         l4+70o3AcCKnaTOuLgrpohjsJ0H443liVQ/UggTsaLz/anxn7aceudtefm5zxgoUHeNh
         a6fLseXbcuxEgOe17gmKTyI2RMkO6VR1PXH/J3aJPlfQnVs3CS97FnKn2YmbguJKHE6L
         1Z0Rb71q2yq5ZZwRXBE8X/oKIcNkdwt1U5UwgFbsrZqT7/wyOYxPPgpUa+RLvAmSy2tO
         JQaaA/UgajQJFvDIAb+4zY6q6lmG4iSyGVm5fPEPA1TUCEHeT7lgEV0cCVUfGEvYXjoX
         o5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=NeMaQtOanBL8n0RkkHszZpayOyt6CW3v4+5ruGNVJTU=;
        b=G20m/Pb1lATSv8bBnF3LXCn4QvIBe4T5l5aohnoIKmkLtz0w5KrfOFsPFsjbOqLw3h
         B5e/XmdAa3UtVY2AsYoP3BUxJHbVcbaRRNQb0+p3jsBfiM2Vy6GGakKQa1oBaOFQX7gh
         qU0f19qf/+k5KPID9xI8D8/HDlpcgPbxUBrbshrRlzmHNWXU6pKpzoq8CsH7hZj8qmEt
         kMcSUJlgGMD1zgjmVpF+Bae46/uJqxnMJZy8MoFAq9iIelI5fUksk8a7jMFQzgPxDHYo
         CvZoTjKq3ItLqgmFF8xRF+c2xNR0bK3NHDyge20l7wIkSZ1yDbwZH0uzBYHANvz8SqmS
         e2MA==
X-Gm-Message-State: ALoCoQlmB0XACKCY8QUokeqdaFJTVBUwq68IsgcUqZEnkkfBJpV6KeqNWe3TFsqlCQloIQ62lX5w
X-Received: by 10.13.230.194 with SMTP id p185mr9486566ywe.320.1445461597390;
 Wed, 21 Oct 2015 14:06:37 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Wed, 21 Oct 2015 14:06:37 -0700 (PDT)
In-Reply-To: <xmqqd1w8uewx.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280021>

On Wed, Oct 21, 2015 at 1:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> This introduces a new helper function in git submodule--helper
>> which takes care of cloning all submodules, which we want to
>> parallelize eventually.
>>
>> Some tests (such as empty URL, update_mode==none) are required in the
>> helper to make the decision for cloning. These checks have been moved
>> into the C function as well. (No need to repeat them in the shell
>> script)
>>
>> As we can only access the stderr channel from within the parallel
>> processing engine, so we need to reroute the error message for
>> specified but initialized submodules to stderr. As it is an error
>> message, this should have gone to stderr in the first place, so a
>> bug fix along the way.
>
> The last paragraph is hard to parse; perhaps it is slightly
> ungrammatical.

I seem to have started a habit starting my sentences with "so..."
even in spoken English. If left out, this may be easier to read:

    As we can only access the stderr channel from within the parallel
    processing engine, we need to reroute the error message for
    "specified but initialized submodules" to stderr. As it is an error
    message, this should have gone to stderr in the first place.
    It's a bug fix along the way.

>
> It would be a really good idea to split the small bit to redirect
> the output that should have gone to the standard error to where it
> should as a preparatory step before showing this patch.

ok.

>
> I sense that this one is still a WIP/RFC, so I'll only skim it in
> this round (but I may come back and read it again later with finer
> toothed comb).
>
>> +static int get_next_task(void **pp_task_cb,
>> +                      struct child_process *cp,
>> +                      struct strbuf *err,
>> +                      void *pp_cb)
>
> Will you have only one caller of the parallel run-command API in
> this file, or will you be adding more to allow various different
> operations run in parallel as more things are rewritten?  I am
> guessing that it would be the latter, but if that is the case,
> perhaps the function wants to be named a bit more specificly for
> this first user, no?  Same for start_failure and task_finished.

Ok, will rename.
Although I am not sure if I need to rewrite more in C for "git submodule".

I only rewrite git submodule update because git clone --recurse is just
blindly calling out to git submodule update.  So instead of parallelizing
"submodule update" I could have put a parallel submodule clone into
the clone command. (That looks strangely appealing now, because it
may be even faster as there is no downstream pipe with sequential
checkouts, so you could have one parallel pool with chained clone
and checkout commands).

>
>> diff --git a/git-submodule.sh b/git-submodule.sh
>> index 8b0eb9a..ea883b9 100755
>> --- a/git-submodule.sh
>> +++ b/git-submodule.sh
>> @@ -655,17 +655,18 @@ cmd_update()
>>               cmd_init "--" "$@" || return
>>       fi
>>
>> -     cloned_modules=
>> -     git submodule--helper list --prefix "$wt_prefix" "$@" | {
>> +     git submodule--helper update-clone ${GIT_QUIET:+--quiet} \
>> +             ${wt_prefix:+--prefix "$wt_prefix"} \
>> +             ${prefix:+--recursive_prefix "$prefix"} \
>> +             ${update:+--update "$update"} \
>> +             ${reference:+--reference "$reference"} \
>> +             ${depth:+--depth "$depth"} \
>> +             "$@" | {
>>       err=
>> -     while read mode sha1 stage sm_path
>> +     while read mode sha1 stage just_cloned sm_path
>>       do
>
> I wonder if you really want this to be upstream of a pipe.  When the
> downstream loop needs to abort, what happens to the remainder of the
> "clone" part of the processing that is still ongoing in the upstream
> of the pipe?  I would imagine that the "update-clone" network
> accessing phase is the more human-time consuming part, so I suspect
> that it would be much better to let the cloning part go and finish
> first (during which time the human-user can spend time for other
> things, like getting cup of coffee or filling expense reports) and
> before moving to the loop that can stop and ask the human-user for
> help.
>
> The fix for the above could be trivial (do not pipe, just take the
> output to a temporary file, and then feed the "while read" loop from
> that temporary file), and I suspect it would make a big difference
> for usability.

I'd like to counter your argument with quoting code from update_clone
method:

     run_processes_parallel(1, get_next_task, start_failure,
task_finished, &pp);

     if (pp.print_unmatched) {
         printf("#unmatched\n");
         return 1;
     }

     for_each_string_list_item(item, &pp.projectlines) {
         utf8_fprintf(stdout, "%s", item->string);
     }

So we do already all the cloning first, and then once we did all of that
we just put out all accumulated lines of text. (It was harder to come up with
a sufficient file name than just storing it in memory. I don't think
memory is an
issue here, only a few bytes per submodule. So even 1000 submodules would
consume maybe 100kB)

Having a file though would allow us to continue after human interaction fixed
one problem.




>
> Thanks.
