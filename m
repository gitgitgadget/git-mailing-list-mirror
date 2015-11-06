From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 25/25] refs: break out ref conflict checks
Date: Fri, 06 Nov 2015 15:24:18 -0800
Message-ID: <xmqqd1vm3e59.fsf@gitster.mtv.corp.google.com>
References: <cover.1446534991.git.mhagger@alum.mit.edu>
	<3060e6410e8798064ef84cd31645021d1b84fbb9.1446534991.git.mhagger@alum.mit.edu>
	<1446670884.4131.42.camel@twopensource.com>
	<563AD452.2030301@alum.mit.edu>
	<1446740535.4131.50.camel@twopensource.com>
	<563CAC58.3070907@alum.mit.edu>
	<xmqq611f3umt.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat Nov 07 00:24:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuqMy-0005uo-DF
	for gcvg-git-2@plane.gmane.org; Sat, 07 Nov 2015 00:24:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757699AbbKFXY2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2015 18:24:28 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63992 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757640AbbKFXY1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2015 18:24:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 244BB29810;
	Fri,  6 Nov 2015 18:24:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PGWt2LUI+WDUebMGu8NXuRqtepo=; b=B242ZN
	/h9jzRtHCuNmZUUX1PEkUzJ2/iPmwv4rftoJQHjzE/vJP6n9tkeyx2SHMIhW5y0i
	Q0ANBocUSnQHHw0uZPyJZZJFK2uVlfwL92t8etc0Ho4H5DFpKPan+3aDL8xOykFe
	4+kS3r99nv2XZ+qO4yEH0EeEby0AXUzQzfCWU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kWSmXti9lyWI83p+Z7bx4Udqj2BS1nrA
	z0F4QRNiDHiGQJyC8+0Puc3Ee/j7ORZuRYyWXU19zLW0horaCazee3EZ9qKzG2Qk
	ci2eL7VgibW18tH49186e52Izwmbcia4NFo7/rpdrZk6pe7SD3zDEmooH4aLwCRM
	2OCUdGIZm3E=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1B09C2980F;
	Fri,  6 Nov 2015 18:24:21 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 243C82980E;
	Fri,  6 Nov 2015 18:24:20 -0500 (EST)
In-Reply-To: <xmqq611f3umt.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Fri, 06 Nov 2015 09:28:10 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8199033E-84DD-11E5-91EF-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281004>

Junio C Hamano <gitster@pobox.com> writes:

> Michael Haggerty <mhagger@alum.mit.edu> writes:
>
>> Junio, if there are no more comments, would you mind
>>
>>     s/verify_no_descendants/find_descendant_ref/
>>
>> in the log message of this commit? And then, if you are also OK with the
>> new subdirectory introduced in this patch series, David and I seem to be
>> in agreement that it is ready to go. It would be great if this patch
>> series could be merged in a timely manner, as it will conflict with
>> nearly any other changes that people might want to undertake in the refs
>> code.
>
> Thanks for working well together.  Let me see what I can do today...

What I'll push out later today merges this to the tip of 'pu'.
The resolution is the same for 'jch' or 'next' (I checked).

I have to say that the merge of this topioc is not pretty.  A topic
that is already in flight has changed ref_is_hidden() in refs.c; you
move this block of code first to refs/refs-backend.c and then to
refs/refs.c, and the recursive merge ends up saying "The trunk side
changed this block of code in refs/refs-backend.c while the side
branch removed that block".

The resolution has to become an evil merge that brings in a new file
refs/refs.c from the tip of your topic to the trunk while replaying
that change in the lost block to that new file.  Because an
in-flight topic like this one needs to be merged over and over until
it gets merged to 'master' I'd prepare an evil merge-fix to be
squashed into the result of an auto-merge to help this process for
the interim maintainer, but this topic is placing more burden than
it otherwise would to the entire process.

Incidentally, that was why I originally asked you if you want to be
an interim maintainer for this cycle.  Whoever is doing a large code
movement with a large patch series must be the one who would know
the best how its interaction with other topics is best managed.

I wonder if refs.c -> refs/refs.c rename is a good idea.  I do agree
that refs/ subdirectory that collects the backend implementation
details is a very sensible thing to do, but if the public and
generic API were left in refs.c, this particular conflict might have
been less severe and easier to handle.  Whatever.

For those who are listening in from sideline, in case when they need
to deal with a similar situation "the code our side changed gets
moved to elsewhere by a side branch", here is what I did:

 * let "git merge --conflict=diff3" attempt and fail.

 * a conflicted file will have something like this:

    <<<< ours
    ... the code with changes made by our side (trunk) ...
    |||| base
    ... the code before our side (trunk) made the above changes ...
    ====
    >>>> theirs

 * create two new files, OURS and BASE.  Save the part in that
   conflicted file between <<<< and |||| to OURS, and between ||||
   and ==== to BASE.

 * look at "diff -u BASE OURS", find in the (failed) automerge
   result where the original went (a sample of it is at the end of
   this message), and apply that change manually.

The above is only to resolve this conflict *once*.

Automating future merges of this branch into a slightly updated
codebase needs help from rerere and also merge-fix/ machinery (this
is not in core-git proper, but the tool is in the 'todo' branch and
its use is described in howto/maintain-git.txt).

Essentially the procedure were:

 * "git checkout pu^0"

 * let "git merge --conflict=diff3" attempt and fail.

 * accept removal of the conflicted block in refs/files-backend.c in
   the editor, do "git rerere" to record it.  commit the result.

 * apply the above diff between BASE and OURS, commit the result.

 * git update-ref refs/merge-fix/dt/refs-backend-pre-vtable HEAD

With this, the Reintegrate script (on 'todo', checked out in "Meta/"
subdirectory) will be able to reproduce the evil merge, e.g.

 $ git checkout pu
 $ echo dt/refs-backend-pre-vtable | Meta/Reintegrate

would first let "git rerere" replay the removal of conflicted block
in refs/files-backend.c and then amend the result by squashing the
change in merge-fix/dt/refs-backend-pre-vtable.


--- V_BASE	2015-11-06 14:51:10.150197900 -0800
+++ V_OURS	2015-11-06 14:51:05.638059250 -0800
@@ -117,7 +117,7 @@
 	return 0;
 }
 
-int ref_is_hidden(const char *refname)
+int ref_is_hidden(const char *refname, const char *refname_full)
 {
 	int i;
 
@@ -125,6 +125,7 @@
 		return 0;
 	for (i = hide_refs->nr - 1; i >= 0; i--) {
 		const char *match = hide_refs->items[i].string;
+		const char *subject;
 		int neg = 0;
 		int len;
 
@@ -133,10 +134,18 @@
 			match++;
 		}
 
-		if (!starts_with(refname, match))
+		if (*match == '^') {
+			subject = refname_full;
+			match++;
+		} else {
+			subject = refname;
+		}
+
+		/* refname can be NULL when namespaces are used. */
+		if (!subject || !starts_with(subject, match))
 			continue;
 		len = strlen(match);
-		if (!refname[len] || refname[len] == '/')
+		if (!subject[len] || subject[len] == '/')
 			return !neg;
 	}
 	return 0;
