From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: inotify to minimize stat() calls
Date: Tue, 19 Feb 2013 15:19:07 +0530
Message-ID: <CALkWK0=XFBfZjO3oCJ8Jxya1ud79MQcQFm6pmZpOU8c3MxVtqQ@mail.gmail.com>
References: <CALkWK0=EP0Lv1F_BArub7SpL9rgFhmPtpMOCgwFqfJmVE=oa=A@mail.gmail.com>
 <7vehgqzc2p.fsf@alter.siamese.dyndns.org> <7va9rezaoy.fsf@alter.siamese.dyndns.org>
 <7vsj56w5y9.fsf@alter.siamese.dyndns.org> <9AF8A28B-71FE-4BBC-AD55-1DD3FDE8FFC3@gmail.com>
 <CALkWK0mttn6E+D-22UBbvDCuNEy_jNOtBaKPS-a8mTbO2uAF3g@mail.gmail.com>
 <CALkWK0nQVjKpyef8MDYMs0D9HJGCL8egypT3YWSdU8EYTO7Y+w@mail.gmail.com>
 <CACsJy8CEHzqH1X=v4yau0SyZwrZp1r6hNp=yXD+eZh1q_BS-0g@mail.gmail.com>
 <CALkWK0=6_n4rf6AWci6J+uhGHpjTUmK7YFdVHuSJedN2zLWtMA@mail.gmail.com>
 <CACsJy8DeM5--WVXg3b65RxLBS7Jho-7KmcGwWk7B5uAx77yOEw@mail.gmail.com>
 <20130210111732.GA24377@lanh> <CABPQNSZ282Lre=sy-+ZQdJA9JnGqQguq2bQDOwvjb0fP+1-w8Q@mail.gmail.com>
 <CACsJy8AWyJ=dW5f44huWyPPe4X62xyi+R9CNM5Tg6u6TYf+thQ@mail.gmail.com> <511AAA92.4030508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Duy Nguyen <pclouds@gmail.com>, kusmabite@gmail.com,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>, finnag@pvv.org
To: blees@dcon.de
X-From: git-owner@vger.kernel.org Tue Feb 19 10:49:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7jph-0004ks-NL
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 10:49:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758167Ab3BSJt3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 04:49:29 -0500
Received: from mail-ia0-f173.google.com ([209.85.210.173]:55350 "EHLO
	mail-ia0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756851Ab3BSJt1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Feb 2013 04:49:27 -0500
Received: by mail-ia0-f173.google.com with SMTP id h37so5932137iak.4
        for <git@vger.kernel.org>; Tue, 19 Feb 2013 01:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=O/v3rLOi1qmbEfmoY2ilHL06EuzuO6pGVKTUx8pFB5A=;
        b=BUjLVXcXKKvYlOtU7f4umWgk4cu1Yb4aEf6Va5MknjDaccPxMuKaQ/ij6kb0aX0eW3
         xN0FM2KRMdk0nhEtqO1zVGKDGW9kknL4W2SMBW7/r65RAX/h+2EnqGyRrsE7X8Q/vkju
         sHjQizVlNIjeRQKX/5B9sU4/NDqhLnOUwY6S2svDerM+zF7PDrGp3L4bUWdIAj6NBkg+
         s1BYUSG5Wl+v8oiq/AUEdPAxyIeq0oqLpNIqq/Qt04C0IWQDeveVlwcThbWek0JpNnFJ
         UeXS8G+njk9wj8ILboIOicdC6N/cK6U+6J8BQp/wb4az+87d4xRLP23UTCzOZ22FBKxN
         KPQQ==
X-Received: by 10.50.108.235 with SMTP id hn11mr7804057igb.107.1361267367483;
 Tue, 19 Feb 2013 01:49:27 -0800 (PST)
Received: by 10.64.166.33 with HTTP; Tue, 19 Feb 2013 01:49:07 -0800 (PST)
In-Reply-To: <511AAA92.4030508@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216587>

Karsten Blees wrote:
> Am 11.02.2013 04:53, schrieb Duy Nguyen:
>> On Sun, Feb 10, 2013 at 11:58 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
>>> Karsten Blees has done something similar-ish on Windows, and he posted
>>> the results here:
>>>
>>> https://groups.google.com/forum/#!topic/msysgit/fL_jykUmUNE/discussion
>>>
>
> The new hashtable implementation in fscache [1] supports O(1) removal and has no mingw dependencies - might come in handy for anyone trying to implement an inotify daemon.
>
> [1] https://github.com/kblees/git/commit/f7eb85c2

Thanks!  I'm cherry-picking this.  Why didn't you propose replacing
hash.{c,h} with this in git.git though?

>>> I also seem to remember he doing a ReadDirectoryChangesW version, but
>>> I don't remember what happened with that.
>>
>> Thanks. I came across that but did not remember. For one thing, we
>> know the inotify alternative for Windows: ReadDirectoryChangesW.
>>
>
> I dropped ReadDirectoryChangesW because maintaining a 'live' file system cache became more and more complicated. For example, according to MSDN docs, ReadDirectoryChangesW *may* report short DOS 8.3 names (i.e. "PROGRA~1" instead of "Program Files"), so a correct and fast cache implementation would have to be indexed by long *and* short names...
>
> Another problem was that the 'live' cache had quite negative performance impact on mutating git commands (checkout, reset...). An inotify daemon running as a background process (not in-process as fscache) will probably affect everyone that modifies the working copy, e.g. running 'make' or the test-suite. This should be considered in the design.

Yes, an external daemon would report creation of *.o files, from the
compile, for instance.  We need a way for it to be filtered at the
daemon itself, so git isn't burdened with the filtering.
