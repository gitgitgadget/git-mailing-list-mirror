Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84B561F461
	for <e@80x24.org>; Fri, 12 Jul 2019 17:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfGLRuC (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jul 2019 13:50:02 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59843 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbfGLRuC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jul 2019 13:50:02 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 47956707FE;
        Fri, 12 Jul 2019 13:50:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1Fjw1iqHQojpnGr0LjFyBJb5UEg=; b=tqj+Ul
        fNLIx/bvUws4b5aucNwq4U+8tnrfWDQ/Pg0NU3ARbOrroUSOJkq9Vb/fShE/uJ0r
        T5m29pztKKBgzNFs9nbAP7fCPfn1wiK0OsALFgQ/+0TWZeeaqvSnXr/QmiuzuOU1
        Z3Y1R7DDALWVgHOgqZgI1SWItgYX4ySfp2uZg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=C6FTRDz+zmLgqSQBKLyaBZ05jp6x0Ita
        ejGdRNlmVesd/0BSlHJYYE3Oji+dc85oHWEU9ws33CSw7T1+Sh8quszntk43xgZi
        iPuihQqsIa0AWqbI8wm05JXFVavgInAalMgZWHq3stzhaPK4r+POzuVoBmsXaC8p
        +FiDzTVmi1E=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3F880707FD;
        Fri, 12 Jul 2019 13:50:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6FAA4707FB;
        Fri, 12 Jul 2019 13:49:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ariadne Conill <ariadne@dereferenced.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v1 0/2] document deprecation of log.mailmap=false default
References: <20190712155901.19210-1-ariadne@dereferenced.org>
Date:   Fri, 12 Jul 2019 10:49:55 -0700
In-Reply-To: <20190712155901.19210-1-ariadne@dereferenced.org> (Ariadne
        Conill's message of "Fri, 12 Jul 2019 10:58:59 -0500")
Message-ID: <xmqqpnmfp2gs.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 767DE032-A4CD-11E9-B6EB-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ariadne Conill <ariadne@dereferenced.org> writes:

> Based on the discussion of the previous patches, we concluded that
> changing the default will require a transitional period.

OK.

> As such, I have introduced a deprecation warning that is printed when
> the log builtin commands are used.

... used when the user did not configure and did not give --[no-]use-mailmap
option from the command line, right?  Otherwise the warning would be annoying.

Have you run the test suite before posting?  To me, at least t0203,
t4212, t7006 and t9700 seem to be having trouble with this change,
that may need adjusting.

0203.1 expects that "git show" gives nothing to its standard error
stream.  Perhaps something like this should serve as a good
workaround.

diff --git a/t/t0203-gettext-setlocale-sanity.sh b/t/t0203-gettext-setlocale-sanity.sh
index 0ce1f22eff..76f774c8b8 100755
--- a/t/t0203-gettext-setlocale-sanity.sh
+++ b/t/t0203-gettext-setlocale-sanity.sh
@@ -10,7 +10,7 @@ test_description="The Git C functions aren't broken by setlocale(3)"
 test_expect_success 'git show a ISO-8859-1 commit under C locale' '
 	. "$TEST_DIRECTORY"/t3901/8859-1.txt &&
 	test_commit "iso-c-commit" iso-under-c &&
-	git show >out 2>err &&
+	git show --use-mailmap >out 2>err &&
 	test_must_be_empty err &&
 	grep -q "iso-c-commit" out
 '


4212.3 is the same way.

4212.4 raises an interesting question.  It wants to see the output
of this command:

	git log --format="%an+%ae+%ad" broken_email >actual.out 2>actual.err &&

The question is, when the user explicitly asked for the "true"
identity values (not the mapped one via %aN, %aE and their friends),
if --use-mailmap should affect the outcome?

A secondary question is if we should be issuing a warning against
this command line in the first place, if the answer to the above
question is "no" (i.e. --[no-]use-mailmap, and the future default
switch, do not affect the outcome).  There is no point issuing a
warning if the command line is already future-proofed.

7006.43 (among others) expects its "colorful" shell helper function
to be a reliable way to detect if color escape sequence is in use in
the output but the helper only reads the first line and expects it
to always begin with the colored "commit 0c9f6db7183a...", which fails
when an error or a warning message comes first.  I think the best fix
there should be to make the helper more robust, perhaps by borrowing
ideas from test-lib-functions.sh::test_decode_color, i.e. find byte
sequence "\033[m" in there (I think assuming the presence of RESET
sequence alone is sufficient for the purpose of t7006 tests that
wants to see "have we tried to color or emit non-colored output?".

A possible workaround for 9007 would be to set log.mailmap=true in
the set-up step, but there may be a better alternative.

diff --git a/t/t9700-perl-git.sh b/t/t9700-perl-git.sh
index 102c133112..a7a336947d 100755
--- a/t/t9700-perl-git.sh
+++ b/t/t9700-perl-git.sh
@@ -36,6 +36,7 @@ test_expect_success \
      echo "changed file 1" > file1 &&
      git commit -a -m "second commit" &&
 
+     git config log.mailmap true &&
      git config --add color.test.slot1 green &&
      git config --add test.string value &&
      git config --add test.dupstring value1 &&


There may be issues with other tests.  I didn't do any exhaustive
vetting.

Thanks.
