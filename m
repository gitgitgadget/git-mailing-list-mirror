From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/2] sha1_name: fix error message for @{u}
Date: Wed, 22 May 2013 01:44:42 +0530
Message-ID: <CALkWK0kVAG4Gg3mgZv+0pXJocwDzZYS3gwVjxPy9cmBEkB2sFg@mail.gmail.com>
References: <1369132915-25657-1-git-send-email-artagnon@gmail.com>
 <1369132915-25657-2-git-send-email-artagnon@gmail.com> <7vtxlwp9mf.fsf@alter.siamese.dyndns.org>
 <CALkWK0mTWtJ_U1O7ZkNU3aNFwGH456xtmDJhhmS3z1tfwFPNgA@mail.gmail.com>
 <7vfvxgnrdo.fsf@alter.siamese.dyndns.org> <CALkWK0nEXKXxercc1mNjyK-QX0pOBeKWAxPZtSPvN_h1eniO5g@mail.gmail.com>
 <CALkWK0m7VBz3wDGUACJAfp33M1GYqKCeMCkQwrgA7kqRMp_rtQ@mail.gmail.com> <7vtxlwm6z4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 21 22:15:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uesy3-0003N3-39
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 22:15:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753223Ab3EUUPY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 16:15:24 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:34094 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752303Ab3EUUPX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 16:15:23 -0400
Received: by mail-ie0-f181.google.com with SMTP id x12so2919800ief.26
        for <git@vger.kernel.org>; Tue, 21 May 2013 13:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=/fW10PEI+CSInqBzJljxCPbz/VsVORrN7c+gHEqYj9E=;
        b=hrFQjRSuKZojie+nx9yPLfOAtLc14m3bbGcspoDNTrZG/PhiTqIycoDxbF41d0uXyw
         Wo7aJFYFU+aDJk2xs6P/UQbr6KTZwuUod2WwqwpB9B14S5dTRyNz2huSsrO7l2WGcfiQ
         h6umXdTOilHwQjq1qcyACXXSxOJ/pzgrJPRsMDjwXxvL1ic4JtWzNuP7gwrf1Dz5egUu
         m602YIrfNPPzG75POStC0yeRiKUNaMJ8uers1odKiZiWf3ajVmwfSOppiENVeuUheuVU
         gUiK7DCl53xaC6SJlXScjG1pTeRGwYYNVGyrOXCHV5B8YCkS7sWXFHE+Ji0cvrnQ7KJ3
         Wl9Q==
X-Received: by 10.50.66.140 with SMTP id f12mr2340525igt.63.1369167323143;
 Tue, 21 May 2013 13:15:23 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Tue, 21 May 2013 13:14:42 -0700 (PDT)
In-Reply-To: <7vtxlwm6z4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225072>

Junio C Hamano wrote:
>> interpret_branch_name -> interpret_branch_name (recursion)
>>                       -> get_sha1_basic -> get_sha1 [context] (end-user data)
>>                       -> substitute_branch_name -> dwim (end-user data)
>>                     -> strbuf_branchname (callers pass a branch name; no @{u})
>>                     -> revision.c:add_pending_object [with_mode] (end-user data)
>>
>> [die_]verify_filename -> builtin/rev-parse.c (end-user)
>>                     -> builtin/reset.c (end-user)
>>                     -> builtin/grep.c:cmd_grep (end-user)
>>                     -> revision.c:setup_revisions (end-user data)
>
> It seems that you are digging in the wrong direction?  I was worried
> about the callers of interpret_branch_name().

Um, aren't interpret_branch_name, get_sha1_basic,
substitute_branch_name, strbuf_branchname, and add_pending_object the
five callers of interpret_branch_name?  I've tried to show how they
are called with either end-user data or programmatic data without a
"@{u}".  What am I missing?
