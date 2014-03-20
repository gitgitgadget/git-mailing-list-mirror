From: Ilya Bobyr <ilya.bobyr@gmail.com>
Subject: Re: [PATCH v3] rev-parse --parseopt: option argument name hints
Date: Thu, 20 Mar 2014 16:19:16 -0700
Message-ID: <532B7774.30308@gmail.com>
References: <532AA923.6030409@gmail.com>	<1395305092-1928-1-git-send-email-ilya.bobyr@gmail.com> <xmqqpplgyaud.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 00:19:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQmFa-0006Gq-Bk
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 00:19:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760134AbaCTXTq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 19:19:46 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:65296 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760049AbaCTXTo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 19:19:44 -0400
Received: by mail-pa0-f41.google.com with SMTP id fa1so1631640pad.0
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 16:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=j22cnCK8VvMTIue3vWb4LY4J367KFWQRUOrOgpJ9Jm8=;
        b=K1+X3JZUPSc0As6VUhgfwGOCodyzcLxzn0YT8Xc3RK6sG06sTMmYKqFAVN7NHfMmCK
         ZciSNcjtV3OVSTZKuwZqipXErrHEt0vW7x4WQBVwrUXKv47Gve7x0rIP4SZ45b6BW4Km
         iCBrA2iiC+MTMhkMQUnGclp7vG3dV34WS9/OvLOoeDPrwdHifsEpxop3o/0wZ8OmFrrT
         vqHjNq/7/KAZYKGoRnxxEaKrruoxydyQwdIJloqmSWsPZYbloEH19brOGu7AlJpY/kcP
         5qI2pS4Kce5YsoSwlNPKbQdmZqGjnG+pJTilMpPo6/L0xGPU5Rb8cyPrTsE6Oq9QE32m
         Jptg==
X-Received: by 10.66.136.131 with SMTP id qa3mr49409947pab.77.1395357584045;
        Thu, 20 Mar 2014 16:19:44 -0700 (PDT)
Received: from [192.168.1.2] (c-50-136-172-14.hsd1.ca.comcast.net. [50.136.172.14])
        by mx.google.com with ESMTPSA id yj1sm16394161pab.30.2014.03.20.16.19.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Mar 2014 16:19:41 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:28.0) Gecko/20100101 Thunderbird/28.0
In-Reply-To: <xmqqpplgyaud.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244612>

On 3/20/2014 11:38 AM, Junio C Hamano wrote:
> Ilya Bobyr <ilya.bobyr@gmail.com> writes:
>
>> Built-in commands can specify names for option arguments when usage text
>> is generated for a command.  sh based commands should be able to do the
>> same.
>>
>> Option argument name hint is any text that comes after [*=?!] after the
>> argument name up to the first whitespace.  Underscores are replaced with
>> whitespace.  It is unlikely that an underscore would be useful in the
>> hint text.
>>
>> Signed-off-by: Ilya Bobyr <ilya.bobyr@gmail.com>
>> ---
>>   Changed according to the last comments.  Added "Usage text" paragraph in the
>>   documentation and updated variable names.
>>
>>   Documentation/git-rev-parse.txt |   34 ++++++++++++++++++++++++++++++++--
>>   builtin/rev-parse.c             |   17 ++++++++++++++++-
>>   t/t1502-rev-parse-parseopt.sh   |   20 ++++++++++++++++++++
>>   3 files changed, 68 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
>> index 0d2cdcd..b8aabc9 100644
>> --- a/Documentation/git-rev-parse.txt
>> +++ b/Documentation/git-rev-parse.txt
>> @@ -284,13 +284,13 @@ Input Format
>>   
>>   'git rev-parse --parseopt' input format is fully text based. It has two parts,
>>   separated by a line that contains only `--`. The lines before the separator
>> -(should be more than one) are used for the usage.
>> +(should be one or more) are used for the usage.
>>   The lines after the separator describe the options.
>>   
>>   Each line of options has this format:
>>   
>>   ------------
>> -<opt_spec><flags>* SP+ help LF
>> +<opt_spec><flags>*<arg_hint>? SP+ help LF
>>   ------------
>>   
>>   `<opt_spec>`::
>> @@ -313,6 +313,12 @@ Each line of options has this format:
>>   
>>   	* Use `!` to not make the corresponding negated long option available.
>>   
>> +`<arg_hint>`::
>> +	`<arg_hing>`, if specified, is used as a name of the argument in the
>> +	help output, for options that take arguments. `<arg_hint>` is
>> +	terminated by the first whitespace. When output the name is shown in
>> +	angle braces.  Underscore symbols are replaced with spaces.
> The last part is troubling (and sounds not very sane).  Do we do
> such a munging anywhere else, or is it just here?  If the latter I'd
> prefer not to see such a hack.

The following commands have spaces in argument names in the "-h" output 
for one or two arguments:
   * clone
   * commit
   * merge

A number of commands use dashes to separate words in arguments names.

"git notes" is the only command that uses an underscore in one argument 
name.

At the moment space is used to separate option specification from the 
help line.  As argument name hint is part of the option specification it 
ends at the first space.

It seems a bit unfair if sh based commands would not be able to use 
spaces while the build-in ones can.
As underscores are not used in the UI (at least that was my impression 
so far), I thought that to be a good option.

Do you think a different kind of escaping should be used? Backslashes?
Or no spaces?

>> @@ -333,6 +339,8 @@ h,help    show the help
>>   
>>   foo       some nifty option --foo
>>   bar=      some cool option --bar with an argument
>> +baz=arg   another cool option --baz with a named argument
>> +qux?path  qux may take a path argument but has meaning by itself
>>   
>>     An option group Header
>>   C?        option C with an optional argument"
>> @@ -340,6 +348,28 @@ C?        option C with an optional argument"
>>   eval "$(echo "$OPTS_SPEC" | git rev-parse --parseopt -- "$@" || echo exit $?)"
>>   ------------
>>   
>> +
>> +Usage text
>> +~~~~~~~~~~
>> +
>> +When "$@" is "-h" or "--help" the above example would produce the following
>> +usage text:
> Sounds like a good idea to add this; all the above arguments inside
> double quotes should be typeset `as-typed`, though.

Thanks, I will fix that.

>> @@ -419,6 +420,20 @@ static int cmd_parseopt(int argc, const char **argv, const char *prefix)
>>   		o->value = &parsed;
>>   		o->flags = PARSE_OPT_NOARG;
>>   		o->callback = &parseopt_dump;
>> +
>> +		/* Possible argument name hint */
>> +		end = s;
>> +		while (s > sb.buf && strchr("*=?!", s[-1]) == NULL)
>> +			--s;
>> +		if (s != sb.buf && s != end) {
>> +			char *a;
>> +			o->argh = a = xmemdupz(s, end - s);
>> +			while (a = strchr(a, '_'))
>> +				*a = ' ';
> ... and without the "underscore" munging, we do not have to allocate
> a new piece of memory, either.

We would have to do it any way to have the string zero terminated.
The list of arguments that holds the lines been parsed is "const char *".

But I do not think this is an argument to be considered when designing 
the user interface :)

Never the less if there is a way not to allocate extra memory that I am 
missing - let me know, I would remove the allocation.
