From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff-tree: do not show the sha1 of the given head with --quiet
Date: Thu, 23 Jul 2015 13:43:07 -0700
Message-ID: <xmqqzj2mobac.fsf@gitster.dls.corp.google.com>
References: <0000014eb518dc87-a69705c4-31e7-4983-99a8-f780a743aeac-000000@eu-west-1.amazonses.com>
	<xmqqmvyoq6gh.fsf@gitster.dls.corp.google.com>
	<CAHGBnuM5TG6m7Rwd-EZTUXnaDNYomidthmCamCevNECTQCTnmA@mail.gmail.com>
	<20150723180846.GB18686@peff.net>
	<xmqq4mkupss7.fsf@gitster.dls.corp.google.com>
	<CAHGBnuM6sgegeq0AXTcS7QNX4_X3GYNf--srq0HH0K_owG3JQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 23 22:43:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZINKm-0005J3-59
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jul 2015 22:43:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754109AbbGWUnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2015 16:43:12 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33092 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753507AbbGWUnK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2015 16:43:10 -0400
Received: by padck2 with SMTP id ck2so1826315pad.0
        for <git@vger.kernel.org>; Thu, 23 Jul 2015 13:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=n2746VLRcPuBPElxyozLXvIyrLiEtVesWaKHQb8vVjI=;
        b=TxiE5VdTxtscUuIkhBSuUQxMBPfAetG88w0AKUA4uB13tpWISJgEKfn2+HxhUeKkg1
         hzcLx0Z/P+JyLK8C/l3i/ng9nB9mTNtnwIr8H7au/cnHraoTuNX2S95SNBMaclW0ynz/
         CyBWJ4mNJckIDS++3F9e4fk1/WMRClOnF4EFRmUQiCGHzg9DCX+6XXV7rW3bglb+C1rQ
         VwCO8SYhY5AW+DW+weXjK6373BrDEBbxRH6dsfiniefXEdWNymuPoaYRa1L2I8WcZNdX
         W55rFBDVWPW4pKfx/gClsehyFOS3tpkdprgj5+gL/2lxMC8XAR0qs7lf18CqFIIbzzKr
         jCwQ==
X-Received: by 10.70.38.136 with SMTP id g8mr21963485pdk.156.1437684189907;
        Thu, 23 Jul 2015 13:43:09 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:156f:a37c:e915:d6df])
        by smtp.gmail.com with ESMTPSA id w3sm10556394pdl.45.2015.07.23.13.43.08
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 23 Jul 2015 13:43:08 -0700 (PDT)
In-Reply-To: <CAHGBnuM6sgegeq0AXTcS7QNX4_X3GYNf--srq0HH0K_owG3JQg@mail.gmail.com>
	(Sebastian Schuberth's message of "Thu, 23 Jul 2015 22:19:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274525>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> On Thu, Jul 23, 2015 at 9:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> I haven't dug into why that happens, but possible ways to fix that
>> are to make "--quiet" output all (making it consistent with "-s") or
>> no (making the command totally silent) output at all ;-).
>
> Exactly, and I chose the latter to add some value to --quiet instead
> of making it an alias for -s.

Heh.  You didn't even know when "diff-tree --stdin --quiet" would be
useful, let alone that it had a bug that made it useless for that
exact use case.  So it cannot be "I chose the latter".

I just gave you a hint so that you can write a plausible-sounding
justification, and we both know that it is very different from your
original motivation.

Be honest.

Perhaps the log message would say something like this:

	$ git rev-list ... | git diff-tree --stdin --quiet [$pathspec]

	is a way to list the commits that modifies the named paths,
        but this bug <<<analysis of the bug comes here>>> makes it
        not to emit all such commits.  It couldn't have been used
        by existing scripts with this longstanding bug.

	We could fix it so that it does not randomly skip commits
	that ought to be shown, but that feature is already
	available by the "-s" option instead of "--quiet".

        So let's change the meaning of "--quiet" to make it really
        quiet, without giving any output.  Strictly speaking, this
        may break backward compatibility but the existing behaviour
        to randomly omit commits couldn't have been useful, so there
        is no harm done.

	And as an added bonus,

	$ git diff-tree --quiet $commit [$pathspec]

	would stop showing the commit object name.

The analysis of the bug is really crucial for the above description
to work as justification for this change, substanciating the words
"longstanding" and "randomly omit" that are used to convince us that
this option couldn't have been used by real scripts.
