Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11AF220954
	for <e@80x24.org>; Sat, 25 Nov 2017 21:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751837AbdKYVra (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Nov 2017 16:47:30 -0500
Received: from p3plsmtpa11-07.prod.phx3.secureserver.net ([68.178.252.108]:47432
        "EHLO p3plsmtpa11-07.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751753AbdKYVr3 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2017 16:47:29 -0500
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with SMTP
        id IiIDesEIC96oiIiIIetiB4; Sat, 25 Nov 2017 14:47:29 -0700
Date:   Sat, 25 Nov 2017 23:47:21 +0200
From:   Max Kirillov <max@max630.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Max Kirillov <max@max630.net>, Jeff King <peff@peff.net>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>,
        Chris Packham <judge.packham@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] http-backend: respect CONTENT_LENGTH as specified by
 rfc3875
Message-ID: <20171125214721.GA26158@jessie.local>
References: <20160401235532.GA27941@sigill.intra.peff.net>
 <20171123234511.574-1-max@max630.net>
 <CAPig+cQEaqaOTcC=5pZZmZNs_QQQ0vBRbzczyM3ZXXi+ZHW4XA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cQEaqaOTcC=5pZZmZNs_QQQ0vBRbzczyM3ZXXi+ZHW4XA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CMAE-Envelope: MS4wfGheR/aSP1shG6BBN9izdzi7QFBqhiwVqn0h79LSYQAtPY1+iV6DjWnHseYyyWaDSev2zJOYDZXTvepm7MMJGXCl3b61vwf00/sJIxgLxZDGoO1U80FY
 eMKsMcmTlHGh8JMHe2UYqqyY4mILzdjxJnjwuAm2aeaTVw62OyRyIRqOhHicrCFibQ6nEIbleWMheyvxNeNs6Znu3L6UgKlgoVHZRwZxEOkoCtwfnowrpdvm
 sffkcTXX5h4jmWbTYzqKmOp38GSkzsekU0pvMFFrpT4kvTId8cIgQEax5a0E/G6SK5eXm1cPQw4F/fkUJpwCercMKbWZsu/nTRLrWa5ILpCnr7UQ7tTlo271
 nHtVjMDm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the review. I saw only reaction of the Jeff in
the original thread and though that it is ok otherwise. I'm
fixing the things you mentioned.

On Thu, Nov 23, 2017 at 08:30:39PM -0500, Eric Sunshine wrote:
>> +static ssize_t read_request_fix_len(int fd, size_t req_len, unsigned char **out)
> 
> Wrong data type: s/size_t req_len/ssize_t req_len/

Passing negative value to the function makes no sense. I
could add explicit type cast to make it clear. It should be
safe as site_t's range is bigger, and overflown
CONTENT_LENGTH results in die() at parsing (I have a test
which verifies it)

> Rather than writing an entirely new "read" function, how about just
> modifying the existing read_request() to optionally limit the read to
> a specified number of bytes?

I'll check it a bit separately.

-- 
Max
