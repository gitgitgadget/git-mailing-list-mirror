Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B53CD37B4
	for <git@archiver.kernel.org>; Sun, 17 Sep 2023 16:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235491AbjIQQq2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Sep 2023 12:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236318AbjIQQqO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Sep 2023 12:46:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778A2132
        for <git@vger.kernel.org>; Sun, 17 Sep 2023 09:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694969120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W+Y+MI7oe+8bNKc0gZFUxl5PHTXzUq8URl7GIeSZPRg=;
        b=F/cItwymP8sfaApRN4GPKZQMIwwYk553I3/PHZnDxOJAZzztIhCazedsabglhhR8KYJ34T
        5lbpHpxC7HxVH9zh8QPW57e/2dCKckz4MSoyY8RDxjnePr5GBnPa5XJVwD6F4nmaMJL6lz
        YSQNjI017BDoEaYqnsvy3lWT+IFDb/k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-WzgBdVseMnOEMIX0IBv6XA-1; Sun, 17 Sep 2023 12:45:14 -0400
X-MC-Unique: WzgBdVseMnOEMIX0IBv6XA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 02CAF945920;
        Sun, 17 Sep 2023 16:45:14 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.42])
        by smtp.corp.redhat.com (Postfix) with SMTP id BD88A2027047;
        Sun, 17 Sep 2023 16:45:12 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Sun, 17 Sep 2023 18:44:21 +0200 (CEST)
Date:   Sun, 17 Sep 2023 18:44:18 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Alexey Gladkov <legion@kernel.org>
Subject: Re: [PATCH 1/1] git-grep: improve the --show-function behaviour
Message-ID: <20230917164418.GA20932@redhat.com>
References: <20230911121126.GA17383@redhat.com>
 <20230911121211.GA17401@redhat.com>
 <xmqq34zktk4h.fsf@gitster.g>
 <20230911231756.GA2840@redhat.com>
 <20230912130429.GA9982@redhat.com>
 <20230912135124.GA11315@redhat.com>
 <df05f761-c498-6930-bfd8-265f7e23d8ee@web.de>
 <xmqq1qf2lxrm.fsf@gitster.g>
 <20230913094638.GA535@redhat.com>
 <9203cd46-6a81-38e4-f191-da0b51e238c1@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9203cd46-6a81-38e4-f191-da0b51e238c1@web.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René, sorry for late reply,

On 09/14, René Scharfe wrote:
>
> Am 13.09.23 um 11:46 schrieb Oleg Nesterov:
> >
> > I have another opinion. To me the 2nd "=..." marker does help to
> > understand the hit location. But this doesn't matter.
>
> You see it as another layer of information, as an annotation, an
> additional line containing meta-information.  I saw them as context
> lines, i.e. lines from the original file shown in the original order
> without duplication, like - lines, with the only place for meta-
> information being the marker character itself.

Yes,

> > But without my patch, in this case I get
> >
> > 	TEST.c                      1                          void func1(struct pid *);
> > 	TEST.c                      3                          void func2(struct pid *pid)
> > 	TEST.c                      5                          use1(pid);
> > 	TEST.c                      8                          void func3(struct pid *pid)
> > 	TEST.c                     10                          use2(pid);
> >
> > because the output from git-grep
> >
> > 	$ git grep --untracked -pn pid TEST.c
> > 	TEST.c:1:void func1(struct pid *);
> > 	TEST.c:3:void func2(struct pid *pid)
> > 	TEST.c:5:       use1(pid);
> > 	TEST.c:8:void func3(struct pid *pid)
> > 	TEST.c:10:      use2(pid);
> >
> > doesn't have the "=..." markers at all.
>
> Sure, that's a problem.  You could easily check whether a match is also
> a function line according to the default heuristic

Yes, but...

> there are some impressive regexes in userdiff.c
> and the script would have to figure out which language the file is
> configured to be for Git in the first place.

Yes, and this is what I'd like to avoid, I do not want to duplicate the
builtin_drivers[] logic.

> > in my editor without this patch, I get
> >
> > 	kernel/sys.c              224 sys_setpriority          struct pid *pgrp;

[...snip...]

> Well, your script turns "SYSCALL_DEFINE3(setpriority, [...]" into
> "sys_setpriority" etc., so it is already knows a lot about function lines.

No, not a lot ;)

But yes sure, I can adapt this script to the current behaviour. In fact I
can even change it to not use "-p", the script can read the file backwards
itself (but of course I'd prefer to not do this).

Nevermind. Thanks for discussion. If I can't convince maintainers - lets
forget this patch. Although I will probably keep it (and another one I
had from the very begginning) for myself, it works for me.

> Can we use two markers, i.e. both : and =?  No idea what that might break.

...

> So with the patch below this would look like this:

...

> kernel/sys.c#1073#SYSCALL_DEFINE2(setpgid, pid_t, pid, pid_t, pgid)

This works for me too. So please CC me if you ever push this change ;)

Thanks,

Oleg.

