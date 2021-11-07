Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6CFC433EF
	for <git@archiver.kernel.org>; Sun,  7 Nov 2021 22:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BAB16139E
	for <git@archiver.kernel.org>; Sun,  7 Nov 2021 22:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236626AbhKGWo6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Nov 2021 17:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbhKGWo6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Nov 2021 17:44:58 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796E4C061570
        for <git@vger.kernel.org>; Sun,  7 Nov 2021 14:42:14 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id b15so35770992edd.7
        for <git@vger.kernel.org>; Sun, 07 Nov 2021 14:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0TSAUQKe9SJhXv92PF07x8qJd1HtPJv9D3T1pQhEdqE=;
        b=qem6OO+3giaSMDXVT69aK4KCqeaUoxxwdaSl5Q+j1nm3rFbmxp4PaJlp2FeBmPuB5J
         VdUdrV2QOxSCT1i5ws2VAslcuKQW2LKy8HelrztUaKjiSOGCoOg87UBVQTh3TpCyWpNj
         QPHhG3djCoTPK/Bnm4K4BIlpef90sp7qVw2JN+q224BbkE8q92U1I7mZh+Y1zdYQd9jd
         FsYH7cs34brSbZZmEduSNcUAKQpgbp37dVlUqbdqYCPBrD3NlDV7za/TawT9loPDT1Bp
         R5I0su2SZBOyYskJ5FilicD44XF8zJAIvzM2WLqForqJG88zAvFAxgqZXW8z2RAr8UsK
         nqJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0TSAUQKe9SJhXv92PF07x8qJd1HtPJv9D3T1pQhEdqE=;
        b=7sH95t5kJBGJvm9LfnlS0sUdjmH1QPxFRNUXUAKoNknejg/pmHsa7q6F/0AAjOGX1a
         m/UPcamsyfu70eLeHi3vYO0HIl4B/2LiBG/hzVbxH6uK+J6h49bbWmXzu675ipykU4I/
         9MTUu0Ajx0BVBy/psGKeOGWl7qSd35fWyJGO+w/2hG8dgspTQN0hqdjg3VKsn9BIVK16
         C4YDq6v1N2O7HG87BBP0CRYRs+LyJ+/VNM9TrffFbj3pLcVpcVM4AHpki+EKDqZjSMZ1
         Zy7ZaF+fOarzNql54jrfgCfx6+wd5utl2/RHN8e4bfsa3CUyNB1R5BoQShnuBeUD9ram
         fX2Q==
X-Gm-Message-State: AOAM531ffM6hxWzF/45FXqsV2Qq4SLG9MCBiWweZG4VshKE+j6WeqN0B
        H4D5XRsJw9bEybdqjd7Y711ori0BTSzKf9KqNIE=
X-Google-Smtp-Source: ABdhPJxFbD+YxvefJe/SrJa0i4aFoIvUGKPGB3W2m8Jes4nCMJ8PEF/laaAxme+3XOQKsc1yQ2iXj+A+1hXPDSZR6Ss=
X-Received: by 2002:aa7:dbca:: with SMTP id v10mr101529337edt.280.1636324932809;
 Sun, 07 Nov 2021 14:42:12 -0800 (PST)
MIME-Version: 1.0
References: <20211104160959.183402-1-greenfoo@u92.eu> <20211104160959.183402-2-greenfoo@u92.eu>
In-Reply-To: <20211104160959.183402-2-greenfoo@u92.eu>
From:   David Aguilar <davvid@gmail.com>
Date:   Sun, 7 Nov 2021 14:41:36 -0800
Message-ID: <CAJDDKr5KZK3wpox6FJPOL9koPr=k5+qTzZtPPFEmg4iZsvwoog@mail.gmail.com>
Subject: Re: [PATCH 1/3] vimdiff: new implementation with layout support
To:     Fernando Ramos <greenfoo@u92.eu>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Seth House <seth@eseth.com>, levraiphilippeblain@gmail.com,
        rogi@skylittlesystem.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an early review. We're still discussing the docs but there's a
few things worth mentioning now before we go too far.

On Thu, Nov 4, 2021 at 9:10 AM Fernando Ramos <greenfoo@u92.eu> wrote:
>
> When running 'git mergetool -t vimdiff', a new configuration option
> ('mergetool.vimdiff.layout') can now be used to select how the user
> wants the different windows, tabs and buffers to be displayed.
>
> If the option is not provided, the layout will be the same one that was
> being used before this commit (ie. two rows with LOCAL, BASE and COMMIT
> in the top one and MERGED in the bottom one).
>
> The 'vimdiff' variants ('vimdiff{1,2,3}') still work but, because they
> represented nothing else than different layouts, are now internally
> implemented as a subcase of 'vimdiff' with the corresponding
> pre-configured 'layout'.
>
> Signed-off-by: Fernando Ramos <greenfoo@u92.eu>
> ---
>  mergetools/vimdiff | 530 ++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 504 insertions(+), 26 deletions(-)
>
> diff --git a/mergetools/vimdiff b/mergetools/vimdiff
> index 96f6209a04..1f2e88777e 100644
> --- a/mergetools/vimdiff
> +++ b/mergetools/vimdiff
> @@ -1,48 +1,509 @@
> +#!/bin/bash
> +
> +# This script can be run in two different contexts:
> +#
> +#   - From git, when the user invokes the "vimdiff" merge tool. In this =
context
> +#     this script expects the following environment variables (among oth=
ers) to
> +#     be defined (which is something "git" takes care of):
> +#
> +#       - $BASE
> +#       - $LOCAL
> +#       - $REMOTE
> +#       - $MERGED
> +#
> +#     In this mode, all this script does is to run the next command:
> +#
> +#         vim -f -c ... $LOCAL $BASE $REMOTE $MERGED
> +#
> +#     ...where the "..." string depends on the value of the
> +#     "mergetool.vimdiff.layout" configuration variable and is used to o=
pen vim
> +#     with a certain layout of buffers, windows and tabs.
> +#
> +#   - From the shell, manually. This is only expected to be done by deve=
lopers
> +#     who are editing this script. When this happens, the script runs a =
battery
> +#     of unit tests to make sure nothing breaks.
> +#     In this context this script does not expect any particular environ=
ment
> +#     variable to be set.
> +#
> +
> +
> +# Set to "true" to print debug messages to stderr
> +DEBUG=3Dfalse
> +#DEBUG=3Dtrue


It might be better to omit "DEBUG=3Dfalse" and call it
GIT_MERGETOOL_VIMDIFF_DEBUG.


> +
> +
> +########################################################################=
########
> +## Internal functions (not meant to be used outside this script)
> +########################################################################=
########
> +
> +debug_print() {
> +       # Send message to stderr if global variable DEBUG is set to "true=
"
> +
> +       if test "$DEBUG" =3D "true"
> +       then
> +               >&2 echo "$@";
> +       fi


... and then in here we can just check:

    if test -n "$GIT_MERGETOOL_VIMDIFF_DEBUG"
    then
        ....
    fi

and we won't ever have to edit the script to activate the debug mode
because it'll get inherited from the environment.



> +}
> +
> +
> +gen_cmd_aux() {
> +       # Auxiliary function used from "gen_cmd()".
> +       # Read that other function documentation for more details.
> +
> +       local LAYOUT=3D$1
> +       local CMD=3D$2  # This is a second (hidden) argument used for rec=
ursion


I believe "local" and other features used in this script are bash-isms.

We have to stick to a strict portable posix shell subset, so there's
some stuff here that will need adjustment for maximal portability.

We can't use any bashisms and we avoid "local" in scripted porcelains.

We also avoid shell arrays and "Substring Expansion" ${parameter:offset:len=
gth}.

https://github.com/git/git/blob/master/Documentation/CodingGuidelines#L41

That's going to require some rework of the implementation below to avoid th=
ese.


> +
> +       debug_print
> +       debug_print "LAYOUT    : $LAYOUT"
> +       debug_print "CMD       : $CMD"
> +
> +       if test -z "$CMD"
> +       then
> +               CMD=3D"echo" # vim "nop" operator
> +       fi
> +
> +       local start=3D0
> +       local end=3D${#LAYOUT}
> +
> +       local nested=3D0
> +       local nested_min=3D100
> +
> +
> +       # Step 1:
> +       #
> +       # Increase/decrease "start"/"end" indices respectively to get rid=
 of
> +       # outer parenthesis.
> +       #
> +       # Example:
> +       #
> +       #   - BEFORE: (( LOCAL | BASE ) - MERGED )
> +       #   - AFTER :  ( LOCAL | BASE ) - MERGED
> +
> +       for (( i=3D$start; i<$end; i++ )); do

Please avoid multiple statements on a single line (the ";" should be a
line break instead).

The for loop is a bash-ism. An alternative might be...

for i in $(seq $start $end)
do
    ...
done

but that is off-by-one because "seq" includes the $end value, so it'll
need to be decremented by 1.



> +               if test "${LAYOUT:$i:1}" =3D " "
> +               then
> +                       continue
> +               fi

This is going to need rework because we can't use "${LAYOUT:$i:1}".


> +
> +               if test "${LAYOUT:$i:1}" =3D "("
> +               then
> +                       nested=3D$(( nested + 1 ))


I mentioned this in the documentation commit as a comment about splitting a
long line, but we do not use Process Substitution <(list) or >(list) either
so that's another reason to break up the pipeline I mentioned in the previo=
us
email.


Arithmetic substitution is something we do use, though, so this would be fi=
ne.


> +                       continue
> +               fi
> +
> +               if test "${LAYOUT:$i:1}" =3D ")"
> +               then
> +                       nested=3D$(( nested - 1 ))
> +                       continue
> +               fi
> +
> +               if test "$nested" -lt "$nested_min"
> +               then
> +                       nested_min=3D$nested
> +               fi
> +       done
> +
> +       debug_print "NESTED MIN: $nested_min"
> +
> +       while test "$nested_min" -gt "0"
> +       do
> +               start=3D$(( start + 1 ))
> +               end=3D$(( end - 1 ))
> +
> +               start_minus_one=3D$(( start - 1 ))
> +
> +               while ! test "${LAYOUT:$start_minus_one:1}" =3D "("
> +               do
> +                       start=3D$(( start + 1 ))
> +                       start_minus_one=3D$(( start_minus_one + 1 ))
> +               done
> +
> +               while ! test "${LAYOUT:$end:1}" =3D ")"
> +               do
> +                       end=3D$(( end - 1 ))
> +               done
> +
> +               nested_min=3D$(( nested_min - 1 ))
> +       done
> +
> +        debug_print "CLEAN     : ${LAYOUT:$start:$(( end - start ))}"
> +
> +
> +       # Step 2:
> +       #
> +       # Search for all valid separators (";", "-" or "|") which are *no=
t*
> +       # inside parenthesis. Save the index at which each of them makes =
the
> +       # first appearance.


I now understand why the parens are helpful. They seem to make the
implementation simpler/possible.

> +
> +       local index_semicolon=3D""
> +       local index_minus=3D""
> +       local index_pipe=3D""

Drop "local".

Semantic names for these might be helpful. "index_new_tab",
"index_vertical_split" and "index_horizontal_split" might be easier to
understand and would be resilient to sugs about using different
tokens.


> +
> +       nested=3D0
> +       for (( i=3D$start; i<$end; i++ )); do
> +               if test "${LAYOUT:$i:1}" =3D " "
> +               then
> +                       continue
> +               fi
> +
> +               if test "${LAYOUT:$i:1}" =3D "("
> +               then
> +                       nested=3D$(( nested + 1 ))


Here and below -- should that be nested=3D$(( $nested + 1 )) ?

It seems to be missing a '$' prefix on the inner $nested variable.

My shell accepts both but the predominant style in the git test suite
is the use $nested, so let's do that.



> +                       continue
> +               fi
> +
> +               if test "${LAYOUT:$i:1}" =3D ")"
> +               then
> +                       nested=3D$(( nested - 1 ))
> +                       continue
> +               fi
> +
> +               if test "$nested" -eq "0"
> +               then
> +                       current=3D${LAYOUT:$i:1}
> +
> +                       if test "$current" =3D ";"
> +                       then
> +                               if test -z "$index_semicolon"
> +                               then
> +                                       index_semicolon=3D$i
> +                               fi
> +
> +                       elif test "$current" =3D "-"
> +                       then
> +                               if test -z "$index_minus"
> +                               then
> +                                       index_minus=3D$i
> +                               fi
> +
> +                       elif test "$current" =3D "|"
> +                       then
> +                               if test -z "$index_pipe"
> +                               then
> +                                       index_pipe=3D$i
> +                               fi
> +                       fi
> +               fi
> +       done
> +
> +
> +       # Step 3:
> +       #
> +       # Process the separator with the highest order of precedence
> +       # (";" has the highest precedence and "|" the lowest one).
> +       #
> +       # By "process" I mean recursively call this function twice: the f=
irst
> +       # one with the substring at the left of the separator and the sec=
ond one
> +       # with the one at its right.
> +
> +       local terminate=3D"false"
> +
> +       if ! test -z "$index_semicolon"
> +       then
> +               before=3D"-tabnew"
> +               after=3D"tabnext"
> +               index=3D$index_semicolon
> +               terminate=3D"true"
> +
> +       elif ! test -z "$index_minus"
> +       then
> +               before=3D"split"
> +               after=3D"wincmd j"
> +               index=3D$index_minus
> +               terminate=3D"true"
> +
> +       elif ! test -z "$index_pipe"
> +       then
> +               before=3D"vertical split"
> +               after=3D"wincmd l"
> +               index=3D$index_pipe
> +               terminate=3D"true"
> +       fi
> +
> +       if  test "$terminate" =3D "true"
> +       then
> +               CMD=3D"$CMD | $before"
> +               CMD=3D$(gen_cmd_aux "${LAYOUT:$start:$(( index - start ))=
}" "$CMD")
> +               CMD=3D"$CMD | $after"
> +               CMD=3D$(gen_cmd_aux "${LAYOUT:$(( index + 1 )):$(( ${#LAY=
OUT} - index ))}" "$CMD")
> +               echo $CMD
> +               return
> +       fi
> +
> +
> +       # Step 4:
> +       #
> +       # If we reach this point, it means there are no separators and we=
 just
> +       # need to print the command to display the specified buffer
> +
> +       local target=3D$(echo "${LAYOUT:$start:$(( end - start ))}" | sed=
 's:[ *();|-]::g')
> +
> +       if test "$target" =3D "LOCAL"
> +       then
> +               CMD=3D"$CMD | 1b"
> +
> +       elif test "$target" =3D "BASE"
> +       then
> +               CMD=3D"$CMD | 2b"
> +
> +       elif test "$target" =3D "REMOTE"
> +       then
> +               CMD=3D"$CMD | 3b"
> +
> +       elif test "$target" =3D "MERGED"
> +       then
> +               CMD=3D"$CMD | 4b"
> +
> +       else
> +               CMD=3D"$CMD | ERROR: >$target<"
> +       fi
> +
> +       echo $CMD
> +       return
> +}
> +
> +
> +gen_cmd() {
> +       # This function returns (in global variable FINAL_CMD) the string=
 that
> +       # you can use when invoking "vim" (as shown next) to obtain a giv=
en
> +       # layout:
> +       #
> +       #   $ vim -f $FINAL_CMD "$LOCAL" "$BASE" "$REMOTE" "$MERGED"
> +       #
> +       # It takes one single argument: a string containing the desired l=
ayout
> +       # definition.
> +       #
> +       # The syntax of the "layout definitions" is explained in ... (TOD=
O)...
> +       # but you can already intuitively understand how it works by know=
ing
> +       # that...
> +       #
> +       #   * ";" means "a new vim tab"
> +       #   * "-" means "a new vim horizontal split"
> +       #   * "|" means "a new vim vertical split"
> +       #
> +       # It also returns (in global variable FINAL_TARGET) the name ("LO=
CAL",
> +       # "BASE", "REMOTE" or "MERGED") of the file that is marked with a=
n "*",
> +       # or "MERGED" if none of them is.
> +       #
> +       # Example:
> +       #
> +       #     gen_cmd "LOCAL* | REMOTE"
> +       #     |
> +       #     `-> FINAL_CMD    =3D=3D "-c \"echo | vertical split | 1b | =
wincmd l | 3b | tabdo windo diffthis\" -c \"tabfirst\""
> +       #         FINAL_TARGET =3D=3D "LOCAL"
> +
> +       local LAYOUT=3D$1
> +
> +
> +       # Search for a "*" in one of the files identifiers ("LOCAL", "BAS=
E",
> +       # "REMOTE", "MERGED"). If not found, use "MERGE" as the default f=
ile
> +       # where changes will be saved.
> +
> +       AUX=3D$(echo "$LAYOUT" | grep -oe "[A-Z]\+\*")


From Documentatin/CodingGuidelines:

As to use of grep, stick to a subset of BRE (namely, no {m,n},
   [::], [=3D=3D], or [..]) for portability.



> +
> +       if ! test -z "$AUX"
> +       then
> +               FINAL_TARGET=3D"${AUX:0:-1}"
> +       else
> +               FINAL_TARGET=3D"MERGED"
> +       fi


The conditional above is better written as:

    if test -n "$AUX"
    then
        ...
    else
        ...
    fi

"test -n" is the logical opposite of "test -z", so "! test -z" can be
replaced with "test -n".




> +
> +
> +       # Obtain the first part of vim "-c" option to obtain the desired =
layout
> +
> +       CMD=3D$(gen_cmd_aux "$LAYOUT")
> +
> +
> +       # Adjust the just obtained script depending on whether more than =
one
> +       # windows are visible or not
> +
> +       if test $(echo $LAYOUT | wc -w) =3D=3D "1"
> +       then
> +               CMD=3D"$CMD | bufdo diffthis"
> +        else
> +               CMD=3D"$CMD | tabdo windo diffthis"
> +       fi


The output of "wc -c" is non-portable. It contains leading whitespace
on some platforms.

The test expression should be:

   test "$value" =3D 1

with a single "=3D" rather than "=3D=3D".



> +
> +
> +       # Add an extra "-c" option to move to the first tab (notice that =
we
> +       # can't simply append the command to the previous "-c" string as
> +       # explained here: https://github.com/vim/vim/issues/9076
> +
> +       FINAL_CMD=3D"-c \"$CMD\" -c \"tabfirst\""
> +}
> +
> +
> +run_unit_tests() {
> +       # Function to make sure that we don't break anything when modifyi=
ng this
> +       # script.
> +       #
> +       # This function is automatically executed when you execute this s=
cript
> +       # from the shell with environment variable "DEBUG_GIT_VIMDIFF" se=
t (to
> +       # any value).
> +
> +       local test_cases=3D(
> +               `#Test case 00` "LOCAL | MERGED | REMOTE"
> +               `#Test case 01` "LOCAL - MERGED - REMOTE"
> +               `#Test case 02` "(LOCAL - REMOTE) | MERGED"
> +               `#Test case 03` "MERGED | (LOCAL - REMOTE)"
> +               `#Test case 04` "(LOCAL | REMOTE) - MERGED"
> +               `#Test case 05` "MERGED - (LOCAL | REMOTE)"
> +               `#Test case 06` "(LOCAL | BASE | REMOTE) - MERGED"
> +               `#Test case 07` "(LOCAL - BASE - REMOTE) | MERGED"
> +               `#Test case 08` "LOCAL* | REMOTE"
> +               `#Test case 09` "MERGED"
> +               `#Test case 10` "(LOCAL | BASE | REMOTE) - MERGED; BASE |=
 LOCAL; BASE | REMOTE; (LOCAL - BASE - REMOTE) | MERGED"
> +               `#Test case 11` "((LOCAL | REMOTE) - BASE) | MERGED"
> +               `#Test case 12` "((LOCAL | REMOTE) - BASE) | ((LOCAL - RE=
MOTE) | MERGED)"
> +               `#Test case 13` "BASE | REMOTE ; BASE | LOCAL"
> +       )
> +
> +       local expected_cmd=3D(
> +               `#Test case 00` "-c \"echo | vertical split | 1b | wincmd=
 l | vertical split | 4b | wincmd l | 3b | tabdo windo diffthis\" -c \"tabf=
irst\""
> +               `#Test case 01` "-c \"echo | split | 1b | wincmd j | spli=
t | 4b | wincmd j | 3b | tabdo windo diffthis\" -c \"tabfirst\""
> +               `#Test case 02` "-c \"echo | vertical split | split | 1b =
| wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
> +               `#Test case 03` "-c \"echo | vertical split | 4b | wincmd=
 l | split | 1b | wincmd j | 3b | tabdo windo diffthis\" -c \"tabfirst\""
> +               `#Test case 04` "-c \"echo | split | vertical split | 1b =
| wincmd l | 3b | wincmd j | 4b | tabdo windo diffthis\" -c \"tabfirst\""
> +               `#Test case 05` "-c \"echo | split | 4b | wincmd j | vert=
ical split | 1b | wincmd l | 3b | tabdo windo diffthis\" -c \"tabfirst\""
> +               `#Test case 06` "-c \"echo | split | vertical split | 1b =
| wincmd l | vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabdo wi=
ndo diffthis\" -c \"tabfirst\""
> +               `#Test case 07` "-c \"echo | vertical split | split | 1b =
| wincmd j | split | 2b | wincmd j | 3b | wincmd l | 4b | tabdo windo difft=
his\" -c \"tabfirst\""
> +               `#Test case 08` "-c \"echo | vertical split | 1b | wincmd=
 l | 3b | tabdo windo diffthis\" -c \"tabfirst\""
> +               `#Test case 09` "-c \"echo | 4b | bufdo diffthis\" -c \"t=
abfirst\""
> +               `#Test case 10` "-c \"echo | -tabnew | split | vertical s=
plit | 1b | wincmd l | vertical split | 2b | wincmd l | 3b | wincmd j | 4b =
| tabnext | -tabnew | vertical split | 2b | wincmd l | 1b | tabnext | -tabn=
ew | vertical split | 2b | wincmd l | 3b | tabnext | vertical split | split=
 | 1b | wincmd j | split | 2b | wincmd j | 3b | wincmd l | 4b | tabdo windo=
 diffthis\" -c \"tabfirst\""
> +               `#Test case 11` "-c \"echo | vertical split | split | ver=
tical split | 1b | wincmd l | 3b | wincmd j | 2b | wincmd l | 4b | tabdo wi=
ndo diffthis\" -c \"tabfirst\""
> +               `#Test case 12` "-c \"echo | vertical split | split | ver=
tical split | 1b | wincmd l | 3b | wincmd j | 2b | wincmd l | vertical spli=
t | split | 1b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c =
\"tabfirst\""
> +               `#Test case 13` "-c \"echo | -tabnew | vertical split | 2=
b | wincmd l | 3b | tabnext | vertical split | 2b | wincmd l | 1b | tabdo w=
indo diffthis\" -c \"tabfirst\""
> +       )
> +
> +       local expected_target=3D(
> +               `#Test case 00` "MERGED"
> +               `#Test case 01` "MERGED"
> +               `#Test case 02` "MERGED"
> +               `#Test case 03` "MERGED"
> +               `#Test case 04` "MERGED"
> +               `#Test case 05` "MERGED"
> +               `#Test case 06` "MERGED"
> +               `#Test case 07` "MERGED"
> +               `#Test case 08` "LOCAL"
> +               `#Test case 09` "MERGED"
> +               `#Test case 10` "MERGED"
> +               `#Test case 11` "MERGED"
> +               `#Test case 12` "MERGED"
> +               `#Test case 13` "MERGED"
> +       )


We can't use shell arrays. This part really tells me that I don't
understand bash at all.

I don't understand what the backticks are doing.. is it actually
running something?

That's just a rhetorical question.. I don't actually know, but it's okay if=
 we
ignore this question since we already indicated that we'll have to do
w/out arrays.




> +
> +       local at_least_one_ko=3D"false"
> +
> +       for i in ${!test_cases[@]}; do


I suspect ${!test_cases[@]} is some bash-ism that we can't use.

For the final patch, I think it would be good if we had a way to run this
through the test suite if possible rather than needing to run the script
directly.

It might have more leeway to setup the environment for testing that way too=
.


> +               gen_cmd "${test_cases[$i]}"
> +
> +               if test "$FINAL_CMD" =3D "${expected_cmd[$i]}" && test "$=
FINAL_TARGET" =3D "${expected_target[$i]}"
> +               then
> +                       printf "Test Case #%02d: OK\n" $i
> +               else
> +                       printf "Test Case #%02d: KO !!!!\n" $i
> +                       echo "  FINAL_CMD              : $FINAL_CMD"
> +                        echo "  FINAL_CMD (expected)   : ${expected_cmd[=
$i]}"
> +                       echo "  FINAL_TARGET           : $FINAL_TARGET"
> +                        echo "  FINAL_TARGET (expected): ${expected_targ=
et[$i]}"
> +                       at_least_one_ko=3D"true"
> +               fi
> +       done
> +
> +       if test "$at_least_one_ko" =3D "true"
> +       then
> +               return -1
> +       else
> +               return 0
> +       fi
> +}
> +
> +
> +########################################################################=
########
> +## API functions (called from "git-mergetool--lib.sh")
> +########################################################################=
########
> +
>  diff_cmd () {
>         "$merge_tool_path" -R -f -d \
>                 -c 'wincmd l' -c 'cd $GIT_PREFIX' "$LOCAL" "$REMOTE"
>  }
>
> +
>  merge_cmd () {
> +       layout=3D$(git config mergetool.$merge_tool.layout)
> +       print_warning=3D"false"
> +
>         case "$1" in
>         *vimdiff)
> -               if $base_present
> +               if test -z "$layout"
>                 then
> -                       "$merge_tool_path" -f -d -c '4wincmd w | wincmd J=
' \
> -                               "$LOCAL" "$BASE" "$REMOTE" "$MERGED"
> -               else
> -                       "$merge_tool_path" -f -d -c 'wincmd l' \
> -                               "$LOCAL" "$MERGED" "$REMOTE"
> +                       # Default layout when none is specified
> +                       layout=3D"(LOCAL | BASE | REMOTE) - MERGED"
>                 fi
>                 ;;
>         *vimdiff1)
> -               "$merge_tool_path" -f -d \
> -                       -c 'echon "Resolve conflicts leftward then save. =
Use :cq to abort."' \
> -                       "$LOCAL" "$REMOTE"
> -               ret=3D"$?"
> -               if test "$ret" -eq 0
> -               then
> -                       cp -- "$LOCAL" "$MERGED"
> -               fi
> -               return "$ret"
> +               layout=3D"LOCAL* | MERGED"
> +               print_warning=3D"true"
>                 ;;
>         *vimdiff2)
> -               "$merge_tool_path" -f -d -c 'wincmd l' \
> -                       "$LOCAL" "$MERGED" "$REMOTE"
> +               layout=3D"LOCAL | MERGED | REMOTE"
> +               print_warning=3D"true"
>                 ;;
>         *vimdiff3)
> -               if $base_present
> -               then
> -                       "$merge_tool_path" -f -d -c 'hid | hid | hid' \
> -                               "$LOCAL" "$REMOTE" "$BASE" "$MERGED"
> -               else
> -                       "$merge_tool_path" -f -d -c 'hid | hid' \
> -                               "$LOCAL" "$REMOTE" "$MERGED"
> -               fi
> +               layout=3D"MERGED"
> +               print_warning=3D"true"
>                 ;;
>         esac
> +
> +       if test "$print_warning" =3D "true"
> +       then
> +               echo "WARNING:"
> +               echo "WARNING: '$1' is going to be removed in a future ve=
rsion. You will be"
> +               echo "WARNING: able to obtain the same result by selectin=
g 'vimdiff' as the merge"
> +               echo "WARNING: tool and setting configuration variable 'm=
ergetool.vimdiff.layout'"
> +               echo "WARNING: to the following value:"
> +               echo "WARNING:"
> +               echo "WARNING:     layout =3D \"$layout\""
> +               echo "WARNING:"
> +               echo "Press ENTER to continue..."
> +               read
> +       fi

I wonder if we should ever remove the old variants.

We could just keep them around forever, and then users won't ever be bother=
ed.

The bulk of the improvement here is to improve the implementation so
that we don't
ever have to add any new variants, and to fold the implementations
together into a
common approach so that there's less code to maintain.

It seems like there's really no need to burden users with our
implementation choices.

I personally would be in favor of dropping the deprecation angle and treati=
ng
these patches more-so as an refactoring of the implementation.


> +
> +       gen_cmd "$layout"
> +
> +       debug_print ""
> +       debug_print "FINAL CMD : $FINAL_CMD"
> +       debug_print "FINAL TAR : $FINAL_TARGET"
> +
> +       if $base_present
> +       then
> +               eval "$merge_tool_path" \
> +                       -f $FINAL_CMD "$LOCAL" "$BASE" "$REMOTE" "$MERGED=
"
> +       else
> +               # If there is no BASE (example: a merge conflict in a new=
 file
> +               # with the same name created in both braches which didn't=
 exist
> +               # before), close all BASE windows using vim's "quit" comm=
and
> +
> +               FINAL_CMD=3D$(echo $FINAL_CMD | \
> +                       sed -e 's:2b:quit:g' -e 's:3b:2b:g' -e 's:4b:3b:g=
')
> +
> +               eval "$merge_tool_path" \
> +                       -f $FINAL_CMD "$LOCAL" "$REMOTE" "$MERGED"
> +       fi
> +
> +
> +       ret=3D"$?"
> +       if test "$ret" -eq 0

This should be:

    if test "$ret" =3D 0

> +       then
> +               if test "$FINAL_TARGET" !=3D "MERGED"
> +               then
> +                       eval cp -- \$"$FINAL_TARGET" "$MERGED"

This eval may not be safe when the value contains whitespace or shell
metacharacters.

I think it might be better to just spell it out and be explicit.

It's more code but it'll be easier to follow:

case "$FINAL_TARGET" in
LOCAL)
    source_path=3D"$LOCAL"
    ;;
REMOTE)
    source_path=3D"$REMOTE"
    ;;
MERGED|*)
    # Do nothing
    source_path=3D
    ;;
esac

if test -n "$source_path"
then
    cp -- "$source_path" "$MERGED"
fi



> +               fi
> +       fi
> +       return "$ret"
>  }
>
> +
>  translate_merge_tool_path() {
>         case "$1" in
>         nvimdiff*)
> @@ -57,14 +518,31 @@ translate_merge_tool_path() {
>         esac
>  }
>
> +
>  exit_code_trustable () {
>         true
>  }
>
> +
>  list_tool_variants () {
>         for prefix in '' g n; do
> -               for suffix in '' 1 2 3; do
> +               for suffix in '' 1 2 3
> +               do
>                         echo "${prefix}vimdiff${suffix}"
>                 done
>         done
>  }
> +
> +
> +########################################################################=
########
> +## Run unit tests when calling this script from a shell
> +########################################################################=
########
> +
> +if test $(ps -o stat=3D -p $PPID) =3D "Ss" && test $(ps -o stat=3D -p $$=
) =3D "S+"
> +then
> +       # Script is being manually run from command line (see
> +       # https://stackoverflow.com/questions/4261876/check-if-bash-scrip=
t-was-invoked-from-a-shell-or-another-script-application)
> +
> +       run_unit_tests
> +fi


I'm not 100% sure, but I suspect this is probably non-portable and
will have some issues.

This is another vote for setting something up to go through the test suite.

The test suite can set some GIT_MERGETOOL_VIMDIFF_TESTING variable
that the scriplet
can key off of explicitly rather than having the script embed this stuff in=
 it.

A test could then source the scriptlet directly and exercise functions
provided by it.

If the implementation details get too complex for shell, I wonder if
it's time to split
off a small helper command in C that does the layout -> vim script
translation. TBD.

The parsing code is pretty complex but if there's a way to do it in our por=
table
posix shell subset then we'll take that. There might be a point where havin=
g a
small dedicated helper command might be easier.

You'll probably have the best sense of that, though.

Thanks for diving into making this happen.
--=20
David
