Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A294CA0EEB
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 16:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236650AbjILQUo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Sep 2023 12:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236636AbjILQUn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2023 12:20:43 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2CB10EB
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 09:20:39 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 376F53EE71;
        Tue, 12 Sep 2023 12:20:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=0dV0LcXwm+r2fjg+myUv+5DTJY/g9otLGRw9Xi
        ixTKI=; b=kY8lWELNPwtdWHf5o5HWTODq+7tbbeDjmlsyM5xN1w0cdwEIuRgsH0
        N1pmU6Kw09b/3zKsp4pLDiMBilR7vRiVjVlhHCiMH1qYUsMNzELPncQvRNZoPaFz
        S1y93N0CbXPcM4LWmP3WFvJ6emND2lIhE2uTweS/hCsgSbA6piO0c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2FC3D3EE70;
        Tue, 12 Sep 2023 12:20:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 872723EE6F;
        Tue, 12 Sep 2023 12:20:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [RFC][PATCH 0/32] SHA256 and SHA1 interoperability
In-Reply-To: <87cyyoeli0.fsf@email.froward.int.ebiederm.org> (Eric
        W. Biederman's message of "Mon, 11 Sep 2023 11:13:27 -0500")
References: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
        <xmqq8r9di5ba.fsf@gitster.g>
        <87cyyoeli0.fsf@email.froward.int.ebiederm.org>
Date:   Tue, 12 Sep 2023 09:20:31 -0700
Message-ID: <xmqqil8fqs6o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4BE3F70A-5188-11EE-B222-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Eric W. Biederman" <ebiederm@xmission.com> writes:

> I am not worried about what it will take time to get the changes I
> posted into the integration.  I had only envisioned them as good enough
> to get the technical ideas across, and had never envisioned them as
> being accepted as is.

Ah, no worries.  By "integration" I did not mean "patches considered
perfect, they are accepted, and are now part of the Git codebase".

All that happens when the patches become part of the 'master'
branch, but before that, patches that prove testable and worthy of
getting tested will be merged to the 'next' branch and spend about a
week there.  What I meant to refer to is a step _before_ that, i.e.
before the patches probe to be testable.  New patches first appear
on the 'seen' branch that merges "everything else" to see the
interaction with all the topics "in flight" (i.e.  not yet in
'master').  The 'seen' branch is reassembled from the latest
iteration of the patches twice of thrice per day, and some patches
are merged to 'next' and down to 'master', these "merging to prepare
'master', 'next' and 'seen' branches for publishing" was what I
meant by "integration".  In short, being queued on 'seen' does not
mean all that much.  It gives project participants an easy access to
view how topics look in the larger picture, potentially interacting
with other topics in flight, but the patches in there can be
replaced wholesale or even dropped if they do not turn out to be
desirable.

I resolved textual conflicts and also compiler detectable semantic
conflicts (e.g. some in-flight topics may have added callsites to a
function your topic changes the function sigunature, or vice versa)
to the point that the result compiles while merging this topic to
'seen', but tests are broken the big time, it seems, even though the
topic by itself seems to pass the tests standalone.

> What I am envisioning as my future directions are:
> ...
> Does that sound like a reasonable plan?

Nice.
