Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_05,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20920C4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 14:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F41E161AFA
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 14:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236622AbhG0Oed (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 10:34:33 -0400
Received: from smtp509.hk.chengmail.me ([113.10.190.110]:41650 "EHLO
        smtp509.hk.chengmail.me" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbhG0Oec (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 10:34:32 -0400
X-Greylist: delayed 1602 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Jul 2021 10:34:31 EDT
X-CHENGMAILHOST: 113.10.190.110
X-CHENGMAIL-INSTANCEID: 24da.61001323.f14a8.0
Date:   Tue, 27 Jul 2021 22:07:32 +0800
From:   "lilinchao@oschina.cn" <lilinchao@oschina.cn>
To:     git <git@vger.kernel.org>
Cc:     "jerry@skydio.com" <jerry@skydio.com>,
        "Junio C Hamano" <gitster@pobox.com>
Subject: git apply --3way behaves abnormally when the patch contains binary
        changes.
X-Priority: 3
X-GUID: BD0F2703-70FB-4794-9360-7904288D37A1
X-Has-Attach: no
X-Mailer: Foxmail 7.2.19.158[cn]
Mime-Version: 1.0
X-source-message-id: <2021072722063161919517@oschina.cn>
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Message-ID: <fdfd283aeee311ebbfb50024e87935e7@oschina.cn>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SSBzZWUgdGhlIGxhdGVzdCBjaGFuZ2UgYWJvdXQgYGdpdCBhcHBseSAtLTN3YXlgIGlzIDkyM2Nk
ODcsIGJ1dCBpdCBkb2Vzbid0IHNlZW0gdG8gaGF2ZSBiZWVuIGZ1bGx5IHRlc3RlZAooaW4gdDQx
MDgtYXBwbHktdGhyZWV3YXkuc2gpLgpPbiBsYXRlc3QgR2l0IHZlcnNpb24gMi4zMi4wLCBjb25z
aWRlciB0ZXN0IGNhc2UgYmVsb3c6CiIKdGVzdF9leHBlY3Rfc3VjY2VzcyAnYXBwbHkgYmluYXJ5
IGZpbGUgcGF0Y2ggd2l0aCAtLTN3YXknICcKwqAgwqAgwqAgwqAgIyAxLiBvbiBuZXcgYnJhbmNo
LCBjb21taXQgYmluYXJ5IGZpbGXCoArCoCDCoCDCoCDCoCBnaXQgY2hlY2tvdXQgLWIgbGVmdCAm
JgrCoCDCoCDCoCDCoCBjYXQgIiRURVNUX0RJUkVDVE9SWSIvdGVzdC1iaW5hcnktMS5wbmcgPmJp
bi5wbmcgJiYKwqAgwqAgwqAgwqAgZ2l0IGFkZCBiaW4ucG5nICYmCsKgIMKgIMKgIMKgIGdpdCBj
b21taXQgLW0gImFkZCBiaW5hcnkgZmlsZSIgJiYKCsKgIMKgIMKgIMKgICMgMi4gYmFzZWQgb24g
bGVmdF9iaW4gYnJhbmNoLCBtYWtlIGFueSBjaGFuZ2UsIGFuZCBjb21taXQKwqAgwqAgwqAgwqAg
Z2l0IGNoZWNrb3V0IC1iIHJpZ2h0ICYmCsKgIMKgIMKgIMKgIGNhdCBiaW4ucG5nIGJpbi5wbmcg
PiBiaW4ucG5nICYmCsKgIMKgIMKgIMKgIGdpdCBhZGQgYmluLnBuZyAmJgrCoCDCoCDCoCDCoCBn
aXQgY29tbWl0IC1tICJ1cGRhdGUgYmluYXJ5IGZpbGUiICYmCgrCoCDCoCDCoCDCoCAjIDMuIG1h
a2UgcGF0Y2gKwqAgwqAgwqAgwqAgZ2l0IGRpZmYgLS1iaW5hcnkgbGVmdC4ucmlnaHQgPmJpbi5k
aWZmICYmCsKgIMKgIMKgIMKgICMgYXBwbHkgLS0zd2F5LCBhbmQgaXQgd2lsbCBmYWlsCsKgIMKg
IMKgIMKgIHRlc3RfbXVzdF9mYWlsIGdpdCBhcHBseSAtLWluZGV4IC0tM3dheSBiaW4uZGlmZgon
CiIKCkJ1dCDCoCJnaXQgYXBwbHkgLS1pbmRleCAtLTN3YXkgYmluLmRpZmYiIHdpbGwgbm90IGZh
aWxsIG9uIEdpdCB2ZXJzaW9uIDIuMzEuMC4KCgo=

