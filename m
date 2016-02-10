From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv9 3/6] fetching submodules: respect `submodule.fetchJobs`
 config option
Date: Tue, 9 Feb 2016 16:11:14 -0800
Message-ID: <CAGZ79kazD22FLv19CvmG+-dzGEP-uwr=fC_1VXB=sdzPBU_uww@mail.gmail.com>
References: <1455051274-15256-1-git-send-email-sbeller@google.com>
	<1455051274-15256-4-git-send-email-sbeller@google.com>
	<20160209223400.GI28749@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 01:11:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTINN-00048r-QM
	for gcvg-git-2@plane.gmane.org; Wed, 10 Feb 2016 01:11:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756326AbcBJALR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2016 19:11:17 -0500
Received: from mail-io0-f174.google.com ([209.85.223.174]:35508 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754173AbcBJALP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2016 19:11:15 -0500
Received: by mail-io0-f174.google.com with SMTP id d63so5178214ioj.2
        for <git@vger.kernel.org>; Tue, 09 Feb 2016 16:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=B0J64C5gd4zmsXWK0fPKhsQ2TiwPuIEMXGFM+HBjCyI=;
        b=DuECfRTPlRdjf+5i/ddAJSStrDjL6pUrGYedEs/687OXsFkM4MrgGBwdOtpa/KvXF+
         m1HeEwg89rUIReYguDwUKi4+6FMlKK3lKBXe6LtPqt2kMmPDZsrTLLJ6Bi5uf5k9nVsm
         yRx+KBtY/BKQiZeBipTx3/EHyAQzc7g/Siyb87qUd0KPfC4LPLptsYjpZQ+5Ym+DnBdt
         J5G638mk+LGGbmh0LB9l0QusGOtH7CE9ctM0EJJ6eUKsW84WwmIBz0mQq+Zrakhn4Xux
         PDgNH11VMH3ovzKbnnJ8SNDiORYfR4h+B19ZPuH/WoIgHioxjAajZX/4CSJKS3n7HXwf
         gZxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=B0J64C5gd4zmsXWK0fPKhsQ2TiwPuIEMXGFM+HBjCyI=;
        b=Sjpi9i2THhvrsIzmSwbmg1FuStkcd2abRFa1lXpsrsh4bB0dWnnTd5/wPNmlfRa3Vl
         nKtHGGjc1b5S6mP9ZFYWoZ5yfvLFPdNdd8C8rYdF1hhzprC9+/3mByQpP0PcvtCDKKsO
         DnoOp8qthugKx/g7kw4XXZDTBuLxrdSxkKXhjrO71gwC92oVfj7wj0d9eHFA1K+9bX6n
         FWdyb2iqxrq3XkqU88dmMf9EMjj1IKnmJyaY0OL8iRGThaLF+ccuVhatSwMJtTAcW05s
         gsLJIk1re8sHRghvlfKKiYQXDXjDCNUKVRkp2Xo4IqOJNUtbJXeAQIqRu2pvD4sdGh/5
         qBWg==
X-Gm-Message-State: AG10YOR0hIc5ksQQrjIyimEEEW1j6ui3AloIHHV0IPPJh7Z6ZlFXRgPyTYYdK0efrM+WZqPFUzOQZT3ZDeGS1uW6
X-Received: by 10.107.137.100 with SMTP id l97mr41389831iod.110.1455063074955;
 Tue, 09 Feb 2016 16:11:14 -0800 (PST)
Received: by 10.107.4.210 with HTTP; Tue, 9 Feb 2016 16:11:14 -0800 (PST)
In-Reply-To: <20160209223400.GI28749@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285886>

On Tue, Feb 9, 2016 at 2:34 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi,
>
> Stefan Beller wrote:
>
>> +++ b/submodule.c
> [...]
>> @@ -169,7 +170,13 @@ void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
>>
>>  int submodule_config(const char *var, const char *value, void *cb)
>>  {
>> -     if (starts_with(var, "submodule."))
>> +     if (!strcmp(var, "submodule.fetchjobs")) {
>> +             unsigned long val;
>> +             if (!git_parse_ulong(value, &val) || 0 > val || val >= INT_MAX)
>> +                     die(_("Error parsing submodule.fetchJobs %s"), value);
>
> 'val < 0' would be more idiomatic than '0 > val'.  More importantly,
> val is an unsigned long.  How could it be negative?
>
> Is it intended that val == INT_MAX is not permitted?  I would have
> expected something like the following to work:
>
>                 unsigned long val = git_config_ulong(var, value);
>                 if (val > INT_MAX) {
>                         errno = ERANGE;
>                         die_bad_number(var, value);
>                 }
>
> (using die_bad_number from config.c).  Or config.c could gain a
> git_config_nonnegative_int helper:
>
>         static int git_parse_nonnegative_int(const char *value, int *ret)
>         {
>                 uintmax_t tmp;
>                 if (!git_parse_unsigned(value, &tmp, maximum_signed_value_of_type(int)))
>                         return 0;
>                 *ret = tmp;
>                 return 1;
>         }
>
>         int git_config_nonnegative_int(const char *name, const char *value)
>         {
>                 int ret;
>                 if (!git_parse_nonnegative_int(value, &ret))
>                         die_bad_number(name, value);
>                 return ret;
>         }
>
> allowing
>
>                 parallel_jobs = git_config_nonnegative_int(var, val);
>                 return 0;

And I thought we wanted to prevent inventing yet another helper?
Although this looks very appealing, so let's do that instead.

>
> [...]
>> @@ -751,6 +758,9 @@ int fetch_populated_submodules(const struct argv_array *options,
>>       argv_array_push(&spf.args, "--recurse-submodules-default");
>>       /* default value, "--submodule-prefix" and its value are added later */
>>
>> +     if (max_parallel_jobs < 0)
>> +             max_parallel_jobs = parallel_jobs;
>
> Makes sense.
>
> [...]
>> @@ -1097,3 +1107,8 @@ void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir)
>>       strbuf_release(&rel_path);
>>       free((void *)real_work_tree);
>>  }
>> +
>> +int parallel_submodules(void)
>> +{
>> +     return parallel_jobs;
>> +}
>
> Is this helper used?

Not yet, but I rather want to introduce it here as it is easier to review here
than in a later patch?

>
> [...]
>> +++ b/submodule.h
>> @@ -41,5 +41,6 @@ int find_unpushed_submodules(unsigned char new_sha1[20], const char *remotes_nam
>>               struct string_list *needs_pushing);
>>  int push_unpushed_submodules(unsigned char new_sha1[20], const char *remotes_name);
>>  void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir);
>> +int parallel_submodules(void);
>
> optional trick: one way to avoid merge conflicts is to add each function
> at some logical place in the file instead of at the end.  Another nice
> side-effect is that it makes it easier to read through the header since
> functions appear in some appropriate order.
>
> E.g. this method could go near the config functions, I suppose.

I was not sure how relevant this is to configuration as it seems a bit
special w.r.t. submodules to me (it's not configured in .gitmodules, but a
standard configuration in .git/config after all).

>
>> --- a/t/t5526-fetch-submodules.sh
>> +++ b/t/t5526-fetch-submodules.sh
>> @@ -471,4 +471,18 @@ test_expect_success "don't fetch submodule when newly recorded commits are alrea
>>       test_i18ncmp expect.err actual.err
>>  '
>>
>> +test_expect_success 'fetching submodules respects parallel settings' '
>
> Makes sense.  Same trick about inserting in some appropriate place in
> the middle of the file applies here, too.  In tests it also ends up
> being useful for finding when tests overlap or when there's a gap in
> coverage.
>
> The documentation says that '0' does something appropriate (DWIM or
> something?  I didn't understand it).  Perhaps a test for that behavior
> would be useful, too.

The 0 is currently using 'online_cpus()' by default as a 'something
appropriate',
which is not really appropriate though. The documentation is worded
such that people should not rely on certain behaviors of '0'.

Maybe instead we could just hardcode 0 to 2 for now and test for that
instead. My reasoning for '2':
* provides the least amount of parallelism
* when fetching/cloning you have phases when the server works or when
   the client works. In absence of any good metric, I estimate the work load
   to be split 50:50. If that is the case the actual optimal number is 2 with
   these two jobs being shifted such that each client and server are
   loaded all the time.


>
> Thanks,
> Jonathan

Thanks,
Stefan
