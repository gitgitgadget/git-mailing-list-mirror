Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81987C2D0E4
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 19:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19C9E2222C
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 19:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="CGeWDjRt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731346AbgKQTwI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 14:52:08 -0500
Received: from mout.web.de ([217.72.192.78]:39639 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730334AbgKQTwH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 14:52:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1605642682;
        bh=Psq6HEVdKpqjBYXxeMv96BnsYAzPVQkmwuiGvCgOwdU=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=CGeWDjRtN0x6i5X4ZL9GL5zIINkz0a7MHGirJNJM4pvs0msmo7y8zZjw05QLjPYfi
         1xT/uM1Ua0AHgE33bdYdNXXe+J7GMgzqEY9QbQvpEA16vkv/fkm1dO/KDKqH1Ehalx
         PUot7YqnQfwckX1tHgEf7zCiwAx2eTI1o/9A++MQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.17.45]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M2gkf-1kh29O47nr-004BA0; Tue, 17
 Nov 2020 20:51:22 +0100
Subject: Re: can someone verify operation of "splitpatch" with a massive "git
 diff"?
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Git Mailing list <git@vger.kernel.org>
References: <fc5cf6bc-aa74-d8-90b-c1789f349b8c@crashcourse.ca>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <2e422fba-2278-497d-d6a2-909d00aa6ac8@web.de>
Date:   Tue, 17 Nov 2020 20:51:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <fc5cf6bc-aa74-d8-90b-c1789f349b8c@crashcourse.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:m+ujt9A8QRV7gnTm3rsgp+mAOc8uZFh1WVZvDIOWbiFa83/FW6d
 w3jfxBsgeveFtjBJjqUW1UJw8xR/kfULI4kXa4+4Nc91Ju7VQy+KGRlSo1Y9JcXG2cRblDa
 s3o002oqoSvDLlHK+/wUbNlrWWRGAqBMn0fLLQ9lpGdmTWdTMvEhNit7hN1GfDx0ZHyMi4C
 bs2vrFneLX8AwoyUgjlOQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ubapr3cQNa4=:pGrdaS4+y0KD6iJ++XCxcx
 ABL3qqCNVlsm90MCk5lR6HMTWBmz30Y5tD5wIElI/FMVM7h26GPA6AxtDmnlBIMCjsAWfxMxo
 nEqT2y7g0n8jirUTxkfcOliRffO9Q3jCiBUQeN6vaQ9Om4wkVphvckaON/bF91wuni6LCNS9t
 gkvdh68pmxygzOMLU5fH91KCk5bqPN+3fjuQSwPB6Aj2PjV37KlPLs6Eck6bupG6g2NXLFtjh
 H4WghRwfvzBIAJ8TRJRJ45Uj6TDHYbSZUjJ9/9BMKUQjmCkdV2EEDTUg/rcq/diV+KNg9jS4f
 RR1l/fWCqbRjrj6pIyk1cV+QCaBOf9eyDqpPgSTKiYV6MPO5xCWII3KOkydEde2FuOFFgkm5x
 KhdFTKVIMuU8SlOtfGKftzOQZnwK4lVE8TeVdj6R9K8h3Zn7Cyd7Mr9bEXpGk+lXovan7Xwm+
 UP8n7CtgH9GvyiHFa1zSk7zM+bjcjywwlNbjD4WxVSid0KBvvM07T46lYS04YFa6c87kxuIH0
 dj6GOFh2+7GpAts67mP0WuPENh2zs6xiwYRJJjfOyRv8j2eUTX0cvko+sgtqWK37xbVcJHWcp
 SQpEh5rzLZJYaL9hFsAvXr3Wz/2/1TQS/09u2C1ZSJFD3ozii3qHmM+Fr+uBljorlrjRELsuj
 GEnByTv5iCyzLoQWl21aKmkopxRhfTH45E0UIN/QxOOKBF5c31HliCXqXnCnGQaXy79TgrXzi
 cqKBWlUG3KjSg+x4l9JwnNV0jLsnvJrxaozQWQ3ocCD/WSKQYiQsRMQKNFQdw5GfM8W6WrDD1
 tL6GZHZmO0+lzpepoWfMIQMdEd/MlptM7aRJpgzJMyHWe59oU/mm4XFBDzJnp3YCMrEDPnFaY
 AtnV9bSZIKyIg5U8j8Uw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 16.11.20 um 10:18 schrieb Robert P. J. Day:
>
>   someone just handed me a several thousand line layer-wide patch, and
> i'd like to pull it apart into bite-sized pieces, and i just noticed
> the utility "splitpatch", but when i applied it to the patch, what i
> got was *almost* right ... except that the patch snippets had the
> trailing "git diff" line from the *following* patch snippet in the
> file; the splitting operation clearly retained the trailing line after
> the patch, rather than the leading line that actually represented the
> snippet.
>
>   is there a simple way to do this? i do have the right to go back to
> the patch creator and ask him to redo the diff in a different way.
> thoughts?

patch(1) should ignore those extra lines and apply the diff without
complaint.  git apply is probably more picky, based on the comments on
the homepage of splitpatch [1].

I don't understand how the original patch got so big, what you consider
bite-sized and what you'd do with the pieces, so I may be way off here.
Anyway, sometimes I lump a lot of semi-related changes into a single
commit and then have to split it up when I prepare a patch series for
review.  I'd then run "git reset HEAD^" to get rid of the commit, but
keep the changes in the worktree, and then repeatedly run
"git commit -p" to select just the hunks for a particular topic until
all the changes are committed.  This may be impractical if you have
thousands of hunks to work with, though.

Ideally huge changes are avoided at the source and split into meaningful
and consumable chunks as early as possible.  This is no longer possible
if the source is e.g. a bunch of ancient tar files with monthly
snapshots.  But since it's a Git diff I wonder what happened.  Could
Git have done better?

Ren=C3=A9


[1] https://www.clearchain.com/blog/posts/splitting-a-patch
