Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE13AEB64D7
	for <git@archiver.kernel.org>; Wed, 28 Jun 2023 10:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbjF1KMJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jun 2023 06:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbjF1KGa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2023 06:06:30 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916CA2972
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 03:05:49 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-31409e8c145so672483f8f.2
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 03:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687946748; x=1690538748;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DCQgLXOwbOYCCKlPnx05ab5wLRFpbHqxEyp+2voS6zk=;
        b=UxP+nWtYebPz0rXkMvx+QEYy+SNNzGhJtS82r2v9dqttlFAPJpTe5r6F1v2++0thWX
         qaTPcL/XAomG4i+Yh/ddQjfHL4GzKCnQcYGnXiwOaE+ByhVSm1EuV3qoxO0/BZZaZgvg
         GlKeaQurCyp/0m4LpCbnYBRTBpF8ntkwik9ToZRE0Mhvez3tMnriEG02uiCfx5Y4UfUA
         faeE4nu5X0GJPB0eNYS0Z5EX1qaaMUpGYjHBi8BpnEY3VPFAqlXuTBOovZWwSMWjIv/a
         bxg6yHlEONE9tqLDskMeCpDK8xGtpTH6s4dPMyHwFR6oRL4+ukhW8Xj5TvVBmwNDthZR
         vv5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687946748; x=1690538748;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DCQgLXOwbOYCCKlPnx05ab5wLRFpbHqxEyp+2voS6zk=;
        b=cfJ8PKhlS6JDl8Sgiaf12Du4ARHeFOvihs2QAfMhhVxtEe6BzPWGgvdMlzDQS5JDKa
         qB92tlNWbHivzc9A44JhT+XpynOkivmcgeS6zo4Ndd1YXLenml5mqvFaTnNXAjg4+1gD
         d3IBD9O17bm4Qd/yzuxOlqNG6CR6d6FjHzEYpEFvwmdA3bJymZYVivKVrK9IqREO9MVF
         dYT2hMI4vm0gkQei0P0CpuxKCDKvP0W0AWYDgc37DTeVSbMoUNqK/PHzBi0AW5+RwZOf
         9srA/wFTLizV6rbsgH0WpSzQNIl1bsPXTlRBcfEtCh4kAcP1jIAJj4AQ6AQif1fdMTSH
         VoHw==
X-Gm-Message-State: AC+VfDxaEwxg3QuTlhl4J92479wV/Lh8GCx0TrdT/FqSP3tHvkceQiC5
        3mOYRekaYtjYhTaJzjwhzSmYbqQC1Rk=
X-Google-Smtp-Source: ACHHUZ47I74aYtAHhXYqMTNpMwLpZGG7y/m07Z+7vB8eBSf4ONpgPWQ9IX2nHCa7/ifZ6r5S2IGxXg==
X-Received: by 2002:a5d:5612:0:b0:313:f505:8211 with SMTP id l18-20020a5d5612000000b00313f5058211mr5789798wrv.46.1687946747594;
        Wed, 28 Jun 2023 03:05:47 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.235.211])
        by smtp.gmail.com with ESMTPSA id g9-20020a5d5549000000b00307acec258esm13043762wrw.3.2023.06.28.03.05.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 03:05:47 -0700 (PDT)
Message-ID: <457ff920-865e-f018-1d79-f3cb1121d199@gmail.com>
Date:   Wed, 28 Jun 2023 11:05:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/3] diff --no-index: support reading from named pipes
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Thomas Guyot-Sionnest <tguyot@gmail.com>
References: <cover.1687874975.git.phillip.wood@dunelm.org.uk>
 <990e71882bfdc697285c5b04b92c290679ca22ab.1687874975.git.phillip.wood@dunelm.org.uk>
 <xmqqy1k4g068.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqy1k4g068.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 27/06/2023 20:44, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> In some shells, such as bash and zsh, it's possible to use a command
>> substitution to provide the output of a command as a file argument to
>> another process, like so:
>>
>>    diff -u <(printf "a\nb\n") <(printf "a\nc\n")
>>
>> However, this syntax does not produce useful results with "git diff
>> --no-index". On macOS, the arguments to the command are named pipes
>> under /dev/fd, and git diff doesn't know how to handle a named pipe. On
>> Linux, the arguments are symlinks to pipes, so git diff "helpfully"
>> diffs these symlinks, comparing their targets like "pipe:[1234]" and
>> "pipe:[5678]".
>>
>> To address this "diff --no-index" is changed so that if a path given on
>> the commandline is a named pipe or a symbolic link that resolves to a
>> named pipe then we read the data to diff from that pipe. This is
>> implemented by generalizing the code that already exists to handle
>> reading from stdin when the user passes the path "-".
>>
>> As process substitution is not support by POSIX this change is tested by
>> using a pipe and a symbolic link to a pipe.
>>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>>   diff-no-index.c          | 80 ++++++++++++++++++++++++----------------
>>   t/t4053-diff-no-index.sh | 25 +++++++++++++
>>   2 files changed, 73 insertions(+), 32 deletions(-)
> 
> This looks good, if a bit invasive, to a cursory read, at least to
> me.  It is very focused to the real problem at hand, and shows that
> the way we split the "no-index" mode out to its own implementation
> of filespec population code does make sense.

Yes, it is more invasive than I'd like but I think that stems from 
needing to treat paths given on the commandline differently to the paths 
we find when recursing directories.

>> -static void populate_from_stdin(struct diff_filespec *s)
>> +static void populate_from_pipe(struct diff_filespec *s, int is_stdin)
>>   {
>>   	struct strbuf buf = STRBUF_INIT;
>>   	size_t size = 0;
>> +	int fd = 0;
>>   
>> -	if (strbuf_read(&buf, 0, 0) < 0)
>> +	if (!is_stdin)
>> +		fd = xopen(s->path, O_RDONLY);
>> +	if (strbuf_read(&buf, fd, 0) < 0)
>>   		die_errno("error while reading from stdin");
>> +	if (!is_stdin)
>> +		close(fd);
> 
> Given that the error message explicitly says "stdin", and there are
> many "if ([!]is_stdin)" sprinkled in the code, I actually suspect
> that there should be two separate helpers, one for stdin and one for
> non-stdin pipe.  It is especially true since there is only one
> caller that does this:
> 
>> +	if (is_pipe)
>> +		populate_from_pipe(s, name == file_from_standard_input);
> 
> which can be
> 
> 	if (is_pipe) {
> 		if (name == file_from_standard_input)
> 			populate_from_stdin(s);
> 		else
> 			populate_from_pipe(s);
> 	}
> 
> without losing clarity.  The code that you are sharing by forcing
> them to be a single helper to wrap up a handful of members in the s
> structure can become its own helper that is called from these two
> helper functions.

Sure, and thanks for pointing out the error message, I'd overlooked that.

>>   static int queue_diff(struct diff_options *o,
>> -		      const char *name1, const char *name2)
>> +		      const char *name1, int is_pipe1,
>> +		      const char *name2, int is_pipe2)
>>   {
>>   	int mode1 = 0, mode2 = 0;
>>   
>> -	if (get_mode(name1, &mode1) || get_mode(name2, &mode2))
>> +	if (get_mode(name1, is_pipe1, &mode1) ||
>> +	    get_mode(name2, is_pipe2, &mode2))
>>   		return -1;
> 
> Makes me wonder why the caller of queue_diff() even needs to know if
> these two names are pipes; we are calling get_mode() which would run
> stat(2) anyway, and the result from stat(2) is what you use (in the
> caller) to determine the values of is_pipeN.  Wouldn't it be more
> appropriate to leave the caller oblivious of special casing of the
> pipes and let get_mode() handle this?  After all, that is how the
> existing code special cases the standard input so there is a strong
> precedence.

Maybe is_pipeN should be called force_pipeN. We only want to 
de-reference symbolic links to pipes for paths that are given on the 
command line, not when the the user asked to compare two directories. 
That means we need to pass some kind of flag around to say whether we're 
recursing or not. An earlier draft of this series had a recursing flag 
rather than is_pipeN like this

-static int get_mode(const char *path, int *mode)
+static int get_mode(const char *path, int *mode, int recursing)
  {
          struct stat st;

          if (!path || !strcmp(path, "/dev/null"))
                  *mode = 0;
  #ifdef GIT_WINDOWS_NATIVE
          else if (!strcasecmp(path, "nul"))
                  *mode = 0;
  #endif
          else if (path == file_from_standard_input)
                  *mode = create_ce_mode(0666);
          else if (lstat(path, &st))
                  return error("Could not access '%s'", path);
          else
                  *mode = st.st_mode;
+
+        /*
+	  * For paths given on the command line de-reference symbolic
+	  * links that resolve to a fifo.
+	  */
+        if (!recursing &&
+            S_ISLNK(*mode) && !stat(path, &st) && S_ISFIFO(st.st_mode))
+                *mode = st.st_mode;
+
          return 0;
  }

I dropped it in favor of is_pipeN after I realized we need to check if 
the paths on the command line are pipes before calling fixup_paths(). I 
think we could use the "special" parameter you suggest below as a 
recursion indicator by setting it to NULL when recursing.

> If we go that route, it may make sense to further isolate the
> "address comparison" trick used for the standard input mode.
> Perhaps we can and do something like
> 
>      static int get_mode(const char *path, int *mode, int *special)
>      {
> 	struct stat st;
> 
> +	*special = 0; /* default - nothing special */
> 	...
> 	else if (path == file_from_standard_input) {
> 		*mode = create_ce_mode(0666);
> +		*pipe_kind = 1; /* STDIN */
> +	} else if (stat(path, &st)) {
> +		... error ...
> +	} else if (S_ISFIFO(st.st_mode)) {
> +		*mode = create_ce_mode(0666);
> +		*pipe_kind = 2; /* FIFO */
> 	} else if (lstat(path, &st)) {
> 		... error ...
> 	} else {
> 		*mode = st.st_mode;
> 	}
> 
> and have the caller act on "special" to choose among calling
> populate_from_stdin(), populate_from_pipe(), or do nothing for
> the regular files?
> 
>      Side note: this has an added benefit of highlighting that we do
>      stat() and lstat() because of dereferencing.  What I suspect is
>      that "git diff --no-index" mode was primarily to give Git
>      niceties like rename detection and diff algorithms to those who
>      wanted to use in contexts (i.e. contents not tracked by Git)
>      they use "diff" by other people like GNU, without bothering to
>      update "diff" by other people.  I further suspect that "compare
>      the readlink contents", which is very much necessary within the
>      Git context, may not fall into the "Git niceties" when they
>      invoke "--no-index" mode.  Which leads me to imagine a future
>      direction where we only use stat() and not lstat() in the
>      "--no-index" codepath.  Having everything including these
>      lstat() and stat() calls inside get_mode() will allow such a
>      future transition hopefully simpler.
> 
> I do not quite see why you decided to move the "is_dir" processing
> up and made the caller responsible.

To avoid a second stat() call in is_directory() after we've already 
called stat() to see if the path is a pipe.

>  Specifically,
> 
>> -	fixup_paths(paths, &replacement);
>> +	if (!is_pipe[0] && !is_pipe[1])
>> +		fixup_paths(paths, is_dir, &replacement);
> 
> this seems fishy when one side is pipe and the other one is not.
> When the user says
> 
>      $ git diff --no-index <(command) path
> 
> fixup_paths() are bypassed because one of them is pipe.  It makes me
> suspect that it should be an error if "path" is a directory.  I do
> not know if fixup_paths() is the best place for doing such checking,
> but somebody should be doing that, no?

I  wasn't sure what was best to do in that case. In the end I went with 
making the behavior the same as "git diff --no-index -- - directory". 
I'm happy to make both an error.

Thanks for your comments, I'll leave it a couple of days to see if there 
are any more comments and then re-roll.

Phillip

