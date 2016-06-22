Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D60B20189
	for <e@80x24.org>; Wed, 22 Jun 2016 16:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752553AbcFVQCQ (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 12:02:16 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:33369 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751726AbcFVQCP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 12:02:15 -0400
Received: by mail-io0-f195.google.com with SMTP id t74so7106800ioi.0
        for <git@vger.kernel.org>; Wed, 22 Jun 2016 09:02:14 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8hNDgWY/Vq/yqDyQa75KFYJk2Ppr+jstE6XoVknS4iI=;
        b=MTPVB3+4Ngs9KDtx/a/PAnelzxlZ8EkyQ1sSpx/0h1K0A6JIe1iHHqABUgHJbA4QFt
         BvHUsCz/EfKxMHgwA+6N+oEC7pKEA6/jJc7UIKmleMwkOJnC83OL3BkxLoZ5fteAmc11
         Xl3Ph4yFJh8eQMJs6gmrwHtwZhLBzsQPGWWazLglx++ZUNBeYG55CJElpfX3r31Ck2Uz
         TOjlGHO3BG0x6rhFeH4NOmOwMCPZaNW0Db5SAJHZciVLAPdYWJjV3u+EDUZP5Sg7Y8dy
         9p7HcE7V+jQNIuWEuhwwRAn8b7f5Dz7rUljoWI76XecujB/lqxlszs3KRF4DEmvRCyfO
         JKww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8hNDgWY/Vq/yqDyQa75KFYJk2Ppr+jstE6XoVknS4iI=;
        b=h1XltG4gINPaAwoR7DchE7+I3JqUM0vy/csK4v4VuhI2LuXBuSaeOtu4QBpys/blTs
         kzCcTPCzjGoUZRm/hZutIf38ojnytB/1Lox5fF8pIp57fJAt6lM7gRuVars314OD4QXg
         KHLGuhzUJTaovZRyQlEZLaC56SkPfblA+GoNDb5pgTGaFywEtkKlrkUuwOWc6xOys+a+
         Zne4wg7SS+xW0jGzCF7THlFkHqgsEGhZwv28lKN3RdjNuo9Ao9R5FK1y2q+rydcs14Hg
         hIgMJHqkfrnbKdcHUs3hT6QurXt6okXnygQ9uP2ot2x2BQPk9xxeCTKR2ZZGAjASrydc
         qSXg==
X-Gm-Message-State: ALyK8tJFT881CpbetmvYESr0k856nNZzsGC/TXEBG2HCJnqb6Qw2Sv33RFgNeKOUTnE1iaEeiJDBRJjVBcXqvg==
X-Received: by 10.107.22.131 with SMTP id 125mr40846365iow.128.1466611334273;
 Wed, 22 Jun 2016 09:02:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Wed, 22 Jun 2016 09:01:44 -0700 (PDT)
In-Reply-To: <CAPig+cQ4CxRo460dcTJJtV_dPH8i5HC76_gpTv8attEZ8sdMZw@mail.gmail.com>
References: <20160621211412.28752-1-charles@hashpling.org> <20160621211412.28752-2-charles@hashpling.org>
 <CAPig+cQ4CxRo460dcTJJtV_dPH8i5HC76_gpTv8attEZ8sdMZw@mail.gmail.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Wed, 22 Jun 2016 18:01:44 +0200
Message-ID: <CACsJy8Biaowr-XoaJgOCXjDGre==CzeSyADftCAdzxFHoxrZAQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] grep: fix grepping for "intent to add" files
To:	Eric Sunshine <sunshine@sunshineco.com>
Cc:	Charles Bailey <charles@hashpling.org>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jun 22, 2016 at 3:13 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, Jun 21, 2016 at 5:14 PM, Charles Bailey <charles@hashpling.org> wrote:
>> From: Charles Bailey <cbailey32@bloomberg.net>
>>
>> This reverts commit 4d552005323034c1d6311796ac1074e9a4b4b57e and adds an
>> alternative fix to maintain the -L --cached behavior.
>
> It is common to provide some context along with the (shortened) commit
> ID. For instance:
>
>     This reverts 4d55200 (grep: make it clear i-t-a entries are
>     ignored, 2015-12-27) and adds ...

And that could be produced with some git alias like

git config alias.one 'show -s --date=short --pretty='format:%h (%s - %ad)'

No point in manually copy/pasting the context.
-- 
Duy
