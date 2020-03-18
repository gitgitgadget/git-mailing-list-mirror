Return-Path: <SRS0=hWrV=5D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6860CC10DCE
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 18:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25CE22077F
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 18:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lbXFFVUf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgCRS0J (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Mar 2020 14:26:09 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51443 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgCRS0I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Mar 2020 14:26:08 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3D434B7FBC;
        Wed, 18 Mar 2020 14:26:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2XsnhAMNTjFSTWC4Ggrc1OTHvf8=; b=lbXFFV
        UfilVLSqP2M+0YO4C+ZTz0NcSWsYhIG3qb3Ef2FJYLpeIUn5f3FlqZ3AcNx9kROG
        i07epDb0PECr5lvIB93SXlKs3kXyFEGhH3Ld4U5Q3vPtzRA69RxAEjpaN7ybjXI4
        znp20eSah9BoYljDvkfGU0ge4RzC+zB6K9e28=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=X/y3g3SCLMRgh+IPHE3A3iA20XUmHXh7
        AfAXTN39rkAW3hMQXBnupRLZsTH7851TM/a5J5E8UytzutD0pE9mAAyYZtjzk5iB
        LRpJ6zmZmQCO3g9BTSbF+TIM0FcL2BS4Fw0OLOkRaw13uFzw0rm1lB0p1cERGRW2
        WkKybpf9m20=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 347B0B7FBB;
        Wed, 18 Mar 2020 14:26:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7B57EB7FBA;
        Wed, 18 Mar 2020 14:26:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        christian.couder@gmail.com, james@jramsay.com.au
Subject: Re*: [RFC PATCH 0/2] upload-pack.c: limit allowed filter choices
References: <CAP8UFD0wJo4onz0_Vw4-bcX1h61=J=ZiKfM-fMXLj4B9q0aveg@mail.gmail.com>
        <cover.1584477196.git.me@ttaylorr.com>
        <20200318101825.GB1227946@coredump.intra.peff.net>
Date:   Wed, 18 Mar 2020 11:26:00 -0700
In-Reply-To: <20200318101825.GB1227946@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 18 Mar 2020 06:18:25 -0400")
Message-ID: <xmqqtv2lfrk7.fsf_-_@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EC3BD5A8-6945-11EA-8BE4-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>>   - 'uploadpack.filter.<filter>.allow' -> specifying whether or not each
>>     filter kind is allowed or not. (Originally this was given as 'git
>>     config uploadpack.filter=blob:none.allow true', but this '=' is
>>     ambiguous to configuration given over '-c', which itself uses an '='
>>     to separate keys from values.)
>
> One thing that's a little ugly here is the embedded dot in the
> subsection (i.e., "filter.<filter>"). It makes it look like a four-level
> key, but really there is no such thing in Git.  But everything else we
> tried was even uglier.

I think this gives us the best arrangement by upfront forcing all
the configuration handers for "<subcommand>.*.<token>" namespace,
current and future, to use "<group-prefix>" before the unbounded set
of user-specifiable values that affects the <subcommand> (which is
"uploadpack").

So far, the configuration variables that needs to be grouped by
unbounded set of user-specifiable values we supported happened to
have only one sensible such set for each <subcommand>, so we could
get away without such <group-prefix> and it was perfectly OK to
have, say "guitool.<name>.cmd".

Syntactically, the convention to always end such <group-prefix> with
a dot "." may look unusual, or once readers' eyes get used to them,
may look natural.  One tiny sad thing about it is that it cannot be
mechanically enforced, but that is minor.

> We could do "uploadpackfilter.allow" and "uploadpackfilter.<filter>.allow",
> but that's both ugly _and_ separates these options from the rest of
> uploadpack.*.

There is an existing instance of a configuration that affects
<subcommand> that uses a different word after <subcommand>, which is
credentialCache.ignoreSIGHUP, and I tend to agree that it is ugly.

By the way, I noticed the following while I was studying the current
practice, so before I forget...

-- >8 --
Subject: [PATCH] separate tar.* config to its own source file

Even though there is only one configuration variable in the
namespace, it is not quite right to have tar.umask described
among the variables for tag.* namespace.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt     | 2 ++
 Documentation/config/tag.txt | 7 -------
 Documentation/config/tar.txt | 6 ++++++
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 08b13ba72b..2450589a0e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -447,6 +447,8 @@ include::config/submodule.txt[]
 
 include::config/tag.txt[]
 
+include::config/tar.txt[]
+
 include::config/trace2.txt[]
 
 include::config/transfer.txt[]
diff --git a/Documentation/config/tag.txt b/Documentation/config/tag.txt
index 6d9110d84c..5062a057ff 100644
--- a/Documentation/config/tag.txt
+++ b/Documentation/config/tag.txt
@@ -15,10 +15,3 @@ tag.gpgSign::
 	convenient to use an agent to avoid typing your gpg passphrase
 	several times. Note that this option doesn't affect tag signing
 	behavior enabled by "-u <keyid>" or "--local-user=<keyid>" options.
-
-tar.umask::
-	This variable can be used to restrict the permission bits of
-	tar archive entries.  The default is 0002, which turns off the
-	world write bit.  The special value "user" indicates that the
-	archiving user's umask will be used instead.  See umask(2) and
-	linkgit:git-archive[1].
diff --git a/Documentation/config/tar.txt b/Documentation/config/tar.txt
new file mode 100644
index 0000000000..de8ff48ea9
--- /dev/null
+++ b/Documentation/config/tar.txt
@@ -0,0 +1,6 @@
+tar.umask::
+	This variable can be used to restrict the permission bits of
+	tar archive entries.  The default is 0002, which turns off the
+	world write bit.  The special value "user" indicates that the
+	archiving user's umask will be used instead.  See umask(2) and
+	linkgit:git-archive[1].
