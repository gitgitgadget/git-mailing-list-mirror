Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A01C1F453
	for <e@80x24.org>; Thu, 31 Jan 2019 07:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfAaHVJ convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 31 Jan 2019 02:21:09 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42292 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbfAaHVI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 02:21:08 -0500
Received: by mail-qt1-f196.google.com with SMTP id d19so2412990qtq.9
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 23:21:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+EO4axyVglqb4e0IeQbUEoGxts7dbLXHzKOHPQXW50g=;
        b=YKwSjsOzLDsDbIyZXID6q8P4UdqyKzwZG4ijcQFguzwpulu8EZBPbkyiPZlbs52A0T
         Z8ZfugJnKAmncBKxfrfZuH5BW6kqFQoH+IPIGDsIXt/dJ55hxZdmw0J4giR6wQ5bG922
         4tPzl2bK1kyLs0EbhZdz0d8coCF/OjlNf7lshNOr94Bs17cUAyM/sOKp20Bl8aM30by+
         mUg34iot69WXBHCXWuBkIKlvBUIEYCa2quHn1QAF9QYXVE0aNjxYTCj1ThLGnYW8KBBW
         CD7l3y0sXHS/QxtCEDU1xIIo3uw+1a+pmKI4lchU9gBEfr8f5cVhQSp2yJ5DGWmPY4vH
         nf2A==
X-Gm-Message-State: AJcUukfXP3rx4t9vq1A1NIHYZrq3PKRtsGMNR43QoYlDH6yrrU20cB6r
        0eVeTEwMccDsKILc/7hOXvNjcmWVIOphtm25hSo=
X-Google-Smtp-Source: ALg8bN6u3jV6fIqJfH6/XD9YNZ6ysgLzktYD4VlICEwP2nSumVtYzhFWydeAMoJAPIGeC1+wETTYVCqtBglaZpLUnPY=
X-Received: by 2002:a0c:9359:: with SMTP id e25mr31506259qve.203.1548919267864;
 Wed, 30 Jan 2019 23:21:07 -0800 (PST)
MIME-Version: 1.0
References: <20190130094831.10420-1-pclouds@gmail.com> <20190130094831.10420-9-pclouds@gmail.com>
 <CAPig+cQ3L4NcMojWYV3spazJNzEa6yhBJQ0wwbwcLSzG3Vmzjw@mail.gmail.com>
 <CACsJy8BKxf6Q1Q-u92enPgw6a18XhAOvYSewZs-G+tB+-MSkNw@mail.gmail.com> <CAPig+cS4Dmgh+hCMXp8ND5DMy6QFVCJOgvDwpcbwZ0HV4MscpA@mail.gmail.com>
In-Reply-To: <CAPig+cS4Dmgh+hCMXp8ND5DMy6QFVCJOgvDwpcbwZ0HV4MscpA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 31 Jan 2019 02:20:56 -0500
Message-ID: <CAPig+cR1bpNE3LUB1jOhDsCJA8FqF9kkTUmSrKFPOW6d6hpBPw@mail.gmail.com>
Subject: Re: [PATCH 08/19] checkout: split part of it to new command switch
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 31, 2019 at 1:24 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Thu, Jan 31, 2019 at 12:29 AM Duy Nguyen <pclouds@gmail.com> wrote:
> > On Thu, Jan 31, 2019 at 7:50 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > > On Wed, Jan 30, 2019 at 4:49 AM Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
> > > > +'git switch' [<options>] [--guess] <branch>
> > > > +'git switch' [<options>] --detach [<start_point>>]
> > > > +'git switch' [<options>] [[-c|-C|--orphan] <new_branch>] [<start_point>]
> > >
> > > What does the third form mean when all optional arguments (that is,
> > > _all_ arguments) are omitted?
> >
> > "git switch" is smart (or too dumb to be clever):
> >
> > $ git switch
> > fatal: nothing to do
>
> But does it need to be this way? Does it make a good user-experience?
> I, personally, find it confusing to see that it can accept no
> arguments. An alternative, perhaps more consistent with UX elsewhere:
>
>     $ git switch
>     fatal: missing branch argument
>
> or something.

Let me clarify by saying that I don't understand why the third form is
documented as validly accepting no arguments given that a no-argument
invocation is an error. That is, I would expect the third form of the
synopsis to say:

    'git switch' [<options>] (-c|-C|--orphan) <new_branch> [<start_point>]
