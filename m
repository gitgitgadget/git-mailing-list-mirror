Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82837C19F28
	for <git@archiver.kernel.org>; Wed,  3 Aug 2022 06:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237139AbiHCG3e (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Aug 2022 02:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237115AbiHCG33 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Aug 2022 02:29:29 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479F645F56
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 23:29:27 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id gb36so4081980ejc.10
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 23:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc;
        bh=o9tAn2yhAifGGwNBLFZbXwq74OriaTNPxRiSYhiESbA=;
        b=PKnMhlrt6Zvg0VqQlbu1QLTkxGQFeeKi1vwM9+6UOXVpy/y0rOV7ejzfL0sTV17TdJ
         tqebeN31+MyDUm99zbnnwpEEmZTfUhI5rvB4iwSpHy6RIhyGl2NoHGZPnnljSH39jnAP
         NqYA+Z08Y2PuuW+LUAKB3veO5tbjuMJcNpsPA+Uz7DqHwX05k1mL5pMRgqHuF0G8fGax
         GMJ7u8rEg1oMNHZdS+vepiBVBWG/ZbJhuUweOo01VkyZrK0uZ7Fjq4NvuJgZKLYoEARS
         ShKSTaRkYn7uiTwBKdkGsHOF+fAOuiXNdFMi/W1QTjTtba3HF16XlFqou9ryx3RVShyf
         1cHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=o9tAn2yhAifGGwNBLFZbXwq74OriaTNPxRiSYhiESbA=;
        b=mjZ+l2lyGj2tTrzIbuzr08+XBvAe/jT+HfuaCMcOTHANGgO6WpPkEByELhEfffnFTh
         FYEc5d46KaLBPel+V/UMK3PQOkOiYsZ/4pOMpv4ioOkltyuAN+IKjq4A5TF3+Hppuw/c
         8bT+HDPkU0SQlZ71/YU41VpMXlgH0+pW/zT4xFGIYNKha5O6aocI2OAY6sH8UchhOkit
         GlTg40oCE+hQXneY/db5BAX3GG2oJCd7yTGrm13tmEl/rYtZw6fdz4wK7F2OhHdkkLX0
         5jhXVPPLsQMiGLx8ypF23Obdin+BLpYaye2oeYQTQ6HWeo/MZjBzMm3k5oCkuhGlvR4S
         +VVg==
X-Gm-Message-State: AJIora8GBLIVXOPvYyIC4VBM3Zmp4kUtP3PCIGoZN6aOiL/1ufx3A98L
        AdGHT75Olv42J1y4f4kgu7NwNnJka5i4nA==
X-Google-Smtp-Source: AGRyM1snbYgNSrgTKZJnCjWR6KfguB2j0Z1qECY2fWGy3vQPOunwbSwDEXMOWnvWuTnqhzgn3t/2bg==
X-Received: by 2002:a17:907:2ccc:b0:72b:6907:fce6 with SMTP id hg12-20020a1709072ccc00b0072b6907fce6mr19230927ejc.115.1659508165646;
        Tue, 02 Aug 2022 23:29:25 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id k5-20020a17090632c500b0073087f7dfe2sm2870915ejk.125.2022.08.02.23.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 23:29:25 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oJ7sh-009PSl-2y;
        Wed, 03 Aug 2022 08:29:23 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        vdye@github.com, steadmon@google.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 02/10] t4207: test coloring of grafted decorations
Date:   Wed, 03 Aug 2022 08:25:30 +0200
References: <pull.1301.git.1658844250.gitgitgadget@gmail.com>
 <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com>
 <b5eb110958baa80b72a345b3c850f1dfceabf076.1659122979.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <b5eb110958baa80b72a345b3c850f1dfceabf076.1659122979.git.gitgitgadget@gmail.com>
Message-ID: <220803.86y1w5g7r0.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 29 2022, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <derrickstolee@github.com>
>
> The color.decorate.<slot> config option added the 'grafted' slot in
> 09c4ba410b0f (log-tree: allow to customize 'grafted' color, 2018-05-26)
> but included no tests for this behavior. When modifying some logic
> around decorations, this ref namespace was ignored and could have been
> lost as a default namespace for 'git log' decorations by default.
>
> Add two tests to t4207 that check that the replaced objects are
> correctly decorated. Use "black" as the color since it is distinct from
> the other colors already in the test. The first test uses regular
> replace-objects while the second creates a commit graft.
>
> Be sure to test both modes with GIT_REPLACE_REF_BASE unset and set to an
> alternative base.
>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  t/t4207-log-decoration-colors.sh | 59 ++++++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
>
> diff --git a/t/t4207-log-decoration-colors.sh b/t/t4207-log-decoration-colors.sh
> index 36ac6aff1e4..69f8ac602d6 100755
> --- a/t/t4207-log-decoration-colors.sh
> +++ b/t/t4207-log-decoration-colors.sh
> @@ -18,6 +18,7 @@ test_expect_success setup '
>  	git config color.decorate.tag "reverse bold yellow" &&
>  	git config color.decorate.stash magenta &&
>  	git config color.decorate.HEAD cyan &&
> +	git config color.decorate.grafted black &&
>  
>  	c_reset="<RESET>" &&
>  
> @@ -27,6 +28,7 @@ test_expect_success setup '
>  	c_tag="<BOLD;REVERSE;YELLOW>" &&
>  	c_stash="<MAGENTA>" &&
>  	c_HEAD="<CYAN>" &&
> +	c_grafted="<BLACK>" &&
>  
>  	test_commit A &&
>  	git clone . other &&
> @@ -63,4 +65,61 @@ test_expect_success 'Commit Decorations Colored Correctly' '
>  	test_cmp expected out
>  '
>  
> +cat >expected <<EOF
> +${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_HEAD}HEAD ->\
> + ${c_reset}${c_branch}main${c_reset}${c_commit},\
> + ${c_reset}${c_tag}tag: D${c_reset}${c_commit})${c_reset} D
> +${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: C${c_reset}${c_commit},\
> + ${c_reset}${c_grafted}replaced${c_reset}${c_commit})${c_reset} B
> +${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: A${c_reset}${c_commit})${c_reset} A
> +EOF

I see this is used by (one) existing test, but for new test code let's
add such setup in the test_expect_success block.

A small issue, but e.g. if the partition our trash directories is on
fills up this sort of thing outside of test_expect_success hides the
source of the "first" error.

More generally (just eyeballing this v.s. the existing one) maybe we can
combine them a bit & share some of these lines?

> +test_expect_success 'test coloring with replace-objects' '
> +	test_when_finished rm -rf .git/refs/replace* &&
> +	test_commit C &&
> +	test_commit D &&
> +
> +	git replace HEAD~1 HEAD~2 &&
> +	git log --first-parent --abbrev=10 --decorate --oneline --color=always HEAD |

This hides segfaults, abort() etc. in git log, let's use an intermediate
file rather than git on the LHS of a pipe.

> +	sed "s/[0-9a-f]\{10,10\}/COMMIT_ID/" |

{10,10} in a regex is just {10}, no?

> +	test_decode_color >out &&
> +	test_cmp expected out &&
> +	git replace -d HEAD~1 &&
> +
> +	GIT_REPLACE_REF_BASE=refs/replace2/ git replace HEAD~1 HEAD~2 &&
> +	GIT_REPLACE_REF_BASE=refs/replace2/ git log --first-parent --abbrev=10 \
> +		--decorate --oneline --color=always HEAD |

Ditto LHS.

> +	sed "s/[0-9a-f]\{10,10\}/COMMIT_ID/" |

Ditto RX, but at this point I see it's copy/pasted from the existing
test in the file, might be worth starting by factoring the duplicate
bits out into a function...

> +	test_decode_color >out &&
> +	test_cmp expected out
> +'
> +
> +cat >expected <<EOF
> +${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_HEAD}HEAD ->\
> + ${c_reset}${c_branch}main${c_reset}${c_commit},\
> + ${c_reset}${c_tag}tag: D${c_reset}${c_commit},\
> + ${c_reset}${c_grafted}replaced${c_reset}${c_commit})${c_reset} D
> +${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: v1.0${c_reset}${c_commit},\
> + ${c_reset}${c_tag}tag: B${c_reset}${c_commit})${c_reset} B
> +${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: A${c_reset}${c_commit})${c_reset} A
> +EOF
> +
> +test_expect_success 'test coloring with grafted commit' '
> +	test_when_finished rm -rf .git/refs/replace* &&
> +
> +	git replace --graft HEAD HEAD~2 &&
> +	git log --first-parent --abbrev=10 --decorate --oneline --color=always HEAD |
> +	sed "s/[0-9a-f]\{10,10\}/COMMIT_ID/" |
> +	test_decode_color >out &&
> +	test_cmp expected out &&
> +	git replace -d HEAD &&
> +
> +	GIT_REPLACE_REF_BASE=refs/replace2/ git replace --graft HEAD HEAD~2 &&
> +	GIT_REPLACE_REF_BASE=refs/replace2/ git log --first-parent --abbrev=10 \
> +		--decorate --oneline --color=always HEAD |
> +	sed "s/[0-9a-f]\{10,10\}/COMMIT_ID/" |
> +	test_decode_color >out &&
> +	test_cmp expected out
> +'
> +
>  test_done

...as we had one of these, and now have 3x...
