From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 2/3] submodule deinit: lose requirement for giving '.'
Date: Tue, 3 May 2016 11:07:27 -0700
Message-ID: <CAGZ79kaHmtRooJ7J6BknqWDkVFN0Bx3xngkEH0CnAp7Aaehnig@mail.gmail.com>
References: <1462227844-10624-1-git-send-email-sbeller@google.com>
	<1462227844-10624-3-git-send-email-sbeller@google.com>
	<xmqqoa8nnjld.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 03 20:07:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axejM-00052t-Rh
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 20:07:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934331AbcECSH3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 14:07:29 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:36337 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934275AbcECSH2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 14:07:28 -0400
Received: by mail-ig0-f180.google.com with SMTP id u10so123920993igr.1
        for <git@vger.kernel.org>; Tue, 03 May 2016 11:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=PhtpBEI8McEiyQJSe03oukrks50y86Y6Hxem5IzsQ4c=;
        b=kp7Gej0TvJ3+lQx/vdNrB2NOO6FhJ1mbWISQB9U/YeSYWShynbpmQpI2+tiM6F3FKN
         RVcCtBNmbSWJbxI0LnIDwbrsI7LjjJk+lvHrXHag6YitODMA5urCbf+HT6NbNXX0RYgs
         RCZT6GXj3/SjCw2dkCvFwqOUyJrUf20j5Xi/AvbSUyqL6hzxgz9D3aAFB3CgDN66kRRe
         HZvddW5Qt+wX7Np8gIn44x5cAo5iJ6qfocJM5phVZpU+kI7wAh/AaNsmPQGRo8kbIyE1
         +x1ch+uNwRJwqQYnpxoLgbNzpgReN94GT56osoc9eaBJWnST22aNh/cYHqn5rLlo0++A
         3hJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=PhtpBEI8McEiyQJSe03oukrks50y86Y6Hxem5IzsQ4c=;
        b=GJyOwVAxLHhwnTGW7xfu9eddJtdSUMDihXxE+QYey6F1k1fhAvkeNoDzYTUXE3c6Fp
         RtkSxhymXKexvBp5cJVOpGZ8jcIlpLX69fOcrQBf9Su/wGjXW0C7JTzZAH68r4KgugXe
         ra6NmIBtSyB/6S5uzS3aFTduEFlDWVKaCmwE4aXLFZvD2CxSMkcsWXG52+DWaruO9jm5
         xYTebpyVrNDkJhrFtWsw+6DWvMOgHTO9Qum9vlWjB1AnjANer3uV6Dd4cEbsW7BKZD9n
         N9ZmX9gcYj4FD7q/79/Zgz9XnSKf6CQCd89u1bfwxPTfcOy03dij3lM7ZYk3FcY1+fIk
         jr4g==
X-Gm-Message-State: AOPr4FU9F78kcMhzhhaOjT1OzzTOwfhHX3N10Ve4XB2++i+952JrlgT4Q614fb27fBFO6PVksU5srH0ppqWXf+op
X-Received: by 10.50.29.45 with SMTP id g13mr28908088igh.93.1462298847187;
 Tue, 03 May 2016 11:07:27 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Tue, 3 May 2016 11:07:27 -0700 (PDT)
In-Reply-To: <xmqqoa8nnjld.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293429>

On Tue, May 3, 2016 at 10:21 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> The discussion in [1] realized that '.' is a faulty suggestion as
>> there is a corner case where it fails:
>>
>>> "submodule deinit ." may have "worked" in the sense that you would
>>> have at least one path in your tree and avoided this "nothing
>>> matches" most of the time.  It would have still failed with the
>>> exactly same error if run in an empty repository, i.e.
>>>
>>>        $ E=/var/tmp/x/empty && rm -fr "$E" && mkdir -p "$E" && cd "$E"
>>>        $ git init
>>>        $ rungit v2.6.6 submodule deinit .
>>>        error: pathspec '.' did not match any file(s) known to git.
>>>        Did you forget to 'git add'?
>>>        $ >file && git add file
>>>        $ rungit v2.6.6 submodule deinit .
>>>        $ echo $?
>>>        0
>>
>> Allow no argument for `submodule deinit` to mean all submodules
>> and add a test to check for the corner case of an empty repository.
>>
>> There is no need to update the documentation as it did not describe the
>> special case '.' to remove all submodules.
>
> OK, and the reason why there is no need to update the actual code,
> other than the "do not allow" gate, is because "submodule--helper
> list" aka module_list already knows to list everything if no
> pathspec is given.  Am I reading the code (not in the patch)
> correctly?

You are correct.

>
>> [1] http://news.gmane.org/gmane.comp.version-control.git/289535
>
> The old discussion thread raises a good point.  The refusal to
> accept no-pathspec form for a potentially destructive "deinit" may
> have been a safety measure, even though the suggested way to tell
> the command "Yes, I know I want to deinit everything" was not a
> good one (i.e. it resulted in an error if your project did not have
> any files tracked yet).
>
> So possible ways forward may be
>
>  - to remove the safety altogether; or
>  - keep the safety, but give a better suggestion to say "Yes, deinit
>    everything".
>
> And this patch decides to take the former approach?

Yes.

>
> I am wondering if this can be solved in a cleaner way to teach
> "deinit" take a new "--all" option instead, e.g. something like...
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 82e95a9..4b84116 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -405,6 +405,7 @@ cmd_init()
>  cmd_deinit()
>  {
>         # parse $args after "submodule ... deinit".
> +       deinit_all=
>         while test $# -ne 0
>         do
>                 case "$1" in
> @@ -414,6 +415,9 @@ cmd_deinit()
>                 -q|--quiet)
>                         GIT_QUIET=1
>                         ;;
> +               -a|--all)
> +                       deinit_all=t
> +                       ;;
>                 --)
>                         shift
>                         break
> @@ -428,9 +432,9 @@ cmd_deinit()
>                 shift
>         done
>
> -       if test $# = 0
> +       if test $# = 0 && test -z "$deinit_all"
>         then
> -               die "$(eval_gettext "Use '.' if you really want to deinitialize all submodules")"
> +               die "$(eval_gettext "Use '--all' if you really want to deinitialize all submodules")"
>         fi
>
>         git submodule--helper list --prefix "$wt_prefix" "$@" |
>
>
> That would work even in the pathological "empty directory that has
> nothing to match even '.'" case without losing the safety, no?

It would work for the case

    git submodule deinit --all # as you would expect.

    git submodule deinit --all COPYIN* # would break
    git submodule deinit --all . # may break
    git submodule deinit --all path/to/some/submodules/ # would be unclear to me

So maybe we want to add a check that no pathspec arguments are given when
--all is given?
