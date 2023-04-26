Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B7CC77B78
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 15:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241231AbjDZPIg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 11:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241140AbjDZPIc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 11:08:32 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DDE3C0C
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 08:08:30 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-63f273b219eso3577874b3a.1
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 08:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682521710; x=1685113710;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zQv5Z/wmukEw/QUczJYt7GOy66QMMfyI/hKojHDZB9I=;
        b=LlkVSxMmEHeE0U/UwzLHqshqP8LGAHQHENHlnZnoP1BAjhWiWGAS5zXe51PKWoHVIN
         V78DgqrQdpHoyUwHQTmKHC3orubvoi5wkQ+rnGBWFuAVUMYlGNMAhVSYcF+0Wg5VcCC4
         rd2MUWE5hTTyq3MOo2qVPIbM3X4Wb5XVV4lpnt4m5jpx2eyj1eK5+632SwFUPYXAxWe2
         ECpXPHZC4udc3IsKi1iLIdzpCfF0IFVoqQsmfXT64XQGkMU0sLiOnOBnFSli5YTlrM5D
         Il50PuLmMMGgC4nUaTk7S4QR+BCF5wshiJ8M9a2eaFtt8L0qtl/z6cJMIXvSo+AvXMwF
         Uw8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682521710; x=1685113710;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zQv5Z/wmukEw/QUczJYt7GOy66QMMfyI/hKojHDZB9I=;
        b=LZTFSB10jdDktqoY3B8W+L1nEr5PW9GVP7cJdTPqcroPuEamsYn3C4rUU5STi7MOU2
         CY/7rX9Btru4VX2J+8O7MLdo2OSousCrM6LYlVCyufYFv66SeI4yxRs40ADx5iU4owGr
         I6dz+t2wHHoPQzYBFJCSCtQUFk8L5n5iI/X0Rg1YCpEQHG8g7sszAYbBznxK8dhtL0I+
         xUfvfzh0qiNfcGmgJ0T1RN5yTYFdZX0Ro6hk+1HO/Fq0QMXN3vEHDUSeFvpAy9J0uEiE
         IV9+dkT7qcHs/D/YQDIvOuw0v7o5vLrQw7e1Q3W8gY8reY+6oD7IIertOt+kHFascvAi
         s+8w==
X-Gm-Message-State: AAQBX9fBmS1+mlS6CX5PPvnUoco7e3/UqIVFlWvJSoqpWiRAzqJZXo3G
        KeRlmC0PqR9+7Qn70Ttigq4=
X-Google-Smtp-Source: AKy350b0SUf9pgfHYi16aXYymape+oQBeOFTA8nH6K30QE3I2DjRL8lgYgH3xPGha10PY+/Ox8WiMw==
X-Received: by 2002:a05:6a20:258c:b0:ef:242d:54e3 with SMTP id k12-20020a056a20258c00b000ef242d54e3mr28715240pzd.21.1682521709585;
        Wed, 26 Apr 2023 08:08:29 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id l4-20020a056a00140400b00622e01989cbsm11798412pfu.176.2023.04.26.08.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 08:08:29 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>
Cc:     Adam Majer <adamm@zombino.com>, git@vger.kernel.org
Subject: Re: git clone of empty repositories doesn't preserve hash
References: <e7a8957e-6251-39f1-5109-87d4dd382e81@zombino.com>
        <xmqqr0syw3pe.fsf@gitster.g>
        <d04c430e-b609-b0a1-fd0f-0f3734d5c3b1@zombino.com>
        <20230405200153.GA525125@coredump.intra.peff.net>
        <xmqqa5zmukp5.fsf@gitster.g> <xmqq355euj2i.fsf@gitster.g>
        <ZEhHsJh20gtiDBd9@tapette.crustytoothpaste.net>
        <xmqqcz3ry2sw.fsf@gitster.g>
        <ZEhuMML6n8F+cNLg@tapette.crustytoothpaste.net>
        <20230426112508.GB130148@coredump.intra.peff.net>
Date:   Wed, 26 Apr 2023 08:08:28 -0700
In-Reply-To: <20230426112508.GB130148@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 26 Apr 2023 07:25:08 -0400")
Message-ID: <xmqqcz3qwuj7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> It sounds from your description that your test is running in a mode
> where the client defaults to sha256 (though I'm not sure how, since we
> explicitly document that GIT_DEFAULT_HASH should not affect clone), and
> then you clone an empty sha256 repository via v0, expecting the result
> to be sha256.

Thanks for coming up with an excellent guess that helped come up
with a reproduction.

With Brian's patch a bit tweaked (attached below), the test does
fail with the current 'master' and passes before the merge in
question.  And the trace clearly shows that without being told
anything about the object format via the capability, the client
chooses to honor GIT_DEFAULT_HASH to initialize the new repository
with sha256.

There is this entry in the release notes of 2.29.0:

 * "git clone" that clones from SHA-1 repository, while
   GIT_DEFAULT_HASH set to use SHA-256 already, resulted in an
   unusable repository that half-claims to be SHA-256 repository
   with SHA-1 objects and refs.  This has been corrected.

This refers to 47ac9703 (builtin/clone: avoid failure with
GIT_DEFAULT_HASH, 2020-09-20).  It seems that the "fix" described
there was incomplete and did not address "clone a void" case, and
the patch under discussion finished the incomplete fix without
knowing by accident.  The test that was added by 47ac9703 to t5601
does use non-empty repositories (one with SHA-1, the other with
SHA-256) and tries to check the interaction with "clone" with the
environment variable.  With the patch under discussion, this test
did not break and "clone" is still ignoring the GIT_DEFAULT_HASH
variable.

Also the description in the document of GIT_DEFAULT_HASH makes
readers ambivalent:

`GIT_DEFAULT_HASH`::
	If this variable is set, the default hash algorithm for new
	repositories will be set to this value. This value is currently
	ignored when cloning; the setting of the remote repository
	is used instead. The default is "sha1". THIS VARIABLE IS
	EXPERIMENTAL! See `--object-format` in linkgit:git-init[1].

To me, "is currently ignored" hints that the author, or somebody
close to the author, of this entry feels that it is a bug that
"clone" does not honor it.  The log message of 47ac9703 also phrases
"failed to honor the GIT_DEFAULT_HASH" as if it were a bad thing [*].

On the other hand, it is clearly documented as experimental so
anything that has been relying on the behaviour of any command with
a particular value set to this variable are waiting to be broken.

I am torn about this.  Even though we may have been very clear that
GIT_DEFAULT_HASH should not kick in in this case, "clone" was buggy
(in the sense that it did not behave as documented in an empty
repository) and whatever thing that changed behaviour that Brian
noticed was ignoring the documentation and taking advantage of that
"bug", and Hyrum's law ensues.

In the longer term, after/when we allow incremental/over-the-wire
migration of object-format, i.e. clone from SHA-1 repository to
create SHA-256 repository (or vice versa) and fetching and pushing
between them would bidirectionally convert the object format on the
fly, it is likely we would teach a new option "--object-format" to
"git clone" to say "you would use whatever object format the origin
uses by default, but this time, I am telling you to use this format
on our side, doing on-the-fly object format conversion as needed".

So it would be OK to make sure that GIT_DEFAULT_HASH is ignored by
"clone" as documented now, and even after on-the-fly object-format
migration is implemented, I would think.


[Footnote]

* ... but I think it was misguided.  What it says there is this:

    And we also don't want to initialize the repository as SHA-1
    initially, since that means if we're cloning an empty
    repository, we'll have failed to honor the GIT_DEFAULT_HASH
    variable and will end up with a SHA-1 repository, not a SHA-256
    repository.

If this were "When we're cloning an empty repository, we'd have
failed to honor the object format the other side has chosen and will
end up with a SHA-1 repository, not a SHA-256 repository.", then it
is very much in line with the reality before the patch under
discussion and also in line with the official stance that "clone"
should not honor GIT_DEFAULT_HASH.

Where the original description breaks down is when the other side is
SHA-1 and this side has GIT_DEFAULT_HASH set to SHA-256.  If we
honored the variable, we'd create a SHA-256 repository that will
talk to SHA-1 repository before the rest of the system is ready.

 t/t5700-protocol-v1.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git i/t/t5700-protocol-v1.sh w/t/t5700-protocol-v1.sh
index 6c8d4c6cf1..2f39dd2e05 100755
--- i/t/t5700-protocol-v1.sh
+++ w/t/t5700-protocol-v1.sh
@@ -244,6 +244,19 @@ test_expect_success 'push with ssh:// using protocol v1' '
 	grep "push< version 1" log
 '
 
+test_expect_success 'clone propagates object-format from empty repo' '
+	test_when_finished "rm -fr src256 dst256" &&
+
+	echo sha256 >expect &&
+	git init --object-format=sha256 src256 &&
+	GIT_DEFAULT_HASH=sha256 \
+	GIT_TRACE_PACKET=1 \
+	git clone --no-local src256 dst256 &&
+	git -C dst256 rev-parse --show-object-format >actual &&
+
+	test_cmp expect actual
+'
+
 # Test protocol v1 with 'http://' transport
 #
 . "$TEST_DIRECTORY"/lib-httpd.sh
