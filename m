Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1DFA1F462
	for <e@80x24.org>; Tue,  4 Jun 2019 12:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfFDMe0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jun 2019 08:34:26 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:3186 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727543AbfFDMeZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jun 2019 08:34:25 -0400
Received: from [192.168.1.22] ([78.148.161.28])
        by smtp.talktalk.net with SMTP
        id Y8dzhbZYGnuQZY8dzhM7Yh; Tue, 04 Jun 2019 13:34:24 +0100
X-Originating-IP: [78.148.161.28]
X-Spam: 0
X-OAuthority: v=2.3 cv=echDgIMH c=1 sm=1 tr=0 a=ujKALdKAi7z8notBBWqKeA==:117
 a=ujKALdKAi7z8notBBWqKeA==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=FM8yyPGvAAAA:8 a=hQZsTO-tqpSOvaMfiiUA:9 a=QEXdDO2ut3YA:10
 a=-RjHeblGm-41HPTmQUZ_:22
Subject: Re: [PATCH] make slash-rules more readable
To:     "Dr. Adam Nielsen" <admin@in-ici.net>, git@vger.kernel.org
References: <20190531074426.6810-1-admin@in-ici.net>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <0c9f79f3-b43b-5f32-d217-ff92531c5da7@iee.org>
Date:   Tue, 4 Jun 2019 13:34:25 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190531074426.6810-1-admin@in-ici.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfJYyyw4ZYlwdY3/y/DZndlH3wby5bhowMOovfMkI3jrbjkEI2gn0aBrr7D984o/JnHmXFKaEXoPRLu2ttL0kGjhJ4Cfm8ad0J+ULASmztcLUV5ltCDUU
 aEnyOP78B5l0Evj3hv72Y3uXIl1nxlt9WxiMhPIP4kpKjTpkl8Jerebh0EmqojxwHJFk/0w9t+b24vy3ZVteqARwDzRWjbOkT8v0ymbXgeWaLAgdFGLIyyHy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Adam,
On 31/05/2019 08:44, Dr. Adam Nielsen wrote:
> gitignore.txt: make slash-rules more readable
>
> Remove meta-rule in a paragraph for trailing-slash.
> Be precise whenever a trailing slash would make a
> difference. Improve paragraph for pattern without slash.
> Remove rule for leading slash because its now redundant.
> Instead, add examples for leading slash and asterix in
> example section.
>
> Signed-off-by: Dr. Adam Nielsen <admin@in-ici.net>
I think the rules end up being difficult because we describe them from a 
coders implementation viewpoint, rather than a users descriptive 
viewpoint. Thus we avoided things like the difficult to code slashes in 
the front/middle, and we get caught on the equivalent of neither/nor 
phrases, which can even be difficult for native English speakers.

Later on there is a recursively/respectively issue (latter not 
explicitly mentioned).  There is also an "Except if" not-a-proper 
sentence. (mentioned off-line)

I think this is the truth table for the slash..
Lead/  | mid/  | end/  |
yes    |yes    |yes    | Directory, directly at .gitignore
no     |yes    |yes    | Directory, directly at .gitignore
yes    |no     |yes    | Directory, directly at .gitignore
no     |no     |yes    | Directory, anywhere at, or below, .gitignore   
<the tricky one ;-)

yes    |yes    |no     | file or Directory, directly at .gitignore
no     |yes    |no     | file or Directory, directly at .gitignore
yes    |no     |no     | file or Directory, directly at .gitignore
no     |no     |no     | file or Directory, anywhere at, or below, 
.gitignore

After sleeping on it, I came up with:

    The slash '/' is used as the directory separator. Separators may
    occur at the beginning, middle or end of the .gitignore search pattern.

    If there is a separator at the beginning or middle (or both) of the
    pattern, then the pattern is relative to the directory level of the
    particular .gitignore file itself. Otherwise the pattern may also
    match at any level below the .gitignore level.

    If there is a separator at the end of the pattern then the pattern
    will only match directories, otherwise the pattern can match both
    files and directories.

    Examples text..

    The special '*' ...

    The special '**' ...

-- 
The key (for me) was to add in the sentence that says we have 
beginning/middle/end slashes as a prompt ready for later, and use the 
plural for 'separator'.

I then also used 'otherwise' and an occasional 'also'  to avoid any 
and/or/neither/nor logic problems. I removed all 'it/they/them' style 
indirect references as it is easy to pick the wrong indirection.

I have been explicit (pedantic) about '.gitignore search pattern' to 
avoid the reader accidentally changing focus and thinking of the path 
string.

One could also add "Likewise the directory(?) pattern will not match a 
symbolic link, as is normal for pathspecs in Git." as this isn't 
mentioned elsewhere.
--
Philip

> ---
>   Documentation/gitignore.txt | 71 ++++++++++++++++++++++++++-----------
>   1 file changed, 50 insertions(+), 21 deletions(-)
>
> diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
> index b5bc9dbff0..a6c7807c74 100644
> --- a/Documentation/gitignore.txt
> +++ b/Documentation/gitignore.txt
> @@ -89,28 +89,32 @@ PATTERN FORMAT
>      Put a backslash ("`\`") in front of the first "`!`" for patterns
>      that begin with a literal "`!`", for example, "`\!important!.txt`".
>   
> - - If the pattern ends with a slash, it is removed for the
> -   purpose of the following description, but it would only find
> + - A slash `/` is used as a directory separator. A leading and trailing
> +   slash have special meaning and are explained in the following.
> +
> + - If the pattern ends with a slash, it would only find
>      a match with a directory.  In other words, `foo/` will match a
> -   directory `foo` and paths underneath it, but will not match a
> -   regular file or a symbolic link `foo` (this is consistent
> -   with the way how pathspec works in general in Git).
> -
> - - If the pattern does not contain a slash '/', Git treats it as
> -   a shell glob pattern and checks for a match against the
> -   pathname relative to the location of the `.gitignore` file
> -   (relative to the toplevel of the work tree if not from a
> -   `.gitignore` file).
> -
> - - Otherwise, Git treats the pattern as a shell glob: "`*`" matches
> -   anything except "`/`", "`?`" matches any one character except "`/`"
> -   and "`[]`" matches one character in a selected range. See
> -   fnmatch(3) and the FNM_PATHNAME flag for a more detailed
> -   description.
> -
> - - A leading slash matches the beginning of the pathname.
> -   For example, "/{asterisk}.c" matches "cat-file.c" but not
> -   "mozilla-sha1/sha1.c".
> +   directory `foo`, but will not match a regular file or a
> +   symbolic link `foo` (this is consistent with the way how
> +   pathspec works in general in Git).
> +
> + - If the pattern does not end with a slash, it would find a match
> +   with a file or directory.
> +
> + - The pattern is matched relative to the location of
> +   the `.gitignore` file. Except if the pattern contains
> +   no slash (or no slash but a trailing slash), then the pattern is
> +   matched against all files and folders (recursively)
> +   from the location of the `.gitignore` file.
> +   For example, `doc/frotz/` matches `doc/frotz` directory, but not
> +   a/doc/frotz`; however `frotz/` matches `frotz` and `a/frotz` that
> +   is a directory (all paths are relative from the `.gitignore` file).
> +
> + - An asterisk "`*`" matches anything except a slash.
> +   The character "`?`" matches any one character except "`/`".
> +   The range notation, e.g. `[a-zA-Z]`, can be used to match
> +   one of the characters in a range. See fnmatch(3) and the
> +   FNM_PATHNAME flag for a more detailed description.
>   
>   Two consecutive asterisks ("`**`") in patterns matched against
>   full pathname may have special meaning:
> @@ -152,6 +156,31 @@ To stop tracking a file that is currently tracked, use
>   EXAMPLES
>   --------
>   
> + - The pattern `/bar` only matches the file or folder `bar`
> +   but not `a/bar`, whereas the pattern `bar` would match both
> +   (relative to the `.gitignore` file). That is because the
> +   pattern `/bar` contains a non-trailing slash and thus matches
> +   relative to the location of the `.gitignore` file.
> +   Since `bar` has no slash, it matches recursively.
> +
> + - The pattern 'hello.*' is not sufficient for the following rule:
> +   "ignore any file whose name begins with 'hello' and in this
> +   directory only, not in its subdirectories." because the pattern
> +   does not have any slash. To work around this limitation,
> +   you can prepend your pattern with a slash, i.e. '/hello.*';
> +   the pattern now matches 'hello.txt', 'hello.c' but not
> +   'a/hello.java'.
> +
> + - The pattern `doc/frotz` and `/doc/frotz` have the same effect
> +   in any `.gitignore` file. Both pattern contain a non-trailing
> +   slash and thus match relative to the location of the
> +   `.gitignore` file.
> +
> + - The pattern "foo/*", matches "foo/test.json"
> +   (a regular file), "foo/bar" (a diretory), but it does not match
> +   "foo/bar/hello.c" (a regular file), as the asterisk in the
> +   patter does not match "bar/hello.c" which has a slash in it.
> +
>   --------------------------------------------------------------
>       $ git status
>       [...]

