From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH/RFC] add: listen to --ignore-errors for submodule-errors
Date: Tue, 26 Jun 2012 10:25:23 +0200
Message-ID: <CABPQNSZmQOiwOo_dV43BidT3TRp63mOJeJWe4pK-9z0ryB6_QQ@mail.gmail.com>
References: <1340666519-41804-1-git-send-email-kusmabite@gmail.com> <7vfw9ieqvh.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 26 10:26:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjR6F-0001i4-89
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 10:26:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758450Ab2FZI0I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Jun 2012 04:26:08 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:41287 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754696Ab2FZI0E convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jun 2012 04:26:04 -0400
Received: by pbbrp8 with SMTP id rp8so7717804pbb.19
        for <git@vger.kernel.org>; Tue, 26 Jun 2012 01:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=aomatDae/8cpHD5s+mRSCbxa50j6S5gCxi84S4SImh4=;
        b=uJe++7gfq0peBUtXPnTIoEwMpzefLMrxRivb1PJZaUHVddcdScs2NPSiK+Io93ItRj
         4/kqi2JqCt3cG9WO7SjeSHUFDwXxPfjujYxgXBA3WoIJxk4LC8NwNzPynUKaACFucupO
         /omhMVJrQLqIRttVXVMuvTP5SQhuwHO1JUjmUvPDO/zZBwUD0LU5KbQ465usgUF99D+3
         92h82eVbTtBJ6YQhUhU2zskAiVkwwblisRHe2g0a4vxlmDfk2yrrtC9S+SqdtCC0AED7
         1sLQDyaCNcfV12t4ryBHTzVdMkEJMxp76zHCurPM2rpjoU2SHkFi72giyxfIJx3i2UgR
         pFOw==
Received: by 10.68.203.7 with SMTP id km7mr49634099pbc.7.1340699163640; Tue,
 26 Jun 2012 01:26:03 -0700 (PDT)
Received: by 10.68.40.98 with HTTP; Tue, 26 Jun 2012 01:25:23 -0700 (PDT)
In-Reply-To: <7vfw9ieqvh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200637>

On Tue, Jun 26, 2012 at 4:41 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Erik Faye-Lund <kusmabite@gmail.com> writes:
>
>> I recently tried to do the following in the msysGit-repo:
>>
>> =A0$ git add --ignore-errors -- */.gitignore
>> =A0fatal: Path 'src/git-cheetah/.gitignore' is in submodule 'src/git=
-cheetah'
>>
>> I was a bit puzzled by this; I explicitly specified --ignore-errors
>> because I did not want to be stopped due to src/git-cheetah/.gitigno=
re
>> being located in a submodule.
>
> If I recall correctly, originally --ignore-errors was added was by
> those who (arguably misguidedly) wanted to randomly run "git add"
> that can potentially race with ongoing working tree updates
> (i.e. think of a poor-man's unreliable snapshotting filesystem), to
> which "git add" will notice that the working tree file it was asked
> to index changed while it was reading and error out. =A0Also on some
> systems, "git add" on files that are currently open may not be able
> to read from them, which would also cause a run-time error. =A0The
> kind of errors the option was meant to ignore were "these paths are
> perfectly OK to add, but for some reason, adding them fails at this
> moment, and for the purpose of poor-man's unreliable snapshot, it is
> OK not to pick the exact current state up, as we will pick it up the
> next round", not your kind of request that will lead to an error of
> the "adding this path will break the structural integrity of the
> repository and git should error out" kind.
>

Right. I guess my confusion was due to the documentation wording "If
some files could not be added *because of errors indexing them*, do
not abort the operation". It's not obvious to me that "because if
errors indexing them" means what you describe above.

>> The documentation seems to suggest that this is what is supposed to
>> happen, and this seems like the most likely behavior that the user
>> wanted. After all, there's no good reason submodules are special
>> in this regard, no?
>
> How does "git add .git" or "git add .git/config" behave with your
> patch applied? =A0It is exactly the same kind of error that breaks th=
e
> structural integrity of the repository as adding src/cheetah/.gitigno=
re
> to the top-level project repository, and there is no good reason to
> special case submodules, either.

Both "git add .git" and "git add --ignore-errors .git" returned
silently without error even before my patch.

"git add .git/config" outputs
"error: Invalid path '.git/config'
error: unable to add .git/config to index
fatal: adding files failed"

=2E..and "git add --ignore-errors .git/config" outputs
"error: Invalid path '.git/config'
error: unable to add .git/config to index"

=2E..this is both before and after my patch. I didn't touch that part o=
f
the code-path, so this already treats these errors as non-fatal when
--ignore-errors are specified.

I simply found a new code-path where errors weren't ignored, but there
might of course be more. However, the lack of a "fatal: adding files
failed" for files inside .git seems to suggest to me that even though
the intent might be what you describe above, that is not actually what
the code does.

Of course, silently ignoring "git add .git" seems odd to me.
