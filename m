From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] msvc: Fix compilation error due to missing mktemp() declaration
Date: Thu, 30 Dec 2010 22:47:04 +0100
Message-ID: <AANLkTinAAGWeFDomo-NQrVtrdf9ue1xVxufy+bkWz1Fc@mail.gmail.com>
References: <4D139D91.8080503@ramsay1.demon.co.uk> <AANLkTineKS2e8PJs76PLZP4L4APwX2kAiFPg4pz3esae@mail.gmail.com>
 <4D1CDE84.7090402@ramsay1.demon.co.uk>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Thu Dec 30 22:48:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PYQM2-00037p-Ez
	for gcvg-git-2@lo.gmane.org; Thu, 30 Dec 2010 22:48:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755297Ab0L3Vr0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Dec 2010 16:47:26 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:56023 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342Ab0L3VrZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Dec 2010 16:47:25 -0500
Received: by fxm20 with SMTP id 20so11509380fxm.19
        for <git@vger.kernel.org>; Thu, 30 Dec 2010 13:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type;
        bh=EJ2PKmqtHa0kUrN1gth+TOT5n1cglxQp9tGB+oNaqV0=;
        b=tDTt9ANGr6i7P+tjYMzxkAyIN0/Kn3dz7AB/poJrQOsbUxBUgHeUOkn7KQLfNnLM2S
         ZMnFtd53KgPmYDfoYSgAbTPu9KC1O3T36D4VMgIVdDjBcJmv3/0iIeZ0N00Z+yaCe/c0
         hJFhYwSv2VMhPAEZNIaSfi8XBTOpMvTRDDcQk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        b=uDNCMOrmoc/Mhk8/l7NnPF8uI1b5dKWMzatpEz17dUxlCwZYqEYfeuwhCDuodViCJS
         lO2dzBTYLDWXizcyOMJj8qSZ/colZzghvxxbX/W0nvc9ZU44LqrFSagYmOphNKR+NpAu
         q2aFxX2GH6Mhr+hKyCX6RVhDHA6ZJotCyZpUk=
Received: by 10.223.86.193 with SMTP id t1mr1983765fal.147.1293745644491; Thu,
 30 Dec 2010 13:47:24 -0800 (PST)
Received: by 10.223.79.3 with HTTP; Thu, 30 Dec 2010 13:47:04 -0800 (PST)
In-Reply-To: <4D1CDE84.7090402@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164369>

On Thu, Dec 30, 2010 at 8:33 PM, Ramsay Jones
<ramsay@ramsay1.demon.co.uk> wrote:
> Erik Faye-Lund wrote:
>> On Thu, Dec 23, 2010 at 8:05 PM, Ramsay Jones
>> <ramsay@ramsay1.demon.co.uk> wrote:
>>> Commit d1b6e6e (win32: use our own dirent.h, 2010-11-23) removed
>>> the compat/vcbuild/include/dirent.h compatibility header file.
>>> This file, among other things, included the <io.h> system header
>>> file which provides the declaration of the mktemp() function.
>>>
>>> In order to fix the compilation error, we add an include directive
>>> for <io.h> to the compat/vcbuild/include/unistd.h header. (The
>>> MinGW build includes <io.h> from it's <unistd.h> header too.)
>>>
>>> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
>>> ---
>>
>> Thanks. But shouldn't this header be included in mingw.h (or perhaps
>> msvc.h) because of _get_osfhandle and _commit?
>
> Er... no. ;-)
>
> All uses of _get_osfhandle() and _commit() on the msvc build (after this
> patch) are within the scope of an appropriate declaration, so there is
> no *need* to include <io.h> in either mingw.h or msvc.h.
> [I'm confident the same is true of the MinGW build as well, but I didn't
> have time to check before sending this mail...]
>
> I suspect that you already know this and I'm just being dumb in missing
> the import of your question... Perhaps you could clarify your concerns
> regarding this patch?
>

Actually, I suspect that you know exactly what my concern is (based on
the above), and that it's not with your patch.

I have a patch in my MSVC-tree that includes io.h in mingw.h, because
mingw.h already depends on facilities from io.h on MSVC. My point was
simply that this dependency was already present, and as such I think
mingw.h is the appropriate place to include it.

Your patch might remove the warnings (perhaps it was only msvc.c that
depends on io.h, I don't remember), and that's fine. But I think we
should solve the problem in msvc.[ch] instread, as this is the
compatibility-layer that the rest of the system includes.

But it's just an opinion, deal with it as you please. The most
important part is to prevent warnings/errors, how we do it is
secondary.
