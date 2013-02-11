From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: inotify to minimize stat() calls
Date: Mon, 11 Feb 2013 10:53:12 +0700
Message-ID: <CACsJy8AWyJ=dW5f44huWyPPe4X62xyi+R9CNM5Tg6u6TYf+thQ@mail.gmail.com>
References: <CALkWK0=EP0Lv1F_BArub7SpL9rgFhmPtpMOCgwFqfJmVE=oa=A@mail.gmail.com>
 <7vehgqzc2p.fsf@alter.siamese.dyndns.org> <7va9rezaoy.fsf@alter.siamese.dyndns.org>
 <7vsj56w5y9.fsf@alter.siamese.dyndns.org> <9AF8A28B-71FE-4BBC-AD55-1DD3FDE8FFC3@gmail.com>
 <CALkWK0mttn6E+D-22UBbvDCuNEy_jNOtBaKPS-a8mTbO2uAF3g@mail.gmail.com>
 <CALkWK0nQVjKpyef8MDYMs0D9HJGCL8egypT3YWSdU8EYTO7Y+w@mail.gmail.com>
 <CACsJy8CEHzqH1X=v4yau0SyZwrZp1r6hNp=yXD+eZh1q_BS-0g@mail.gmail.com>
 <CALkWK0=6_n4rf6AWci6J+uhGHpjTUmK7YFdVHuSJedN2zLWtMA@mail.gmail.com>
 <CACsJy8DeM5--WVXg3b65RxLBS7Jho-7KmcGwWk7B5uAx77yOEw@mail.gmail.com>
 <20130210111732.GA24377@lanh> <CABPQNSZ282Lre=sy-+ZQdJA9JnGqQguq2bQDOwvjb0fP+1-w8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>, finnag@pvv.org,
	Karsten Blees <blees@dcon.de>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Mon Feb 11 04:54:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4kT1-0001bj-B2
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 04:54:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751970Ab3BKDxo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 22:53:44 -0500
Received: from mail-oa0-f42.google.com ([209.85.219.42]:54914 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751715Ab3BKDxn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 22:53:43 -0500
Received: by mail-oa0-f42.google.com with SMTP id i18so5898170oag.1
        for <git@vger.kernel.org>; Sun, 10 Feb 2013 19:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=z5A8VItxINTdAyIRCv5qWhNZJ5XxCo5599l5Kr7nuE4=;
        b=OvHC0SKe26r2R5nrdooAY8uhAuTzdjbvSLI94YSLdq4E/EikYaddLauELsQOzfE5rf
         GxxxfM0zd23TgnzWreCEkukJqGeTEsNQ9N5J1Qwr0y+BebSPYaN+73gJRx7txLo+ycxv
         PEYIF0KKo3AE+S2VCM/yHKVFkGUeQq9bll5RTD8cDpOYEnL4t4l3GyQsxmDGi2sFaFbB
         dG0aKluyc64kZrgDHYK2gVD+1nns+lD1XlnObyxKBCY3BNmPJH4NkzGJGd5zx0+kJyW4
         S9nSr9agjqZ2p3LR9CQ6tTo1FbF5Ndo2UYZp4XMXvkiK+3TJEattYUGD2CxyDC4QBh3T
         kdew==
X-Received: by 10.60.32.67 with SMTP id g3mr9464487oei.77.1360554822901; Sun,
 10 Feb 2013 19:53:42 -0800 (PST)
Received: by 10.76.154.197 with HTTP; Sun, 10 Feb 2013 19:53:12 -0800 (PST)
In-Reply-To: <CABPQNSZ282Lre=sy-+ZQdJA9JnGqQguq2bQDOwvjb0fP+1-w8Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215981>

On Sun, Feb 10, 2013 at 11:58 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> Karsten Blees has done something similar-ish on Windows, and he posted
> the results here:
>
> https://groups.google.com/forum/#!topic/msysgit/fL_jykUmUNE/discussion
>
> I also seem to remember he doing a ReadDirectoryChangesW version, but
> I don't remember what happened with that.

Thanks. I came across that but did not remember. For one thing, we
know the inotify alternative for Windows: ReadDirectoryChangesW.

But the meat of the patch is not about that function. In fact it's
dropped in fscache-v3 [1]. It seems that doing
FindFirstFile/FindNextFile for an entire directory, cache the results
and use it to simulate lstat() is faster on Windows. Sounds similar to
preload-index. And because directory listing is cached anyway,
opendir/readdir is replaced to read from cache instead of opening the
directory again.

So it is orthogonal with using ReadDirectoryChangesW/inotify to
further reduce the system calls.

I copy "git status"'s (impressive) numbers from fscache-v0 for those
who are interested in:

preload | -u  | normal | cached | gain
--------+-----+--------+--------+------
false   | all | 25.144 | 3.055  |  8.2
false   | no  | 22.822 | 1.748  | 12.8
true    | all |  9.234 | 2.179  |  4.2
true    | no  |  6.833 | 0.955  |  7.2

[1] https://github.com/kblees/git/commit/35f319609aa046d2350db32d3afa1fa44920e880
-- 
Duy
