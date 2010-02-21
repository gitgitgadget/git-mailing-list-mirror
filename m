Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=0.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: (qmail 13244 invoked by uid 107); 21 Feb 2010 15:23:58 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.180.67)
    by peff.net (qpsmtpd/0.40) with ESMTP; Sun, 21 Feb 2010 10:23:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752470Ab0BUPXi (ORCPT <rfc822;peff@peff.net>);
	Sun, 21 Feb 2010 10:23:38 -0500
Received: from mail-iw0-f177.google.com ([209.85.223.177]:50486 "EHLO
	mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752416Ab0BUPXa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Feb 2010 10:23:30 -0500
Received: by mail-iw0-f177.google.com with SMTP id 7so1601473iwn.4
        for <git@vger.kernel.org>; Sun, 21 Feb 2010 07:23:30 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=wjKf3SQY476n47lPZVrmJ9jUFqbONFjitOg69r8/GhU=;
        b=tv2vZbtIpXz/WoBawH3gpTqMqwIczFXcIwz9c1lYV2hDtOpCajqmj0ksav2k11xJM1
         T0JdXwqhlr1D+yKVOxdJ965kfR9YrQbQJdtbY4Y+oT1QbyPbYxJJrdYJSrduDBbxjErA
         5nEPZNPThygG209OCjPl8jEptYHmuXYWSsiTY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=EtW283ZhgSYUmbTFfpvpQj/k5RngsFBSwW1TbpI3nPUoNnYbwkfHLInH8TuJ1qFKK5
         KLFkabj1YZhTZVd4aDoHdw8pdgQOfabLsD2d2rIYkxFV59OC4sh/KXpEDbvjrfmhuF7l
         bYmLDKw7QlTnljfg4LPhWirr9yd9ai396vk9Q=
MIME-Version: 1.0
Received: by 10.231.168.133 with SMTP id u5mr3110508iby.29.1266765810102; Sun, 
	21 Feb 2010 07:23:30 -0800 (PST)
In-Reply-To: <20100221105707.GA22534@localhost>
References: <1266721708-1060-1-git-send-email-rctay89@gmail.com>
	 <1266721708-1060-6-git-send-email-rctay89@gmail.com>
	 <20100221103820.GA5166@localhost> <20100221105707.GA22534@localhost>
Date:	Sun, 21 Feb 2010 23:23:30 +0800
Message-ID: <be6fef0d1002210723j742c0d8ex86b9d552f924408f@mail.gmail.com>
Subject: Re: [PATCH 5/7] http: init and cleanup separately from http-walker
From:	Tay Ray Chuan <rctay89@gmail.com>
To:	Clemens Buchacher <drizzd@aon.at>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Mike Hommey <mh@glandium.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi,

On Sun, Feb 21, 2010 at 6:57 PM, Clemens Buchacher <drizzd@aon.at> wrote:
> On Sun, Feb 21, 2010 at 11:38:20AM +0100, Clemens Buchacher wrote:
>> On Sun, Feb 21, 2010 at 11:08:26AM +0800, Tay Ray Chuan wrote:
>> > diff --git a/http-fetch.c b/http-fetch.c
>> [...]
>>
>>         add_fill_function(walker, (int (*)(void *)) fill_active_slot);
>>
>> already deals with curl functionality. So even though I think it technically
>> doesn't break, I would prefer if this dependency were still expressed in the
>> code.
>>
>> > @@ -88,6 +90,7 @@ int main(int argc, const char **argv)
>> >  "status code.  Suggest running 'git fsck'.\n");
>> >     }
>> >
>> > +   http_cleanup();
>> >     walker_free(walker);
>> >
>> >     free(rewritten_url);
>>
>> Same as above.
>
> But I think this is still valid.

regarding the order of invocation - I could put http_cleanup() after
walker_free().

Perhaps I can express this dependency with a comment in that area in
http-fetch.c and/or http-walker::cleanup()?

  Don't invoke http_cleanup() yet, we might still need to perform http
operations in http-walker.

(Separately, on re-reading the code, I noticed that
http-walker::cleanup() calls http_cleanup() again, so I dropped that
invocation from http-walker.)

-- 
Cheers,
Ray Chuan
