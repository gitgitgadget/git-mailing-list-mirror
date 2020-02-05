Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D591C35247
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 21:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5289B2082E
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 21:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Cw9Wp+q8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgBEVmp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 16:42:45 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63922 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbgBEVmp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 16:42:45 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E482BB776E;
        Wed,  5 Feb 2020 16:42:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aoSJ9NdLFdvp2X5KDtoqyJzH/Cs=; b=Cw9Wp+
        q8TlMlTgciND9gr8rKGfsmG9W8eQ7Q4AQiPYXBkNY3IqPRXkj5bFy5+lJgb7TB7N
        Op0DL0Z6Abtd9Ao40ibJj53BWFWFr0pB0aFiMty8/BXGcVV2bVCA+smMYyrXdxq1
        yhQHabRlKhX8PIzoFHRYruOCcMwO9nRx3Duyw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KQa/VHzH0XECoyvfyvhFwRAIHPYO28jR
        c2BtVU+tZBY8lffpzqgsnXeurgjFs192RzBZzShZ+5i8fU0TkLCxATgnExIJ3wmm
        bGH2cNCr7OTBipKoAMfz7C8KfBl3Nm+axC8RTw/ln6sovbRDjJ/GnnG/v1NhQP08
        mBQPo9rYQZA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DA768B776D;
        Wed,  5 Feb 2020 16:42:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AE143B776C;
        Wed,  5 Feb 2020 16:42:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Keene <seraphire@gmail.com>
Cc:     Ben Keene via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 2/4] git-p4: create new method gitRunHook
References: <pull.698.git.git.1579555036314.gitgitgadget@gmail.com>
        <pull.698.v2.git.git.1580507895.gitgitgadget@gmail.com>
        <f1f9fdc542353196612f8dd6b996d4fbd1f76c73.1580507895.git.gitgitgadget@gmail.com>
        <xmqqr1za6q83.fsf@gitster-ct.c.googlers.com>
        <ac44531e-b02d-5a98-3e25-a305b1250cf6@gmail.com>
Date:   Wed, 05 Feb 2020 13:42:37 -0800
In-Reply-To: <ac44531e-b02d-5a98-3e25-a305b1250cf6@gmail.com> (Ben Keene's
        message of "Wed, 5 Feb 2020 14:56:19 -0500")
Message-ID: <xmqq36bohfsi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6E913C5C-4860-11EA-BDB3-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Keene <seraphire@gmail.com> writes:

>>> +        hooks_path = os.path.join(os.environ.get("GIT_DIR", ".git"), "hooks")
>> This assumes that the process when his function is called (by the
>> way, even though the title of the patch uses the word "method", this
>> is not a method but a function, no?), it is always at the top level
>> of the working tree.  Is that a good assumption?  I don't know the
>> code well, so "yes it is good because a very early thing we do is to
>> go up to the top" is a good answer.
> I'm not sure what you mean by top level of the tree unless you mean
> that it is not part of a class, but a "Free standing" function?

No.  The discussion about function vs method was over immediately
after we left the parentheses ;-)

The "top level of the working tree" is the directory where the files
you see in "git ls-tree $commit^{tree}" would appear in.  In our
project, that is where the primary Makefile, COPYING, Documentation/,
etc. hangs from.

The code in your patch (quoted above) says that "When $GIT_DIR is
not set, '.git/hooks/' is the directory the hooks live in".  That is
true only when your process is at the top level of the working tree.
If you chdir'ed to a subdirectory (e.g. Documentation/ in our
project) and then let the quoted code run, hooks_path is set to
".git/hooks/", but from the point of view of the process running
inside "Documentation/" subdirectory, it should actually be
"../.git/hooks/", right?

> And
> yes, it returns a value so it should be called a function. I'll
> correct that.

This is an irrelevant tangent ;-) but yeah, it is a function, as
opposed to a method, because it is not attached to any class.  I did
not think Python differentiated functions that return a value and
ones that do not (e.g. Pascal call the latter "procedure").

> I chose to not put the function within a class so
> that if other hooks should be added, it would not require a refactoring
> of the code to use the function in other classes.

I think that is a sensible design decision to have a free-standing
function to execute hooks.

Thanks.
