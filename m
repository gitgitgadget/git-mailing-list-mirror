From: Jim Meyering <jim@meyering.net>
Subject: Re: git-diff: must --exit-code work with --ignore* options?
Date: Sun, 30 Aug 2009 22:27:02 +0200
Message-ID: <87fxb9ujxl.fsf@meyering.net>
References: <87k549dyne.fsf@meyering.net>
	<7vvdnt869j.fsf@alter.siamese.dyndns.org>
	<87eiuhdnw9.fsf@meyering.net>
	<7v7i087twu.fsf@alter.siamese.dyndns.org>
	<87skf9uv3r.fsf@meyering.net>
	<7vljl1dpud.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 30 22:27:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mhqzg-0000qs-DX
	for gcvg-git-2@lo.gmane.org; Sun, 30 Aug 2009 22:27:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754059AbZH3U1K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2009 16:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754052AbZH3U1K
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Aug 2009 16:27:10 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:56407 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754000AbZH3U1J (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2009 16:27:09 -0400
X-Greylist: delayed 14479 seconds by postgrey-1.27 at vger.kernel.org; Sun, 30 Aug 2009 16:27:07 EDT
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 35EBC818147
	for <git@vger.kernel.org>; Sun, 30 Aug 2009 22:27:05 +0200 (CEST)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 519D281816F
	for <git@vger.kernel.org>; Sun, 30 Aug 2009 22:27:03 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id F21973849E; Sun, 30 Aug 2009 22:27:02 +0200 (CEST)
In-Reply-To: <7vljl1dpud.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 30 Aug 2009 13:11:22 -0700")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127430>

Junio C Hamano wrote:
> Jim Meyering <jim@meyering.net> writes:
>> Junio C Hamano wrote:
>> ...
>>> Subject: [PATCH] diff --quiet: special case "ignore whitespace" options
>>> ...
>>> Change the semantics of --ignore-whitespace* options to mean more than
>>> "omit showing the difference in text".  When these options are used, the
>>> internal "quick" optimization is turned off, and the status reported with
>>> the --exit-code option will now match if any the textual diff output is
>>> actually produced.
>>>
>>> Also rename the internal option "QUIET" to "QUICK" to better reflect what
>>> its true purpose is.
>>
>> Thanks again.
>> If there's anything I can to do help (add a test?), let me know.
>
> The change has been cooking in 'next' and hopefully be in 1.7.0.  I think
> the updated series adds its own test script, too.
>
> Using it in every day scenario, and reporting any breakage you notice
> before 1.7.0 happens, would be greatly appreciated.

Oh!  I am using next (will test!), and even searched log summary output,
but obviously my search was too cursory or just inaccurate.

I glanced through it and it looks fine (of course!).
I spotted one typo, and suggest a second change that's barely worth
mentioning, both in comments:

diff --git a/diff.c b/diff.c
index 91d6ea2..24bd3fc 100644
--- a/diff.c
+++ b/diff.c
@@ -2382,7 +2382,7 @@ int diff_setup_done(struct diff_options *options)
 	 * Most of the time we can say "there are changes"
 	 * only by checking if there are changed paths, but
 	 * --ignore-whitespace* options force us to look
-	 * inside contets.
+	 * inside contents.
 	 */

 	if (DIFF_XDL_TST(options, IGNORE_WHITESPACE) ||
@@ -3346,7 +3346,7 @@ free_queue:
 		fclose(options->file);

 	/*
-	 * Report the contents level differences with HAS_CHANGES;
+	 * Report the content-level differences with HAS_CHANGES;
 	 * diff_addremove/diff_change does not set the bit when
 	 * DIFF_FROM_CONTENTS is in effect (e.g. with -w).
 	 */
