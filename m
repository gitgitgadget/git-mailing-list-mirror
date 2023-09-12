Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA5FCA0EDB
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 13:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235220AbjILNxf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Sep 2023 09:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235813AbjILNx0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2023 09:53:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 09E2810CE
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 06:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694526755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zs3sipXaUv8hiEf8Ux+sNtFTAq+A8dEElUhshJTogfw=;
        b=A7YA3SYFiEZ9TwNf4loVaXo2LUMBQu8wMiF0js9Q5YvnN5BT2aaJfnBWkXyC9G/qyO0VFI
        P3pSebCixj/uqCRh+CbEaQ1w5NgVnRhfxY3SmqYLJwfAkmo4LT0rhdzAXAFpsXMVtDzPWn
        PniWEoRX+kl1SrtqLIVXfo8TBsVYjDs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-392-iqFvn95aOZW_oIEZOmiznQ-1; Tue, 12 Sep 2023 09:52:27 -0400
X-MC-Unique: iqFvn95aOZW_oIEZOmiznQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 62EA8916FA4;
        Tue, 12 Sep 2023 13:52:23 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.195])
        by smtp.corp.redhat.com (Postfix) with SMTP id 650F22026D68;
        Tue, 12 Sep 2023 13:52:17 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 12 Sep 2023 15:51:31 +0200 (CEST)
Date:   Tue, 12 Sep 2023 15:51:24 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Carlo Marcelo Arenas =?iso-8859-1?Q?Bel=F3n?= 
        <carenas@gmail.com>, Elijah Newren <newren@gmail.com>,
        Jeff King <peff@peff.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mathias Krause <minipli@grsecurity.net>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Alexey Gladkov <legion@kernel.org>
Subject: Re: [PATCH 1/1] git-grep: improve the --show-function behaviour
Message-ID: <20230912135124.GA11315@redhat.com>
References: <20230911121126.GA17383@redhat.com>
 <20230911121211.GA17401@redhat.com>
 <xmqq34zktk4h.fsf@gitster.g>
 <20230911231756.GA2840@redhat.com>
 <20230912130429.GA9982@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230912130429.GA9982@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/12, Oleg Nesterov wrote:
>
> René, Junio,
>
> I don't like the fact we can't understand each other ;) Could you
> please explain why do you think this patch should update the docs?
>
> Please forget about my patch for the moment. Lets start from the very
> beginning:
>
> 	-p::
> 	--show-function::
> 		Show the preceding line that contains the function name of
> 		the match, unless the matching line is a function name itself.
>
> and in my opinion, it is the current behaviour that doesn't match the
> documentation.
>
> -------------------------------------------------------------------------
>
> 	$ cat TEST1.c
> 	void func1()
> 	{
> 	}
> 	void func2()
> 	{
> 	}
>
> 	$ git grep --untracked -pn func2 TEST1.c
> 	TEST1.c=1=void func1()
> 	TEST1.c:4:void func2()
>
> in this case the matching line is "void func2()" and it is also a function
> name itself, in this case git-grep should not show "=void func1()" which is
> "the preceding line that contains the function name of the match.
>
> But it does. So perhaps git-grep needs another change, something like
>
> 	if (match_funcname(opt, gs, bol, end_of_line(...)))
> 		return;
>
> at the start of show_funcname_line(), but my patch does not change this
> behaviour.
>
> --------------------------------------------------------------------------
>
> 	$ cat TEST2.c
> 	void func(xxx)
> 	{
> 		use(xxx);
> 	}
>
> 	$ git grep --untracked -pn xxx TEST2.c
> 	TEST2.c:1:void func(xxx)
> 	TEST2.c:3:      use(xxx)
>
> the 2nd match is use(xxx) and it is not a function name itself, in this
> case git-grep should "Show the preceding line that contains the function
> name of the match.
>
> But it doesn't. To me, this behaviour looks as
>
> 		Show the preceding line that contains the function name of
> 		the match, unless the _PREVIOUS_ matching line is a function
> 		name itself.
>
> Now, with my patch we have
>
> 	$ ./git grep --untracked -pn xxx TEST2.c
> 	TEST2.c:1:void func(xxx)
> 	TEST2.c=1=void func(xxx)
> 	TEST2.c:3:      use(xxx);
>
> and unless I am totatlly confused this does match the documentation.

So, just in case, please see V2 below. In my opinion it _fixes_ the
current behaviour. With this patch

	$ ./git grep --untracked -pn func2 TEST1.c
	TEST1.c:4:void func2()

	$ ./git grep --untracked -pn xxx TEST2.c
	TEST2.c:1:void func(xxx)
	TEST2.c=1=void func(xxx)
	TEST2.c:3:      use(xxx);

Or I am totally confused?

Oleg.
---

diff --git a/grep.c b/grep.c
index 0904d55b24..c240c4bfa1 100644
--- a/grep.c
+++ b/grep.c
@@ -1347,15 +1347,19 @@ static int match_funcname(struct grep_opt *opt, struct grep_source *gs,
 static void show_funcname_line(struct grep_opt *opt, struct grep_source *gs,
 			       const char *bol, unsigned lno)
 {
+	unsigned long left = bol - gs->buf;
+
+	if (match_funcname(opt, gs, bol, end_of_line(bol, &left)))
+		return;
+
 	while (bol > gs->buf) {
 		const char *eol = --bol;
 
+		if (--lno < opt->last_shown)
+			break;
+
 		while (bol > gs->buf && bol[-1] != '\n')
 			bol--;
-		lno--;
-
-		if (lno <= opt->last_shown)
-			break;
 
 		if (match_funcname(opt, gs, bol, eol)) {
 			show_line(opt, bol, eol, gs->name, lno, 0, '=');

