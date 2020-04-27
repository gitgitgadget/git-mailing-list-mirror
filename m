Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE997C4CECD
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 20:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AE012073C
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 20:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="d+zUhw2h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgD0Unp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 16:43:45 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54291 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbgD0Unp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Apr 2020 16:43:45 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6A8ECC6D83;
        Mon, 27 Apr 2020 16:43:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=00gv/FZsWQ/ZQU1CZE9TnMVrSPg=; b=d+zUhw
        2hB1UjK+4zWzHIC+E7wlqtzjhPUTArQkrc2IXAAbxLwrSr6iURhwgEImE3yREmiC
        MBp77lKXA44nTVznqesnYsM8D/BTGFfmTKhP/ovqnNO1UrB9rdUfpdSA2yVoF/+h
        PciciN/rigFk2mu0tElKugXG49N9Hbls/I0z4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vif5xUjTfKiPce9OAq6LLibWdPqDZXPG
        xGK78fAdQHmBujLO5ZhCU/Ll0fYvS0nwC+Wms9KfQyKRP7fHmicXBXsXpg/8JDNN
        6yyrXemMgmyp2xaawTRIg7PaP4uUhmLCbsk3Z3/XYan6hdxxL+3257tIxFJZhO4h
        etrTmPjEzvM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6227CC6D82;
        Mon, 27 Apr 2020 16:43:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AD2C5C6D80;
        Mon, 27 Apr 2020 16:43:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        git@vger.kernel.org, dirk@ed4u.de, sunshine@sunshineco.com
Subject: Re: [PATCH v3] git-credential-store: skip empty lines and comments from store
References: <20200427084235.60798-1-carenas@gmail.com>
        <20200427125915.88667-1-carenas@gmail.com>
        <xmqqftco94wx.fsf@gitster.c.googlers.com>
        <20200427191858.GB1728884@coredump.intra.peff.net>
Date:   Mon, 27 Apr 2020 13:43:38 -0700
In-Reply-To: <20200427191858.GB1728884@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 27 Apr 2020 15:18:58 -0400")
Message-ID: <xmqqv9lk7j7p.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C707D9F2-88C7-11EA-A1F8-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Apr 27, 2020 at 11:09:34AM -0700, Junio C Hamano wrote:
>
>> > modified store files which might have empty lines or even comments
>> > were reported[1] failing to parse as valid credentials.
>> 
>> These files are not supposed to be viewed or edited without the help
>> of the credential helpers.  Do these blank lines and comments even
>> survive when a new credential is approved, or do we just overwrite
>> and lose them?
>
> That's a good question. In the older code we do save them, because
> credential-store passes through lines which don't match the credential
> we're operating on.
>
> But in Carlo's patch, the immediate "continue" means we wouldn't ever
> call "other_cb", which is what does that pass-through.

So, does that mean the patch that started this thread will still help
users who wrote custom comments and blank lines in their credential
store by letting git-credential-store start up, but leaves a ticking
bomb for them to lose these precious comments and blanks once they
add a new site, change password, etc., at which point the user realizes
that comments and blanks are not supported after all?

>> I'd rather not to do either, if we did not have to, but if it were
>> necessary for us to do something, I am OK to ignore empty lines.
>> But I'd prefer not to mix the new "# comment" feature in, if we did
>> not have to.
>> 
>> Also, triming the lines that are not empty is unwarranted.  IIUC,
>> what the "store" action writes encodes whitespaces, so as soon as
>> you see whitespace on either end, (or anywhere on the line for that
>> matter), it is a hand-edited cruft in the file.  If you ignore
>> comments, you probably should ignore those lines, too.
>
> Yeah, all of that seems quite sensible.

I think the first patch we need is a (belated) documentation patch,
that adds to the existing "STORAGE FORMAT".  We already say "Each
credential is stored on its own line as a URL", but we do not say
anything about allowing other cruft in the file.  We probably
should.  Adding a "comment" feature, if anybody feels like it, is OK
and we can loosen the paragraph when that happens.

-- >8 --
Subject: credential-store: document the file format a bit more

Reading a malformed credential URL line and silently ignoring it
does not mean that we promise to torelate and/or keep empty lines
and "# commented" lines forever.

Some people seem to take anything that is not explicitly forbidden
as allowed, but the world does not work that way.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-credential-store.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/git-credential-store.txt b/Documentation/git-credential-store.txt
index 693dd9d9d7..76b0798856 100644
--- a/Documentation/git-credential-store.txt
+++ b/Documentation/git-credential-store.txt
@@ -94,6 +94,10 @@ stored on its own line as a URL like:
 https://user:pass@example.com
 ------------------------------
 
+No other kinds of lines (e.g. empty lines or comment lines) are
+allowed in the file, even though some may be silently ignored. Do
+not view or edit the file with editors.
+
 When Git needs authentication for a particular URL context,
 credential-store will consider that context a pattern to match against
 each entry in the credentials file.  If the protocol, hostname, and
