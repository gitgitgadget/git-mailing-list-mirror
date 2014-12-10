From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] pkt-line: allow writing of LARGE_PACKET_MAX buffers
Date: Wed, 10 Dec 2014 04:49:38 -0500
Message-ID: <CAPig+cT9rRXdZ5OS8HPBuNOh2P-+PVYZkGR-74rBfXsc2nj_Zw@mail.gmail.com>
References: <20141209174958.GA26167@peff.net>
	<20141209180916.GA26873@peff.net>
	<xmqqa92wla34.fsf@gitster.dls.corp.google.com>
	<20141210073447.GA20298@peff.net>
	<CAPig+cQQThA7wiz8iwkKX=ipg1n5w+gyeS8NqtbjGui986Hn+g@mail.gmail.com>
	<CAPig+cR4p9C46wU2-nNVy7rpXzbW0fGmqzik85UP_1j3YUEmjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Michael Blume <blume.mike@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 10 10:49:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xydtx-0003l2-1I
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 10:49:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752764AbaLJJtl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2014 04:49:41 -0500
Received: from mail-yk0-f172.google.com ([209.85.160.172]:40668 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751380AbaLJJtj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2014 04:49:39 -0500
Received: by mail-yk0-f172.google.com with SMTP id 131so1071854ykp.3
        for <git@vger.kernel.org>; Wed, 10 Dec 2014 01:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=7QETcWQrU1di+4OFMSU2UXjimjteh74b84xYKT3Z/f0=;
        b=yYUYo9o0Kf8pzRXxucEv89FDsAGVWUXS5SrGceGApdhAsqRF5lJcz4SNck+Y4gxiXp
         RaYqFuxG0OGrqxojItCANfGqcmO/UCoOqdhlOpqdbyZIpLGlcMdoYO7Wv1tuk/hDZzRi
         WZkzvFfLk3cZeWrLTvGYEptQU9MzKbDF+EaubxeJOFbHKE0JWOZp12MnQ+kpbabvn/ao
         oY+lyb0rJnrTB5Pr/v6n1FkDl0C4LroCQZ5pudW31HP9gSRX4rVg8bUoJqfi1TLACoZx
         vuYgXTxYZJd4nYXkxeWlMGft51OIwJtUirZl6NqfY2oUDAfZWyYcnt1CJNfbGoavmARp
         w5yQ==
X-Received: by 10.170.134.72 with SMTP id a69mr2115200ykc.103.1418204978915;
 Wed, 10 Dec 2014 01:49:38 -0800 (PST)
Received: by 10.170.79.215 with HTTP; Wed, 10 Dec 2014 01:49:38 -0800 (PST)
In-Reply-To: <CAPig+cR4p9C46wU2-nNVy7rpXzbW0fGmqzik85UP_1j3YUEmjA@mail.gmail.com>
X-Google-Sender-Auth: bGy6XYzQbTckn-et6hW5pudg_-M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261202>

On Wed, Dec 10, 2014 at 4:42 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Dec 10, 2014 at 3:36 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Wed, Dec 10, 2014 at 2:34 AM, Jeff King <peff@peff.net> wrote:
>>> Below is a another iteration on the patch. The actual code changes are
>>> the same as the strbuf one, but the tests take care to avoid assuming
>>> the filesystem can handle such a long path. Testing on Windows and OS X
>>> is appreciated.
>>
>> All three new tests fail on OS X. Thus far brief examination of the
>> first failing tests shows that 'expect' and 'actual' differ:
>>
>> expect:
>>     long
>>     master
>>
>> actual:
>>     master
>
> The failure manifests as soon as the refname hits length 1024, at
> which point for-each-ref stops reporting it. MAX_PATH on OS X is 1024,
> so some part of the machinery invoked by for-each-ref likely is
> rejecting refnames longer than that (even when coming from
> packed-refs).

Clarification: for-each-ref ignores the ref when the full line read
from packed-refs hits length 1024 (not when the refname itself hits
length 1024).
