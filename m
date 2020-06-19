Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D0EC433E0
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 21:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7465221F2
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 21:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MEJt6B+8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbgFSVnz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 17:43:55 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61459 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728005AbgFSVny (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 17:43:54 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 99F49CD135;
        Fri, 19 Jun 2020 17:43:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=C+L5zVXJMzn8B8UMBqtNNxctpbU=; b=MEJt6B
        +8BiCB26NM4TNXyIPnDolDQrcZFMonQpiatloZ12XK7Qh5YNfd1/bR+bV/cPFzhf
        Cswj5CaFyCBKicXlGQu0mMS0h56+iTLNwI0QjTkDFoVtqqhconaIeYfpv1geadCH
        If4i/0R9HhO3gAqXiGey6nxc2rn0Mz+eTzgg8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xGgjawZpMKl/Iu5DB3L6hkgJKU5B2gXu
        NoGRT8ruLvnrGm6NtICnDJpe8Dba3Fe2MItVmvF9jGPWNPvp+C+J9QXKeaei4BzH
        wlVlFrrHCKvbSznjF2rmGuKNoAswdhq0kZuFWtSkgtuNlCdgumsrgzqZBRRX/nv1
        71pF4aQpOF4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 92DDECD134;
        Fri, 19 Jun 2020 17:43:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CC1B0CD132;
        Fri, 19 Jun 2020 17:43:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] diff-files: treat "i-t-a" files as "not-in-index"
References: <20200611161640.52156-1-shrinidhi.kaushik@gmail.com>
        <xmqqk104knrs.fsf@gitster.c.googlers.com>
        <xmqqbllgknfd.fsf@gitster.c.googlers.com>
        <20200619093127.GA47528@mail.clickyotomy.dev>
Date:   Fri, 19 Jun 2020 14:43:46 -0700
In-Reply-To: <20200619093127.GA47528@mail.clickyotomy.dev> (Srinidhi Kaushik's
        message of "Fri, 19 Jun 2020 15:01:27 +0530")
Message-ID: <xmqqftaqg299.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F4F04548-B275-11EA-AD12-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Srinidhi Kaushik <shrinidhi.kaushik@gmail.com> writes:

>> > +     git add -N empty not-empty &&
>> > +     git diff-files -p >actual &&
>> > +     hash_e=$(git hash-object empty) &&
>> > +     hash_n=$(git hash-object not-empty) &&
>> > +     cat >expect <<-EOF &&
>> > +     diff --git a/empty b/empty
>> > +     new file mode 100644
>> > +     index 0000000..$(git rev-parse --short $hash_e)
>> > +     diff --git a/not-empty b/not-empty
>> > +     new file mode 100644
>> > +     index 0000000..$(git rev-parse --short $hash_n)
>> > +     --- /dev/null
>> > +     +++ b/not-empty
>> > +     @@ -0,0 +1 @@
>> > +     +$content
>> > +     EOF
>> > +     test_cmp expect actual
>> > +'
>>
>> OK.  Do we want to show what happens when "diff" and "diff --cached"
>> are run with these two "added but not quite added yet" paths to
>> contrast with this new case?
>
> I'm not sure if we want to repeat an older test. The test (which was
> renamed in this patch) in t2203-add-intent.sh: "diff/diff-cached shows
> ita as new/not-new files" is already doing that. Should  the "diff" and
> "diff --cached" steps be appended here again?

No, there is no need to repeat essentially the same test that exists
elsewhere.  I wonder if it reduces duplication even further if we
extend that existing test that checks "diff" and "diff --cached" so
that it also checks "diff-files" as well?, instead of adding this
new one?  The existing one checks diff and diff-cached only with a
new non-empty path, and it can use tests with a new empty path at
the same time, with a unified "set up" code that is in the early
part of the test, e.g.

diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index 5bbe8dcce4..cfde790ac7 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -235,7 +235,8 @@ test_expect_success 'double rename detection in status' '
 test_expect_success 'diff-files/diff-cached shows ita as new/not-new files' '
 	git reset --hard &&
 	echo new >new-ita &&
-	git add -N new-ita &&
+	: >new-ita-empty &&
+	git add -N new-ita new-ita-empty &&
 	git diff --summary >actual &&
 	...

Then the existing tests can be updated to see not just --summary but
also for the contents like you did in the new test---and another test
that examines what "git diff-files" sees (which is what you added)
can happen in the same test (that way, the same set-up can be reused
for three tests).

Thanks.









