From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH v4 1/2] add `config_set` API for caching config files
Date: Thu, 03 Jul 2014 22:35:13 +0530
Message-ID: <53B58D49.8010409@gmail.com>
References: <1404280905-26763-1-git-send-email-tanayabh@gmail.com>	<1404280905-26763-2-git-send-email-tanayabh@gmail.com> <xmqqd2dnitm7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Karsten Blees <karsten.blees@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 03 19:05:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2kRq-0001kD-Gt
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jul 2014 19:05:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758903AbaGCRFW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2014 13:05:22 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:48292 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756228AbaGCRFV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2014 13:05:21 -0400
Received: by mail-pd0-f180.google.com with SMTP id fp1so520597pdb.39
        for <git@vger.kernel.org>; Thu, 03 Jul 2014 10:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=N0hpJjXZmDBvgywshrltDOxNN3kA8QXQrrnYy1feyY0=;
        b=HSiAIAyEY4cfDMtR0jMuXwOS9BzjlOF2F4tVMhykTvszEaHnu2H+PoI7s5byjDbBrK
         sVxGk9j6F6gkiwXBGOm8TsBDkzbhy2lCnWocdK2A7w3r/CuP4PSJCzbcrxcGFmTHa3en
         zMDDVi4oywO6CUotQZCpqP3pAyV08ukv1fI9W+s5cXqB/J4sVyH/Bd1vk9MzEn7vLld9
         loYkpQFB2ALZjyoyAZL9lXDBzYVCEaXaHUaBb6yPdvMBbYc+B3nGdp2NY1I92/5o3LwB
         SHD+TpOvqsg02pw0w4TmeFfJr2Gwy1h77UrgWfWxd9ag5fFGVZVpdtYiah6m7uxc3rHq
         6cqw==
X-Received: by 10.66.153.80 with SMTP id ve16mr5829127pab.143.1404407120401;
        Thu, 03 Jul 2014 10:05:20 -0700 (PDT)
Received: from [127.0.0.1] ([117.254.218.96])
        by mx.google.com with ESMTPSA id nf5sm39342645pbc.77.2014.07.03.10.05.16
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 03 Jul 2014 10:05:19 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqqd2dnitm7.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252869>



On 7/2/2014 10:30 PM, Junio C Hamano wrote:
> Tanay Abhra <tanayabh@gmail.com> writes:
> 
>> diff --git a/Documentation/technical/api-config.txt b/Documentation/technical/api-config.txt
>> index 230b3a0..2c02fee 100644
>> --- a/Documentation/technical/api-config.txt
>> +++ b/Documentation/technical/api-config.txt
>> @@ -77,6 +77,75 @@ To read a specific file in git-config format, use
>> +`git_config_get_value` returns 0 on success, or -1 for no value found.
>> +
>> +`git_config_get_value_multi` allocates and returns a `string_list`
>> +containing all the values for the key passed as parameter, sorted in order
>> +of increasing priority (Note: caller has to call `string_list_clear` on
>> +the returned pointer and then free it).
>> +
>> +`git_config_get_value_multi` returns NULL for no value found.
>> +
>> +`git_config_clear` is provided for resetting and invalidating the cache.
>> +
>> +`git_config_iter` gives a way to iterate over the keys in cache. Existing
>> +`git_config` callback function signature is used for iterating.
> 
> Instead of doing prose above and then enumeration below,
> consistently using the enumeration-style would make the descriptions
> of API functions easier to find and read.  Also show what parameters
> each function takes.  E.g.
> 

Noted.

>                 
> A few random thoughts.
> 
>  - Are "a value for the variable is found" and "no value for the
>    variable is found" the only possible outcome?  Should somebody
>    (not necessarily the calling code) be notified of an error---for
>    example, if you opened a config file successfully but later found
>    that the file could not be parsed due to a syntax error or an I/O
>    error, is it possible the caller of this function to tell, or are
>    these just some special cases of "variable not found"?

The syntactical errors when parsing the file are shown when it fails to
construct the hashmap. Whenever a caller calls for a value for the first
time, the file is read and parsed and if it fails during parsing it dies
raising a error specifying the lineno and filename.

Variable not found means that the variable is not present in the file,
nothing more. Note: the hashmap code uses git_config() parsing stack
so whatever error it raises in normal git_config() invocation, it
would be raised here too.

>  - The same goes for the "multi" variant but it is a bit more grave,
>    as a function that returns an "int" can later be updated to
>    return different negative values to signal different kinds of
>    errors, but a function that returns a pointer to string-list can
>    only return one kind of NULL ;-)
>

Null pointer just means no variable found in the files. What other kind
of errors may arise?

>  - For the purpose of "git_config_get_value()", what is the value
>    returned for core.filemode when the configuration file says
>    "[core] filemode\n", i.e. when git_config() callback would get a
>    NULL for value to signal a boolean true?

NULL in value pointer with 0 return value denoting variable found.

>  - Is there a reason why you need a separate and new "config_iter"?
>    What does it do differently from the good-old git_config() and
>    how?  It does not belong to "Querying for Specific Variables"
>    anyway.
>

You mentioned previously in the list for a analogue to git_config()
which supports iterating over the keys.
The link is [1] I think, gmane is not working for me currently.

http://thread.gmane.org/gmane.comp.version-control.git/252567

>> +The config API also provides type specific API functions which do conversion
>> +as well as retrieval for the queried variable, including:
>> +
>> +`git_config_get_int`::
>> +Parse the retrieved value to an integer, including unit factors. Dies on
>> +error; otherwise, allocates and copies the integer into the dest parameter.
>> +Returns 0 on success, or 1 if no value was found.
> 
> "allocates and copies"????  Is a caller forced to do something like
> this?
> 
> 	int *val;
> 
> 	if (!git_config_get_int("int.one", &val)) {
>         	use(*val);
>                 free(val);
> 	}
> 
> I'd expect it to be more like:
> 
> 	int val;
>         if (!git_config_get_int("int.one", &val))
>         	use(val);
>

Yup, you are right, my fault.

> Also, is there a reason why the "not found" signal is "1" (as
> opposed to "-1" for the lower-level get_value() API)?
> 

Many of the type specific functions return -1 for wrongful parsing
like git_config_get_string and git_config_get_maybe_bool, that is
why I changed the return value for such functions.

>> +Custom Configsets
>> +-----------------
>> +
>> +A `config_set` points at an ordered set of config files, each of
>> +which represents what was read and cached in-core from a file.
> 
> This over-specifies the implementation.  Judging from the list of
> API functions below, an implementation is possible without having to
> keep track of what source files were fed in what order (i.e. it can
> just keep a single hash-table of read values and incrementally parse
> the new contents given via configset-add-file into it, without even
> recording the origins, and forget about the source files once it
> finishes parsing).
> 
> As was pointed out during the previous review round, a stack of
> <hash, filename> tuples cannot represent the configuration when
> config-includes are involved.  Also we would eventually want to be
> able to also read from non-file sources (e.g. from a blob, or a
> caller-supplied in-core strings).
> 
> For the purpose of reporting errors at the point of value being
> used, I have a suspicion that you would need to associate the
> <file,line> pair with each individual value string you will keep
> after configset_add_file() parses the file.  The implementation of
> the call-chain may look like:
> 
> 
> 	git_configset_add_file(cs, filename):
>         	file = open filename
>                 lineno = 0
> 		while read line from file:
> 	                git_configset_parse_line(cs, filename, lineno++, line)
> 		close file
> 
> 	git_configset_parse_line(cs, filename, lineno, line):
>         	... this needs to implement a state machine
>                 ... that keeps track of what has been read halfway
>                 ... e.g. we may have seen "[core] crlf =\\\n"
>         	... earlier, which is not a complete input yet,
>                 ... and now we may be looking at "auto" that lets
>                 ... us finally parse one item.
> 
> 	        if state in 'cs' and new 'line' gives us a complete input:
> 			determine key and value
>                         record <value, filename, lineno> for 'key' to cs.hash
>                 update state in 'cs'
> 
> For processing "git -c section.variable=value", we probably would
> call git_configset_parse_line() on the_configset with filename
> set to "command line" or something.
> 
> And then when the caller tries to actually use the value, e.g.
> 
>          git_configset_get_int(cs, key):
> 		look up <value, filename, lineno> for 'key' from the cs.hash
> 		if value is successfully parsed as int:
>                 	return the parsed result
> 		else:
>                 	error("not an int: '%s' (%s:%s)", value, filename, lineno)
> 

Okay, lets see what I can do with it.

> 
>> +It can be used to construct an in-memory cache for config files that
>> +the caller specifies. For example,
> 
> This is almost good to help a reader decide if she might want to use
> it in her code, but we probably want to stress the fact that use of
> a config_set is done for a namespace separate from the main
> configuration system, e.g. ".gitmodules".
> 
>> +---------------------------------------
>> +struct config_set gm_config = CONFIG_SET_INIT;
>> +int b;
>> +/* we add config files to the config_set */
>> +git_configset_add_file(&gm_config, ".gitmodules");
>> +git_configset_add_file(&gm_config, ".gitmodules_alt");
>> +
>> +if (!git_configset_get_bool(gm_config, "submodule.frotz.ignore", &b)) {
>> +/* hack hack hack */
>> +}
>> +
>> +/* when we are done with the configset */
>> +git_configset_clear(&gm_config);
>> +----------------------------------------
>> +
>> +Configset API provides functions for the above mentioned work flow, including:
>> +
>> +`git_configset_init`::
>> +
>> +Returns an allocated and initialized struct `config_set` pointer.
> 
> "allocated"???  Is a caller forced to do this, i.e. always have the
> config-set on heap?
> 
> 	struct config_set *config = git_configset_init();
>         ... use it ...
>         git_configset_clear(config);
> 
> I'd expect it be more like this:
> 
> 	struct config_set config;
> 
> 	git_configset_init(&config);
>         ... use it...
>         git_configset_clear(&config);
> 

Yup, I prefer the second one.
Thanks for the review,
Tanay Abhra.
