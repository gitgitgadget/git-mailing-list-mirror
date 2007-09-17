From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/8] git-gc --auto: restructure the way "repack" command line is built.
Date: Mon, 17 Sep 2007 12:53:59 -0700
Message-ID: <7vwsupyso8.fsf@gitster.siamese.dyndns.org>
References: <11900186941912-git-send-email-gitster@pobox.com>
	<1190018713416-git-send-email-gitster@pobox.com>
	<Pine.LNX.4.64.0709171040070.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Sep 17 21:54:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXMfX-0005Mw-C1
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 21:54:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755553AbXIQTyD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 15:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755382AbXIQTyB
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 15:54:01 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:55954 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754827AbXIQTyB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 15:54:01 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070917195401.EVFX9743.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Mon, 17 Sep 2007 15:54:01 -0400
Received: from localhost ([68.225.240.77])
	by fed1rmimpo01.cox.net with bizsmtp
	id pXtz1X00J1gtr5g0000000; Mon, 17 Sep 2007 15:53:59 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58474>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 17 Sep 2007, Junio C Hamano wrote:
>
>> @@ -154,8 +161,6 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
>>  		 * Auto-gc should be least intrusive as possible.
>>  		 */
>>  		prune = 0;
>> -		for (i = 0; i < ARRAY_SIZE(argv_repack_auto); i++)
>> -			argv_repack[i] = argv_repack_auto[i];
>>  		if (!need_to_gc())
>>  			return 0;
>>  	}
>
> This subtly changes behaviour: --auto ran also garbage collection for 
> reflogs and rerere.

Does it change any behaviour?  It "ran" meaning "it used to run
them always"?  I do not think so.  We always exited here if
there is no gc needed for object store.

I however think a behaviour change might be needed around here.
"gc --auto" is about being lightweight and no impact in the
semantics from the point fo view of the repository user.  As
such, I suspect we may not want to run gc on reflogs nor rerere.
Running pack-refs is supposed to be "no impact in the semantics"
operation so I think it is Ok, but even that would affect how
the ancient fetch over http implementations would interact with
this repository.

But skipping these would make automated "behind the scene" gc
much less useful.  I dunno.
