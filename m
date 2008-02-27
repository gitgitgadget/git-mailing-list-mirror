From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 05/10] builtin-fsck: move common object checking code to
 fsck.c
Date: Tue, 26 Feb 2008 23:48:59 -0800
Message-ID: <7vr6eyx2j8.fsf@gitster.siamese.dyndns.org>
References: <12039765002329-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12039765004039-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12039765003484-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12039765002219-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12039765002397-git-send-email-mkoegler@auto.tuwien.ac.at>
 <7vskzg6pmw.fsf@gitster.siamese.dyndns.org>
 <20080226213523.GA26618@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: mkoegler@auto.tuwien.ac.at (Martin Koegler)
X-From: git-owner@vger.kernel.org Wed Feb 27 08:50:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUH37-0007N5-I2
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 08:49:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbYB0HtT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 02:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbYB0HtT
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 02:49:19 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49849 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbYB0HtS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 02:49:18 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 76D5B122A;
	Wed, 27 Feb 2008 02:49:15 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 4DEBF1228; Wed, 27 Feb 2008 02:49:10 -0500 (EST)
In-Reply-To: <20080226213523.GA26618@auto.tuwien.ac.at> (Martin Koegler's
 message of "Tue, 26 Feb 2008 22:35:23 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75209>

mkoegler@auto.tuwien.ac.at (Martin Koegler) writes:

> I have compared it to 3c5fb6a798a0b686e7818bf1da63791fb94a7b21 and
> everything seems to look OK. I'll do better verification in the next
> days.

Thanks.

> How should I handle changes? Send a patch ontop of 154a955 or should I
> send a amended version of the patches?

The rules under which I operate are (1) 'next', 'master', or
'maint' will not rewind, hence (2) anything that is merged into
these three branches won't be amended, either.

Running "git -p show-branch next master maint 154a955" and
scrolling to the end would show that up to "peel_onion: handle
NULL" are in 'next' and 'master' (I wanted to make sure these
safety-tightening commits are fine and then wanted to merge them
eventually to 'maint', so this topic forked from 'maint' branch
and is not meant to contain any new stuff in 'master').

 ! [next] Merge branch 'db/cover-letter' into next
  ! [master] git-apply --whitespace=fix: fix off by one thinko
   ! [maint] Documentation/git-am.txt: Pass -r in the example invoca...
    ! [154a955] receive-pack: use strict mode for unpacking objects
 ----
    ...
    + [154a955] receive-pack: use strict mode for unpacking objects
    + [154a955^] index-pack: introduce checking mode
    + [154a955~2] unpack-objects: prevent writing of inconsistent objects
    + [154a955~3] unpack-object: cache for non written objects
    + [154a955~4] add common fsck error printing function
    + [154a955~5] builtin-fsck: move common object checking code to fsck.c
    + [154a955~6] builtin-fsck: reports missing parent commits
    + [154a955~7] Remove unused object-ref code
    + [154a955~8] builtin-fsck: move away from object-refs to fsck_walk
    + [154a955~9] add generic, type aware object chain walker
 ++ + [154a955~10] peel_onion: handle NULL
 ++ + [154a955~11] check return value from parse_commit() in various functions
 ++ + [154a955~12] parse_commit: don't fail, if object is NULL
 ++ + [154a955~13] revision.c: handle tag->tagged == NULL
 ++ + [154a955~14] reachable.c::process_tree/blob: check for NULL
 ++ + [154a955~15] process_tag: handle tag->tagged == NULL
 ++ + [154a955~16] check results of parse_commit in merge_bases
 ++ + [154a955~17] list-objects.c::process_tree/blob: check for NULL
 ++ + [154a955~18] reachable.c::add_one_tree: handle NULL from lookup_tree
 ++ + [154a955~19] mark_blob/tree_uninteresting: check for NULL
 ++ + [154a955~20] get_sha1_oneline: check return value of parse_object
 ++ + [154a955~21] read_object_with_reference: don't read beyond the buffer
 ++++ [maint~20] GIT 1.5.4.2

So "peel_onion" fix and all commits below it are cast in stone.  But
"add generic walker" and later ones are not, and we can do whatever we
want to them.

If you have additional checks for other commands, that are not included
in 154a955, they naturally would make separate independent commits to be
applied on top of 154a955.  But if you find embarrassing typo or a grave
bug in them, you may want to send a replacement patch instead of
incremental fix-up, because there is no point to record an earlier
mistake in the public history only to later amend it, if mistakes are
already known.

I am tempted to merge the ones up to "peel_onion" to 'maint' soon, by
the way.

> I did not know all of these styling guidelines. SubmittingPatches only
> talks about broken mailer. Maybe it would be a good thing to include
> them somewhere.

Yeah, some words in CodingGuidelines might be a good idea.
