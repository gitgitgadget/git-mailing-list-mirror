Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DF221F516
	for <e@80x24.org>; Mon,  2 Jul 2018 00:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752739AbeGBAR5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Jul 2018 20:17:57 -0400
Received: from mail.cmpwn.com ([45.56.77.53]:53770 "EHLO mail.cmpwn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752625AbeGBAR4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jul 2018 20:17:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cmpwn.com; s=cmpwn;
        t=1530490863; bh=XO/8jwyzuGcnFphXVLKACJMhTNjJEbnC6CvdvoTSUKQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=2HxL3rwZOneyT/GoU8f05qAjKLlPQXXJzA27WYZc2Cj5GiLxcvrj7xUch4bmA9HoH
         3ki0f3m3EWc/z4gG76lG7KaOdiF4N/jQeWeD5EdCzfRhulqlaoExq52eH+g3ck3t6P
         kHZYYLnLK6ge8HQ+9vPZI8HFyIU3ERtDdikrCLEo=
Date:   Sun, 1 Jul 2018 20:17:53 -0400
From:   Drew DeVault <sir@cmpwn.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, contact@emersion.fr
Subject: Re: send-email: change the default value of sendmail.validate
Message-ID: <20180702001753.GA30086@homura.localdomain>
References: <20180629190751.GA2559@miku>
 <20180701181546.GD7965@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180701181546.GD7965@genre.crustytoothpaste.net>
X-GNU:  Terry Pratchett
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-07-01  6:15 PM, brian m. carlson wrote:
> Can you say a bit more about the exact error message you're seeing?

"patch contains a line longer than 998 characters"

A recent occasion when this came up was when someone attempted to send
me a patch which included a base64-encoded data URI, which cannot be
wrapped.

> Are you suggesting that we not limit lines to 998 octets?  I've seen
> lots of mail servers that do reject mail over 998 octets.  I've
> configured Postfix to do so because being strict on mail standards is a
> great way to stop spam.

Yes, that's what I'm suggesting. We should error out later when the SMTP
server rejects the mail.

Also, Extended SMTP is a standard. RFC 1869.

> If that's the issue you're seeing, it might be better to either
> automatically encode those patches as binary patches or teach git
> send-email and git am how to automatically handle quoted-printable.

I'm really not fond of quoted-printable. Extended SMTP has been
standardized for over 20 years. Assuming people don't blithly disable it
on their servers, we can expect it to be present on almost all mail
servers.

I don't think I've ever seen a spam email that would have been stopped
because it contained 998 lines. Approaches like SpamAssassin,
greylisting, DNSBLs, SPF/DKIM, these are much more effective.
