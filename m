From: pi song <pi.songs@gmail.com>
Subject: Re: [PATCH 1/2] grep Added --blame so that grep can show result 
	tagged with blame entries
Date: Tue, 10 Mar 2009 22:29:49 +1100
Message-ID: <1b29507a0903100429v5b4a66d7sa9e3b32010fae2e0@mail.gmail.com>
References: <49B51791.4030801@gmail.com>
	 <7v7i2xaewh.fsf@gitster.siamese.dyndns.org>
Reply-To: pi.songs@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: gitster@pobox.com, git@vger.kernel.org, rene.scharfe@lsrfire.ath.cx
X-From: git-owner@vger.kernel.org Tue Mar 10 12:31:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lh0B8-000431-Mk
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 12:31:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754356AbZCJL3v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Mar 2009 07:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754337AbZCJL3v
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 07:29:51 -0400
Received: from wf-out-1314.google.com ([209.85.200.172]:5331 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754327AbZCJL3v convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Mar 2009 07:29:51 -0400
Received: by wf-out-1314.google.com with SMTP id 28so2544358wfa.4
        for <git@vger.kernel.org>; Tue, 10 Mar 2009 04:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=c13r06LP7+7t7hAGjtQguVAQtNOhWU7BRmZEurc+MaY=;
        b=SgV+6ljyx24y8M5g4sEbJ1TEHRckCqivJl04Zh57oGwK0xMvGWSNt4ZvtnSksRRa/d
         X5AD+tdEsTnEEZYRiFUDTsWdSThh8M6rHyPANqUpYDpxdRT75N9ezyzoQ/PU+GPXn0OB
         eonVtOEgjSKgDLknSOqGkE6J0eGGQ5bKM85qM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:content-type:content-transfer-encoding;
        b=kehuLZ0VEovZCyKSIeekHAEFhaXQZbJHHDFTTXj2bn1yNuECo6wkasRZTXgMkJU20A
         cwZRZBofd5cXzCk/le/vlN4zYCv+u7JvCYIkcTH7THy+TKLyYfmkTA+n66bpNUa+SiGi
         odZZcAVrY3TdPnQlEVqNyvWoNrY9MH6nJUeOE=
Received: by 10.142.141.21 with SMTP id o21mr2441150wfd.79.1236684589215; Tue, 
	10 Mar 2009 04:29:49 -0700 (PDT)
In-Reply-To: <7v7i2xaewh.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112806>

OK, I'll move my work to "next" branch. BTW, can anyone tell me what
the "next" and "pu" branch are for ?

Pi Song

On Tue, Mar 10, 2009 at 8:46 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> pi song <pi.songs@gmail.com> writes:
>
>> This part:-
>> 1) Move reusable bits from builtin-blame.c into blame.c, blame.h
>> 2) Replace static variables with context struct
>>
>> Signed-off-by: Pi Song <pi.songs@gmail.com>
>> ---
>> Makefile =A0 =A0 =A0 =A0| =A0 =A02 +
>> blame.c =A0 =A0 =A0 =A0 | 1919 +++++++++++++++++++++++++++++++++++++=
++++++++++++++
>> blame.h =A0 =A0 =A0 =A0 | =A0222 ++++++
>> builtin-blame.c | 2072
>> +++----------------------------------------------------
>> 4 files changed, 2245 insertions(+), 1970 deletions(-)
>> create mode 100644 blame.c
>> create mode 100644 blame.h
>
> This is simply too big to ask anybody sane to review (besides as we c=
an
> clearly see in the above the patch is severely whitespace damaged to =
be
> usable nor mechanically reviewable).
>
> I suspect that most of the file-scope static variables can be moved t=
o the
> scoreboard, and when the reusable parts are made public, some structu=
re
> and function names may need to become a bit more blame specific to av=
oid
> namespace contamination.
>
> Perhaps the first two patches in an equivalent series that is rerolle=
d to
> be reviewable would look like:
>
> =A0(1) move file-scope static variables to the scoreboard, and necess=
ary
> =A0 =A0 code changes associated with it;
>
> =A0 =A0 renaming of some structures and functions (if needed---I didn=
't
> =A0 =A0 check);
>
> =A0(2) create blame.c and blame.h, and move lines from builtin-blame.=
c *and*
> =A0 =A0 do NOTHING OTHER THAN
>
> =A0 =A0 - adding #include "blame.h" to builtin-blame.c,
>
> =A0 =A0 - adding necessary #include at the top of blame.c,
>
> =A0 =A0 - surrounding blame.h with necessary
>
> =A0 =A0 =A0 =A0 #ifndef BLAME_H
> =A0 =A0 =A0 =A0 #define BLAME_H
> =A0 =A0 =A0 =A0 ...
> =A0 =A0 =A0 =A0 #endif
>
> =A0 =A0 =A0 and finally
>
> =A0 =A0 - updating Makefile to add blame.c and blame.h
>
> =A0 =A0 This step will make a HUGE patch, and it is crucial for revie=
wability
> =A0 =A0 for it not to do anything other than line movement. =A0Ideall=
y, the
> =A0 =A0 patch shouldn't even reorder the structures and function defi=
nitions
> =A0 =A0 during this step.
>
> =A0 =A0 Then we can use "git blame" itself to make sure that no other=
 changes
> =A0 =A0 were sneaked in by mistake. =A0"git blame -C blame.h" and "gi=
t blame -C
> =A0 =A0 blame.c" would show everything came from builtin-blame.c.
>
> At this point, there shouldn't still be any behaviour change nor new
> feature. =A0And the titles of these preparatory step will never say a=
nything
> about "grep". =A0They are only refactoring "blame".
>
> Once this becomes solid, you can start adding features to blame.c to
> support your new caller, and we can be reasonably sure that such patc=
hes
> can be reviewed to decide if its change breaks the existing (and so f=
ar
> the only) caller builtin_blame() or not.
>
