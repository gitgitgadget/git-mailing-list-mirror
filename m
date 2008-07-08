From: "Eric Raible" <raible@gmail.com>
Subject: Re: PATCH] Documentation: Tweak use case in "git stash save --keep-index"
Date: Tue, 8 Jul 2008 00:40:56 -0700
Message-ID: <279b37b20807080040y47b87c35r9b1aa33236a86da6@mail.gmail.com>
References: <279b37b20807072218o19dabd97y2c4edc62fb980ca4@mail.gmail.com>
	 <7vlk0dvsr5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>, szeder@ira.uka.de
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 09:41:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KG7pj-0003gB-LY
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 09:41:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752677AbYGHHk6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 03:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752510AbYGHHk6
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 03:40:58 -0400
Received: from wf-out-1314.google.com ([209.85.200.171]:38343 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752015AbYGHHk5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 03:40:57 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2435837wfd.4
        for <git@vger.kernel.org>; Tue, 08 Jul 2008 00:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=HwjG2rlGrz9vGfy2G5jf3hD0h1wwLx0sWZTwqiqZEWw=;
        b=nrJQZpbStoa+C9KzMFqbDKCprJ+29ngzgLT0WgzYUJQnthXWnm/AAH/oLR5sdKxeZl
         j2AldhAHNB/SVcCxVJ6hcWNDCiZuRR7ugeRfEEenmDk2a99SHCOpT05gN0pJssgrsaAG
         TQ8zEfdFR/Yvzxe/RzKkK9vea3gKihCy5pK8g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=fz3bwPGipq5zDNK7rAAqKvqf0bFH/b4DcqIFvPCOg1MJlGuc6wbtYtDPT+jMpTZOhs
         a0QE8JCRJkDDpjoDHDok0IwdPUqh5+4BoL15DQX68o7ZcPwDezbAbevuh/bPUg5xavdr
         Dnbo1GPdOB43c0y+OMtBm6hOMZZ6oCU0/vxN8=
Received: by 10.143.8.10 with SMTP id l10mr1680029wfi.340.1215502856849;
        Tue, 08 Jul 2008 00:40:56 -0700 (PDT)
Received: by 10.142.14.12 with HTTP; Tue, 8 Jul 2008 00:40:56 -0700 (PDT)
In-Reply-To: <7vlk0dvsr5.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87728>

The documentation suggests using "git stash apply" in the
--keep-index workflow even though doing so will lead to clutter
in the stash.  And given that the changes are about to be
committed anyway "git stash pop" is more sensible.

Additionally the text preceeding the example claims that it
works for "two or more commits", but the example itself is
really tailored for just two.  Expanding it just a little
makes it clear how the procedure generalizes to N commits.

Finally the example is annotated with some commentary to
explain things on a line-by-line basis.
---
[Note: If we can't rely on fixed-width fonts then the resulting
example will look stupid]

On Mon, Jul 7, 2008 at 10:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Also this may be a good way to split an existing commit into five during a
> "rebase -i" session, and the example in the documentation might want to
> talk about it in that larger picture.

If you're talking about 'edit' mode, doing a "reset HEAD^", and then
using the same "add --patch"/"stash save -k-i"/commit/"stash pop"
cycle in question then I understand and agree.  But only if the
user wants to test each part separately.

Otherwise why bother with stash-k-i when you can just loop
on add-patch/commit or use git-gui?
--
 Documentation/git-stash.txt |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index df26901..7d50d74 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -197,13 +197,14 @@ each change before committing:
 +
 ----------------------------------------------------------------
 ... hack hack hack ...
-$ git add --patch foo
-$ git stash save --keep-index
-$ build && run tests
-$ git commit -m 'First part'
-$ git stash apply
-$ build && run tests
-$ git commit -a -m 'Second part'
+$ git add --patch foo            # add just first part to the index
+$ git stash save --keep-index    # save all other changes to the stash
+$ edit/build/test first part
+$ git commit foo -m 'First part' # commit fully tested change
+$ git stash pop                  # prepare to work on all other changes
+... repeat above five steps until one commit remains ...
+$ edit/build/test remaining parts
+$ git commit foo -m 'Remaining parts'
 ----------------------------------------------------------------

 SEE ALSO
-- 
1.5.6.1.1073.g489ff.dirty
