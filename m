Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864A1C636CC
	for <git@archiver.kernel.org>; Thu, 16 Feb 2023 23:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjBPXX0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Feb 2023 18:23:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjBPXW6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2023 18:22:58 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F42859590
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 15:22:18 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id bt14so2436823pfb.13
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 15:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6W3MxZ03OWAx3vWuqF2x5U0Rzhzfgc1BHEZDee/K854=;
        b=SAxML011o3HY22AnuPUerqxj1aH3Y58ElEuLE/IcY88yeTx3UL2OX20vQkQnlZS4v2
         uuibuxJ58cyGKVW0+Q/ZiX7dbGhr+j14M60hwkxRJprX3GuPoxI7VP+xrbI7hNrgMm5a
         btD6xgFwuOwfhDMq5HogSVLOVV1XzbXMvswvf2ihFukMZb21/qsrmz/oIpckQPM5bZQF
         a5YSn6qgSpb/w7H3FopuAwcxZYPxif7H+eGE55GgHzayH2i7ydjV57SXHv47XV8wMQWN
         DM9seff+Qz2xN+g+ORWXO/QFVZDBKWVTPs1J4DkYfojIShlEzgFQ3Si2vtO5ItpmHeLi
         2UCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6W3MxZ03OWAx3vWuqF2x5U0Rzhzfgc1BHEZDee/K854=;
        b=4SDs+CSKEVMQCfd/3t9tsJB5WFGL2vJP3AIXo3X4hqgFoo9qOjq9pVb9D9RBW0d3wk
         mlXGagIDQyWLDcrW4ru8Ic9wKgxug+LqAF1FlzfmBk0qzS7Sh8zeTEWl4zW7Ul1oqjaq
         QNgShRKgLtIfQbHg8bTGxkBOpocNzL12fFy0nmOh1y8XzE4994Ds8h9Ucnv8WZHUslnA
         MlQFueD84ISO9UaeIfPsDLXS629h9U9rQrbgBk1DMZcZjtAu93NXTpw9aS9wA8Wm+ipg
         j/wHRHpLmWHyPfvdcOCplKzOrS+H6UOTDoT3gHgdVq6kfOfyvpfOygmsERH2Sa4+AClh
         yLjA==
X-Gm-Message-State: AO0yUKU9Xy/2DUq9d9C6tbJIEibBhsFDc88ENOFfW9gZXj9eVAA+BMeT
        nhqy2zavZCNwWaYral/bdLM=
X-Google-Smtp-Source: AK7set8dvUrNlmvAVn7lfSeLQE8mNFbcme0DtZslagyNYayJs64UXQYh2pje5IK29qJRUK3o6yNhyQ==
X-Received: by 2002:a62:184f:0:b0:5aa:2216:5c5c with SMTP id 76-20020a62184f000000b005aa22165c5cmr350301pfy.33.1676589737583;
        Thu, 16 Feb 2023 15:22:17 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id 11-20020aa7910b000000b005a84de20c24sm1775159pfh.209.2023.02.16.15.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 15:22:17 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, git@vger.kernel.org, sunshine@sunshineco.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v5 3/3] notes.c: introduce "--separator" option
References: <cover.1676551077.git.dyroneteng@gmail.com>
        <a74c96d6dd23f2f1df6d3492093f3fd27451e24c.1676551077.git.dyroneteng@gmail.com>
Date:   Thu, 16 Feb 2023 15:22:16 -0800
In-Reply-To: <a74c96d6dd23f2f1df6d3492093f3fd27451e24c.1676551077.git.dyroneteng@gmail.com>
        (Teng Long's message of "Thu, 16 Feb 2023 21:05:05 +0800")
Message-ID: <xmqq7cwhnql3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

> When appending to a given notes object and the appended note is not
> empty too, we will insert a blank line at first which separates the
> existing note and the appended one, which as the separator.

", which as the separator" does not sound grammatically correct.
Without that part, the above is a perfectly readable description of
the current behaviour.

> Sometimes, we want to use a specified <separator> as the separator. For
> example, if we specify as:
>
>     * --separator='------': we will insert "------\n" as the separator,
>     because user do not provide the line break char at last, we will add
>     the trailing '\n' compatibly.

In a way compatible to what?  I think s/compatibly// would be even
easier to read.  I think you are doing that for convenience.

>     * --separator='------\n': we will insert as-is because it contains
>     the line break at last.

If this behaviour gets spelled out like this, it needs to be
justified.

After seeing that "------" gives the user these dashes on its own
single line, wouldn't a natural expectation by the user be to see a
line with dashes, followed by a blank line, if you give "------\n"?
How do you justify removal of that newline in a way that is easy to
understand to readers?

I am not saying that you should allow --separator="---\n\n\n" to
give three blank lines between paragraphs. I think it makes sense to
keep the stripspace in the code after a paragraph gets added. I just
prefer to see it done as our design choice, not "because there is
stripspace that removes them", i.e. what the code happens to do. 

>     * not specified --separator option: will use '\n' as the separator
>     when do appending and this is the default behavour.

s/not specified --separator option/no --separator option/; the way
you phrased can be misread for

	git notes --separator -m foo -m bar

i.e. any additional specifics is not given but --separator is still
on the command line.  But I do not think you meant that---rather
this entry is what happens by default, i.e. a blank line separates
each paragraph.

>     * --separator='': we specify an empty separator which has the same
>     behavour with --separator='\n' and or not specified the option.

I do not quite see why it is necessary to spell this out.  Isn't
this a natural consequence of the first one (i.e. "six dashes
without any terminating LF gets a line with dashes plus LF"
naturally extends to "0 dashes without any terminating LF gets a
blank line")?

> In addition, if a user specifies multple "-m" with "--separator", the
> separator should be inserted between the messages too, so we use
> OPT_STRING_LIST instead of OPT_CALLBACK_F to parse "-m" option, make
> sure the option value of "--separator" been parsed already when we need
> it.

This is hard to grok.  Is it an instruction to whoever is
implementing this new feature, or is it an instruct to end-users
telling that they need to give --separator before they start giving
-m <msg>, -F <file>, -c <object>, etc.?

> diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
> index efbc10f0..5abe6092 100644
> --- a/Documentation/git-notes.txt
> +++ b/Documentation/git-notes.txt
> @@ -11,7 +11,7 @@ SYNOPSIS
>  'git notes' [list [<object>]]
>  'git notes' add [-f] [--allow-empty] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]

Doesn't add allow you to say

	$ git notes add -m foo -m bar

Shouldn't it also honor --separator to specify an alternate
paragraph break?

> -'git notes' append [--allow-empty] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
> +'git notes' append [--allow-empty] [--separator] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]

"--separator" -> "--separator=<paragraph-break>" or something?

> @@ -86,7 +86,9 @@ the command can read the input given to the `post-rewrite` hook.)
>  
>  append::
>  	Append to the notes of an existing object (defaults to HEAD).
> -	Creates a new notes object if needed.
> +	Creates a new notes object if needed. If the note and the
> +	message are not empty, "\n" will be inserted between them.
> +	Use the `--separator` option to insert other delimiters.

"\n" is so, ... programmer lingo?  "A blank line" is inserted
between these paragraphs.

> +--separator <separator>::
> +	The '<separator>' inserted between the note and message
> +	by 'append', "\n" by default. A custom separator can be

I see no reason to single out 'append'; "add -m <msg> -m <msg>"
follows exactly the same paragraph concatenation logic in the
current code, no?  If we allow customized paragraph separators,
we should use the same logic there as well.

It probably is simpler to explain if you treat the "current note in
'append'" as if the text were just "earlier paragraphs", to which
more paragraphs taken from each -m <msg> and -F <file> are
concatenated, with paragraph break before each of them.  In the case
of 'add', there happens to be zero "earlier paragraphs", but
everything else gets concatenated the same way, no?

> +	provided, if it doesn't end in a "\n", one will be added
> +	implicitly .

Funny punctuation.
