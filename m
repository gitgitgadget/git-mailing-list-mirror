Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C975DC0015E
	for <git@archiver.kernel.org>; Mon, 24 Jul 2023 12:39:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjGXMjs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jul 2023 08:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjGXMjr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2023 08:39:47 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C0E1B8
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 05:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1690202382; x=1690807182; i=l.s.r@web.de;
 bh=g5rSZ3b5ed+9YyDCQf/y3FXW13mLRlS4L3+hPruXifc=;
 h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
 b=Nj13XDLkZfB4AY7m3CSkPfiTNT69pHHvn9HN341HLS2oQvJ5puBiqygGs/y1QI/N/jiqkE9
 /N4F0pakLIRWsyYlzIQXmAo4RTSajLOxJZjGI7hXD8vN5BTK62/K565RonE2jvJYs/9TGmKSY
 pkkdj/wVbeS6nhqixV/CNQ8RK6bZGAdy0bpOqn9c3s9z1uEVQYEJfB86BzQQsZRqIqYTCNL3t
 bjTGOApB+ek9HlixcZpbs8qRx9w3PV5poAp9s3kmrXHWXihoNmmyn/p8Mscue1O1E8cXqUgZI
 RHPszgU75sQkfKT2aYIOjNYibLXI5g5f/WeCo3OqWsawYQ1aWSTA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.150.179]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MVJNT-1qVF8L15Hz-00S5Xv; Mon, 24
 Jul 2023 14:39:42 +0200
Message-ID: <831cfa35-8c83-cd24-4348-c9c3769643c7@web.de>
Date:   Mon, 24 Jul 2023 14:39:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: [PATCH v2 4/5] t1502: test option negation
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <d392a005-4eba-7cc7-9554-cdb8dc53975e@web.de>
 <xmqqo7k9fa5x.fsf@gitster.g> <a6326aaa-4f05-4d00-8906-2f50ea8e1e7a@web.de>
 <xmqq351hz5xp.fsf@gitster.g> <43ca3f01-ba11-6c29-a8e8-4e6c262a68cc@web.de>
 <xmqq4jlxuiuu.fsf@gitster.g> <4d01e971-07cb-4f11-3cc6-9d9f21e590c1@web.de>
In-Reply-To: <4d01e971-07cb-4f11-3cc6-9d9f21e590c1@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WHgstp/Ge/T+MN3m4jtF6+3VSRZWM0YNwwZaiMTYlWUrZ04rITx
 WLOFHgjjz7XFjwur8C1rFOKHeOBG68ZUAieBQAtWgiPQHfgT/Hu2ZPQjsTxQ5lXp7rciYGb
 nJyizPdp6zEcDPJ/PQaCxBgTs0HLGRBxNG9FZ+1MmRpOX10PzBnBEyFBa/3g3PXVzEo+HOW
 EV5SUmVsUHmDJmvsFtlMA==
UI-OutboundReport: notjunk:1;M01:P0:TrJgqPmSby4=;m5HWiVU8bh31/103H4/B+ScOrVB
 pUElTmXtis53KdUqD+KNhEweV4YnR9Faf/PMPiTBmCYjJrGqA0+UvLJpjMCl/T45Z913pThg+
 tGh7hWgtedG01/frCKpeXpPi9IjCcZI0MfSeiCh6szNENX+e5tn+4/DVjk/9VbZw3bi81OC/g
 EJTg42zvcVYh8yF/Oq1B12uo3p/7jL/a09LfhcFzWn3bl8R3vQEgSVzzUv4VSJaerV80eLo8j
 uUhd3mFTZC1i4LtagY2F/dI+aepjBhZd/rNtNGWIY99ou//UQAL6fVlY4gnmbOaB4bmZq/n3K
 rMmMcVcME07uQKRiHQv+tLjjTFos0JjLuZHya7ywkG6K6C33nLUeUe+cjN0YpS58j5jsg600V
 5StDM6+UHxu7Wx1WeZPnn9wa0zJeaPNKO/cSwsV9uv6iXezmfloIoodMnwSREVC0xYwB1dieS
 gOhrnuhEEydtHENdnoZ/dqKyLy8g/48oQaqeLrFRDAJ2pVaLZZujUQH9p5/iyfviLVoZ2D4dc
 6VvkRqp3XzLPAIRQ8f8j7NJOsA+2jg2RxRHi7IaT/jiT25DAywO7/pyUBfveke/E5QZgTENiH
 T8m51HdvRwXlYQvET7VK2FdDFCSF1jMtUp9QH6KfkhK3PXoinrlChbdUwVtDmnOYqukExN0BO
 C8M9vQwFm8H5QJ589btIdKPaF4wYC6J3KV9D9JpMhqPQHI6Md9QnTSbjQNd5sZYJIJWQIdJ5g
 7ZxUInGiKC6B38G1it6ZBWk5s/kwG705g3POh5nuH6OniCk/2xixTj64ZQ4Dwvz7TPCP6sbBZ
 v8PV1cbS+pgf1CrWiGun9/10vJVKDQzMoyOH42cO483vsepa9QzXJNboAIB69W1EmuVif1gp9
 i0Qj309B/AD8YYjz7qlyJH8t+6Loic59B+i87ryfbs7IiwfEh/foFJU3rY1xaihju6QjsWzBq
 qhpGMg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add tests for checking the "git rev-parse --parseopt" flag "!" and
whether options can be negated with a "no-" prefix.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/t1502-rev-parse-parseopt.sh | 44 +++++++++++++++++++++++++++++++++++
 t/t1502/optionspec-neg        |  8 +++++++
 t/t1502/optionspec-neg.help   | 11 +++++++++
 3 files changed, 63 insertions(+)
 create mode 100644 t/t1502/optionspec-neg
 create mode 100644 t/t1502/optionspec-neg.help

diff --git a/t/t1502-rev-parse-parseopt.sh b/t/t1502-rev-parse-parseopt.sh
index 813ee5872f..0f7c2db4c0 100755
=2D-- a/t/t1502-rev-parse-parseopt.sh
+++ b/t/t1502-rev-parse-parseopt.sh
@@ -3,6 +3,22 @@
 test_description=3D'test git rev-parse --parseopt'
 . ./test-lib.sh

+check_invalid_long_option () {
+	spec=3D"$1"
+	opt=3D"$2"
+	test_expect_success "test --parseopt invalid switch $opt help output for=
 $spec" '
+		{
+			cat <<-\EOF &&
+			error: unknown option `'${opt#--}\''
+			EOF
+			sed -e 1d -e \$d <"$TEST_DIRECTORY/t1502/$spec.help"
+		} >expect &&
+		test_expect_code 129 git rev-parse --parseopt -- $opt \
+			2>output <"$TEST_DIRECTORY/t1502/$spec" &&
+		test_cmp expect output
+	'
+}
+
 test_expect_success 'setup optionspec' '
 	sed -e "s/^|//" >optionspec <<\EOF
 |some-command [options] <args>...
@@ -278,4 +294,32 @@ test_expect_success 'test --parseopt help output: mul=
ti-line blurb after empty l
 	test_cmp expect actual
 '

+test_expect_success 'test --parseopt help output for optionspec-neg' '
+	test_expect_code 129 git rev-parse --parseopt -- \
+		-h >output <"$TEST_DIRECTORY/t1502/optionspec-neg" &&
+	test_cmp "$TEST_DIRECTORY/t1502/optionspec-neg.help" output
+'
+
+test_expect_success 'test --parseopt valid options for optionspec-neg' '
+	cat >expect <<-\EOF &&
+	set -- --foo --no-foo --no-bar --positive-only --no-negative --
+	EOF
+	git rev-parse --parseopt -- <"$TEST_DIRECTORY/t1502/optionspec-neg" >out=
put \
+	       --foo --no-foo --no-bar --positive-only --no-negative &&
+	test_cmp expect output
+'
+
+test_expect_success 'test --parseopt positivated option for optionspec-ne=
g' '
+	cat >expect <<-\EOF &&
+	set -- --no-no-bar --no-no-bar --
+	EOF
+	git rev-parse --parseopt -- <"$TEST_DIRECTORY/t1502/optionspec-neg" >out=
put \
+	       --no-no-bar --bar &&
+	test_cmp expect output
+'
+
+check_invalid_long_option optionspec-neg --no-positive-only
+check_invalid_long_option optionspec-neg --negative
+check_invalid_long_option optionspec-neg --no-no-negative
+
 test_done
diff --git a/t/t1502/optionspec-neg b/t/t1502/optionspec-neg
new file mode 100644
index 0000000000..28992ee303
=2D-- /dev/null
+++ b/t/t1502/optionspec-neg
@@ -0,0 +1,8 @@
+some-command [options] <args>...
+
+some-command does foo and bar!
+--
+foo		can be negated
+no-bar		can be positivated
+positive-only!	cannot be negated
+no-negative!	cannot be positivated
diff --git a/t/t1502/optionspec-neg.help b/t/t1502/optionspec-neg.help
new file mode 100644
index 0000000000..591f4dcd9f
=2D-- /dev/null
+++ b/t/t1502/optionspec-neg.help
@@ -0,0 +1,11 @@
+cat <<\EOF
+usage: some-command [options] <args>...
+
+    some-command does foo and bar!
+
+    --foo                 can be negated
+    --no-bar              can be positivated
+    --positive-only       cannot be negated
+    --no-negative         cannot be positivated
+
+EOF
=2D-
2.41.0
