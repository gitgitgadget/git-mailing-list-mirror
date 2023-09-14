Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6068CEEAA6A
	for <git@archiver.kernel.org>; Thu, 14 Sep 2023 19:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjINT5h (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Sep 2023 15:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjINT5g (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2023 15:57:36 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BF926B8
        for <git@vger.kernel.org>; Thu, 14 Sep 2023 12:57:32 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:41346)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qgsSx-00Gboc-Lt; Thu, 14 Sep 2023 13:57:31 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:34154 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qgsSw-003zxa-1z; Thu, 14 Sep 2023 13:57:31 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
References: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
        <xmqq8r9di5ba.fsf@gitster.g>
        <87cyyoeli0.fsf@email.froward.int.ebiederm.org>
        <xmqqil8fqs6o.fsf@gitster.g>
Date:   Thu, 14 Sep 2023 14:57:22 -0500
In-Reply-To: <xmqqil8fqs6o.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        12 Sep 2023 09:20:31 -0700")
Message-ID: <871qf0wmsd.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1qgsSw-003zxa-1z;;;mid=<871qf0wmsd.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+Kgyz8dVTh46I6G/Mj2QuGUmT3NWCzZ3s=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [RFC][PATCH 0/32] SHA256 and SHA1 interoperability
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Eric W. Biederman" <ebiederm@xmission.com> writes:
>
>> I am not worried about what it will take time to get the changes I
>> posted into the integration.  I had only envisioned them as good enough
>> to get the technical ideas across, and had never envisioned them as
>> being accepted as is.
>
> Ah, no worries.  By "integration" I did not mean "patches considered
> perfect, they are accepted, and are now part of the Git codebase".
>
> All that happens when the patches become part of the 'master'
> branch, but before that, patches that prove testable and worthy of
> getting tested will be merged to the 'next' branch and spend about a
> week there.  What I meant to refer to is a step _before_ that, i.e.
> before the patches probe to be testable.  New patches first appear
> on the 'seen' branch that merges "everything else" to see the
> interaction with all the topics "in flight" (i.e.  not yet in
> 'master').  The 'seen' branch is reassembled from the latest
> iteration of the patches twice of thrice per day, and some patches
> are merged to 'next' and down to 'master', these "merging to prepare
> 'master', 'next' and 'seen' branches for publishing" was what I
> meant by "integration".  In short, being queued on 'seen' does not
> mean all that much.  It gives project participants an easy access to
> view how topics look in the larger picture, potentially interacting
> with other topics in flight, but the patches in there can be
> replaced wholesale or even dropped if they do not turn out to be
> desirable.
>
> I resolved textual conflicts and also compiler detectable semantic
> conflicts (e.g. some in-flight topics may have added callsites to a
> function your topic changes the function sigunature, or vice versa)
> to the point that the result compiles while merging this topic to
> 'seen', but tests are broken the big time, it seems, even though the
> topic by itself seems to pass the tests standalone.

That the tests are broken is very unfortunate.

I took at look at What's cooking in git.git and I did not see my topic
mentioned.  So I presume I would have to perform the test merge myself
to have a sense of what the conflicts were.

Is there a time when in flight topics is low?  I had a hunch that basing
my work on a brand new release would achieve that but I saw a lot of
topics in your "What's cooking" email.

I am just trying to figure out a good plan to deal with conflicts,
because the bugs need to be hunted down.

Eric



