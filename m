Return-Path: <SRS0=ZAU+=3M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39FFC2D0DB
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 19:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A83D12077C
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 19:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ggV2uhPV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgAWTUq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 14:20:46 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59033 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbgAWTUq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 14:20:46 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E5BCB42F85;
        Thu, 23 Jan 2020 14:20:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yOLHTdvquuZm2QObg5Eslwm4H9o=; b=ggV2uh
        PVR+t5JYK36jdAqEdTZTWMN2loQP71p+WS7zLaeA8+K/QXGO1CIVIHKjBtNkt+Ti
        wmlnUKg5m/mZzCe/7QLfk5CrBFf/mbjL6LejSeg0EUzov3/y6+5PndGtT1Itr4zD
        AVVxHRpIWtSBoaqrfkEUjnUR7o9G7A+0jCwgk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=spNrrbIDfDQc+8gpxS/syScL9t0T/ANg
        n3970x9I3v5gtoERDm3dJpw7NyDhrP7w1C79YncLUoyYMkflCgyj/bjL+SKz3WOX
        b52HYnyg/g+d1epLgVKbMOltKcBqu1DZNBeQFnC++OggTysynYD+X02uoOmfwwq5
        b6WznR5jHbY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DBE0442F84;
        Thu, 23 Jan 2020 14:20:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4E55142F83;
        Thu, 23 Jan 2020 14:20:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Paul Mackerras <paulus@ozlabs.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        ch <cr@onlinehome.de>,
        Martin von Zweigbergk <martinvonz@gmail.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: [PATCH] gitk: to run in a bare repository (was: gitk can't be run from non-worktree folders)
References: <4e2e5829-b9a7-b9b4-5605-ac28e8dbc45a@onlinehome.de>
        <20200123163151.GC6837@szeder.dev>
        <CAPig+cTixT9JYDPn-umKdQLtTm5byA1wwmvVY1ryuh+hv2=6MQ@mail.gmail.com>
        <xmqqpnfa3sj1.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 23 Jan 2020 11:20:36 -0800
In-Reply-To: <xmqqpnfa3sj1.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 23 Jan 2020 11:02:42 -0800")
Message-ID: <xmqqk15i3rp7.fsf_-_@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6F74C940-3E15-11EA-AE50-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[This message is designed to be readable by "git am -c".]

Junio C Hamano <gitster@pobox.com> writes:

> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> It's a new regression introduced by 2d92ab32fd (rev-parse: make
>> --show-toplevel without a worktree an error, 2019-11-19), as far as I
>> can tell. I have many times used gitk on bare repositories as an
>> interactive replacement for git-log, so this is a unfortunate bit of
>> fallout from that change. That's not to say that 2d92ab32fd should be
>> reverted, though... perhaps gitk itself needs a bit of a fix.
>
> Curious.
>
> There is a "proc gitworktree" that does use --show-toplevel but it
> is fairly conservative and assumes these calls can fail.
>
>     ...
>     if {[catch {set _gitworktree [exec git rev-parse --show-toplevel]}]} {
>         if {[catch { set _gitworktree $env(GIT_WORK_TREE) }]} {
> 	    catch {set _gitworktree [exec git config --get core.worktree]}
> 	    if {$_gitworktree eq ""} {
> 		set _gitworktree [file normalize ./[exec git rev-parse --show-cdup]]
> 	    }
>
> However, there is this call
>
>     set worktree [exec git rev-parse --show-toplevel]
>
> at the top-level of the code.  I wonder if the obvious and minimum
> fix would be sufficient, i.e.
>
>     -set worktree [exec git rev-parse --show-toplevel]
>     +set worktree [gitworktree]
>
> around l.12546

I've read 784b7e2f ("gitk: Fix "External diff" with separate work
tree", 2011-04-04) again and am reasonably convinced that the above
single liner would be "sufficient".  The external_diff_get_one_file
proc is written, with or without the "fix external diff" patch, to
work ONLY in a non-bare repository (it used to find and use the
parent directory of ".git" as the top-level of the working tree
before 784b7e2f, which changed it to use $worktree global obtained
by calling "rev-parse --show-toplevel") and does not work in a bare
repository anyway, if I am reading the code correctly.


-- >8 --
Subject: [PATCH] gitk: be prepared to be run in a bare repository

784b7e2f ("gitk: Fix "External diff" with separate work tree",
2011-04-04) added an unconditional call to "git rev-parse
--show-toplevel" to set up a global variable quite early in the
course of the program, so that the location of the working tree can
later be known if/when the user chooses to run the external diff via
the external_diff_get_one_file proc.  Before that change, the
external diff code used to assume that the parent directory of ".git"
directory is the top-level of the working tree.

Recent versions of git however notices that "rev-parse --show-toplevel"
executed in a bare repository is an error, which makes gitk stop,
even before the user could attempt to run external diff.

Use the gitworktree helper introduced in 65bb0bda ("gitk: Fix the
display of files when filtered by path", 2011-12-13), which is
prepared to see failures from "rev-parse --show-toplevel" and other
means it tries to find the top-level of the working tree instead to
work around this issue.  The resulting value in $worktree global,
when run in a bare repository, is bogus, but the code is not
prepared to run external diff correctly without a working tree
anyway ;-)

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 gitk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gitk b/gitk
index abe4805ade..1483bf5ed5 100755
--- a/gitk
+++ b/gitk
@@ -12599,7 +12599,7 @@ set cdup {}
 if {[expr {[exec git rev-parse --is-inside-work-tree] == "true"}]} {
     set cdup [exec git rev-parse --show-cdup]
 }
-set worktree [exec git rev-parse --show-toplevel]
+set worktree [gitworktree]
 setcoords
 makewindow
 catch {

