From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH 2/2] log: remove redundant check for merge commit
Date: Fri, 27 Jul 2012 21:52:59 -0700
Message-ID: <CAOeW2eFROgZ+taqFvCHoSTVrQZnaQZo567e=73BcA+d5uSjKDA@mail.gmail.com>
References: <1343409699-27199-1-git-send-email-martin.von.zweigbergk@gmail.com>
	<1343409699-27199-3-git-send-email-martin.von.zweigbergk@gmail.com>
	<7vfw8czvj5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 06:53:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Suz1W-0003qU-E0
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 06:53:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752294Ab2G1ExA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jul 2012 00:53:00 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:51413 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752223Ab2G1Ew7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2012 00:52:59 -0400
Received: by vbbff1 with SMTP id ff1so3332250vbb.19
        for <git@vger.kernel.org>; Fri, 27 Jul 2012 21:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=AIV5k5/F1Rs5x+2XpdxMwFzMGu6FQzomfU1GS6WEEss=;
        b=HG6Qc0zXd2Yjr4NWbgL4dly8e0R/Dx3+rofRumOAzVAEJF8UtUZPcuI8Zbv3SxL3ak
         sIkoPQcNRr97YfpXRVUh6LJNIiqDE7uukSJdc3aXWsV9lCwb8HDemXks4R0cGW83R9uO
         B2/sYHZkj25INWkza45Z1mdmLRHGqn+IcSM0jyYUiisxTD0lmlY4qsq3C1qcPB4k6ubz
         6r8Ki/+pVVjXFUdzYVctTo+AGIllg+MH8dDDZ01bESFLQR46QUV+s1RXgt0P8bArCvxe
         fO9lcVuN5yfynTkRn+taIyLsrUKXjwv/6YFbM8a0lQDeZLlhFg4LpTqRsFkkHEPQFNT/
         L2ig==
Received: by 10.52.97.196 with SMTP id ec4mr4107090vdb.96.1343451179094; Fri,
 27 Jul 2012 21:52:59 -0700 (PDT)
Received: by 10.58.219.165 with HTTP; Fri, 27 Jul 2012 21:52:59 -0700 (PDT)
In-Reply-To: <7vfw8czvj5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202404>

On Fri, Jul 27, 2012 at 3:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:
>> Also re-initializing rev_info fields to the same values already set in
>> init_revisions().

Oops, that should have been " _avoid_ re-initializing".

> I suspect that
> explicit initialization to revs.ignore_merges outself can be called
> belt-and-braces defensive programming to avoid getting surprised by
> future changes to what init_revisions() would do, so I do not have
> strong preference either way.

I suspected the same, but OTOH, if it was ever changed, one would have
to go through all call sites anyway. I checked the other calls to
init_revisions (48 of them, I think) and I found only 3 other places
where a field was re-initialized to the same value. In this case it
was done inconsistently even within the file. Seeing init_revisions()
followed by "revs.ignore_merges = 1;" in one place but not the other
can easily lead one to believe that the other place does not ignore
merges.

Do you want a reroll with updated commit messages (the missing "avoid"
above, the dropped "seems like" about the prefix in 1/2)? Since you
don't have a strong preference about the explicit initialization, I
assume I can leave those hunks in. I would clarify my reasoning,
though.

Martin
