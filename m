Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEDEC433B4
	for <git@archiver.kernel.org>; Mon, 10 May 2021 07:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AACD613B6
	for <git@archiver.kernel.org>; Mon, 10 May 2021 07:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhEJHvZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 03:51:25 -0400
Received: from smtp516.hk.chengmail.me ([113.10.190.199]:50761 "EHLO
        smtp516.hk.chengmail.me" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbhEJHvX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 03:51:23 -0400
X-CHENGMAILHOST: 113.10.190.199
X-CHENGMAIL-INSTANCEID: 1604.6098e5af.10bf7.0
Date:   Mon, 10 May 2021 15:50:08 +0800
From:   "lilinchao@oschina.cn" <lilinchao@oschina.cn>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>,
        git <git@vger.kernel.org>,
        "Derrick Stolee" <dstolee@microsoft.com>,
        "Eric Sunshine" <sunshine@sunshineco.com>
Subject: Re: Re: [PATCH] maintenance: fix two memory leaks
References: <20210509221613.474887-1-lenaic@lhuard.fr>, 
        <67ed4ca6b15a11eba8d80024e87935e7@oschina.cn>, 
        <0c04f7c2b15f11eb82baa4badb2c2b1178978@pobox.com>
X-Priority: 3
X-GUID: E88EC19E-489F-4087-8294-4F72D3628FDA
X-Has-Attach: no
X-Mailer: Foxmail 7.2.19.158[cn]
Mime-Version: 1.0
X-source-message-id: <2021051015480370480524@oschina.cn>
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <5abbc3beb16411eba07a0024e87935e7@oschina.cn>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiJsaWxpbmNoYW9Ab3NjaGluYS5jbiIgPGxpbGluY2hhb0Bvc2NoaW5hLmNuPiB3cml0ZXM6Cj4K
Pj4+QEAgLTE5OTksNiArMjAwMCw3IEBAIHN0YXRpYyBpbnQgdXBkYXRlX2JhY2tncm91bmRfc2No
ZWR1bGUoaW50IGVuYWJsZSkKPj4+IGRpZSgidW5rbm93biBiYWNrZ3JvdW5kIHNjaGVkdWxlcjog
JXMiLCBzY2hlZHVsZXIpOwo+Pj4KPj4+IHJvbGxiYWNrX2xvY2tfZmlsZSgmbGspOwo+Pj4rCWZy
ZWUobG9ja19wYXRoKTsKPj4gQmFzZWQgb24geW91ciBjaGFuZ2UsIEkgdGhpbmsgd2hlbiAiaG9s
ZF9sb2NrX2ZpbGVfZm9yX3VwZGF0ZSgpPDAiLCB3ZSBzaG91bGQgYWxzbyBmcmVlIGxvY2FsX3Bh
dGgKPj4gVGhhbmtzCj4KPk1lYW5pbmcgc29tZXRoaW5nIGxpa2UgdGhpcz8KPgo+Cj4gYnVpbHRp
bi9nYy5jIHwgOSArKysrKysrLS0KPiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAy
IGRlbGV0aW9ucygtKQo+Cj5kaWZmIC0tZ2l0IGMvYnVpbHRpbi9nYy5jIHcvYnVpbHRpbi9nYy5j
Cj5pbmRleCA5OGE4MDMxOTZiLi41MDU2NWMzN2M3IDEwMDY0NAo+LS0tIGMvYnVpbHRpbi9nYy5j
Cj4rKysgdy9idWlsdGluL2djLmMKPkBAIC0xOTcxLDggKzE5NzEsMTAgQEAgc3RhdGljIGludCB1
cGRhdGVfYmFja2dyb3VuZF9zY2hlZHVsZShpbnQgZW5hYmxlKQo+IGNtZCA9IHNlcCArIDE7Cj4g
fQo+Cj4tCWlmIChob2xkX2xvY2tfZmlsZV9mb3JfdXBkYXRlKCZsaywgbG9ja19wYXRoLCBMT0NL
X05PX0RFUkVGKSA8IDApCj4tCXJldHVybiBlcnJvcihfKCJhbm90aGVyIHByb2Nlc3MgaXMgc2No
ZWR1bGluZyBiYWNrZ3JvdW5kIG1haW50ZW5hbmNlIikpOwo+KwlpZiAoaG9sZF9sb2NrX2ZpbGVf
Zm9yX3VwZGF0ZSgmbGssIGxvY2tfcGF0aCwgTE9DS19OT19ERVJFRikgPCAwKSB7Cj4rCXJlc3Vs
dCA9IGVycm9yKF8oImFub3RoZXIgcHJvY2VzcyBpcyBzY2hlZHVsaW5nIGJhY2tncm91bmQgbWFp
bnRlbmFuY2UiKSk7Cj4rCWdvdG8gY2xlYW51cDsKPisJfQo+Cj4gaWYgKCFzdHJjbXAoc2NoZWR1
bGVyLCAibGF1bmNoY3RsIikpCj4gcmVzdWx0ID0gbGF1bmNoY3RsX3VwZGF0ZV9zY2hlZHVsZShl
bmFibGUsIGdldF9sb2NrX2ZpbGVfZmQoJmxrKSwgY21kKTsKPkBAIC0xOTg0LDYgKzE5ODYsOSBA
QCBzdGF0aWMgaW50IHVwZGF0ZV9iYWNrZ3JvdW5kX3NjaGVkdWxlKGludCBlbmFibGUpCj4gZGll
KCJ1bmtub3duIGJhY2tncm91bmQgc2NoZWR1bGVyOiAlcyIsIHNjaGVkdWxlcik7Cj4KPiByb2xs
YmFja19sb2NrX2ZpbGUoJmxrKTsKPisKPitjbGVhbnVwOgo+KwlmcmVlKGxvY2tfcGF0aCk7Cj4g
ZnJlZSh0ZXN0aW5nKTsKPiByZXR1cm4gcmVzdWx0Owo+IH0KClllcywgaXQncyBhbG1vc3QgbGlr
ZSB0aGlzLCBhbmQgeW91ciBpcyBiZXR0ZXIgdGhhbiBJIHRob3VnaHQuCkkganVzdCByZWZlcnJl
ZCB0byB0aGlzIGZ1bmN0aW9uKEwxMjY2LUwxMzIxKTogCgpzdGF0aWMgaW50IG1haW50ZW5hbmNl
X3J1bl90YXNrcyhzdHJ1Y3QgbWFpbnRlbmFuY2VfcnVuX29wdHMgKm9wdHMpCnsKwqAgwqAgwqAg
wqAgLi4uCgppZiAoaG9sZF9sb2NrX2ZpbGVfZm9yX3VwZGF0ZSgmbGssIGxvY2tfcGF0aCwgTE9D
S19OT19ERVJFRikgPCAwKSB7CsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC4uLgoKZnJlZShsb2Nr
X3BhdGgpOwpyZXR1cm4gMDsKfQpmcmVlKGxvY2tfcGF0aCk7CgrCoCDCoCDCoCDCoCAuLi4KwqAg
wqAgwqAgwqAgLi4uCgpyb2xsYmFja19sb2NrX2ZpbGUoJmxrKTsKcmV0dXJuIHJlc3VsdDsKfSAK
CmFuZCB0aG91Z2h0IHdlIHNob3VsZCBhbHNvIGFwcGx5IGl0IHRvICJ1cGRhdGVfYmFja2dyb3Vu
ZF9zY2hlZHVsZSgpIi4KCgo=

