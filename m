From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 3/2] dir.c: fix dir re-inclusion rules with "NODIR" and "MUSTBEDIR"
Date: Sat, 19 Mar 2016 08:03:46 +0700
Message-ID: <CACsJy8BBwiH9YtDUZRYwHm4t2ou84B6Ltx37ruXkM-vDoSGG9A@mail.gmail.com>
References: <1458218744-15810-2-git-send-email-pclouds@gmail.com>
 <1458219254-16343-1-git-send-email-pclouds@gmail.com> <xmqqfuvoy89q.fsf@gitster.mtv.corp.google.com>
 <56EB8961.70302@fb.com> <CACsJy8A2FKn-8nWtK4QPMHDCDYvTZBrQs1RVMApnuejXQis19g@mail.gmail.com>
 <xmqqa8lvr7ix.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Durham Goode <durham@fb.com>,
	Git Mailing List <git@vger.kernel.org>,
	Mateusz Jakub Kwapich <mitrandir@fb.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 19 02:04:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ah5JW-0007FP-A6
	for gcvg-git-2@plane.gmane.org; Sat, 19 Mar 2016 02:04:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754072AbcCSBET (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 21:04:19 -0400
Received: from mail-lb0-f193.google.com ([209.85.217.193]:35377 "EHLO
	mail-lb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752902AbcCSBER (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 21:04:17 -0400
Received: by mail-lb0-f193.google.com with SMTP id wn5so7673862lbb.2
        for <git@vger.kernel.org>; Fri, 18 Mar 2016 18:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IuheRX/rM5kIesJvgawh8x47UVi0JzU/kT6+31K96/g=;
        b=QeUxFXEdoKmXNnYjT5fxETPMKVL0iRwJsGwsAa1mZNsSceMFX/lHWaTLEf7gZ3HlvG
         nUwmvt1R2urWmNbSVZwqlW7Crnk7siihIpitwSQFYzZNgITEwutFra++Utx7bvCkBwm6
         ZBkIISDNlZ5VT/4bfW4HFYlR/kg9R7Y1/WRWV0Xhv9ZwmprM+nxWyNCJk5rY/dElvmc6
         Txkx+kQABxA44qvMXhGTCG88eRN/Ke4jYmeg9eb2h6z/0oYQJUfMLEPgFUaQHReI3Gh7
         R8Ji2LCdKEXY0pUUS8FqJ/5wyio5QqccvuT2lqu7bdBvJrAVwRsK7LADTRSp+/H8vYgW
         VXuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IuheRX/rM5kIesJvgawh8x47UVi0JzU/kT6+31K96/g=;
        b=MHZFPRVc88thAtI8SKemS+Whs45yKBjbsWXcWnDU9X/dXWJKw4rLlk9yHsx8yG71FP
         GsHalwjKM+GeM5tRQtoLBPxImStHQ4gSLENrV6+Ocrq35F/0jlFET2O2LDPYX3qxgQY7
         FCz33eD7iChUZKFwIP2ArtVO0mD48HFGPPqLBAcPk8cfofZ0yfSdFBwcYtjbn7kyxKRV
         fSTPv8oGtpi/E73aTo5r6feK4xbbYF9GqSHdW0cyv3f4sVTCA9M6PRVd52LM0HdvJGyE
         5X/JnwI4EaPL7fXUPAKVmGZN/gfygO0LRb0xQHm3a8EJirHVScZXTp1rz8s057Gvzkkr
         hpWw==
X-Gm-Message-State: AD7BkJI884aDRiNYZsh8RgeHVpDYSqU6VOA/1FClLWZrnOxAoAA8LiLHriuWywnTMcbHkdqUohmF987BZIZEYA==
X-Received: by 10.112.209.99 with SMTP id ml3mr6692239lbc.26.1458349456167;
 Fri, 18 Mar 2016 18:04:16 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Fri, 18 Mar 2016 18:03:46 -0700 (PDT)
In-Reply-To: <xmqqa8lvr7ix.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289266>

On Sat, Mar 19, 2016 at 1:00 AM, Junio C Hamano <gitster@pobox.com> wrote:
> What is the ultimate goal of nd/exclusion-regression-fix topic over
> the behaviour before 2.7.0 and after 2.7.1 (there was a regression
> in 2.7.0 that was reverted in 2.7.1)?  From the cover letter of the
> series:
>
>     Take one was bad and reverted in commit 8c72236. Take two provides a
>     more complete solution to the pair of rules
>
>       exclude/this
>       !exclude/this/except/this
>
>     3/4 should do a better job at stopping regressions in take 1. 4/4
>     provides the solution. I think I have tested (and wrote tests) for all
>     the cases I can imagine.
>
> "solution to the pair of rules" hints there are some problem in the
> pair of rules, without stating what it is trying to solve.
>
> Isn't the root cause of the issue that treat_one_path() when
> deciding if it is worth descending into a directory check if the
> directory itself is excluded and returns path_excluded, even if some
> paths inside it may have a countermanding ! entries that would match
> them?  What if we change that part smarter and allow it to descend?

That's the easy part, detecting a pair and continue descending. The
problem is after you descend, exclude engine may return contradicting
results on old patterns. It's the same thing that 3/2 describes (after
you change patterns from "!dir\ndir/file2" to "dir\n!dir/file2").
-- 
Duy
