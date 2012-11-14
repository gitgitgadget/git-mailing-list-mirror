From: Chris Rorvick <chris@rorvick.com>
Subject: Re: [PATCH v3 0/5] push: update remote tags only with force
Date: Wed, 14 Nov 2012 00:29:14 -0600
Message-ID: <CAEUsAPZtF-L5J_g1L5d44BKveoAnJ81PatX94fFS4FM=iW33KA@mail.gmail.com>
References: <1352693288-7396-1-git-send-email-chris@rorvick.com>
	<7v4nktdwtp.fsf@alter.siamese.dyndns.org>
	<CAEUsAPYvrR6WsVWCvwoEWA21gzL6Sib0sTyx-c_2tH=8ni69yQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Angelo Borsotti <angelo.borsotti@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Kacper Kornet <draenog@pld-linux.org>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 07:29:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYWTa-00012n-Jv
	for gcvg-git-2@plane.gmane.org; Wed, 14 Nov 2012 07:29:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752213Ab2KNG3R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 01:29:17 -0500
Received: from mail-lb0-f174.google.com ([209.85.217.174]:46874 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752179Ab2KNG3Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 01:29:16 -0500
Received: by mail-lb0-f174.google.com with SMTP id gp3so118979lbb.19
        for <git@vger.kernel.org>; Tue, 13 Nov 2012 22:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=DaUjUPRIAGau6DSP0TSh0UJxkPOrw0MRky5wvF20v1E=;
        b=Lqp24yjcZn3sozShoEDCS5XYbACFVkPm2DrT/JG2g8S0vGtWMu/HW046mgSNIpWyF7
         zUoly2wJZMb4VfI5PHu5I/Q7iu1ibxl8jkdf8JzBfSGhOse1tR8QDgF36L64Z+98JXx0
         sHhg2oioUBUeSjAmHwqe0/CyXapDmlChXn905JCjDlwrvjD3+ieh/CjIpyPbuN+MXnLy
         W3D6WtoPKTKPpJ1kxZiEGhZ6KkZqg8motQMZUliNZk83oGb+5/V2ywr4NQsmyqN3tEyu
         Sl0jHJG2xwvSieO5eodRjiCfNgrJn+57SyqLKn9NWNK+wbB26APzKbSy5Npu3JPuhn54
         pgMg==
Received: by 10.112.102.10 with SMTP id fk10mr10294577lbb.40.1352874554596;
 Tue, 13 Nov 2012 22:29:14 -0800 (PST)
Received: by 10.114.13.2 with HTTP; Tue, 13 Nov 2012 22:29:14 -0800 (PST)
In-Reply-To: <CAEUsAPYvrR6WsVWCvwoEWA21gzL6Sib0sTyx-c_2tH=8ni69yQ@mail.gmail.com>
X-Google-Sender-Auth: YWJeycCc0GsPMxltLSc5PtYWoWI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209697>

resending to list ...

On Tue, Nov 13, 2012 at 3:20 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Chris Rorvick <chris@rorvick.com> writes:
>
>> Minor changes since from v2 set.  Reposting primarily because I mucked
>> up the Cc: list (again) and hoping to route feedback to the appropriate
>> audience.
>>
>> This patch set can be divided into two sets:
>>
>>   1. Provide useful advice for rejected tag references.
>>
>>      push: return reject reasons via a mask
>>      push: add advice for rejected tag reference
>>
>>      Recommending a merge to resolve a rejected tag update seems
>>      nonsensical since the tag does not come along for the ride.  These
>>      patches change the advice for rejected tags to suggest using
>>      "push -f".
>
> Below, I take that you mean by "tag reference" everything under
> refs/tags/ (not limited to "annotated tag objects", but also
> lightweight tags).

Yes.

> Given that the second point below is to strongly discourage updating
> of existing any tag, it might be even better to advise *not* to push
> tags in the first place, instead of destructive "push -f", no?

That does seem like a better idea.  Read the full manual page to
figure out how to force the update if that's what you want to do--the
advice should not suggest something exceptional.

>>   2. Require force when updating tag references, even on a fast-forward.
>>
>>      push: flag updates
>>      push: flag updates that require force
>>      push: update remote tags only with force
>>
>>      An email thread initiated by Angelo Borsotti did not come to a
>>      consensus on how push should behave with regard to tag references.
>
> I think the original motivation of allowing fast-forward updates to
> tags was for people who wanted to have "today's recommended version"
> tag that can float from day to day. I tend to think that was a
> misguided notion and it is better implemented with a tip of a
> branch (iow, I personally am OK with the change to forbid tag
> updates altogether, without --force).
>
>>      I think a key point is that you currently cannot be sure your push
>>      will not clobber a tag (lightweight or not) in the remote.
>
> "Do not update, only add new" may be a good feature, but at the same
> time I have this suspicion that its usefulness may not necessarily
> be limited to refs/tags/* hierarchy.
>
> I dunno.

Are you suggesting allowing forwards for just refs/heads/*?  I
initially went this route based on some feedback in the original
thread, but being that specific broke a couple tests in t5516 (i.e.,
pushing to refs/remotes/origin/master and another into refs/tmp/*.)
My initial thought was that I'd broken something and I need to modify
the patch, but now I think I should just modify those tests.  Branches
are restricted to refs/heads/* (if I understand correctly), so
allowing fast-forwards when pushing should be limited to this
hierarchy, too.

Thanks,

Chris
