From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 4/5] remote.c: teach branch_get() to treat symrefs other
 than HEAD
Date: Wed, 1 May 2013 17:23:15 -0500
Message-ID: <CAMP44s2_ccoYaaEZ_qGQ-fOb4aY4UVtqYzDjo8OXmvC-EgYSvQ@mail.gmail.com>
References: <1367425235-14998-1-git-send-email-artagnon@gmail.com>
	<1367425235-14998-5-git-send-email-artagnon@gmail.com>
	<CAMP44s20F-QALd18VPHLF4Fj=eFFvXmkhC4XK__kxNhMoeN=ug@mail.gmail.com>
	<CALkWK0n2odCn=GnYSXv7g113PFEX42WF1d2GBGV=ye2TuY3CHA@mail.gmail.com>
	<CAMP44s34X+6c2V0iU_+dfNR9ULXD+Q0CDFk0S9qdK0n8AC81DQ@mail.gmail.com>
	<CALkWK0mfHVBLPdU7jyiBR=-kSguCBFOhsEsXYYthBuQbtX7MuA@mail.gmail.com>
	<CAMP44s1dWhpVhUar2-u1NAqK-TPssxZYgGMY9_SVxvuKSFT4QA@mail.gmail.com>
	<CALkWK0mz6+RS-fZAjz=1+kVN6WFTb+cX98V=8AGfzybacf28RQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 02 00:23:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXfQn-0001yg-Lp
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 00:23:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759689Ab3EAWXS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 18:23:18 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:39430 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759298Ab3EAWXR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 18:23:17 -0400
Received: by mail-lb0-f174.google.com with SMTP id t11so1858488lbd.19
        for <git@vger.kernel.org>; Wed, 01 May 2013 15:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=f2UzyJzBXzv+TNKhUwF5ZSnCI7UXdwGU25VDJNh8vsk=;
        b=GVRT95ksDidVAbyCdAsCnsANiX13dX+74ZPc0hiMHHl+oSeqaj0Eh5ZLxLxrTSriLP
         3ihlwqh49HGgEMu6L1qTYLzQg126fE13rcWKvhObVIOtHprMWwqvYHkn4oRpDHRwo57W
         eG/yUNcI4ZjNJmwwDM0lAmfkrxiDEQ4/pOk0J7LMePjzOm9pvMmwLDAKXpKsCA+d+D/C
         faUTVPs3ZiGAcANiP4ULp/fX/w54Hk3VQtkVe35t30KrH6SWa7Ylj0T9JMvoXLn2+90R
         oTfC7TGbfo1fVcKqdeSgv9ak5hSKUadK5C7EFYU99UKPYXGKBQ2d+hthV8jG/1ejfnxC
         /Cpg==
X-Received: by 10.112.145.72 with SMTP id ss8mr1030729lbb.12.1367446995529;
 Wed, 01 May 2013 15:23:15 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Wed, 1 May 2013 15:23:15 -0700 (PDT)
In-Reply-To: <CALkWK0mz6+RS-fZAjz=1+kVN6WFTb+cX98V=8AGfzybacf28RQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223156>

On Wed, May 1, 2013 at 3:57 PM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>> If you are arguing in favor of arbitrary symbolic refs plus @{u} to
>> work, a patch that allows that, and nothing else, should make sense.
>> Such patch would trigger further discussion, for example, if
>> get_branch() is the right place to achieve that.
>
> What kind of absurd argument is this?  I am trying to solve the @ ->
> HEAD problem correctly.  In the process, I fixed general symbolic-ref
> handling and cleaned up the @-parsing logic.  Does anyone have a
> problem with the fix, or am I missing something?

This is not a fix, this is multiple changes blobbed into one.

> So, start the discussion.  What are you waiting for?
>
>> I still see this in the code:
>>
>>         if (!name || !*name || !strcmp(name, "HEAD"))
>
> Remove the !strcmp(name, "HEAD") and tell me what you see.  "HEAD"
> will get resolved just like any other symbolic ref, via the hunk I
> added.

If you are so certain why don't you remove that code then? I wouldn't
be so sure.

-- 
Felipe Contreras
