Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC46C4332F
	for <git@archiver.kernel.org>; Thu, 22 Dec 2022 08:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235080AbiLVI0d (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Dec 2022 03:26:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiLVI0b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2022 03:26:31 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567901E73F
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 00:26:30 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id d20so1985098edn.0
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 00:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UMQp0vA0QWVeUmXq2uC87Hpi2aP5rzzpNx4hUns2A/U=;
        b=RSIEm2b6r4ylGrmqtxrh6znqWS+apfuqoFQgsvrLNHNIZ1Dk+wcWU7m/v8eipHQ9Pp
         6tHONB2225KfAFQb8OWwCfIaez3zpSp1AGumi36Mr8gMwdI78uloksaxQPyl4mG+KClI
         8nAp18wrw8t+ahW2t6ySt+VliJSnp+10ZyDFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UMQp0vA0QWVeUmXq2uC87Hpi2aP5rzzpNx4hUns2A/U=;
        b=mtc0gU6zX8XZowlnDoIVm5s6YB9eoIB9yfxZZfvHVLTSZMuNQLMs4yNMZgZDkQ1+Ru
         BmdGzfVKfwVTI7A0qjRj88kdhjHdUUwiJj3O1ox7RSF2Cf1e1X9lg9e9LMB+FASrPE0Z
         ngqkLK2eeJOBfwL0awYH5appQNzuXpKgfxOV41J+jNuN95Elpa1ou/SQSxp5CDYuf/aG
         78xvT6jG9loCg5rKY2dQAYCX3Ju3gazudp75Pw++DubZzXg/NDX2w91IWH+xsuRV3vbW
         NkSzBB0KYTEV8m0JQYIPY6KlJmCnIoJP981NZDnKpm4yAFnFyirJzjZtvBN48bgtlis9
         TAbw==
X-Gm-Message-State: AFqh2kq2bijxIDVJ5nxbs5vfndRCNuco3aQfqnUrx/X/ppGibF3LMOrQ
        mggt/rvEMU9rDj/tjIs7kB7yec8VRHw6CIFF6hKSGQ==
X-Google-Smtp-Source: AMrXdXum3I3//S7276MJH6v5WpuImNI8M4T8fgvRNxmD/i0BF9L+o8NU8jcLrVNj6WQ8Yj3PX4nAiKYPOdjTe3S0N0c=
X-Received: by 2002:aa7:d752:0:b0:478:56c6:54d8 with SMTP id
 a18-20020aa7d752000000b0047856c654d8mr506506eds.125.1671697588746; Thu, 22
 Dec 2022 00:26:28 -0800 (PST)
MIME-Version: 1.0
References: <CAKu1iLWvd+PVOK405Q+SNDyyYnhbi=LtovZvWw55y6eQqoRpaA@mail.gmail.com>
 <CAPMMpoi=6x5VbSh=Lkbi7WJKudGpQS2U_GnJk8GJi+ArJNp2EA@mail.gmail.com>
 <xmqq1qp1wph5.fsf@gitster.g> <CAPMMpoiLYhjjK73Le1u71e-nzU1cf_dA=i7zYYz3t8+AujgbCA@mail.gmail.com>
In-Reply-To: <CAPMMpoiLYhjjK73Le1u71e-nzU1cf_dA=i7zYYz3t8+AujgbCA@mail.gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Thu, 22 Dec 2022 09:26:19 +0100
Message-ID: <CAPMMpohHoPwxGTrwUi-WNvhU_+CnKP-rKPcDE-7qTUVBuRWA1g@mail.gmail.com>
Subject: Re: [PATCH] git-p4: preserve utf8 BOM when importing from p4 to git
To:     Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Luke Diamand <luke@diamand.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 19, 2022 at 10:09 AM Tao Klerks <tao@klerks.biz> wrote:
>
> I definitely need to keep testing around this to understand what the
> right thing to do for Tzadik (and others like him of course) might be.
>
> Tzadik, could you provide any more detail about the failing situation?
> One piece of info that might be particularly helpful is *what is the
> exact/full p4 FileType of the problem file?*

Hi Tzadik, over the past few days I've been making progress towards
understanding the behavior of unicode-enabled perforce servers (and p4
client tooling against such servers):
* Perforce always stores/adds new files containing a utf8 bom as type
"utf8", and always syncs them to the workspace with a BOM, regardless
of the P4CHARSET env variable. Same goes for utf16 with bom being
stored as type "utf16".
* The only filetype that gets synced to the workspace differently
depending on P4CHARSET is the "unicode" type - a type exclusive to
*specific files* on unicode-enabled servers
* The P4CHARSET env var is used in three situations that I've
detected/understood so far:
  1. It is used when "p4 add"ing new files - if the content of the
file is valid/parseable according to the P4CHARSET, and is not a
built-in more-specific type like utf8-with-bom (perforce type "utf8")
or utf16-with-bom (perforce type "utf16"), then it gets parsed
according to that charset and stored as type "unicode". If the content
is not parseable according to that charset, nor the more specific
types, then it gets stored as "text" or "binary".
  2. It is used when "p4 sync"ing files of type "unicode" to the
workspace. All other types are synced in a "standard" way, only type
"unicode" is sensitive to the charset config during "sync".
  3. It is used when "p4 print"ing files of type "unicode", "utf8",
and "utf16" (unless P4COMMANDCHARSET overrides, or a "-o" output file
is specified). This last behavior spells trouble for git-p4...
* When a file is stored as type "unicode", the way it gets
synchronized to the workspace always depends on the P4CHARSET env
variable. When a "with-bom" charset value is configured, like
"utf8-bom" or "utf16", the resulting files on disk / in the workspace
end up indistinguishable from the corresponding perforce native
with-bom type "utf8" or "utf16".
* If an output file (-o) is specified, "p4 print" behaves like "p4
sync" - using P4CHARSET only for file type "unicode".
* If no output file (-o) is specified, the output of "p4 print"
depends on the P4CHARSET env variable or the more-specific
P4COMMANDCHARSET if specified, but with a number of provisos:
** "p4 print" will refuse to print using a "wide" charset like
"utf16"; it will fall back to utf8.
** If you configure P4CHARSET (and/or P4COMMANDCHARSET) to a charset
value with bom ("utf8-bom" specifically, I guess), you don't in fact
get the BOM in the "p4 print" output.
** If you configure P4CHARSET (and/or P4COMMANDCHARSET) to a charset
value that cannot express the specific contents of a utf8, utf16 or
unicode file, "p4 print" will fail.
* The behavior of "p4 print" matters in git-p4 because this is the p4
command used to import files; for "utf16" files a "file-targeting"
form is used (-o), and for all other file types, the regular form.
* One other "weirdness" in all this is that if you remove the BOM from
a "utf8" file and submit, this change is silently swallowed; your
workspace copy of the file remains without BOM, but if you force-sync
the file, the BOM magically reappears.

This is all further complicated by the fact that older Perforce server
(and client?) versions behaved differently! (eg see
https://stackoverflow.com/questions/38320814/bom-issue-in-unicode-perforce-server).

So far in my testing of git-p4 against a unicode server, I've
reproduced two concrete "problem workflows" specific to this server
configuration:

1: If you have P4CHARSET configured to "utf8-bom"
* "git p4 clone" imports your "unicode" files without BOM (because "p4
print" always omits the BOM)
* "p4 sync" syncs your "unicode" files *with* BOM - because that's
what P4CHARSET is telling it to do
* "git p4 submit" fails to apply (some) git changes (to "unicode"
files) because the git-workspace files do not have a BOM, and the p4
workspace files do.

2: If you have P4CHARSET configured to a non-utf8 encoding like "winansi":
* "git p4 clone" imports your "utf8" files as winansi-encoded (because
"p4 print" respects the configured P4CHARSET), and adds a utf8 bom
(because of the fix earlier this year)
* "p4 sync" syncs your "utf8" files encoded as utf8-with-BOM - because
that's the only and correct behavior
* Some of these files in the git repo may not open correctly in any
given editor, if they have a utf8 bom but are not actually
utf8-encoded (if they contain characters in the 128+ codepoint range)
* "git p4 submit" fails to apply (some) git changes (to these "utf8"
files) because these git-workspace files can have different bytes to
the utf8-encoded files in the workspace.

There seem to be two corresponding "fundamental bugs" in "git-p4 clone":
* Files of type "unicode" are imported according to the
client-configured charset (with some inconsistency around wide
charsets like utf16) - correct behavior is hard to define, as perforce
treats these files as having no "fundamental" encoding, but current
behavior is clearly buggy. It's unclear whether properly/consistently
respecting the p4-client-configured encoding makes more sense (to
support local-git-repo workflows transparently) by default, or whether
it makes more to use "utf8" by default, to have a consistent and
correct representation of the Perforce repository contents in git by
default (and then the equivalent of P4CHARSET behavior in
individual/personal git repos would need to be implemented using git
smudge and clean filters, I assume, for "git p4 submit" to work
against non-utf8-configured p4 workspaces).
* If unicode mode is enabled and P4CHARSET is not set to "utf8" or
"utf8-bom", files of perforce type "utf8" will be imported according
to the client-configured charset instead of the actual/internal (and
p4-workspace-respected) encoding - and additionally, with "my fix",
they will still get a utf8 BOM prepended, which can result in corrupt
files in the git repo.

Perplexingly, most of the issues I've identified with unicode-mode
perforce servers are not caused by my changes: the only *new* problem
this year is that, if P4CHARSET is set to something other than "utf8"
or "utf8-bom", files of p4 type "utf8" will now not only be imported
into the git repo with the *wrong* encoding (prior behavior), but will
additionally have a utf8 BOM added, resulting in *corrupted* files
(if/when the charset encoding diverges, eg if the content includes
characters in the 128+ codepoint range for P4CHARSET=winansi).

It's worth noting there's also an existing workflow failure that
applies equally to unicode-mode and regular servers, when users delete
the BOM from existing "utf8" files in their git repo and submit that
change into perforce:
* "git p4 clone" imports your "utf8" files correctly, as utf8-with-BOM
(in the case of a unicode-mode perforce server, assume "P4CHARSET" is
set to "utf8" or "utf8-bom")
* "p4 sync" syncs your "utf8" files encoded as utf8-with-BOM - because
that's the only and correct behavior
* The user accidentally or intentionally removes the BOM as part of
some edits to the file in the git workspace
* "git p4 submit" applies the change to the p4 workspace successfully,
it is committed to perforce (but perforce ignores the BOM removal bit)
* "git p4 submit" does its rebase of the git branch on top of the
now-submitted-and-reimported p4 changes, but the rebase fails because
the changes are different: in the p4 history there was no BOM-removal.

Tzadik, could you please confirm:
* Your p4 client and server versions ("p4 info")
* The perforce "types" of files you are concerned with (check with "p4
files <PATH>" or in the p4v GUI)
* Your OS
* Your P4CHARSET value, if set explicitly to something other than "auto"

I will keep exploring how this all works, and proposing fixes to
git-p4's vulnerable use of "p4 print". The correct outcome/behavior is
clear (and achievable) for files of perforce type "utf8", but I'm not
confident as to what the best default behavior will be for type
"unicode" - I imagine it will be to keep current client-specific
local-workflow-supporting behavior, fixing it to support wide
encodings and BOM-specifying encodings, and recommending that
P4CHARSET be set to "utf8" explicitly for canonical git-p4 clone
operations / for shared repos.

I have not yet looked into filepath-handling, commit-message-handling,
username-handling etc on unicode-enabled servers, but I suspect
similar issues will apply there: we'll have to figure out what the
correct behavior would be for "canonical" git repos, whether it should
be any different for "local-workflow-only" git repos, and how either
desirable behavior compares to current behavior for various values of
P4CHARSET. Everything probably already works correctly when
P4CHARSET=utf8.

For the "reappearing BOM" problem/behavior of perforce, I'm also not
sure what the right approach is, even manually. I've tried asking p4
to reevaluate the "type" of the file upon edit, but can't find any way
to get it to *auto*-detect the new file type. Given that I've never
seen this issue described before, it doesn't feel hugely important
though. I will at least add a failing test case to cover this, when I
get to it.

For now, based on the original problem statement/bug report, I cannot
understand what specific problem is affecting Tzadik, and whether or
how it was caused by the 2022 utf8 bom-preserving fix to "git-p4
clone".

Thanks,
Tao
