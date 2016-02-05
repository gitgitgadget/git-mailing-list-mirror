From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv8 6/9] fetching submodules: respect `submodule.fetchJobs`
 config option
Date: Fri, 5 Feb 2016 10:50:36 -0800
Message-ID: <CAGZ79kaamt=7mLv23JyJiWL9cJ8deV4JWH_Kv0Csovvqs5SBcg@mail.gmail.com>
References: <1454623776-3347-1-git-send-email-sbeller@google.com>
	<1454623776-3347-7-git-send-email-sbeller@google.com>
	<xmqqa8nfeswj.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 19:50:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRlSs-0003jU-Gt
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 19:50:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755374AbcBESuj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 13:50:39 -0500
Received: from mail-io0-f171.google.com ([209.85.223.171]:36414 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755242AbcBESuh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 13:50:37 -0500
Received: by mail-io0-f171.google.com with SMTP id g73so138433144ioe.3
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 10:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=G11/4IqimsvlPSsEk0+3M1oT0yFPfKs5pM5rRydpfko=;
        b=FOs62feZch3CyMDjIYDjqXirir4uO8g8cmqJLLvNWmA4ua77a0kTHZrq7GzjSQQWZd
         wr2QeHrIR4CmR8uC6kwsjfGZa45mlcxE2BryN3cylaui3z8f9JxsiD+V79MMzTzgJGGU
         9fTVEZdetj8UT8fJIZIMo3CkdMU9Rhb0Y5IP+oaagczADkupMMzlx746FWgPC1DZK3H7
         2ETzvpuavIz42zvotpwxzV9Yo8jBudLrhV6MiQx2Sno9WY8PYU8Na6Qd6l7vDLYDw8BC
         0k30SvWMp9kT+yuvnM/IkNoiy6ZKdOzCJ9kz8xME2NZfk9CtMausymSwbNT3jNAOsqvz
         6UgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=G11/4IqimsvlPSsEk0+3M1oT0yFPfKs5pM5rRydpfko=;
        b=h7bcD28Mbe5NLMuaN5JXBWbCTFT/D1ub6NjOAYCV6sN26ibJW8I+wj5pSX9RFHZPiL
         H1pczkgR/+m3eciHdHhd+g0XjQLGnGAKJE0plp4n6XvHvWKgrcm3FT6Qp6MlWkXDjELj
         FTl+qlrN9WLqmgSGZt4yJIkQ5ADXIC0GbE5A/j4G7TcGdbrkLs0Q/PYqeHX9kOx17/4I
         +1ZJPWd5hgZVz4rCsN7a1dzWO7to3TnIuVACees5C245sspW5CgmCpIojJWeMxJf8Auu
         bVRvUHx+Ip5a45XvTzxa88AXG4Mf13fU9t0ztc4K41sjGozhtKUaJ9tBeqIHUOXFbnHu
         zV5w==
X-Gm-Message-State: AG10YOTl/VSsKLIBeQnSakBT6ZqzwTF53Y57BBQhm97j3DnilgeS4WUC6XNpllsTjL03MlYGopnxrKHIsFngOlDj
X-Received: by 10.107.168.149 with SMTP id e21mr16294685ioj.96.1454698236549;
 Fri, 05 Feb 2016 10:50:36 -0800 (PST)
Received: by 10.107.4.210 with HTTP; Fri, 5 Feb 2016 10:50:36 -0800 (PST)
In-Reply-To: <xmqqa8nfeswj.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285593>

On Thu, Feb 4, 2016 at 7:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> diff --git a/builtin/fetch.c b/builtin/fetch.c
>> index 586840d..5aa1c2d 100644
>> --- a/builtin/fetch.c
>> +++ b/builtin/fetch.c
>> @@ -37,7 +37,7 @@ static int prune = -1; /* unspecified */
>>  static int all, append, dry_run, force, keep, multiple, update_head_ok, verbosity;
>>  static int progress = -1, recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
>>  static int tags = TAGS_DEFAULT, unshallow, update_shallow;
>> -static int max_children = 1;
>> +static int max_children = -1;
>
> This makes sense as you would later be doing "If left unspecified,
> i.e. -1, then fall back to blah" ...

Right,
max_children is passed into fetch_populated_submodules, which
should handle that....

>
> g> diff --git a/submodule-config.c b/submodule-config.c
>> index 2841c5e..339b59d 100644
>> --- a/submodule-config.c
>> +++ b/submodule-config.c
>> @@ -32,6 +32,7 @@ enum lookup_type {
>>
>>  static struct submodule_cache cache;
>>  static int is_cache_init;
>> +static unsigned long parallel_jobs = -1;
>
> ... but I do not think this does.  For one thing, you would not be
> doing "If parallel_jobs < -1, then that is unspecified yet" for the
> unsigned long variable, and for another, I do not think you would be
> behaving differently for the first time (i.e. "unspecified yet" case).
>
> I think you want to initialize this to 1, if your "not configured at
> all" default is supposed to be 1.

Please read on in the patch, such that you find

@@ -751,6 +751,11 @@ int fetch_populated_submodules(
(This is where the max_children from builtin/fetch is passed into,
named max_parallel_jobs now)

+       if (max_parallel_jobs < 0)
+               max_parallel_jobs = config_parallel_submodules();
+       if (max_parallel_jobs < 0)
+               max_parallel_jobs = 1;
+

So if we don't get the config option from builtin/fetch, we ask for
config_parallel_submodules(), which is what you were seeing above
initialized as -1, too.  And if that is still -1, we default to 1 there.

So from a design perspective, you're rather saying we want to move part of
this logic into submodule-config.c, such that
config_parallel_submodules never returns -1,
but either 1 as the default or the actual configuration?
Then the code in fetch_populated_submodules, would be as simple as

    if (max_parallel_jobs < 0)
        max_parallel_jobs = config_parallel_submodules();
    // done , as config_parallel_submodules(); gives the last
authoritive answer.

Well looking at submodule-config.c this might be easier, too.

Ok.

>
>> @@ -233,6 +234,13 @@ static int parse_generic_submodule_config(const char *key,
>>                                         const char *value,
>>                                         struct parse_config_parameter *me)
>>  {
>> +     if (!strcmp(key, "fetchjobs")) {
>> +             if (!git_parse_ulong(value, &parallel_jobs)) {
>> +                     warning(_("Error parsing submodule.fetchJobs; Defaulting to 1."));
>> +                     parallel_jobs = 1;
>
> Hmph, this is not a die() because...?  Not a rhetorical question.

Because this config option doesn't alter the state of the repository.
After the fact you should not be able to tell how much parallel operations
were going on.

(As opposed to other options which alter the state of the repository)

I'll change it to die(...), though it sounds overly strict to me in this case.
But I guess consistency beats overstrictness here.

>
>> +unsigned long config_parallel_submodules(void)
>> +{
>> +     return parallel_jobs;
>> +}
>
> It is not a crime to make this return "int", as the code that
> eventually uses it will assign it to a variable that will be
> passed to run_processes_parallel() that takes an "int".

ok

>
> In fact, returning "int" would be preferrable.  You are causing
> truncation somewhere in the callchain anyway.  If the truncation
> bothers you, this function or immediately after calling
> git_parse_ulong() would be a good place to do a range check.  The
> variable parallel_jobs has to stay "unsigned long" in any case as
> you are calling git_parse_ulong().

ok, that should be the best place.

>
>> diff --git a/submodule.c b/submodule.c
>> index b83939c..eb7d54b 100644
>> --- a/submodule.c
>> +++ b/submodule.c
>> @@ -751,6 +751,11 @@ int fetch_populated_submodules(const struct argv_array *options,
>>       argv_array_push(&spf.args, "--recurse-submodules-default");
>>       /* default value, "--submodule-prefix" and its value are added later */
>>
>> +     if (max_parallel_jobs < 0)
>> +             max_parallel_jobs = config_parallel_submodules();
>> +     if (max_parallel_jobs < 0)
>> +             max_parallel_jobs = 1;
>> +
>>       calculate_changed_submodule_paths();
>>       run_processes_parallel(max_parallel_jobs,
>>                              get_next_submodule,
