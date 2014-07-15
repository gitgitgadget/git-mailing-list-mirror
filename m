From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v20 43/48] refs.c: move the check for valid refname to lock_ref_sha1_basic
Date: Tue, 15 Jul 2014 12:35:28 -0700
Message-ID: <CAL=YDWmz=yQGs8HcwO1rkg1UfBy6jEhipA2vkO+jg9Wcu1GaTA@mail.gmail.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
	<1403275409-28173-44-git-send-email-sahlberg@google.com>
	<53BC07FC.8080601@alum.mit.edu>
	<20140715180424.GJ12427@google.com>
	<xmqqtx6iv5cs.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 21:35:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X78Vj-0002vd-JL
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jul 2014 21:35:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933509AbaGOTfd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 15:35:33 -0400
Received: from mail-vc0-f175.google.com ([209.85.220.175]:39437 "EHLO
	mail-vc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933213AbaGOTf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 15:35:29 -0400
Received: by mail-vc0-f175.google.com with SMTP id hu12so6086050vcb.6
        for <git@vger.kernel.org>; Tue, 15 Jul 2014 12:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=xUy6NIDkCWO7glh1g2zOxaIwK+dXGvOSg1LDgR+mjgA=;
        b=e3sLexz+8tbI8H9lSSS/L2xBVqNqzWglx5qqGCocsIDnWX7n5btWPpr7a41LYCEA+X
         ekRTmfCWkzpCCUr/5BUxIQAsG5UUpCHrSY9FN6lYOrH9Hl/8bHeE9quI2dvRAqUIbjyl
         r3Ftn7CxQ4+cWbXLW5ep2MLT5QtAz0KKPjLhHwvabzL3OkQyUqc8pkX5MuZCpAy3It8D
         xrU9IuU1AsQawx/Zs7lsluX4X4rFgJIR2owgIlFUMomLDjlXnl/YOkohgzQzSyApZwdw
         eYEjYPw1Du7wnV9e07m8UNiWT66qoZEKPfmmlLFi1A2LX0bj51zUY5lLeRLVIwJG/l6r
         6ozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=xUy6NIDkCWO7glh1g2zOxaIwK+dXGvOSg1LDgR+mjgA=;
        b=S3Q+BYkozedKswTuFEPf2zKBGgQZUpriFIUS23SrU6P0SF8TUQAeY1AcvQY07/3ecC
         vhE1+QbouTR5e6z1g2u0ib8SkNg4KCBLjOUmfeLuQqD/jiAUqMU8Nefhur9vxgh0Pf8v
         zXsJEj8F584gsL5AQZfE3p1WcO43vuZFDjK3sisBOLghZXj6INFye9ksaHYthMfNKxai
         kKx7TdqY4Rq+r0FcssvmqW/U3e/a0Yza6j5Uo5iP2sZ0gV8hWO3JY9eV7NhmQI79LvhY
         6z1gugnH68bxSbe88C/rAwAZc++DGJS3xG9Ttz59O09yjMSvmmMb+jiUY9G79+0WbYLZ
         VxiA==
X-Gm-Message-State: ALoCoQlg05G8lfkhhfxUdsjzi6IgFRieQZMbylzgJ1ab26rxCY5I/YIPVZ+BxcPptbRTZHtq6z75
X-Received: by 10.220.200.71 with SMTP id ev7mr11203188vcb.24.1405452928275;
 Tue, 15 Jul 2014 12:35:28 -0700 (PDT)
Received: by 10.52.136.166 with HTTP; Tue, 15 Jul 2014 12:35:28 -0700 (PDT)
In-Reply-To: <xmqqtx6iv5cs.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253593>

On Tue, Jul 15, 2014 at 11:34 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> How to take care of the recovery use case is another question.  FWIW I
>> also would prefer if "git update-ref -d" or "git branch -D" could be
>> used to delete corrupt refs instead of having to use fsck (since a
>> fsck run can take a while), but that's a question for a later series.
>
> Good thinking.
>
>> In an ideal world, the low-level functions would allow *reading* and
>> *deleting* poorly named refs (even without any special flag) but not
>> creating them.  Is that doable?  The main complication I can see is
>> iteration: would iteration skip poorly named refs and warn, or would
>> something more complicated be needed?
>
> I somehow thought that was what we have always designed for, which
> DO_FOR_EACH_INCLUDE_BROKEN was a part of.

I think that include broken only handles the case where the ref itself
is bad, not when the refname is bad.
I.e. it affects cases where the sha1 does not exist or the symref
points to nowhere.
