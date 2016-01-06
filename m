From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4] reflog-walk: don't segfault on non-commit sha1's in
 the reflog
Date: Tue, 5 Jan 2016 20:52:57 -0500
Message-ID: <CAPig+cQ7MineqezZXxpfAotVwoM9Ju1qwVGpEnEh9qNKBF1Pjg@mail.gmail.com>
References: <1451552227.11138.6.camel@kaarsemaker.net>
	<20160105211206.GA12057@spirit>
	<CAPig+cRufd4qOwZRpw2TR39npkRGg=7S+7YwfSu6EvRR95kRSA@mail.gmail.com>
	<1452043212.5562.18.camel@kaarsemaker.net>
	<CAPig+cThSHKBiUk5CmtE59mci3JLMv7QPNfHZAYmkqQvZHHofA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Wed Jan 06 02:53:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGdHb-0004hX-RD
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jan 2016 02:53:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752560AbcAFBxA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2016 20:53:00 -0500
Received: from mail-vk0-f67.google.com ([209.85.213.67]:35341 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751949AbcAFBw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2016 20:52:58 -0500
Received: by mail-vk0-f67.google.com with SMTP id i129so150703vkb.2
        for <git@vger.kernel.org>; Tue, 05 Jan 2016 17:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=+PM5aatZBHO87VBmE6fgTzBpyshB7eU++24DnLUur9k=;
        b=lA5qWw3F2IuoZwjhq8IGtDPcGpuIxIQQI9TbLnneUTgE9oay/Mnwnh72wE9FbuBKRY
         dq3SRR6bJGkK7ovbDybEiUxQy7rpyn7DDhj3OP3r7qwe4B60Jzs8MGokF/9/eNCAkGtp
         V4zJb0klh2LNA7ewSeP19Dpzf4FimXLnHIKx2OA0T90XRMMcd78q7CLJXHtfrK28Z+AY
         EXv0hXaE52MS55yyjomguqsulmEAn+cqgH5CEFHIMQR5YR8LMI5iZWBrqwbo44SwXePr
         YJVGiz+HnEsBmzVCAyI+0gz4H18c/sBZ4y6rp1L48a0A2XMgt1lJByXt/nGTiy8rset8
         AitQ==
X-Received: by 10.31.141.2 with SMTP id p2mr42961094vkd.37.1452045177632; Tue,
 05 Jan 2016 17:52:57 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Tue, 5 Jan 2016 17:52:57 -0800 (PST)
In-Reply-To: <CAPig+cThSHKBiUk5CmtE59mci3JLMv7QPNfHZAYmkqQvZHHofA@mail.gmail.com>
X-Google-Sender-Auth: jMWY9ZgsBo0S8sf2CIeTs-xfA7U
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283415>

On Tue, Jan 5, 2016 at 8:28 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, Jan 5, 2016 at 8:20 PM, Dennis Kaarsemaker
> <dennis@kaarsemaker.net> wrote:
>> On di, 2016-01-05 at 20:05 -0500, Eric Sunshine wrote:
>>> Hmm, this test is successful for me on OS X even without the
>>> reflog-walk.c changes applied.
>>>
>>> And this test actually fails (inversely) because it's expecting a
>>> failure, but doesn't get one since the command produces the expected
>>> output.
>>
>> That's... surprising to say the least. What's the content of 'actual',
>> and which git.git commit are you on?
>
> % cat t/trash\ directory.t1410-reflog/actual
> b60a214 refs/tests/tree-in-reflog@{0}: Restoring to commit
> 140c527 refs/tests/tree-in-reflog@{1}: Forcing tree
> b60a214 refs/tests/tree-in-reflog@{2}: Creating ref
> %
>
> This is with only the t/t1410-reflog.sh changes from your patch
> applied atop current 'master' (SHA1 7548842).

By the way, the segfault does occur for me on Linux and FreeBSD.

And, in all cases, on all tested platforms, with the full patch
applied, both tests behave sanely (in the expected fashion). So, even
though the crash doesn't manifest everywhere, the fact that the tests
are meaningfully testing it on the "affected" platforms may mean that
it's not worth worrying about why it doesn't segfault on OS X.

(Of course, practicality aside, one might want to satisfy one's
intellectual curiosity about why it behaves differently on OS X.)
