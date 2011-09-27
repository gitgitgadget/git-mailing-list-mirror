From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: Git is not scalable with too many refs/*
Date: Tue, 27 Sep 2011 13:10:25 +0100
Message-ID: <e44cba8038381a722e127fb47b8ddfe4@quantumfyre.co.uk>
References: <4DF6A8B6.9030301@op5.se>
 <9ae990f15489d7b51a172d08e63ca458@quantumfyre.co.uk>
 <201109261539.33437.mfick@codeaurora.org>
 <201109261552.04946.mfick@codeaurora.org>
 <ece30e6a1b74bcddde5634003408f61f@quantumfyre.co.uk>
 <CAGdFq_hvR1MPF33YFcjDCzCM0iOO2zpiiePFFS4dBabu84cwTg@mail.gmail.com>
 <22f055b34840e3c64f3339f7b3dc6920@quantumfyre.co.uk>
 <4E81AE63.8040008@alum.mit.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_74ce99a6546b2474fc2b4b072b528f18"
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Martin Fick <mfick@codeaurora.org>, <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	David Michael Barr <davidbarr@google.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Sep 27 14:10:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8WUc-0005Cr-2W
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 14:10:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753686Ab1I0MK3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Sep 2011 08:10:29 -0400
Received: from neutrino.quantumfyre.co.uk ([93.93.128.23]:60870 "EHLO
	neutrino.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753539Ab1I0MK2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Sep 2011 08:10:28 -0400
Received: from reaper.quantumfyre.co.uk (quantumfyre-1-pt.tunnel.tserv5.lon1.ipv6.he.net [IPv6:2001:470:1f08:1724::2])
	by neutrino.quantumfyre.co.uk (Postfix) with ESMTP id 78B79C060C;
	Tue, 27 Sep 2011 13:10:27 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 5879336A831;
	Tue, 27 Sep 2011 13:10:27 +0100 (BST)
X-Virus-Scanned: amavisd-new at reaper
Received: from reaper.quantumfyre.co.uk ([127.0.0.1])
	by localhost (reaper.quantumfyre.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id mQ5DSgBKLfVp; Tue, 27 Sep 2011 13:10:26 +0100 (BST)
Received: from webmail.quantumfyre.co.uk (reaper.quantumfyre.co.uk [192.168.0.2])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id CE76635F60F;
	Tue, 27 Sep 2011 13:10:25 +0100 (BST)
In-Reply-To: <4E81AE63.8040008@alum.mit.edu>
X-Sender: julian@quantumfyre.co.uk
User-Agent: Roundcube Webmail/0.5.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182236>

--=_74ce99a6546b2474fc2b4b072b528f18
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8;
 format=flowed

On Tue, 27 Sep 2011 13:07:15 +0200, Michael Haggerty wrote:
> On 09/27/2011 11:01 AM, Julian Phillips wrote:
>> It has to be hot-cache, otherwise time taken to read the refs from 
>> disk
>> will mean that it is always slow.  On my Mac it seems to _always_ be
>> slow reading the refs from disk, so even the "fast" case still takes 
>> ~17m.
>
> This case should be helped by lazy-loading of loose references, which 
> I
> am working on.  So if you develop some benchmarking code, it would 
> help
> me with my work.

The attached script creates the repo structure I was testing with ...

If you create a repo with 100k refs it takes quite a while to read the 
refs from disk.  If you are lazy-loading then it should take practically 
no time, since the only interesting ref is refs/heads/master.

The following is the hot-cache timing for "./refs-stress c 40000", with 
the sorting patch applied (wasn't prepared to wait for numbers with 100k 
refs).

jp3@rayne: refs>(cd c; time ~/misc/git/git/git branch)
* master

real    0m0.885s
user    0m0.161s
sys     0m0.722s

After doing "rm -rf c/.git/refs/changes/*", I get:

jp3@rayne: refs>(cd c; time ~/misc/git/git/git branch)
* master

real    0m0.004s
user    0m0.001s
sys     0m0.002s

-- 
Julian
--=_74ce99a6546b2474fc2b4b072b528f18
Content-Transfer-Encoding: base64
Content-Type: text/x-java;
 name=refs-stress
Content-Disposition: attachment;
 filename=refs-stress

IyEvdXNyL2Jpbi9lbnYgcHl0aG9uCgppbXBvcnQgb3MKaW1wb3J0IHJhbmRvbQppbXBvcnQgc3Vi
cHJvY2VzcwppbXBvcnQgc3lzCgpkZWYgZGllKG1zZyk6CiAgICBwcmludCA+PiBzeXMuc3RkZXJy
LCBtc2cKICAgIHN5cy5leGl0KDEpCgpkZWYgbmV3X3JlZihhLCBiLCBjb21taXQpOgogICAgZCA9
ICIuZ2l0L3JlZnMvY2hhbmdlcy8lZC8lZCIgJSAoYSwgYikKICAgIGlmIG5vdCBvcy5wYXRoLmV4
aXN0cyhkKToKICAgICAgICBvcy5tYWtlZGlycyhkKQogICAgZSA9IDEKICAgIHAgPSAiJXMvJWQi
ICUgKGQsIGUpCiAgICB3aGlsZSBvcy5wYXRoLmV4aXN0cyhwKToKICAgICAgICBlICs9IDEKICAg
ICAgICBwID0gIiVzLyVkIiAlIChkLCBlKQogICAgZiA9IG9wZW4ocCwgInciKQogICAgZi53cml0
ZShjb21taXQpCiAgICBmLmNsb3NlKCkKCmRlZiBtYWtlX3JlZnMoY291bnQsIGNvbW1pdCk6CiAg
ICB3aGlsZSBjb3VudCA+IDA6CiAgICAgICAgc3lzLnN0ZG91dC53cml0ZSgibGVmdDogJWQlc1xy
IiAlIChjb3VudCwgIiAiICogMzApKQogICAgICAgIGEgPSByYW5kb20ucmFuZHJhbmdlKDEwLCAz
MCkKICAgICAgICBiID0gcmFuZG9tLnJhbmRyYW5nZSgxMDAwMCwgNTAwMDApCiAgICAgICAgbmV3
X3JlZihhLCBiLCBjb21taXQpCiAgICAgICAgY291bnQgLT0gMQogICAgcHJpbnQgInJlZnMgY29t
cGxldGUiCgpkZWYgbWFpbigpOgogICAgaWYgbGVuKHN5cy5hcmd2KSAhPSAzOgogICAgICAgIGRp
ZSgidXNhZ2U6ICVzIDxuYW1lPiA8cmVmIGNvdW50PiIgJSBzeXMuYXJndlswXSkKCiAgICBfLCBu
YW1lLCByZWZzID0gc3lzLmFyZ3YKCiAgICBvcy5ta2RpcihuYW1lKQogICAgb3MuY2hkaXIobmFt
ZSkKCiAgICBpZiBzdWJwcm9jZXNzLmNhbGwoWyJnaXQiLCAiaW5pdCJdKSAhPSAwOgogICAgICAg
IGRpZSgiZmFpbGVkIHRvIGluaXQgcmVwbyIpCgogICAgZiA9IG9wZW4oImZvb2Jhci50eHQiLCAi
dyIpCiAgICBmLndyaXRlKCIlczogJXMgcmVmc1xuIiAlIChuYW1lLCByZWZzKSkKICAgIGYuY2xv
c2UoKQoKICAgIGlmIHN1YnByb2Nlc3MuY2FsbChbImdpdCIsICJhZGQiLCAiZm9vYmFyLnR4dCJd
KSAhPSAwOgogICAgICAgIGRpZSgiZmFpbGVkIHRvIGFkZCBmb29iYXIudHh0IikKCiAgICBpZiBz
dWJwcm9jZXNzLmNhbGwoWyJnaXQiLCAiY29tbWl0IiwgIi1tIiwgImluaXRhbCBjb21taXQiXSkg
IT0gMDoKICAgICAgICBkaWUoImZhaWxlZCB0byBjcmVhdGUgaW5pdGlhbCBjb21taXQiKQoKICAg
IGNvbW1pdCA9IHN1YnByb2Nlc3MuY2hlY2tfb3V0cHV0KFsiZ2l0IiwgInNob3ctcmVmIiwgIi1z
IiwgIm1hc3RlciJdKS5zdHJpcCgpCgogICAgbWFrZV9yZWZzKGludChyZWZzKSwgY29tbWl0KQoK
aWYgX19uYW1lX18gPT0gIl9fbWFpbl9fIjoKICAgIG1haW4oKQo=
--=_74ce99a6546b2474fc2b4b072b528f18--
