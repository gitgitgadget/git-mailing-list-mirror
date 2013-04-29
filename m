From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] pretty: Fix bug in truncation support for %>, %< and
 %><
Date: Mon, 29 Apr 2013 22:29:00 +0100
Message-ID: <517EE61C.5040802@ramsay1.demon.co.uk>
References: <517C2A68.4030802@ramsay1.demon.co.uk> <CACsJy8Dx2tKdQDLw9=i1aM6=uqVBvHYpzq-q+rQE-e7-oJTRcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 01:33:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWxZB-000078-3q
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 01:33:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932528Ab3D2Xc7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 19:32:59 -0400
Received: from mdfmta009.mxout.tbr.inty.net ([91.221.168.50]:51137 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932368Ab3D2Xc7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 19:32:59 -0400
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 3E54E384083;
	Tue, 30 Apr 2013 00:32:57 +0100 (BST)
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 71004384081;
	Tue, 30 Apr 2013 00:32:56 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP;
	Tue, 30 Apr 2013 00:32:55 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <CACsJy8Dx2tKdQDLw9=i1aM6=uqVBvHYpzq-q+rQE-e7-oJTRcg@mail.gmail.com>
X-MDF-HostID: 4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222879>

Duy Nguyen wrote:
> On Sun, Apr 28, 2013 at 2:43 AM, Ramsay Jones
> <ramsay@ramsay1.demon.co.uk> wrote:
>> The truncation support was implemented with the assistance of a
>> new strbuf function (strbuf_utf8_replace). This function contains
>> the following code:
>>
>>        strbuf_attach(sb_src, strbuf_detach(&sb_dst, NULL),
>>                      sb_dst.len, sb_dst.alloc);
>>
>> Unfortunately, this code is subject to unspecified behaviour. In
>> particular, the order of evaluation of the argument expressions
>> (along with the associated side effects) is not specified by the
>> C standard.
> 
> Thanks for noticing and fixing it.

I didn't notice it; your test noticed it and nagged me to take a look!
;-)

The verbose output from the test made it clear that, rather than the
expected truncated output, it was returning an empty string. A quick
trip to the debugger clearly showed strbuf_detach() clearing the len
and alloc fields of sb_dst, which was then passed to strbuf_attach().
So, I didn't really do much. :-D

>                                   What compiler did you use by the way?

The compiler was gcc, but that doesn't really matter much.

ATB,
Ramsay Jones
