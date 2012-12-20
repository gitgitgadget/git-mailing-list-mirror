From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] mergetools/p4merge: Honor $TMPDIR for the /dev/null placeholder
Date: Thu, 20 Dec 2012 00:03:35 -0800
Message-ID: <CAJDDKr63Yf0-3yTppGKAW+19wHY_OOF0iiKZ_6XR+Vae-7Bx7w@mail.gmail.com>
References: <1355978754-7041-1-git-send-email-davvid@gmail.com>
	<7v623x6xvv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 20 09:11:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlbE2-0005Fa-9R
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 09:11:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218Ab2LTILN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2012 03:11:13 -0500
Received: from mail-vc0-f179.google.com ([209.85.220.179]:45494 "EHLO
	mail-vc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751069Ab2LTILL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2012 03:11:11 -0500
Received: by mail-vc0-f179.google.com with SMTP id p1so3340068vcq.24
        for <git@vger.kernel.org>; Thu, 20 Dec 2012 00:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=SUa1TN1k6Yxin35iWx11zabbGjz1h2sMAqKIos5D4GU=;
        b=tHTii5s8HZKvcg6G7ydLyLHVTh6C7BUyt5rJeoV//Kx8AMJZQII2VnKe2ljuicy9lX
         M9LJX1qzvfALIxynrOqwvuO0yu2iHRQiAN+qHIAN17YKk7n2c1BFzmUpZCDxajCVpLXQ
         9ynoYUxuWihirYj28vrQbMmoZ63Qq5BinWvHIONvKs1bKjVMpECNlnAnbx2MmTb47G8m
         1hO3hKQJwBrSRCZejsQvk50i06ERqrcM9b/RsqgUDjluJpxiK8hoN/KNvm29GQPOfICx
         szGuQi6nebhc3Ydob0CAYJVHZcMIr6qIFmG3VKWy7wfw3uIzwMwtE+cm8vhbvIWZyQwm
         qG2Q==
Received: by 10.52.37.9 with SMTP id u9mr11347880vdj.83.1355990615462; Thu, 20
 Dec 2012 00:03:35 -0800 (PST)
Received: by 10.58.182.10 with HTTP; Thu, 20 Dec 2012 00:03:35 -0800 (PST)
In-Reply-To: <7v623x6xvv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211884>

On Wed, Dec 19, 2012 at 10:28 PM, Junio C Hamano <gitster@pobox.com> wrote:
> David Aguilar <davvid@gmail.com> writes:
>
>> Use mktemp to create the /dev/null placeholder for p4merge.
>> This keeps it out of the current directory.
>>
>> Reported-by: Jeremy Morton <admin@game-point.net>
>> Signed-off-by: David Aguilar <davvid@gmail.com>
>> ---
>> I consider this a final finishing touch on a new 1.8.1 feature,
>> so hopefully we can get this in before 1.8.1.
>
> Does everybody have mktemp(1), which is not even in POSIX.1?
>
> I'm a bit hesitant to apply this to the upcoming release without
> cooking it in 'next' for sufficiently long time to give it a chance
> to be tried by wider audience.

True.  I only tried Linux and Mac OS X, so I would not be
surprised to find some exotic UNIX that does not have mktemp.

I meant to write "is this portable?" in the section after
the double-dash; saying that it's polish for a fix
is only true if it's portable.

The git-unpack thing looks interesting...
is the SHA-1 in your example the special SHA-1 for an
empty tree or blob?

The reason I ask is because in this code path we are
comparing an unknown blob, basically a blob that does
not exist in one of the trees, so I'm not sure if an
'unpack' command would help for this case because we
would not have a blob SHA-1 to unpack.


As far as portability goes, the "UNIX" list
for p4merge is here:

http://www.perforce.com/downloads/complete_list

I do not have AIX, Solaris, or FreeBSD to test,
so I agree that this can wait.

Does msysgit have mktemp?

p4merge is available on Windows too so I would
need to check there too unless someone happens
to know off the top of their heads.

My other thought was to write a simple shell
function that checks TMPDIR itself, and defaults
to creating some file under /tmp when it is undefined.
I can pursue this option if you think it's a safer choice.
-- 
David
