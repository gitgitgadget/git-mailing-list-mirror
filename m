Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFFEC7619A
	for <git@archiver.kernel.org>; Thu,  6 Apr 2023 01:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbjDFB7M (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 21:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjDFB7L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 21:59:11 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1CD10A
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 18:59:09 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id ml21so13947292pjb.4
        for <git@vger.kernel.org>; Wed, 05 Apr 2023 18:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680746349;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=KwHQkkcnLyN/GwrjHgxO9h3+XeQzdJY1s3VkYLieXV4=;
        b=gQQnyrm9IqkdMRGsRSDShi2y42j8+7G+q6KxaAapcMPq5inqOzW9DCGWIebBO53g10
         g5KIJg97RPDrMjuX1o/yjo9r2VQpMW4YcNC5Wr3cbNgcutK8Ge0k8Sd3Dj1h9a1Lhech
         oK/PD2SqyDZB3VPfAc6ZM63SXwJVsFFOtftWeGLBEQ+iWk6GbshfFhH0tNCjIwdl/cZ1
         +c+PJv9UPrLw7xQNnA5Q/2PBiPDXiYcHeSw5DPqb0BhPVx6hEQRrP86r6UjFir9AzLz6
         nT1Tdr9xPNEoLFI9UctpwtfjYcnIE7oa4OKsEqNLZLua2FDzU4qt8qY0fHW4/ps6bMkJ
         IAYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680746349;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KwHQkkcnLyN/GwrjHgxO9h3+XeQzdJY1s3VkYLieXV4=;
        b=6X+1a64p/cCA5Ub4f0ePj3GMTZTTFwzEyci2zPrVEg7BrMqllLYkL2lxKGE9mBAW7k
         q00QLFdTYreiFLdII/72Wpj6r5NktaJeR/ksKgoYShDrY4kJv6Vhh9y9XB2cvX8soGr5
         5FepUZeyUVJhoGcDvE9I1LpFmJ2gAgfXowmhFq+Du6EZGy+45dhx+NLwF/NXvnlWeg8q
         Kl+rKqALUJAT5kZCoxCK0U5bswr2K45XrpsyD7/KZrCFGeWw42hBFt/wtWZpsmW5QRjY
         EGrr14jJfIhTrJNzRQEN/0sglTy15HMjAQGUjPTwyXxXQXMv+6eDD5iYknL7SmosmKWh
         khqw==
X-Gm-Message-State: AAQBX9f5pWhNqepOfZBaZJbFKMhe6l9hSlu4nBdXR97jI91Eag/jEShx
        DxCa8uqMhYlsLYsbIQeupXQ=
X-Google-Smtp-Source: AKy350aUbjd9f8k+bjeW9cNSgy/nM6o/ZrhnkvO3YWrUaaEkg7Qy6hKWCXKCTqewdfXtrqlX+GK6SA==
X-Received: by 2002:a17:903:cd:b0:19f:1e3e:a84d with SMTP id x13-20020a17090300cd00b0019f1e3ea84dmr6083789plc.64.1680746348846;
        Wed, 05 Apr 2023 18:59:08 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id l6-20020a170902ec0600b0019c90f8c831sm164450pld.242.2023.04.05.18.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 18:59:08 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Bran Hagger <brhagger@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Emily Shaffer <nasamuffin@google.com>
Subject: Re: Improving support for name changes in git
References: <LV2PR21MB31334981E02BCA25792BAFFCCF939@LV2PR21MB3133.namprd21.prod.outlook.com>
Date:   Wed, 05 Apr 2023 18:59:07 -0700
Message-ID: <xmqqcz4hrct0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bran Hagger <brhagger@microsoft.com> writes:

> I'm interested in volunteering to help improve the process for
> users changing their name in Git.

To "improve", we need to understand what these users want when they
change their names.  Changing the names and changing the e-mail
addresses are both commonly done, and people depending on
circumstances want different things from the tool.  Some do not want
to be known that the person who used to use that old name is you,
the person who uses this new name.  Some do not mind their old name
or address to be in the record but they want to take credit for what
they did under both names.  There may be some position in between,
with various degrees of being realistic (e.g. "I do not want to be
associated with the old commit, but at the same time I do want to
take credit for it"---is that a reasonable desire?).

> Solving the first problem seems reasonably doable....

Up to this point, I found what you wrote to be reasoned very nicely.
However, ...

> The second problem of how to maintain a mapping of user.idHash
> without history is a radical departure from how git currently
> works.

... I think the above is an understatement.  No "radical departure"
would change the fundamental issue here: people need to be able to
map the random token X to the "current name" right now, and the
mechanism used to do so can be replayed at later date because a
mapping will be distributed, copied and saved.  Or a much simpler
and obvious source of the problem is that people have memories.

People change names and addresses over the course of their lives.
Employers may encourage their employees to use their corporate ident
when contributing to an external project, and often their employment
contract would make it clear that rights to the work belong to the
employers.  When employees move on, old contributions need to stay
to be "owned" by the original user ident.

	Side note: when changing an employer, people may more often
	change the address but not names.  But technically names and
	addresses as part of author/committer ident have the same
	characteristics in Git (e.g. being part of a etched-in-stone
	identity string), and the address is much less loaded
	emotionally, I'll talk about address change in this
	paragraph, but the same discussion applies to name change.

Some of these employees may not mind letting others know that the
person who made these old contributions and the person who is making
new contributions under different name and/or address are the same
person.  Others may be ashamed of their past association to the $EVIL
company and may want to start afresh, without being known about their
past employment with them.

The mailmap mechanism is a great way for the former group of folks.
It allows them to group the contributions by such a person who had
multiple idents over time into a single bucket.  But the mechanism
may not be suited for other uses, including the latter.

Some folks, after changing their name and/or address, do not want it
to be known that they used to use that name and/or address (e.g.
they may be a victim of a crime, being stalked, etc.)  The mailmap
mechanism would not help, even with your "random token" redirection,
and it shouldn't, because for those folks, they do not want to be
associated with their old ident after they started using new one.
The idea to use mailmap to somehow "link" the author of these old
commits (made under old ident) and the author of the new commits
(made under new ident of the same physical person who wants the
association with the old ident not to be known) _creates_ the
problem of "the linkage between two idents, which was made with
clever use of random token to make it irreversible, can be
recovered".

If "Such and such person used to work at $CORP and made these
contribution" was publically known as a fact before the person
changed their name and/or address, it is impossible to force all
other people to forget.  Wouldn't the only practical solution be to
stick to your new ident, and not talk about the old ident you used
to use?  If you try to abuse mailmap for something it wasn't even
designed to and have any entry to link the old and new ident in some
way, isn't it backwards as a solution, when what you want is that
the linkage between the old ident and you not to be known?
