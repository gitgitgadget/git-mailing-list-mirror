From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/6] notes: replace pseudorefs with real refs
Date: Tue, 28 Jul 2015 19:00:08 -0700
Message-ID: <xmqqh9onbu53.fsf@gitster.dls.corp.google.com>
References: <1438107144-24293-1-git-send-email-dturner@twopensource.com>
	<1438107144-24293-3-git-send-email-dturner@twopensource.com>
	<xmqqpp3cds44.fsf@gitster.dls.corp.google.com>
	<xmqqegjsdq3n.fsf@gitster.dls.corp.google.com>
	<CALKQrgdLC_sLkM3jyH6pnDoY+RTHr9wJR_VH6iirBWmvyHYcVA@mail.gmail.com>
	<xmqqpp3bc2u6.fsf@gitster.dls.corp.google.com>
	<CALKQrgfxc83-yjrCWZqC+pyPhbQDgYbrpCDSaBk78YypO=BXOg@mail.gmail.com>
	<xmqqlhdzby5o.fsf@gitster.dls.corp.google.com>
	<55B824BD.8000003@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johan Herland <johan@herland.net>,
	David Turner <dturner@twopensource.com>,
	Git mailing list <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Philip Oakley <philipoakley@iee.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Jul 29 04:00:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKGfM-0001Ak-BF
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 04:00:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752246AbbG2CAN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 22:00:13 -0400
Received: from mail-pd0-f193.google.com ([209.85.192.193]:35967 "EHLO
	mail-pd0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752107AbbG2CAM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 22:00:12 -0400
Received: by pdbfq13 with SMTP id fq13so8110411pdb.3
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 19:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=JwrzdhzEzFIzh1P7wWze6t+gac4dvjobqNyP8FmMlHM=;
        b=brYU6d1ZfE6oVXExDGpq6g+SJNDiKe1ff6vkvmXBClSSfWF9y0a47J0ZieF4gIURuo
         pJMipnrz0+LdNLA5QAj+Yoe9qweeKOQvUu/htl/j9QytfXFYhAwnRMJ20QKJNAirX3Ag
         oRZAZ0NQGLlGXSNMbj2KDXVDw5k6znBCQM4nPZ7/8Sf2lpK4vjSPuFHYlYiK0gnpdMsT
         2MgIYBWQ2V+uO400peG727oUlryx04mDKL3a21lGvvjw9qUVBIGn22jl7FSw/ahhK2Tb
         tD3WcEArGdRcPiWfPVMLKAEytPNAtJytWqzJHyLXUar2CKzlNUsBNslNRZhH/CB0ghWV
         cT0Q==
X-Received: by 10.70.41.202 with SMTP id h10mr86741194pdl.155.1438135211783;
        Tue, 28 Jul 2015 19:00:11 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:e592:68fd:3f1d:35f9])
        by smtp.gmail.com with ESMTPSA id w3sm37435248pdl.45.2015.07.28.19.00.09
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 Jul 2015 19:00:09 -0700 (PDT)
In-Reply-To: <55B824BD.8000003@alum.mit.edu> (Michael Haggerty's message of
	"Wed, 29 Jul 2015 02:56:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274873>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> It sounds like what a notes merge really wants is a new linked worktree
> that has branch refs/notes/foo checked out:
>
> * This would allow multiple notes merges to take place at the same time
> provided they target different merge references.
>
> * This would prevent multiple notes merges to the same notes reference
> at the same time by the same mechanism that prevents the same branch
> from being checked out in two linked worktrees at the same time.
>
> It's just a thought; I have no idea whether it is practical...

That was certainly one of the possibilities that crossed my mind.

In any case, the primary thing I am interested in at this point is
to unblock David's "prepare things so that we can put primary refs
in a different ref backends more easily" topic, and I've already
made my point a few messages ago upstream:

    I think it is OK for us to admit that the "notes" subsystem is
    not quite ready to work well with multiple working tree world
    yet [*1*], and move this series forward without worrying about
    them.

So doing the absolute minimum, leaving the "now what can we do to
improve notes-merge process?" outside the scope of the topic.

Improving the notes-merge process is also an interesting topic, but
it is clear that people started thinking about it today ;-), so it
can wait without blocking David's work.  The refs/notes/* hierarchy
will be handled exactly the same way as regular branches in the
pluggable ref-backends, and how the ephemeral REF_NOTES_REF and
friends are represented (some are refs, some may be pseudo-refs,
some may be just a filesystem entity) would need to be revamped if
we really do the "improving notes-merge" thing anyway, so David's
topic shouldn't be blocked by the "possible future tweak" of the
current design that hasn't happened yet.  Instead, improving
notes-merge can be done on top, potentially undoing and redoing
Davi'd topic.
