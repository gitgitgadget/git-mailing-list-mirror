From: Mike Rappazzo <rappazzo@gmail.com>
Subject: Re: [PATCH v4] git-rebase--interactive.sh: add config option for
 custom instruction format
Date: Fri, 12 Jun 2015 18:15:44 -0400
Message-ID: <CANoM8SXQq_zbRui7SHDDAnrgf2VUdCkkJJ7_RHLu355JUzdNxA@mail.gmail.com>
References: <1434075808-43453-1-git-send-email-rappazzo@gmail.com>
 <1434075808-43453-2-git-send-email-rappazzo@gmail.com> <xmqqa8w4d4sc.fsf@gitster.dls.corp.google.com>
 <CANoM8SW-N6_yJ0kgGDuGWB+RS-0d54D4FtaRbKqhsf0_fSeMdw@mail.gmail.com> <xmqqzj44bn1l.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 13 00:16:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3XFD-00008e-Ed
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jun 2015 00:16:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755021AbbFLWQH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2015 18:16:07 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:35317 "EHLO
	mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459AbbFLWQF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2015 18:16:05 -0400
Received: by oiax69 with SMTP id x69so5843207oia.2
        for <git@vger.kernel.org>; Fri, 12 Jun 2015 15:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=6XwkGAijkdYwfOFQnaxT6Q2dPNqVl8xm8Kxq674yj90=;
        b=ICCt8HzF7oy16Ky6IdBEHYd216NpVAw6jw6LwXPWE7SlKSqJbHSlmfrcN04jq1Mzb0
         OZ2EIYP6JrVP41QindV3dW3hOQZFee32Mi8M9aEEmXnOKPiZHgs9rAKmCWKdg/unWHEJ
         KpI3UeMbt7ASCKG4Km8/XlVxPgvATnPhgxJBFgPgx9nphZgtRb5LzMYGeLExuxvKzqFG
         Q/FJSB77vSWzibbErkJIT/Z/FDGO3Irp15UMMX0fUsM9qd6EGhBR671ZKURzNrnu3Ftn
         dXIZ4AEtrQ5EOEBuLrlzmbfInF8Si4tOxkcJigBmd3WfKGHJNpjOK+5wWQopzNuuN9nR
         +9WQ==
X-Received: by 10.202.188.139 with SMTP id m133mr13328069oif.73.1434147364724;
 Fri, 12 Jun 2015 15:16:04 -0700 (PDT)
Received: by 10.202.204.20 with HTTP; Fri, 12 Jun 2015 15:15:44 -0700 (PDT)
In-Reply-To: <xmqqzj44bn1l.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271535>

On Fri, Jun 12, 2015 at 6:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
> But because you overwrite the $message variable you read from the
> original insn sheet (which uses the custom format) and compute $rest
> based on the default "%s" and store that in "$1.sq", lines in
> "$1.sq" do not know anything about the custom format, do they?
>
> And then they are injected to appropriate places in "$1.rearranged".
> Moved lines in the the rearranged result would end up written in the
> default "%s" format, no?
>
> That was the part that made me uneasy.
>
> I do not think that is a bug worth fixing, but I view it as a sign
> that fundamentally the autosquash and the idea of configurable
> format do not mesh well with each other.

My understanding of the rearrange_squash function is this:
There are two loops.  The first loop collects the commits which should
be moved (squashed).  The second loop re-constructs the instruction
list using the info from the first loop.

In the second loop, I changed it to recalculate the presented message
when the re-ordered commit is added:

+       if test -n "${format}"
+       then
+            msg_content=$(git log -n 1 --format="${format}" ${squash})


That is the "$rest".

I have patched my locally installed `git-rebase--interactive` with
these changes, and I did see the proper rearrangement of commits with
the custom formatted message.
