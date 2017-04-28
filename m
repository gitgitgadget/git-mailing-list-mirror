Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD370207D6
	for <e@80x24.org>; Fri, 28 Apr 2017 00:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939453AbdD1APa (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 20:15:30 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36701 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754271AbdD1AP3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 20:15:29 -0400
Received: by mail-pg0-f66.google.com with SMTP id v1so2665822pgv.3
        for <git@vger.kernel.org>; Thu, 27 Apr 2017 17:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=wjwYBfjN7FCkT5TCWpzCA6g3NBN4Wqs7jdFeXZFVbzw=;
        b=dud22xumgKpPDGJyXoaHdchr+hQWgwwJxK4BqLu3svZL1JWiDXx1hJqK0hrw/lQlgs
         RKw+Jf+XoAyvl2d9IgOx5ci3AakafqkpEMXHStJ2Tk/HwdQPNDcTkaY6N+yieYSie49v
         MTuUYy8c5ifJlq/7SgDmgRgKTt5rXNNK47wByEGhgCW2hzL5WUBNywcFrHA6Vg8onwd4
         2LlmWhHI/BKfdRN2uryhhQ7y4gCY+oz4iMGgQiMYohitFDM3B+YzpduedwLinSO+KB9b
         CMGJYGyA/OuvcVO+WoodaMOoW+R1p44tSDiPsYFaWYhzF/hrHSOQXbNMiU1EPvEjnSN3
         T2Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=wjwYBfjN7FCkT5TCWpzCA6g3NBN4Wqs7jdFeXZFVbzw=;
        b=pHezQFZ7Ipv62Nh8pklTJ7yOblJwLh2kgJbXVSdcy2/lqzL1LHCbZrX0WVzOx6fnDl
         3ly2GkHfl5OHrklqwG/8Qx60zBcUtfYWvZVTkoy77zCWagsjKsoPgf+y2lGwnUotmD2A
         HXzsZeTlRDh2Y/DUKRfgtFTWZ1FFsQ6AMIkHygLXiqD6ymvJeqNhWXmZOJDkNgiBDYCH
         GkS9qvCoKaipIx1p416MPCM1qonOGNJBLprtSjCcGdF42kZy+PjsAaGn6G4h/Sz906Au
         owaVhMc+OrOneyavDH7/iRD059G1uMkVvr4Tgd+28bVixeXuGo5aUwgobCCbnjfhNNOL
         mcAA==
X-Gm-Message-State: AN3rC/7RM9h+0xS+2tCzU9TOlkk25wQ0D4vo1e1gCyhGrdefE/7GNwZE
        /0YKuPar50PA6Q==
X-Received: by 10.98.20.210 with SMTP id 201mr8854866pfu.70.1493338528774;
        Thu, 27 Apr 2017 17:15:28 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:51c2:e137:8e5a:b68b])
        by smtp.gmail.com with ESMTPSA id 29sm6327596pfo.9.2017.04.27.17.15.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 27 Apr 2017 17:15:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 4/9] rebase -i: also expand/collapse the SHA-1s via the rebase--helper
References: <cover.1493128210.git.johannes.schindelin@gmx.de>
        <cover.1493207864.git.johannes.schindelin@gmx.de>
        <df5263cc0cad5cffbd1932d4b9b8e5c0507536e6.1493207864.git.johannes.schindelin@gmx.de>
        <xmqqr30eo36n.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1704272331190.3480@virtualbox>
Date:   Thu, 27 Apr 2017 17:15:27 -0700
In-Reply-To: <alpine.DEB.2.20.1704272331190.3480@virtualbox> (Johannes
        Schindelin's message of "Thu, 27 Apr 2017 23:44:35 +0200 (CEST)")
Message-ID: <xmqq7f25mlpc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > +	out = fopen(todo_file, "w");
>> 
>> The usual "open lockfile, write to it and then rename" dance is not
>> necessary for the purpose of preventing other people from reading
>> this file while we are writing to it.  But if we fail inside this
>> function before we fclose(3) "out", the user will lose the todo
>> list.  It probably is not a big deal, though.
>
> I guess you're right. It is bug-for-bug equivalent to the previous shell
> function, though.

I think the scripted version uses the "write to $todo.new and mv
$todo.new to $todo" pattern so you'd at least have something to go
back to when the loopfails.
