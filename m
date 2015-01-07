From: kelson@shysecurity.com
Subject: Re: [PATCH 1/2] support for --no-relative and diff.relative
Date: Wed, 07 Jan 2015 13:46:50 -0500
Message-ID: <54AD7F1A.3060500@shysecurity.com>
References: <548B7967.3060201@shysecurity.com>	<54972C29.7060801@shysecurity.com> <54A2E744.8010508@shysecurity.com>	<54A2FDC8.5010504@shysecurity.com> <54AC0B2B.90107@shysecurity.com> <xmqqiogijwdp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Philip Oakley <philipoakley@iee.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 07 19:47:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8vdH-0005G2-2a
	for gcvg-git-2@plane.gmane.org; Wed, 07 Jan 2015 19:47:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754096AbbAGSq6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2015 13:46:58 -0500
Received: from mail-qg0-f50.google.com ([209.85.192.50]:62177 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753931AbbAGSq5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2015 13:46:57 -0500
Received: by mail-qg0-f50.google.com with SMTP id z60so1264048qgd.23
        for <git@vger.kernel.org>; Wed, 07 Jan 2015 10:46:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=qKSd7QpDVXV33T6nw8LpfSbd9Ouj0Oj9Ih392HI0FRc=;
        b=eG3UjjURNooTPYApGd+xzQQIhZYDfOx4SqFUkIBCI917PGkQbAjBD1NdEc5odPwn7m
         1TG4MYDAk8HhwW9vc35hC4YAAl41rDZi0GCjM0JhMBWRST5iAIW9DugsQBAn9bUBh71G
         2WkV3CKoWXO4KY55x2trTrgB4Nmnwl+kCzegRI16D4KHQl+26ncSZLTHjUbNR/y98Z7c
         hzIvsFIh6hzEWL3iEsYursxUdf9csK6J1jptMhKPMEM9Y9qOSvXUAjAtrASf657U/sub
         Bz6S17AzGHbOw8MPDzfrWc+VxydW+21Hm3F7UBRT6rhWsuBwnn/vmG1gDpEN88pEqBpD
         b93A==
X-Gm-Message-State: ALoCoQlowasLP97pNXYy/rRpEu4XvfU6R6EQDgyD5GraakXjIpH3TNnGZuCjmwyH8WB2IMzGuJ1j
X-Received: by 10.224.69.200 with SMTP id a8mr7260413qaj.40.1420656417092;
        Wed, 07 Jan 2015 10:46:57 -0800 (PST)
Received: from [10.0.0.22] (pool-100-36-60-151.washdc.fios.verizon.net. [100.36.60.151])
        by mx.google.com with ESMTPSA id f49sm1911132qga.42.2015.01.07.10.46.56
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Jan 2015 10:46:56 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <xmqqiogijwdp.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262143>

>> Content-Type: text/plain; charset=utf-8; format=flowed
>Please.  No format=flawed.  Really.
I'll figure out the line-wrapping.

> Also this step is not about --no-relative and diff.relative but is only about --no-relative option.
Should I submit as two independent patches then? I took the approach of 
splitting them out into 1/2 vs 2/2 to distinguish, but it sounds like 
that isn't optimal.

> When "--relative" is given, options->prefix is set to something as we can see above.
>
> The --relative option is described as optionally taking <path> in the doc:
...
> Doesn't "--no-relative" codepath have to undo the effect of that assignment to options->prefix?
diff_setup_done NULLs options->prefix when DIFF_OPT_TST(options, 
RELATIVE_NAME) is cleared (--no-relative clears this option).

On review, this may be a bad approach though. Non-locality makes it 
harder to follow/understand and introduces a subtle bug.
current:  "git-diff --relative=path --no-relative --relative" == 
"git-diff --relative=path"
expected: "git-diff --relative=path --no-relative --relative" == 
"git-diff --relative"

> So I can agree with the design decision but only after spending 6
> lines to think about it.  For the end-users, this design decision
> needs to be explained and spelled out in the documentation.
Agreed; update to come.

-----Original Message-----
From: Junio C Hamano <gitster@pobox.com>
Sent: 01/07/2015 01:09 PM
To: kelson@shysecurity.com
CC: Git Mailing List <git@vger.kernel.org>,  Philip Oakley 
<philipoakley@iee.org>,  Duy Nguyen <pclouds@gmail.com>,  Jonathan 
Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] support for --no-relative and diff.relative

> kelson@shysecurity.com writes:

> Content-Type: text/plain; charset=utf-8; format=flowed

Please.  No format=flawed.  Really.

> Subject: Re: [PATCH 1/2] support for --no-relative and diff.relative

"diff: teach --no-relative to override earlier --relative" or
something.  Saying the affeced area upfront, terminated with a colon
':', will make it easier to spot in "git shortlog" output later.

Also this step is not about --no-relative and diff.relative but is
only about --no-relative option.

> added --no-relative option for git-diff (code, documentation, and tests)

"Add --no-relative option..."; we write in imperative, as if we are
giving an order to the project secretary to "make the code do/be so".

> --no-relative overrides --relative causing a return to standard behavior

OK (modulo missing full-stop).

>
> Signed-off-by: Brandon Phillips <kelson@shysecurity.com>

Please also have

	From: Brandon Phillips <kelson@shysecurity.com>

as the first line of the body of your e-mail message, if you are
letting your MUA only give your e-mail address without name.
Alternatively, please ask/configure your MUA to put your name as
well as your address on From: header of the e-mail (which is
preferrable).

> diff --git a/diff.c b/diff.c
> index d1bd534..7bceba8 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -3695,6 +3695,8 @@ int diff_opt_parse(struct diff_options *options,
> const char **av, int ac)

Line-wrapped.

>   		DIFF_OPT_SET(options, RELATIVE_NAME);
>   		options->prefix = arg;
>   	}
> +	else if (!strcmp(arg, "--no-relative"))
> +		DIFF_OPT_CLR(options, RELATIVE_NAME);
>

When "--relative" is given, options->prefix is set to something as
we can see above.

The --relative option is described as optionally taking <path> in
the doc:

   --relative[=<path>]::
          When run from a subdirectory of the project, it can be
          told to exclude changes outside the directory and show
          pathnames relative to it with this option.  When you are
          not in a subdirectory (e.g. in a bare repository), you
          can name which subdirectory to make the output relative
          to by giving a <path> as an argument.

Doesn't "--no-relative" codepath have to undo the effect of that
assignment to options->prefix?

For example, after applying this patch, shouldn't

	$ cd t
	$ git show --relative=Documentation --no-relative --relative

work the same way as

	$ cd t
	$ git show --relative

i.e. limiting its output to the changes in the 't/' directory and
not to the changes in the 'Documentation/' directory?

Patch 2/2 also seems to share similar line-wrapping breakages that
make it unappliable, but more importantly, the configuration that is
supposed to correspond to --relative option only parses a boolean.
Is that the right design, or should it also be able to substitute a
command line `--relative=<path>` with an argument?

The last was a half-way rhetorical question and my answer is that
boolean-only is the best you could do, because we cannot do the
usual "bool or string" trick when "string" can be arbitrary.  In
other words, "diff.relative=true" could mean "limit to the current
subdirectory" aka "--relative" or it could mean "limit to true/
subdirectory" aka "--relative=true", and there is no good way to
disambiguate between the two [*1*].

So I can agree with the design decision but only after spending 6
lines to think about it.  For the end-users, this design decision
needs to be explained and spelled out in the documentation.  Saying
"equivalent to `--relative`" is not sufficient, because the way
`--relative` option itself is described elsewhere.  The option
appears as `--relative[=<path>]` (see above), so some people _will_
read "equivalent to `--relative`" to mean "Setting diff.relative=t
should be equivalent to --relative=t", which is not what actually
happens.


[Footnote]

*1* Actually, you could declare that "diff.relative=true/" means the
      'true/' directory while "diff.relative=true" means the boolean
      'true' aka 'diff --relative', but I think it is too confusing.
      Let's not make it worse by going that route.
