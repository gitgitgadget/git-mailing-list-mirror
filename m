Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47577C433E0
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 02:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E11AC22D58
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 02:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729481AbhALC1u (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 21:27:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbhALC1u (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jan 2021 21:27:50 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCC5C061575
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 18:27:09 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id w2so447314pfc.13
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 18:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sorjzg/y1w9X3DEe3cFxVeoJPyFcXBazSkQHfePeglQ=;
        b=RTn7/l9I25YMFQYpMLZ+sjoVDsAB+8YJeR8nijJKrZuEK7992vpBtfFJ/GGXUnV4h9
         GN/Zc5oVAs2+uD2aq0fWOSLaZ3AzSNp8xMiJbonMHOwK+l6oy/5Kl77jR3PcG4G5Vtk7
         blnyASHJhGhzD44fE2NhlMYC5ywJKQOGKhEa5q5/IhzjvJ+HTKwwVe8QjK6DQ1vx4GaV
         ZjY4c1KXveyuTyd2l9LmLOFM9YPM5IMKSpWtZayzKitfq/8Ysu2P0wvirH6PYdbtDjew
         1jWuD8K2XemY92DsN6W/AscwoAzaSEfOH0Ysm2LNkWBOcXB3+cyGIzYrluj8BteTOz1/
         ubTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sorjzg/y1w9X3DEe3cFxVeoJPyFcXBazSkQHfePeglQ=;
        b=VmXp3K/glvrSn6z3BJhngXsD5jAcz04yTSSW3k23l1pdyrCAJCum1M66IK2F1gl+DF
         YL/ooFlxARmUz57shH6ycHbFtlza9khNb+ZeueaBVci2YdeTvDPyo033zAHlxGIoPLrU
         Gmvq13joDBP6FrNd2oWIL0l5vXCZVLKB4y+sQ9O9xTcTwFqdLo2dRN2r83ltKHQXK0dw
         tqpeoI19ygVLL5/P8Q9NUDgMuaGgam89xNdtMbTGVBl03kb114nEsuviXc+Gnrhe4JcD
         OUtC2NBDcFO+6L67Vcu1JDGhDnkvHyTMfiGRaq3r83dileytfb2GJjOjS8sPo9HFyAnZ
         8oXg==
X-Gm-Message-State: AOAM532xxEfI8G+yMTG2Wj8rR+wDq/1mcOa5RPxxteo4cOhbYsRVXfMb
        crj3jMbWpQ5VLbXfHCUS8Wc=
X-Google-Smtp-Source: ABdhPJxOFZIUzAVzkvgB7ZFLv0QEZV4uvE7GNvliPy0DnBjTQ8Cm8Xkd9lKsO+KEqwHXvLW0yzIOjg==
X-Received: by 2002:a63:c64a:: with SMTP id x10mr2465287pgg.14.1610418429508;
        Mon, 11 Jan 2021 18:27:09 -0800 (PST)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id cq15sm813134pjb.27.2021.01.11.18.27.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jan 2021 18:27:08 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v6 0/3] improvements for git-bundle
Date:   Mon, 11 Jan 2021 21:27:00 -0500
Message-Id: <20210112022703.1884-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <xmqq1rer8cbz.fsf@gitster.c.googlers.com>
References: <xmqq1rer8cbz.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Introduce two improvements for git-bundle

+ Commit "bundle: lost objects when removing duplicate pendings",
  which fixes command like:

        $ git bundle create <file> 'master^!'

+ Commits "bundle: arguments can be read from stdin",
  which add "--stdin" option support for git-bundle, like:

        $ git bundle create <file> <input


## Changes since v5:

Junio C Hamano <gitster@pobox.com> writes:
>
> Jiang Xin <worldhello.net@gmail.com> writes:
>
> > +     var=$1
> > +     shift
> > +     if test -z "$var"
> > +     then
> > +             echo >&2 "error: var is not defined"
> > +             return 1
> > +     fi
>
> We need to check $# immediately after the loop to ensure that we can
> carve out $var and at least another arg.  [*Nit 1*]
>
> The previous round required the command line to have at least one
> after the loop (including parsing of $var) parsed it, but now we
> fall through from here when a command line were:
>
>     test_commit_setvar --merge -C there VAR
>
> and because "$1" does not exist, such an error is propagated down to
> "git merge" not getting the side branch, "git tag" not getting the
> object to tag, etc.

range-diff v5...v6 (part-1):

    @@ t/t6020-bundle-misc.sh (new)
     +		esac
     +		shift
     +	done
    -+
    -+	var=$1
    -+	shift
    -+	if test -z "$var"
    ++	if test $# -lt 2
     +	then
    -+		echo >&2 "error: var is not defined"
    ++		echo >&2 "error: test_commit_setvar must have at least 2 arguments"
     +		return 1
     +	fi
    ++	var=$1
    ++	shift
     +	indir=${indir:+"$indir"/}
     +	if test -z "$notick"
     +	then

> > +     else
> > +             file=${2:-"$1.t"} &&
> > +             echo "${3-$1}" > "$indir$file" &&
>
> Style?  [*Nit 2*]

range-diff v5...v6 (part-2):

* Add new arg "${2:-HEAD}" for `git tag`.
* Fix [*Nit 2*].

    @@ t/t6020-bundle-misc.sh (new)
     +		oid=$(git ${indir:+ -C "$indir"} rev-parse HEAD)
     +	elif test -n "$tag"
     +	then
    -+		git ${indir:+ -C "$indir"} tag -m "$1" "$1" &&
    ++		git ${indir:+ -C "$indir"} tag -m "$1" "$1" "${2:-HEAD}" &&
     +		oid=$(git ${indir:+ -C "$indir"} rev-parse "$1")
     +	else
     +		file=${2:-"$1.t"} &&
    -+		echo "${3-$1}" > "$indir$file" &&
    ++		echo "${3-$1}" >"$indir$file" &&
     +		git ${indir:+ -C "$indir"} add "$file" &&
     +		git ${indir:+ -C "$indir"} commit $signoff -m "$1" &&
     +		oid=$(git ${indir:+ -C "$indir"} rev-parse HEAD)

> > +# Format the output of git commands to make a user-friendly and stable
> > +# text.  We can easily prepare the expect text without having to worry
> > +# about future changes of the commit ID and spaces of the output.
> > +make_user_friendly_and_stable_output () {
> > +     sed \
> > +             -e "s/$(echo $A | cut -c1-7)[0-9a-f]*/<COMMIT-A>/g" \
>
> Is "$(echo $A | cut -c1-7)" the same as "${A%${A#???????}}"?  If so,
> the latter may be a bit shorter.


range-diff v5...v6 (part-3):

    @@ t/t6020-bundle-misc.sh (new)
     +	eval $var=$oid
     +}
     +
    -+
     +# Format the output of git commands to make a user-friendly and stable
     +# text.  We can easily prepare the expect text without having to worry
     +# about future changes of the commit ID and spaces of the output.
     +make_user_friendly_and_stable_output () {
     +	sed \
    -+		-e "s/$(echo $A | cut -c1-7)[0-9a-f]*/<COMMIT-A>/g" \
    -+		-e "s/$(echo $B | cut -c1-7)[0-9a-f]*/<COMMIT-B>/g" \
    -+		-e "s/$(echo $C | cut -c1-7)[0-9a-f]*/<COMMIT-C>/g" \
    -+		-e "s/$(echo $D | cut -c1-7)[0-9a-f]*/<COMMIT-D>/g" \
    -+		-e "s/$(echo $E | cut -c1-7)[0-9a-f]*/<COMMIT-E>/g" \
    -+		-e "s/$(echo $F | cut -c1-7)[0-9a-f]*/<COMMIT-F>/g" \
    -+		-e "s/$(echo $G | cut -c1-7)[0-9a-f]*/<COMMIT-G>/g" \
    -+		-e "s/$(echo $H | cut -c1-7)[0-9a-f]*/<COMMIT-H>/g" \
    -+		-e "s/$(echo $I | cut -c1-7)[0-9a-f]*/<COMMIT-I>/g" \
    -+		-e "s/$(echo $J | cut -c1-7)[0-9a-f]*/<COMMIT-J>/g" \
    -+		-e "s/$(echo $K | cut -c1-7)[0-9a-f]*/<COMMIT-K>/g" \
    -+		-e "s/$(echo $L | cut -c1-7)[0-9a-f]*/<COMMIT-L>/g" \
    -+		-e "s/$(echo $M | cut -c1-7)[0-9a-f]*/<COMMIT-M>/g" \
    -+		-e "s/$(echo $N | cut -c1-7)[0-9a-f]*/<COMMIT-N>/g" \
    -+		-e "s/$(echo $O | cut -c1-7)[0-9a-f]*/<COMMIT-O>/g" \
    -+		-e "s/$(echo $P | cut -c1-7)[0-9a-f]*/<COMMIT-P>/g" \
    -+		-e "s/$(echo $TAG1 | cut -c1-7)[0-9a-f]*/<TAG-1>/g" \
    -+		-e "s/$(echo $TAG2 | cut -c1-7)[0-9a-f]*/<TAG-2>/g" \
    -+		-e "s/$(echo $TAG3 | cut -c1-7)[0-9a-f]*/<TAG-3>/g" \
    ++		-e "s/${A%${A#???????}}[0-9a-f]*/<COMMIT-A>/g" \
    ++		-e "s/${B%${B#???????}}[0-9a-f]*/<COMMIT-B>/g" \
    ++		-e "s/${C%${C#???????}}[0-9a-f]*/<COMMIT-C>/g" \
    ++		-e "s/${D%${D#???????}}[0-9a-f]*/<COMMIT-D>/g" \
    ++		-e "s/${E%${E#???????}}[0-9a-f]*/<COMMIT-E>/g" \
    ++		-e "s/${F%${F#???????}}[0-9a-f]*/<COMMIT-F>/g" \
    ++		-e "s/${G%${G#???????}}[0-9a-f]*/<COMMIT-G>/g" \
    ++		-e "s/${H%${H#???????}}[0-9a-f]*/<COMMIT-H>/g" \
    ++		-e "s/${I%${I#???????}}[0-9a-f]*/<COMMIT-I>/g" \
    ++		-e "s/${J%${J#???????}}[0-9a-f]*/<COMMIT-J>/g" \
    ++		-e "s/${K%${K#???????}}[0-9a-f]*/<COMMIT-K>/g" \
    ++		-e "s/${L%${L#???????}}[0-9a-f]*/<COMMIT-L>/g" \
    ++		-e "s/${M%${M#???????}}[0-9a-f]*/<COMMIT-M>/g" \
    ++		-e "s/${N%${N#???????}}[0-9a-f]*/<COMMIT-N>/g" \
    ++		-e "s/${O%${O#???????}}[0-9a-f]*/<COMMIT-O>/g" \
    ++		-e "s/${P%${P#???????}}[0-9a-f]*/<COMMIT-P>/g" \
    ++		-e "s/${TAG1%${TAG1#???????}}[0-9a-f]*/<TAG-1>/g" \
    ++		-e "s/${TAG2%${TAG2#???????}}[0-9a-f]*/<TAG-2>/g" \
    ++		-e "s/${TAG3%${TAG3#???????}}[0-9a-f]*/<TAG-3>/g" \
     +		-e "s/ *\$//"
     +}
     +

> Do we even need the "error" message?  "git index-pack" would have
> already given some error message to its standard error stream, no?
> If so
>
>         if test -n "$thin"
>         then
>                 ...
>         fi || return 1
>
> would be sufficient, I guess.

range-diff v5...v6 (part-4):

1:  fa7516b2ec ! 1:  900bb16178 test: add helper functions for git-bundle
    @@ t/test-bundle-functions.sh (new)
     +		git index-pack --stdin --fix-thin "$pack" <"$bundle.thin.pack"
     +	else
     +		git index-pack "$pack"
    -+	fi
    -+	if test $? -ne 0
    -+	then
    -+		echo >&2 "error: fail to convert $bundle or index-pack"
    -+		return 1
    -+	fi
    ++	fi || return 1
     +	count=$(git show-index <"${pack%pack}idx" | wc -l) &&
     +	test $2 = $count && return 0
     +	echo >&2 "error: object count for $bundle is $count, not $2"
2:  ea543de111 = 2:  1bbf0ab213 bundle: lost objects when removing duplicate pendings
3:  18f0d48814 = 3:  7ac0751821 bundle: arguments can be read from stdin

--

Jiang Xin (3):
  test: add helper functions for git-bundle
  bundle: lost objects when removing duplicate pendings
  bundle: arguments can be read from stdin

 bundle.c                   | 109 +++++----
 object.c                   |  10 +-
 t/t5510-fetch.sh           |  26 +--
 t/t5607-clone-bundle.sh    |   4 +-
 t/t6020-bundle-misc.sh     | 463 +++++++++++++++++++++++++++++++++++++
 t/test-bundle-functions.sh |  42 ++++
 6 files changed, 576 insertions(+), 78 deletions(-)
 create mode 100755 t/t6020-bundle-misc.sh
 create mode 100644 t/test-bundle-functions.sh

-- 
2.28.0.15.gba9e81f0bd
