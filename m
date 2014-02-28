From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] rewrite bulk-checkin.c:finish_bulk_checkin() using strbuf
Date: Fri, 28 Feb 2014 16:59:16 -0500
Message-ID: <CAPig+cTGL+s5nT9rgcHhsM+oPTjoJPaorFKHmYtGJ=ZCk4Rm=A@mail.gmail.com>
References: <1393574305-24015-1-git-send-email-faiz.off93@gmail.com>
	<CAPig+cTXK6=LDPDii6RQyO1fiMCq0Rai5uO0JYOzunM=4c_nUw@mail.gmail.com>
	<CAFbjVcnx41CTOV-SCGC9a91b9weNTgYoRP1+uVDukp6Z+0F_yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Faiz Kothari <faiz.off93@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 28 22:59:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJVSj-0002Ak-6T
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 22:59:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752435AbaB1V7R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 16:59:17 -0500
Received: from mail-yk0-f169.google.com ([209.85.160.169]:37835 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752036AbaB1V7Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 16:59:16 -0500
Received: by mail-yk0-f169.google.com with SMTP id 142so3626052ykq.0
        for <git@vger.kernel.org>; Fri, 28 Feb 2014 13:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=WXCktzAsUqcZpjjPMq9i9rZ/4vDBKyLgqRHuO3Sa9NA=;
        b=rD/pjTrUvAiifHdK9KlgGUtDUpRyX86OYPy0C0Zt/XDuFvii0gv+TPq2zxRwSUUtwN
         9NTylAqnOwIkciW2q912QAL5rNEoJAPH/l+gqZgMtlJdH9wFBdf8YVCqg3R+c/cMRRWW
         XuWPvyKctRsKpIrI9KASgRG9aPou9nRMCdnlwJM4dRyIY7cXz38s3UIQoNJmgpTOCxAk
         Bu4GhnxABdfx9Wl0ND7ivI0FJiQI4Ol26bw78CcNv7/2LPMryXoDrs4/BEERWHgDaHVT
         ldQGYXqt9vfgQxwgm7x9FZ0VgkYnr5zh9T6qiMxts7piBH6O1WfUCHXbk86cNIYj1SM7
         I+zA==
X-Received: by 10.236.199.82 with SMTP id w58mr4591590yhn.57.1393624756202;
 Fri, 28 Feb 2014 13:59:16 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Fri, 28 Feb 2014 13:59:16 -0800 (PST)
In-Reply-To: <CAFbjVcnx41CTOV-SCGC9a91b9weNTgYoRP1+uVDukp6Z+0F_yg@mail.gmail.com>
X-Google-Sender-Auth: ZvkVgvwJeK6GLaF0HxsNcTWo7UI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243021>

On Fri, Feb 28, 2014 at 1:27 PM, Faiz Kothari <faiz.off93@gmail.com> wrote:
> Thanks for the suggestions and remarks.

[Administrivia: On this list, top-posting is frowned upon; inline
responses are preferred.]

> I rewrote bulk-checkin.c:finish_bulk_checkin() using strbuf. But saw
> that Sun He has already implemented the same way I have done.
> Should I submit my implementation as a patch?

Yes. The purpose of these micro-projects is to expose you to the Git
project's development process so that you know what will be expected
of you as a GSoC student, and to give the GSoC mentors an opportunity
to evaluate your abilities and observe how you interact with the
reviewers.

> Secondly,
> I tried implementing this WITHOUT changing the prototype of the
> function pack-write.c:finish_tmp_packfile().
>
> For this I detached the buffer from strbuf in finish_bulk_checkin()
> using strbuf_detach() and passed it to finish_tmp_packfile().
>
> Inside finish_tmp_packfile, I attached the same buffer to a local
> struct strbuf using strbuf_attach().
> Now the problem is, two of the arguments to strbuf_attach() are
> 'alloc' and 'len' which are private members of the struct strbuf.
> But since I am just passing the detached buffer, the information of
> alloc and len is lost which is required at the time of attaching.
> I cannot think of any better way of using strbuf and NOT modify the
> prototype of finish_tmp_packfile()
>
> As a workaround, I can determine alloc = (strlen(buf) + 1) and len =
> strlen(buf) but AFAIK this is not always true and may break.
> Any suggestions?

That's getting rather convoluted. You may want to ask yourself if it
is really necessary for finish_tmp_packfile() to modify the buffer
passed in by the caller or if finish_pack_file() should instead take
responsibility for itself by allocating its own buffer (strbuf) in
which to do path manipulation.
