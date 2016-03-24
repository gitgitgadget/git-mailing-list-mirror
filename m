From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: What's cooking in git.git (Mar 2016, #04; Wed, 23)
Date: Thu, 24 Mar 2016 21:47:20 -0000
Organization: OPDS
Message-ID: <171B6E119FCF4E5CBF2831F6A7A004EA@PhilipOakley>
References: <xmqqpoukc30t.fsf@gitster.mtv.corp.google.com><54B6C1E1FE6A4BAEA07E97B7BA81EB01@PhilipOakley> <xmqqlh57am55.fsf@gitster.mtv.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 22:47:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajD6D-0003tA-As
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 22:47:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbcCXVrW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 17:47:22 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:56617 "EHLO
	smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750794AbcCXVrU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 17:47:20 -0400
Received: from PhilipOakley ([92.22.6.252])
	by smtp.talktalk.net with SMTP
	id jD66abhRlCrtejD66a9oTZ; Thu, 24 Mar 2016 21:47:18 +0000
X-Originating-IP: [92.22.6.252]
X-Spam: 0
X-OAuthority: v=2.1 cv=L/e9O7n8 c=1 sm=1 tr=0 a=L1JPMP/96Cd0ZXeOJ41CKA==:117
 a=L1JPMP/96Cd0ZXeOJ41CKA==:17 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10
 a=s5jvgZ67dGcA:10 a=8nJEP1OIZ-IA:10 a=ybZZDoGAAAAA:8 a=xtxXYLxNAAAA:8
 a=9Hgr8xzUwl2K_1I22iQA:9 a=wPNLvfGTeEIA:10
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfKjRlvbM4oYoxpiJXw5TM4rWGVFj3IujR3nPHuFo4Gd3mj7lJYCTCoZ8dAp0PveRKL5IWSCWNBRzCB7xz3TbOcvKTOV75XpR8rbyDP9xx/E8Wu+PiQ6f
 /SjW0Ixs8HWHwoXft9xh6M47crzPASGPW9/AOUliy2kdAKHLJC5mkZLeCejOxb8L9W29Ut+nJW8/tg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289806>

From: "Junio C Hamano" <gitster@pobox.com>
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>>>
>>> The beginning of "split bundle", which could be one of the
>>> ingredients to allow "git clone" traffic off of the core server
>>> network to CDN.
>>>
>> ...
>> Hi Junio,
>>
>> I think there may be a concept clash between the ideals of a
>> sneakernet bundle' and the 'resumable clone'.
>
> Notice the "could" above ;-)
>
> Read the original thread and notice that the inclination is for the
> first one the primary "clone priming" mechanism would likely to be a
> packfile, not a bundle, even though use of "bundle" is not ruled out.
>
I'd seen the thread ($gmane/288380), and that it had developed toward a bare 
pack-file.

This was just clarifying that if a variant of the bundle format (# V3?) was 
used, that it must, if the name was retained(*), still work as a sneakernet 
transfer option. In that case the user would need to be told, or be able to 
find out via (e.g.) the 'verify' sub-command, where the other half of the 
split bundle (the pack) was located so that both halves could be copied for 
sneakernet transfer.

Then on reaching the destination, the user would need to appreciate where 
the two halves are to go (side by side?), and the code would need a way of 
knowing that it should use the local copy of the split pack, rather seeking 
to transfer a fresh copy (which obviously fails in an air-gapped scenario).

(*) Changing the user facing names for the new resumable transfers to avoid 
the potential user confusion is a simple solution, which could just be a 
tweak to the final patch 4/4 c34c9a9db65 "bundle v3: the beginning". Perhaps 
explicitly use "split-bundle", though choosing a good alternative isn't easy 
;-)

As you say that all could become academic if the independent pack transfer 
works as a better resumable clone.

--

Philip
