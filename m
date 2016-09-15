Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97F8A2070F
	for <e@80x24.org>; Thu, 15 Sep 2016 15:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753047AbcIOPmb (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 11:42:31 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:47714 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751125AbcIOPm3 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 15 Sep 2016 11:42:29 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 81D5D2054C;
        Thu, 15 Sep 2016 11:42:28 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute3.internal (MEProxy); Thu, 15 Sep 2016 11:42:28 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=jonathonmah.com;
         h=cc:content-transfer-encoding:content-type:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-sasl-enc:x-sasl-enc; s=mesmtp; bh=YeE84AbHa+ejwLx7HY0JY8BnK9g
        =; b=TK5H2PJyQR1ck3zwbx1R3u3w5kz9vzdqBCMa1JHrzYgUOe1iu7hF/6SyDyD
        XtRRevNWZiFbW++4CFFQlfwcfY/EOMPQDWdTlc5eoSb20ixBV55Ha18b+xclXhGt
        Xl/6rNF7yYZa49hmA1oDkxAPfMANbcFv3MzXOUzEo5AOfUfY=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=YeE84AbHa+ejwLx
        7HY0JY8BnK9g=; b=geCH6XEFxrL83FP5u2kjUKZBoyp3+kJkdi42hX9A7yTSVoB
        +uWU1HPkE5B7UjXN4+7aOfNlQS95XgpQXuNc75N9XaRwq+I05sIYM1r4w98Jfqjz
        D5Y9K4IHcO9/3zPLUf/GoYluZEdh3/SYDeyq7znfa4b3l98SOHV9lFyytj28=
X-Sasl-enc: 6KPzte8dAnyCY0jwt/5k6Ddk17AYqLl/kTkWVt/C6MRs 1473954148
Received: from [192.168.120.105] (c-76-126-140-87.hsd1.ca.comcast.net [76.126.140.87])
        by mail.messagingengine.com (Postfix) with ESMTPA id 084D1CCE9A;
        Thu, 15 Sep 2016 11:42:27 -0400 (EDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.1 \(3243\))
Subject: Re: Tracking down a segfault in delta_base_cache
From:   Jonathon Mah <me@jonathonmah.com>
In-Reply-To: <20160915005640.3ui4qfmiqjz2lsov@sigill.intra.peff.net>
Date:   Thu, 15 Sep 2016 08:42:26 -0700
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6FA0A47C-61CB-4602-8629-46448E582292@jonathonmah.com>
References: <3946EE74-219D-4E9C-9CED-69D53B940955@jonathonmah.com>
 <20160915005640.3ui4qfmiqjz2lsov@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3243)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 2016-09-14, at 17:56, Jeff King <peff@peff.net> wrote:
>=20
> On Wed, Sep 14, 2016 at 05:42:29PM -0700, Jonathon Mah wrote:
>=20
>> Hi git, I've been seeing git segfault over the past few days. I'm on =
Mac OS X 10.12, 64-bit, compiling with clang (Apple LLVM version 8.0.0 =
(clang-800.0.40)).
>> [...]
>> Bisect says:
>>=20
>> 8261e1f139db3f8aa6f9fd7d98c876cbeb0f927c is the first bad commit
>> commit 8261e1f139db3f8aa6f9fd7d98c876cbeb0f927c
>> Author: Jeff King <peff@peff.net>
>> Date:   Mon Aug 22 18:00:07 2016 -0400
>>=20
>>    delta_base_cache: use hashmap.h
>=20
> Have you tried with the patch in:
>=20
>  =
http://public-inbox.org/git/20160912164616.vg33kldazuthff3d@sigill.intra.p=
eff.net/
>=20
> ?

All the examples I've tried work when I use that. Thanks!

>> $ lldb /Users/jmah/Documents/Streams/git/git-log -- -u
>> (lldb) target create "/Users/jmah/Documents/Streams/git/git-log"
>> Current executable set to '/Users/jmah/Documents/Streams/git/git-log' =
(x86_64).
>> (lldb) settings set -- target.run-args  "-u"
>> (lldb) process launch -o /dev/null
>> Process 92815 launched: '/Users/jmah/Documents/Streams/git/git-log' =
(x86_64)
>> Process 92815 stopped
>> * thread #1: tid =3D 0x1c30677, 0x00000001001bba80 =
git-log`release_delta_base_cache(ent=3D0xffffffffffffffd0) + 16 at =
sha1_file.c:2171, queue =3D 'com.apple.main-thread', stop reason =3D =
EXC_BAD_ACCESS (code=3D1, address=3D0x10)
>>    frame #0: 0x00000001001bba80 =
git-log`release_delta_base_cache(ent=3D0xffffffffffffffd0) + 16 at =
sha1_file.c:2171
>>   2168=09
>>   2169	static inline void release_delta_base_cache(struct =
delta_base_cache_entry *ent)
>>   2170	{
>> -> 2171		free(ent->data);
>>   2172		detach_delta_base_cache_entry(ent);
>=20
> The problems I saw with valgrind weren't here, but would explain this.
> We free() the previous node, then walk forward from its "next" =
pointer.
> On my Linux box, that happens to work, but we could be feeding total
> junk to the list pointer, which would meant ent->data is junk, and
> free() notices.
>=20
> -Peff

