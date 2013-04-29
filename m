From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] send-email: improve recipients_cmd()
Date: Mon, 29 Apr 2013 00:14:52 -0500
Message-ID: <CAMP44s0x8fK-6vbY20eKA9QjWqhiOCvx+KFOgKOZ8q58bwk8Tw@mail.gmail.com>
References: <1367101561-14671-1-git-send-email-felipe.contreras@gmail.com>
	<7vbo8yqxas.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Joe Perches <joe@perches.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 07:15:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWgQU-0002nT-LG
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 07:14:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262Ab3D2FOy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 01:14:54 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:48678 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001Ab3D2FOy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 01:14:54 -0400
Received: by mail-lb0-f176.google.com with SMTP id p10so145893lbv.21
        for <git@vger.kernel.org>; Sun, 28 Apr 2013 22:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=8DRf2MCEa8rTuTkIWr6P2BOmvCnVs0JY7+8qBDS3fHA=;
        b=kgFopfOSqewab0h0TIIt52O8v2R8Ot7DezpcUxpUFig9uqUaFRKdKUPqL/rlJD82O7
         w9ZhXcgpXlC8Wu7UyDvyEixGD4LZ/uQITtx7dNeEzn/Pgdgsjc1CZ0pHknwSMvwCC2J5
         KHe7NK1gV4RnWQ95igZMfVebBIaoB15pw+0yH0xwESGNcZJe090ZpS3qR5AZyyVQ/C4a
         ykNg5PKYoteWONJPVzKfS1bFw2j/Y8vqcuH6RnBQgP3Pwy9PEBIKdJWdQ+8HkJodyKFR
         O/p0KbURoBeBtT4BGw6f+fXU2a8oJGpMovBDBQqV5G+e2IkGqv0GRAoKKoU/M4PFXNC8
         FCyQ==
X-Received: by 10.112.154.98 with SMTP id vn2mr24651543lbb.8.1367212492305;
 Sun, 28 Apr 2013 22:14:52 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Sun, 28 Apr 2013 22:14:52 -0700 (PDT)
In-Reply-To: <7vbo8yqxas.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222769>

On Sun, Apr 28, 2013 at 2:18 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> We don't need to quote the filename to pass to the command, we can use
>> an array of all the arguments to pass to the command, which is safer,
>> and more extensible.
>>
>> Commit a47eab0 (send-email: use the three-arg form of open in
>> recipients_cmd) stated we couldn't pass $file directly, but in fact, we
>> can, the multi-word string is passed as is, and we can pass an array
>> too.
>
> I think the comment is not about passing $file directly, but is
> about passing $cmd that could be multi-word string directly.  The
> caller expects it be split into command and its earlier part of
> command line parameters, so that you can say
>
>     $cmd = "cccmd --frotz --nitfol"

I see.

> but the non-string form of open would not give you that, unless you
> rewrite it to
>
>         open $fh, "-|", qw(sh -c), $cmd, @args

That doesn't seem to work for me.

It would have to be:

  open $fh, "-|", qw(sh -c), "$cmd \Q$args\E"

So we end up in the same place.

-- 
Felipe Contreras
