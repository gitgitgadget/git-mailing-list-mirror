Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF20C0018C
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 12:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D2AA23AC6
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 12:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgLSMyI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Dec 2020 07:54:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgLSMyI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Dec 2020 07:54:08 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDDDC0617B0
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 04:53:27 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id 9so6109388oiq.3
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 04:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=6Q/woXJ0BqDKLbBlgUTNLB9nQarPzdsYNJcxdmQ5oHY=;
        b=MVYwN+p7HaKbH+HP9HTvko9UgBPVZC6lDZZKLIc1MxTEo1Vex09njlo2j7ObNZCogw
         AgQbJXVvzp0aMdA2RQXFTRdRy7NR6xh/SWX+a2FcXMazI0Bf9YMGftYx6cySOxwAfFTJ
         C8rBFY9UK+vmZRh1mfFmgDF2mMXYTmlFvgwBbvv1XK0nypjEEuM1NIbFhwhLa0xPQpJ0
         aDcfBYw6zz88YY3wW/i/qDzwytNE471hbGj6818Y3gnTv6i2H7Wv9az25H8FY42iRuhO
         1xEOH1reDjnrJrNr7Vc6IHasPjN4+g6nDpFKHse5Dca3Gtw37ID0903k5dYbe0DXcjzI
         1PMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=6Q/woXJ0BqDKLbBlgUTNLB9nQarPzdsYNJcxdmQ5oHY=;
        b=ElUINWKU0Nu92SHlbRAArYSYxHEDZMhKERfdM9E2kBKdw89455aqd9LmWJZZlwlgKO
         DZLvZHVNB4iyZzyHt4ppC2kS9h0gXUTNiS766EQ5uPMHMQfnEtTgFF9obnGDnKXXPid+
         iU5LV597khaH7z2UTBjON5p0xG21FqGFt8bx96gOkXOfy3+L+c7eEqtAHNUsjIM+fQDh
         0/lUj2flUq4aGh42vnTMLGfkRzQ19nD1bAcjANOIZ9zBWfUC1gpad7Xq1xhggVcNCBvN
         n87peMB+dGaqYFmNJTzIwJhRjcFXmVw4aaEMRA4SqJOxl5nUQUwvTvho3qD3/mOjHNX9
         rrzw==
X-Gm-Message-State: AOAM531fp3RghYG5AO1KNQFLN23uZi1GoLMolECrQf2MOB2N/+MGI+nE
        K9RlqxGIXD8nBAJeH8MlsjU=
X-Google-Smtp-Source: ABdhPJyUvzkcKaVuXpoc2E/ybO54tmQly0BXeFDsouEITYUbcUU+MYbvoGB1hFvOISUDMBACZYLgSg==
X-Received: by 2002:aca:d5c3:: with SMTP id m186mr5660752oig.73.1608382407209;
        Sat, 19 Dec 2020 04:53:27 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id o21sm2552316otj.1.2020.12.19.04.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Dec 2020 04:53:26 -0800 (PST)
Date:   Sat, 19 Dec 2020 06:53:25 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Seth House <seth@eseth.com>
Message-ID: <5fddf7c5650fe_1de0de208a3@natae.notmuch>
In-Reply-To: <b338a9f4-6e34-c5c6-16ef-097aadc3f3a8@gmail.com>
References: <20201218124905.1072514-1-felipe.contreras@gmail.com>
 <20201218124905.1072514-2-felipe.contreras@gmail.com>
 <b338a9f4-6e34-c5c6-16ef-097aadc3f3a8@gmail.com>
Subject: Re: [PATCH v4 1/1] mergetool: add automerge configuration
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood wrote:
> Hi Felipe
> 
> On 18/12/2020 12:49, Felipe Contreras wrote:
> > It doesn't make sense to display lines without conflicts in the
> > different views of all mergetools.
> > 
> > Only the lines that warrant conflict markers should be displayed.
> > 
> > Most people would want this behavior on, but in case some don't; add a
> > new configuration: mergetool.autoMerge.
> > 
> > See Seth House's blog post [1] for the idea, and the rationale.
> > 
> > [1] https://www.eseth.org/2020/mergetools.html
> 
> I would be good to have a summary of the idea in this commit message so 
> people do not have to go and find a blog post which may well disappear 
> in the future

I thought I did, in the paragraphs above. How about adding this
explanation:

When merging, not all lines with changes are considered conflicts, for
example:

  cat >BASE <<EOF
  Patagraph 1

  Paragraph 2
  EOF

  cat >LOCAL <<EOF
  Paragraph 1

  Paragraph 2
  EOF

  cat >REMOTE <<EOF
  Patagraph 1.

  Paragraph 2.
  EOF

In this case the first paragraph does have a conflict because there are
two changes (in LOCAL and REMOTE), that the user must resolve.

However, the second paragraph doesn't have a conflict; it's
straightforward to decide that we want the only change present (in
REMOTE).

In fact, if it were not for the first paragraph with a conflict, git
wouldn't have bothered the user since the automatic merge would have
succeeded.

So it doesn't make sense to display these unconflicted lines to the user
inside the mergetool; it only creates noise.

We can fix that by propagating the final version of the file with the
automatic merge to all the panes of the mergetool (BASE, LOCAL, and
REMOTE), and only make them differ on the places where the are actual
conflicts (and they are demarcated with conflict markers).

(this is mostly my explanation though, not Seth's, who used visual
examples)

> > Original-idea-by: Seth House <seth@eseth.com>
> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > ---
> >   Documentation/config/mergetool.txt |  3 +++
> >   git-mergetool.sh                   | 17 +++++++++++++++++
> >   t/t7610-mergetool.sh               | 18 ++++++++++++++++++
> >   3 files changed, 38 insertions(+)
> > 
> > diff --git a/Documentation/config/mergetool.txt b/Documentation/config/mergetool.txt
> > index 16a27443a3..7ce6d0d3ac 100644
> > --- a/Documentation/config/mergetool.txt
> > +++ b/Documentation/config/mergetool.txt
> > @@ -61,3 +61,6 @@ mergetool.writeToTemp::
> >   
> >   mergetool.prompt::
> >   	Prompt before each invocation of the merge resolution program.
> > +
> > +mergetool.autoMerge::
> > +	Remove lines without conflicts from all the files. Defaults to `true`.
> > diff --git a/git-mergetool.sh b/git-mergetool.sh
> > index e3f6d543fb..f4db0cac8d 100755
> > --- a/git-mergetool.sh
> > +++ b/git-mergetool.sh
> > @@ -239,6 +239,17 @@ checkout_staged_file () {
> >   	fi
> >   }
> >   
> > +auto_merge () {
> > +	git merge-file --diff3 --marker-size=7 -q -p "$LOCAL" "$BASE" "$REMOTE" >"$DIFF3"
> 
> I've been wondering if we want to recreate the merge or just get the 
> merged BASE LOCAL and REMOTE from the merged file in the working tree. 
> If the user wants to resolve the conflicts in stages, or opens the file 
> in a editor and fixes some conflicts and then realizes they want to use 
> a merge tool that work is thrown away if we recreate the merge. They can 
> always use `checkout --merge` to throw away their changes and start 
> again with a mergetool. It would mean checking the size of the conflict 
> markers and using 
> '/^<{$conflict_marker_size}/,^|{$conflict_marker_size}/' for sed. 
> Getting the merged BASE would be tricky if the user does not have diff3 
> conflicts enabled, I'm not sure if we can safely get BASE from `git 
> merge-file ...` and LOCAL and REMOTE from the working tree.

That's a good point.

However, their work is not thrown away; MERGED is not touched by this.

It's only for visualization purposes that some already-fixed conflicts
would be shown in the mergetool, which yeah; it's not ideal.

That's an improvement that can be done later, on top of this patch. The
bulk of improvements are already enabled by this, and the marginal
gains can be added later.

> > +	if test -s "$DIFF3"
> > +	then
> > +		sed -e '/^<<<<<<< /,/^||||||| /d' -e '/^=======\r\?$/,/^>>>>>>> /d' "$DIFF3" >"$BASE"
> > +		sed -e '/^||||||| /,/^>>>>>>> /d' -e '/^<<<<<<< /d' "$DIFF3" >"$LOCAL"
> > +		sed -e '/^<<<<<<< /,/^=======\r\?$/d' -e '/^>>>>>>> /d' "$DIFF3" >"$REMOTE"
> > +	fi
> > +	rm -- "$DIFF3"
> > +}
> > +
> >   merge_file () {
> >   	MERGED="$1"
> >   
> > @@ -274,6 +285,7 @@ merge_file () {
> >   		BASE=${BASE##*/}
> >   	fi
> >   
> > +	DIFF3="$MERGETOOL_TMPDIR/${BASE}_DIFF3_$$$ext"
> >   	BACKUP="$MERGETOOL_TMPDIR/${BASE}_BACKUP_$$$ext"
> >   	LOCAL="$MERGETOOL_TMPDIR/${BASE}_LOCAL_$$$ext"
> >   	REMOTE="$MERGETOOL_TMPDIR/${BASE}_REMOTE_$$$ext"
> > @@ -322,6 +334,11 @@ merge_file () {
> >   	checkout_staged_file 2 "$MERGED" "$LOCAL"
> >   	checkout_staged_file 3 "$MERGED" "$REMOTE"
> >   
> > +	if test "$(git config --bool mergetool.autoMerge)" != "false"
> 
> If I run `git config --bool mergetool.autoMerge` it returns an empty 
> string so I think you need to test it is actually equal to "true".

Yeah, this would evaluate to positive:

  test "" != "false"

It's enabled by default since I heard Junio mention it would make sense.

> I also share the view that this should be per tool. Your demand that 
> someone comes up with an example that breaks assumes that we have access 
> to all the tools that users are using.

It's not a demand. It's a fact that unless we have an example (even if
hypothetical), the burden of proof has not been met.

The default position is that we don't know if such configuration would
make sense or not.

> Seth has done a great job of 
> surveying the popular tools but given the size of git's user-base and 
> the diversity of uses it is very likely that there will be people using 
> in-house or proprietary tools that no one on the list has access to.

Yes, they can just turn off the flag.

> I would much prefer to avoid breaking them rather than waiting for a
> bug report before implementing a per-tool setting.

Even with a per-tool configuration they would be broken (until the user
configures otherwise).

> It is quite possible people are using different tools for different
> files in the same way as they use different merge drivers for
> different files and want the setting disabled for a tool that does
> semantic merging but enabled textual merges.

I think your definition of what's possible and mine are very different.

But this is actually what I was asking: an example. You are bringing a
hypothetical "semantic mergetool" that would somehow benefit from having
unconflicted lines. Can you explain how it would benefit?

Also, neither Seth nor Junio responded to my example, can you?

Do you agree there is no conflict here?

  echo Hello > BASE
  echo Hello > LOCAL
  echo Hello. > REMOTE
  git merge-file -p LOCAL BASE REMOTE

Cheers.

-- 
Felipe Contreras
