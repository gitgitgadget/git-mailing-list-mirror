Return-Path: <SRS0=YePV=76=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 587D0C433DF
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 08:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30B992073E
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 08:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3ZJcMrp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgFQIir (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 04:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbgFQIir (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jun 2020 04:38:47 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D81C061573
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 01:38:46 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id k6so593431pll.9
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 01:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xnLMpTKPBS5m3fQM4acLiNsemnpa0G6PpKhvM+vZSsA=;
        b=J3ZJcMrpzU2auMrxDfsbMvhHAf6k7NsUI2i6mtooFbedGchP7MWV1sPhZFxxIzoT0r
         CTE2H8UfY/KAL/krMoWI+7S5gbnjw9Gha8GtQpHgXe5OAu6bHFPbGtHW3rsKXnXAzgZU
         JVpXALRpTX9w4z3hwwaDTgYs5FFZabxG5JZ+CktrHpFUrcC4cZTMOrUAMmNkL/Laicow
         0/1p5gMuq/8qddfghyICAiI55naGG/IsKFEQ+eDIPsVD0anpqVMJKVE9u64rWyVGB9gI
         bFk6GzFP2R+ddYscCTMIxPrrhhPU5XCYzQkQu0IMN6sESuH4e5ZQ+iqS+NQnHUb9y8IV
         3LXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xnLMpTKPBS5m3fQM4acLiNsemnpa0G6PpKhvM+vZSsA=;
        b=W/llC4LWkcLQ0RB6YwY0i5104eiZ04wfoU3pZZRbm87m7PwEuGne7zccv1+SzGZBSy
         QBpDfddudz2rsO9wJ8B5pf8wpcrR3x8cp1X4cPBTuwR2kstRbCoDwVUdsD3/rRhQhnAj
         Y1JIlJ+EQ4gsgarRzVfBQ4grFC6VhpLmfgbvqqj3igwe9atv5JkbjZya61fajg51VUFZ
         TboVLQsiNS64EzuR/Fw8Q7kZPYoKQ6OQG/olXc+5UfBtS5T2rVibTJ7KbXrqgKciF2KB
         khEb6k9E6ITJBAPiHfsNZMnmy/VQtp7KUqKl79ZPN+xHBd6Q776ETzu/atkK1qnKdhHC
         HDDA==
X-Gm-Message-State: AOAM533oiSa1RFOAiNmmTlYFu9KZwBXsK+C9XHO9PwQhhjAMs0Rb/ShH
        05WsRacSiBy632euPy0IYgk=
X-Google-Smtp-Source: ABdhPJyUsBfGeyMOcxUwiLapSVXTydjVZMJauBi4bNI9dlAlcmVbyxkCHDyNq9aN3022SLD1hZSUrg==
X-Received: by 2002:a17:902:7048:: with SMTP id h8mr5703530plt.117.1592383125915;
        Wed, 17 Jun 2020 01:38:45 -0700 (PDT)
Received: from [192.168.208.37] ([49.207.128.224])
        by smtp.gmail.com with ESMTPSA id i3sm4689156pjv.1.2020.06.17.01.38.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2020 01:38:45 -0700 (PDT)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [GSoC] Shourya's Blog
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, christian.couder@gmail.com
References: <20200616072108.GA10273@konoha>
Message-ID: <c88fe426-eac7-8d77-ec9b-9cb6d8dfc9f9@gmail.com>
Date:   Wed, 17 Jun 2020 14:08:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200616072108.GA10273@konoha>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Shourya,

On 16-06-2020 12:51, Shourya Shukla wrote:
> Hello all!
> 
> This is the sixth installation of my weekly blog covering what I have
> learned in GSoC and other like stuff.
> https://shouryashukla.blogspot.com/2020/06/gsoc-week-55.html
> 
> Feel free to comment!
> 

Some things I noted in the blog:

> As far as I have learned, summary prints a git log --oneline
> between the revision checked out in the submodule and the
> revision superproject assumed the submodule to be in (i.e.,
> the one checked out in the superproject).

The explanation is pretty close. The wording could be tweaked a little
to be more precise. Particularly "assume" isn't a proper word to
explain the working of summary. It works based on facts not
assumptions. Something along the lines of:

    As far as I have learned, summary prints a git log --oneline
    between the revision checked out in the submodule and the revision
    "known" to the superproject (i.e., the revision found in the index
    of the superproject).

>  If no revision is specified of the submodule then we assume it to be HEAD

As discussed elsewhere, the revision passed to the summary command is
the revision of the superproject and not the revision of the submodule.

> $ git submodule summary my-subm
>   * my-subm abc123..def456
>     < some commit
>     < another commit
>     < some another commit 

While the command above would produce the result you mention when
'my-subm' in the repo. The command itself is incorrect if it's
intention is to print "only" the summary of 'my-subm'. This is the
format of the 'summary' sub-command according to the doc:

    summary [--cached|--files] [(-n|--summary-limit) <n>] [commit] [--]
[<path>...]

So, it expects a 'commit' followed by the 'path'. As you had passed the
path as the first argument it would be treated as the 'commit' argument.
As 'my-subm' is likely not a valid commit-ish, the script would
default to 'HEAD' (the final else mentioned below) and would
print the summary of all the submodules. IOW, it just prints the
same output as:

   $ git submodule summary

in this case.

> elif test -z "$1" || test "$1" = "HEAD"
> then
> 	# before the first commit: compare with an empty tree
> 	head=$(git hash-object -w -t tree --stdin </dev/null)
> 	test -z "$1" || shift
> 
> This part checks if there are any commits in our tree (of the submodule) or not.

Again, it's the tree of the superproject that we're concerned about.

> If there aren’t any commits then it simulates an empty repo environment
> using head=$(git hash-object -w -t tree --stdin </dev/null). The
> /dev/null is the UNIX null device and is sort of a blackhole meaning
> things if gone into it completely disappear never to be seen again.

Fine. As we're using '/dev/null' as an input here. It would've been nice
if you had also mentioned that it serves as a "convenient empty file for
input streams"[1] because "reads from /dev/null always return end of
file"[2].

> Making stdin as /dev/null means giving nothing as input hence
> nothing to create a hash object of.

Not precise. That command would return the hash of an empty tree.

> else
> 	head="HEAD"
> fi
>
> This means that if the above 2 cases fail (which will most probably
> lead to presence of commits yet a failure in git rev-parse --verify)
> then make head as HEAD.

Characterising 'git rev-parse --verify ...' as not being able to print
the hash of a commit even when there is one in the repo seems incorrect
to me. There are other more likely cases which would lead to rev-parse
failing and that last else part getting executed. For instance, an
incorrect ref being passed as the first argument to the summary
sub-command like:

    git submodule summary no-such-ref-exists

or

    git submodule summary "invalid ref"

So, I think it would've been precise to just say:

    This means that if the above 2 cases fail then we make
    head as HEAD.

[1]: https://en.wikipedia.org/wiki/Null_device
[2]: https://man7.org/linux/man-pages/man4/null.4.html

-- 
Sivaraam
