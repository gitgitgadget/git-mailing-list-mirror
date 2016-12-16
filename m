Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E09861FF40
	for <e@80x24.org>; Fri, 16 Dec 2016 23:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757753AbcLPXeZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Dec 2016 18:34:25 -0500
Received: from mail-qt0-f175.google.com ([209.85.216.175]:33881 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757187AbcLPXeY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2016 18:34:24 -0500
Received: by mail-qt0-f175.google.com with SMTP id n6so101102924qtd.1
        for <git@vger.kernel.org>; Fri, 16 Dec 2016 15:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Cd3I4nxTi4iZyuBHaK8Ml4Votp5JHPp/UOKZwnG/o1k=;
        b=qj3g/c1m7B2flzB0hKPucTGdmORDsNcIPyzr6DgtHuya9LNlUjwL9es0gJ0jv/lJ3S
         wn6UKuNZjGQ3cWNi5ZP//vqI485tufZijoKvmmOuqrIl6Wc4CPOYyKEk3si8vlIT1sOT
         7mFb/pSTn+Yz44rVLP1X3xkpVfA8jWN9m04CKuGHfkHzT5bAY9moMmIb4S47otJdjA0X
         yZc6VQaVcw8bm17CwQHK9BitfOGdxq3+ufbxLLD32AsYUosijafsfvgYkH1znk/E2ZPh
         M8gAeJUDQ/yIm4lCxR54d1RucwVSJigvhUcq/L9PIPRTWaJJkxvKiI6zIFJeUqEmXCuI
         QYfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Cd3I4nxTi4iZyuBHaK8Ml4Votp5JHPp/UOKZwnG/o1k=;
        b=RaxczUEi2ebwXlFR0A87uiI7j3SNGn2BZ21iaLT19CGs2s3b/ZsZk+VzlRHytwojq7
         17g15Idgt9GSoOXyatZZbuK5OhJpyQCWGNu/jDJvBUDxUI6zoNitvJ4UZH7rJcVP0Cez
         jVa8MZDOuzz5FPSpEk9uKYB/ctlo1mDxjbONc20YFvkmzuHRLkOMOngWiSp9qwUxWh2i
         6qi9nTZ4IdxBLgGBwA1rYENHdE+igfST4Fx71aFPsNeIf3UuJqSq8Wupl3ZS3ulLMFbh
         D5ZwMYeW14sr2i3D9mFdRzDbpX5s8qMVSKiyQxN5ZZH87BIj9yyumj7KyMWhV9twuwTQ
         MjAw==
X-Gm-Message-State: AIkVDXIKDkwmPRr/LQX+xLkuQRLkgH0XNEwf3CdAWoQ+3rI3IEXRHeMQuUHamIUr9JwNAKTChOyMQavI9ibNAksu
X-Received: by 10.200.53.249 with SMTP id l54mr5798451qtb.173.1481931263205;
 Fri, 16 Dec 2016 15:34:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.39.115 with HTTP; Fri, 16 Dec 2016 15:34:22 -0800 (PST)
In-Reply-To: <xmqqpokru6yg.fsf@gitster.mtv.corp.google.com>
References: <20161216164751.GA12174@inner.h.apk.li> <xmqqpokru6yg.fsf@gitster.mtv.corp.google.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Fri, 16 Dec 2016 15:34:22 -0800
Message-ID: <CAGyf7-EvbV4XWCsfLpCUDo5V4_wM3SSJcHxVh9Rp78JUC6S-yw@mail.gmail.com>
Subject: Re: Races on ref .lock files?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Andreas Krey <a.krey@gmx.de>, Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas,

Bitbucket Server developer here. Typically these errors on your client
are indicative of git gc --auto being triggered by git-receive-pack on
the server. Auto GC directly attached to a push in a repository with
pull requests often fails due to concurrent ref updates linked to
background pull request processing.

If you'd like to investigate more in depth, I'd encourage you to
create a ticket on support.atlassian.com so we can work with you.
Otherwise, if you just want to prevent seeing these messages, you can
either fork the relevant repository in Bitbucket Server (which
disables auto GC), or run "git config gc.auto 0" in
/opt/apps/.../repositories/68. Once auto GC is disabled, Bitbucket
Server will automatically take over managing GC for the repository
without any additional configuration required.

Note that we're working on revamping our GC handling such that auto GC
will always be disabled for all repositories and managed explicitly
within Bitbucket Server instead, so a future upgrade should
automatically prevent these messages from appearing on clients.

Best regards,
Bryan Turner

On Fri, Dec 16, 2016 at 9:20 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Andreas Krey <a.krey@gmx.de> writes:
>
>> We're occasionally seeing a lot of
>>
>>   error: cannot lock ref 'stash-refs/pull-requests/18978/to': Unable to create '/opt/apps/..../repositories/68/stash-refs/pull-requests/18978/to.lock': File exists.
>>
>> from the server side with fetches as well as pushes. (Bitbucket server.)
>>
>> What I find strange is that neither the fetches nor the pushes even
>> touch these refs (but the bitbucket triggers underneath might).
>>
>> But my question is whether there are race conditions that can cause
>> such messages in regular operation - they continue with 'If no other git
>> process is currently running, this probably means a git process crashed
>> in this repository earlier.' which indicates some level of anticipation.
>
> I think (and I think you also think) these messages come from the
> Bitbucket side, not your "git push" (or "git fetch").  Not having
> seen Bitbucket's sources, I can only guess, but assuming that its
> pull-request is triggered from their Web frontend like GitHub's
> does, it is quite possible when you try to "push" into (or "fetch"
> from, for that matter) a repository, somebody is clicking a button
> to create that ref.  We do not know what their "receive-pack" that
> responds to your "git push" (or "upload-pack" for "git fetch") does
> when there are locked refs.  I'd naively think that unless you are
> pushing to that ref you showed an error message for, the receiving
> end shouldn't care if the ref is being written by somebody else, but
> who knows ;-) They may have their own reasons wanting to lock that
> ref that we think would be irrelevant for the operation, causing
> errors.
>
>
>
