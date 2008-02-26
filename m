From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 05/10] builtin-fsck: move common object checking code to
 fsck.c
Date: Tue, 26 Feb 2008 01:19:51 -0800
Message-ID: <7vskzg6pmw.fsf@gitster.siamese.dyndns.org>
References: <12039765002329-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12039765004039-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12039765003484-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12039765002219-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12039765002397-git-send-email-mkoegler@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Tue Feb 26 10:21:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTvza-0002v3-Hf
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 10:20:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758525AbYBZJUL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 04:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758492AbYBZJUK
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 04:20:10 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46301 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758204AbYBZJUI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 04:20:08 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A61A821AE;
	Tue, 26 Feb 2008 04:20:06 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 36A8321AC; Tue, 26 Feb 2008 04:19:58 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75113>

Is this series an unadjusted resend or something?  This particular one
had funny interaction with your own d4fe07f (git-fsck: report missing
author/commit line in a commit as an error) that is already in
'master', so I had to munge it by hand.  It was not so pleasant
(a large chunk of code was moved from builtin-fsck.c to fsck.c),
but that is what the maintainer does, so it's Ok.  But I'd like
you to eyeball the result to see if it looks sane.

I'll push it out as part of 'pu'.  The tip of your topic is
154a955 (receive-pack: use strict mode for unpacking objects)
tonight:

	Side note: To find a tip of a topic yourself, look for "Merge
	mk/maint-parse-careful" in "git log --first-parent
	origin/next..origin/pu" output and find the latest one.

One thing I noticed was that parse_$type_buffer() family all take
non-const void *buf pointers but one new caller you introduced takes
"const void *data" and passes that pointer to them.  I hated to, but
ended up loose-casting it.  You may want to make the function take
non-const pointer, but I did not look very carefully.

By the way, while I was at it, many stylistic issues bugged me too
much, so I ended up fixing them as well:

 * Trailing whitespaces; avoid them.

 * Indenting with SP not HT; don't.

 * Pointer to struct foo type is (struct foo *), not (struct foo*);

 * One SP each around comparison operator "==";

 * One SP around assignment operator "=";

 * One SP after "if", "while", "switch" and friends before "(";

 * No SP between function name and "(";

 * A function without parameter is "static void foo(void)", not
   "static void foo()";

 * Decl-after-statement; don't.

 * Multi-line comment is:

	/*
         * This is multi line comment
         * and this is its second line.
         */

   not

	/* This is multi line comment
           and this is its second */

 * If you cast, cast to the right type ;-)

	struct tree *item = (struct tree *) obj;

   not

	struct tree *item = (struct item*) obj;

Please do not make me do this again, as I do not have infinite amount
of time.  This plea is not only about your patch but applies to
everybody.

I wanted to merge a few new commits to existing topics to 'next' and
merge down a few well cooked topics to 'master', but ran out of time
tonight.  New stuff I received and looked at are all parked in 'pu'
tonight.
