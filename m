Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AEC8EE14D3
	for <git@archiver.kernel.org>; Wed,  6 Sep 2023 19:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244086AbjIFTKh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Sep 2023 15:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237738AbjIFTKf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2023 15:10:35 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC60185
        for <git@vger.kernel.org>; Wed,  6 Sep 2023 12:10:30 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B3FDB1B4363;
        Wed,  6 Sep 2023 15:10:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=CFqonJIj/elg
        k7mioWxr8BxQlFqf0PsJiGeFuef1NwI=; b=COOGPUHzcWlWyc4Fis1pS2c3CGfv
        zAz8uEeMvYILiEx1hOlLHhtzwnugL0MN9tXWVrTHKIwl/OPYDPDUCwnL06YIKPBL
        7hxvQ76f/uGhmUdA6WkdMFaRNL3jTciYNrHxdTUn58pJZUEun/n0ik4iwz0Tegcq
        KM7ik7wEhloCMW0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ABEE51B4362;
        Wed,  6 Sep 2023 15:10:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 233C71B4361;
        Wed,  6 Sep 2023 15:10:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Cc:     "Eric Sunshine" <sunshine@sunshineco.com>,
        "Tao Klerks" <tao@klerks.biz>,
        "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
        "Taylor Blau" <me@ttaylorr.com>, "Patrick Steinhardt" <ps@pks.im>,
        git <git@vger.kernel.org>
Subject: Re: Is "bare"ness in the context of multiple worktrees weird?
 Bitmap error in git gc.
In-Reply-To: <xmqq5y4nnq9b.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        06 Sep 2023 10:52:16 -0700")
References: <CAPMMpoixKnr4BkKd8jeU+79Edhqtu4R7m8=BX4ZSYKdBHDzK=w@mail.gmail.com>
        <b5833396-7e04-465f-96f6-69d5280fa023@app.fastmail.com>
        <CAPig+cQoiqeZF52Jr45an+cZF+ZQbHPXtLVn+VmyegjMQaJqCg@mail.gmail.com>
        <2ba66542-9ae2-4b13-ae6b-f37dec6b72c7@app.fastmail.com>
        <xmqq5y4nnq9b.fsf@gitster.g>
Date:   Wed, 06 Sep 2023 12:10:26 -0700
Message-ID: <xmqqwmx3m82l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 09DCD49C-4CE9-11EE-9C5E-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:
>
>> But not with =E2=80=9Cworktree=E2=80=9D:
>>
>>   =E2=80=9C A repository can have zero (i.e. bare repository) or one o=
r more
>>     worktrees attached to it. ...
>>
>> Since this entry claims that =E2=80=9Cbare repository=E2=80=9D and =E2=
=80=9Czero worktrees=E2=80=9D are
>> equivalent.
>
> I wrote that "(i.e. bare repository)" in 2df5387e (glossary:
> describe "worktree", 2022-02-09) but did not mean that way. =20
>
> A non-bare repository can reduce the number of its worktrees, but it
> cannot go below one, because the directory with working tree files
> and the .git/ subdirectory, i.e. its primary worktree, must exist
> for it to be a non-bare repository.  Consequently a repository with
> zero worktree is by definition a bare repository.
>
> But that does not have to mean all bare repositories can have no
> worktrees.

I re-read the glossary entry and I think the current text is mostly
OK, except that it does not even have to mention "bare" at that
position in the sentence.  A bare repository with zero worktrees is
totally uninteresting in the explanation of the worktree.

We need to say that the repository data (configuration, refs and
objecs) are mostly shared among worktrees while some data are kept
per-worktree, which the current text adequately covers, and what is
missing with respect to a bare repository is that we do not say
worktrees can be attached after the fact to a repository that was
created bare.

So, perhaps something along this line?

 Documentation/glossary-content.txt | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git c/Documentation/glossary-content.txt w/Documentation/glossary-=
content.txt
index 5a537268e2..6dba68ffc0 100644
--- c/Documentation/glossary-content.txt
+++ w/Documentation/glossary-content.txt
@@ -694,10 +694,12 @@ The most notable example is `HEAD`.
 	plus any local changes that you have made but not yet committed.
=20
 [[def_worktree]]worktree::
-	A repository can have zero (i.e. bare repository) or one or
-	more worktrees attached to it. One "worktree" consists of a
-	"working tree" and repository metadata, most of which are
-	shared among other worktrees of a single repository, and
-	some of which are maintained separately per worktree
-	(e.g. the index, HEAD and pseudorefs like MERGE_HEAD,
-	per-worktree refs and per-worktree configuration file).
+	A repository can have zero or more worktrees attached to it.
+	One "worktree" consists of a "working tree" and repository
+	metadata, most of which are shared among other worktrees of
+	a single repository, and some of which are maintained
+	separately per worktree (e.g. the index, HEAD and pseudorefs
+	like MERGE_HEAD, per-worktree refs and per-worktree
+	configuration file).
++
+Note that worktrees can be attached to an existing bare repository.
