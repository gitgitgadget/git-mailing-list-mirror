From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH 1/2] relative_path should honor dos_drive_prefix
Date: Fri, 20 Sep 2013 09:26:41 +0800
Message-ID: <CANYiYbGK_KdF5Yvcus5C_cGz3EyGTaFvirsUH5q4Eu=3VC4=Wg@mail.gmail.com>
References: <xmqq38pczjw6.fsf@gitster.dls.corp.google.com>
	<0688d5a5bd194ff5808c555e8e75132e2c687368.1378977052.git.worldhello.net@gmail.com>
	<5231CBFA.3070806@web.de>
	<5231F839.3080208@kdbg.org>
	<xmqq8uz1q2i4.fsf@gitster.dls.corp.google.com>
	<CANYiYbE6nT+9LrekWp7mryJ13RxQBSQ+p6EyQspAKBMj7oG0zQ@mail.gmail.com>
	<xmqq7gelmfm5.fsf@gitster.dls.corp.google.com>
	<CANYiYbH9pLMx4gu1qONhy-+++ojUhPSd9F=sdRTmGWH3pSUTqQ@mail.gmail.com>
	<5238AE60.1010700@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Git List <git@vger.kernel.org>,
	Tvangeste <i.4m.l33t@yandex.ru>,
	Karsten Blees <karsten.blees@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Sep 20 03:26:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMpUg-0002ZN-WC
	for gcvg-git-2@plane.gmane.org; Fri, 20 Sep 2013 03:26:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752050Ab3ITB0o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Sep 2013 21:26:44 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:55929 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751927Ab3ITB0n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Sep 2013 21:26:43 -0400
Received: by mail-wg0-f42.google.com with SMTP id m15so7739981wgh.1
        for <git@vger.kernel.org>; Thu, 19 Sep 2013 18:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=JBvLcCNqNBkIdgyWs7k6W6Cr9+KW0DtJOrAMeWWg/Ro=;
        b=wsbfIsPXacxZipcrj9nXzaM47NGrUDuo046TabJDEYRXmXihEm7hSvZ/byg1LmmEcs
         jBkOsT6+SRILdrp+Ru64mKzSAxPdZtV1i4kTLlGRAbAZSHw/kTdezogIGBhXKRquH8pQ
         yfJEZrdigJDR+W3TE3CvuNjColVkA+lRK5Y/cwXkBO0rb+JnRKaMCTpsBLwbJlsY9z6y
         jDVKDTqI4/OTckHkTqiu+ycy8nCffBR+caaWO3KP6PCj318cl6ZP73EsQpuOJ0vF3diW
         NhDvwqrR80l72jov6JqSPwFu7MoQ5FOubVoa+YHqOnPyDvRniZQkK+fmKBpTEVDyiVVM
         j86A==
X-Received: by 10.180.82.36 with SMTP id f4mr568264wiy.63.1379640402072; Thu,
 19 Sep 2013 18:26:42 -0700 (PDT)
Received: by 10.216.122.202 with HTTP; Thu, 19 Sep 2013 18:26:41 -0700 (PDT)
In-Reply-To: <5238AE60.1010700@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235044>

2013/9/18 Johannes Sixt <j6t@kdbg.org>:
> Am 17.09.2013 10:24, schrieb Jiang Xin:
>> I have checked the behavior of UNC path on Windows (msysGit):
>>
>> * I can cd to a UNC path:
>>
>>     cd //server1/share1/path
>>
>> * can cd to other share:
>>
>>     cd ../../share2/path
>>
>> * and can cd to other server's share:
>>
>>     cd ../../../server2/share/path
>>
>> That means relative_path(path1, path2) support UNC paths out of the box.
>> We only need to check both path1 and path2 are UNC paths, or both not.
>
> Your tests are flawed. You issued the commands in bash, which (or rather
> MSYS) does everything for you that you need to make it work. But in
> reality it does not, because the system cannot apply .. to //server/share:
>
> $ git ls-remote //srv/public/../repos/his/setups.git
> fatal: '//srv/public/../repos/his/setups.git' does not appear to be a
> git repository
> fatal: Could not read from remote repository.
>
> Please make sure you have the correct access rights
> and the repository exists.
>
> even though the repository (and //srv/public, let me assure) exists:
>
> $ git ls-remote //srv/repos/his/setups.git
> bea489b0611a72c41f133343fdccbd3e2b9f80b5        HEAD
> ...

After see this link (provided by Torsten):

    <http://msdn.microsoft.com/en-us/library/windows/desktop/aa365247%28v=vs.85%29.aspx>

I find the following commands could work:

    $ git ls-remote //srv/repos/his/setups.git
    $ git ls-remote //srv/repos/his/../his/setups.git
    $ git ls-remote //?/UNC/srv/repos/his/setups.git
    $ git ls-remote //?/UNC/srv/repos/../repos/his/setups.git

But no luck for this one:

    $ git ls-remote //srv/repos/../repos/his/setups.git

I trace it using gdb, and find it failed in "stat()/mingw_stat()" call
of function "enter_repo" in path.c. But I can not find out why
"git ls-remote //?/UNC/srv/repos/../repos/his/setups.git" could
work (success in shell, failed in gdb).

> Please let me suggest not to scratch where there is no itch. ;) Your
> round v2 was good enough.
>
> If you really want to check UNC paths, then you must compare two path
> components after the the double-slash, not just one.
>

I have already try this (honor two path components after //)
during the reroll for patch v3. But I am not satisfied with it,
and it seems like over-engineered: Rename "have_same_root"
to "get_common_root_prefix_width", and it return -1 for no
same_root found, otherwize return the length of root_prefix_width.

Since restored the default behavior of setup.c in commit ("Use
simpler relative_path when set_git_dir"), function "relative_path"
are only used in "quote.c" and "builtin/clean.c", and two paths
provided to "relative_path" are always (I can not find exception)
relative paths. So no itch exist I think.

-- 
Jiang Xin
