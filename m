Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CF9C77B60
	for <git@archiver.kernel.org>; Fri, 28 Apr 2023 18:05:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346273AbjD1SF0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Apr 2023 14:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjD1SFZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2023 14:05:25 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745562D69
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 11:05:23 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-64115e652eeso14422739b3a.0
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 11:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682705123; x=1685297123;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UXzwQVHE3/zAzPjBu7mRFlEP7JaamgCMHynb1AMOYiM=;
        b=IWa63S8d+JP7Jc14xPWg73IeKwkx0mi67aiFUi6rCCIK0K789gb/tGNQCT+1JkZNJp
         ZHzfEq1AHUKL/Rb7W/8AzERljayROxEb7IzOVxWB3RtD8vXkS1qX3G/f+0H14R49Hbwx
         ZNE+a58Hils8QOf5B8UXtTJTEbbu3gczOEioXUmzxo62dPY4ZJu48wjrUijfUAaXX6Hb
         HSXFX3j+PENVGGNmKbAs7kdGd7SlhJTBKH12nPzyRprcOHEJhHtmQ6zZ3oUhhU0C79C6
         4PpWKc0bcmKHpHiyisgGaH4cRsFXo/6VL5nhVpfcXkhImOBl7iMFdFkQ3+m20ABkNyZt
         CPPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682705123; x=1685297123;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UXzwQVHE3/zAzPjBu7mRFlEP7JaamgCMHynb1AMOYiM=;
        b=aOXT/q26cz/o2m2hPAKupuFKGqq+zWVGyJTtnShtyjhHWmTScUSFxfob/f0r5j1pse
         P/1WtQ2bUILcdT+JkvCRQS0FuVs+/x5dFYsoT8N691f4tHHHCJ9byRQyTy3RS7XLZyXO
         YsmCN0cvdZftRFrQUpkbCJkYUleYviX+dC1tE/uzCQandB8pavSYi4HIpVqCbd55oh0V
         PoCfeWXlfWPNfouzJSaZU6j12I8WuQFwkAZal1tXtYjsqdfYNCcnriyxP6sUuIX+N8sy
         6j78/on4oO7BkxP04Nih8xHyAqItwOWOHxRYLiDaQjHMMQ8CgyvGqQL6Vk7TSdaQWRrh
         1VWQ==
X-Gm-Message-State: AC+VfDz7hGjoc9IhtK25zwIB1JPTY8fxblzeSWDL8stzy0gBE3rlKZCl
        Jj9QccSiezGntQCAMu4z3jp5YlSwqlY=
X-Google-Smtp-Source: ACHHUZ4M3KBSWbyVinTLp5LxRmqf/YuiKLrNWgeZsTaw9B0cuq+U0Hzfasa+gBf9d7IQ7fkU+LhNYw==
X-Received: by 2002:a05:6a20:7f8c:b0:d4:fcb2:7966 with SMTP id d12-20020a056a207f8c00b000d4fcb27966mr6134010pzj.11.1682705122499;
        Fri, 28 Apr 2023 11:05:22 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id w2-20020a62c702000000b0062608a7557fsm15390424pfg.75.2023.04.28.11.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 11:05:21 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, eyvind.bernhardsen@gmail.com, tboegi@web.de
Subject: Re: [PATCH v2] docs: rewrite the documentation of the text and eol
 attributes
References: <20230421055641.550199-1-alexhenrie24@gmail.com>
        <20230428042221.871095-1-alexhenrie24@gmail.com>
Date:   Fri, 28 Apr 2023 11:05:20 -0700
In-Reply-To: <20230428042221.871095-1-alexhenrie24@gmail.com> (Alex Henrie's
        message of "Thu, 27 Apr 2023 22:22:21 -0600")
Message-ID: <xmqqsfcjevbz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> These two sentences are confusing because the description of the text
> attribute sounds exactly the same as the description of the text=auto
> attribute:
>
> "Setting the text attribute on a path enables end-of-line normalization"
>
> "When text is set to "auto", the path is marked for automatic
> end-of-line conversion"
>
> Unless the reader is already familiar with the two variants, there's a
> high probability that they will think that "end-of-line normalization"
> is the same thing as "automatic end-of-line conversion".
>
> It's also not clear that the phrase "When the file has been committed
> with CRLF, no conversion is done" in the paragraph for text=auto does
> not apply equally to the bare text attribute which is described earlier.
> Moreover, it falsely implies that normalization is only suppressed if
> the file has been committed. In fact, running `git add` on a CRLF file,
> adding the text=auto attribute to the file, and running `git add` again
> does not do anything to the line endings either.
>
> On top of that, in several places the documentation for the eol
> attribute sounds like it can force normalization on checkin and checkout
> all by itself, but eol doesn't control normalization on checkin and
> doesn't control normalization on checkout either unless accompanied by
> the text attribute.
>
> Rephrase the documentation of text, text=auto, eol, eol=crlf, and eol=lf
> to be clear about how they are the same, how they are different, and in
> what cases normalization is performed.

All good observations, appropriate motivation of the change.

> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
> v2: rewrite completely and rewrite the eol documentation too
> ---

Thanks.  I wonder helped-by tboegi@ might be in order, but hopefully
it may come during the review of this round.

> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
> index 39bfbca1ff..bcea84f439 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -120,20 +120,22 @@ repository upon 'git add' and 'git commit'.
>  `text`
>  ^^^^^^
>  
> -This attribute enables and controls end-of-line normalization.  When a
> -text file is normalized, its line endings are converted to LF in the
> -repository.  To control what line ending style is used in the working
> -directory, use the `eol` attribute for a single file and the
> -`core.eol` configuration variable for all text files.
> -Note that setting `core.autocrlf` to `true` or `input` overrides
> -`core.eol` (see the definitions of those options in
> -linkgit:git-config[1]).
> +This attribute marks the path as a text file, which enables end-of-line
> +normalization on checkin and possibly also checkout: When a matching
> +file is added to the index, even if it has CRLF line endings in the
> +working directory, the file is stored in the index with LF line endings.
> +Conversely, when the file is copied from the index to the working
> +directory, its line endings may be converted from LF to CRLF depending
> +on the `eol` attribute, the Git config, and the platform (see
> +explanation of `eol` below).

Four points.

1. Overall, the new text is clearly written, and I think it made the
   updated description of "Set" and "Set to string 'auto'" easier to
   understand.

2. "on checkin and possibly also checkout" may be redundant, as the
   section in which the `text` attribute is described is all about
   various conversions upon checking in (i.e. moving contents to the
   index) and checking out (i.e. moving contents out of the index).
   The introductory text for the whole section that does not define
   what "check-in" and "check-out" are and instead loosely says
   "commands such as" may want to be clarified, but that can be done
   as a follow-on clean-up work after this patch lands.   

3. It is unclear why we would want to mention "even if it has CRLF
   line endings in the working directory".  "Regardless of the line
   endings in the working tree files" may slightly be better [*1*],
   but I think the text reads better without it as storing contents
   with possibly different end-of-line convention is the point of
   "end-of-line normalization" in the first place.

   "the file is stored in the index with LF line endings" may better
   be rephrased to "the contents is stored, after converting to use
   LF line endings if necessary, in the index", so that we can use
   the verb "convert" to stress the point of setting this attribute.

4. This problem is shared with the original text, but "This
   attribute marks the path as a text file" might be a bit
   misleading.  If it is left unspecified (i.e. unmentioned, or any
   earlier settings by explicitly overriding them with "!text") or
   worse yet, explicitly unset (i.e. "-text"), it marks the path as
   a non text.

      This attribute is used to mark the path as a text file, which
      needs certain end-of-line normalization upon check-in and
      check-out, or a non-text file, which do not.

  I dunno if the extra verbosity is too much, though.

>  Set::
>  
>  	Setting the `text` attribute on a path enables end-of-line
> -	normalization and marks the path as a text file.  End-of-line
> -	conversion takes place without guessing the content type.
> +	normalization on checkin and checkout as described above.  Line
> +	endings are normalized in the index the next time the file is
> +	checked in, even if the file was previously added to Git with CRLF
> +	line endings.

"the next time" -> "every time", but that is probably moot, because
I would question the need for the whole sentence.

The last sentence, starting with "Line endigns are normalized", may
be redundant and we probably are better off without it.  It would
risk becoming maintenance burden because we have to make sure it
stays in sync with what you wrote in the introductory text.  "as
described above" before that sentence is clear enough.

> @@ -142,10 +144,11 @@ Unset::
>  
>  Set to string value "auto"::
>  
> -	When `text` is set to "auto", the path is marked for automatic
> -	end-of-line conversion.  If Git decides that the content is
> -	text, its line endings are converted to LF on checkin.
> -	When the file has been committed with CRLF, no conversion is done.
> +	When `text` is set to "auto", Git decides by itself whether the file
> +	is text or binary.  If it is text and the file was not already in
> +	Git with CRLF endings, line endings are converted on checkin and
> +	checkout as described above.  Otherwise, no conversion is done on
> +	checkin or checkout.

Nice.

> @@ -162,23 +165,28 @@ unspecified.
>  This attribute sets a specific line-ending style to be used in the
>  working directory.  This attribute has effect only if the `text`
>  attribute is set or unspecified, or if it is set to `auto`, the file is
> -detected as text, and it is stored with LF endings in the index.  Note
> -that setting this attribute on paths which are in the index with CRLF
> -line endings may make the paths to be considered dirty unless
> -`text=auto` is set. Adding the path to the index again will normalize
> -the line endings in the index.
> +detected as text, and it is stored with LF endings in the index.

This level of clarification is very much appreciated.

We may want to use the phrase "checking out" somewhere in
conjunction with "in the working directory" to be consistent with
how the section is titled.  Something like

    This attribute marks a path to use a specific line-ending style
    in the working tree when it is checked out.

>  Set to string value "crlf"::
>  
> +	This setting converts the file's line endings in the working
> +	directory to CRLF when the file is checked out.

Nice.

>  Set to string value "lf"::
>  
> -	This setting forces Git to normalize line endings to LF on
> -	checkin and prevents conversion to CRLF when the file is
> -	checked out.
> +	This setting uses the same line endings in the working directory as
> +	in the index, whether they are LF or CRLF.  However, unless
> +	`text=auto`, adding the file to the index again will normalize its
> +	line endings to LF in the index.

First of all, "uses the same, except if ... then LF is used" is much
harder to understand than "use LF, except if ..." as an explanation
for "lf".

The description may be correct but is 'eol=lf' what controls how the
normalization is done upon checking in?

As you said in the explanation for the `eol` attribute as a whole,
`eol` is effective only when `text` says the path is a text file,
and that (i.e. the fact that `text` controls the end-of-line) makes
the path to use LF line endings, isn't it?  The last sentence
starting with "However, unless" that talks about conversion going
into the index feels out of place.

There are some exception handling in the code for odd cases like the
contents with mixed line endings, a path set to use LF but the file
actually has CRLF, etc.  While they are worth describing, I wonder
if they should be done in a separate paragraph.

> +Unspecified::
> +
> +	If the `eol` attribute is unspecified for a file, its line endings
> +	in the working directory are determined by the `core.autocrlf` or
> +	`core.eol` configuration variable (see the definitions of those
> +	options in linkgit:git-config[1]).  The default if `text` is set but
> +	neither of those variables is is `eol=lf` on Unix and `eol=crlf` on
> +	Windows.

Nice.


[Footnote]

*1* The intent is not about special-casing CRLF but any other; if
    Git were to be extended to support ancient MacOS, we would
    convert even if it uses CR line endings.
