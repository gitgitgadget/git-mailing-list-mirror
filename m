From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] add pack index v2 reading capability to git v1.4.4.4
Date: Wed, 16 Jul 2008 10:04:18 -0700
Message-ID: <7vprpdsqul.fsf@gitster.siamese.dyndns.org>
References: <1216189899-14279-1-git-send-email-nico@cam.org>
 <alpine.LFD.1.10.0807160924340.2835@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org,
	Gerrit Pape <pape@smarden.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jul 16 19:05:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJARV-000068-EN
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 19:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755223AbYGPREa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 13:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756191AbYGPREa
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 13:04:30 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35464 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755081AbYGPRE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 13:04:29 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5589238C55;
	Wed, 16 Jul 2008 13:04:27 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 95FF338C54; Wed, 16 Jul 2008 13:04:22 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3F7D9450-5359-11DD-A69E-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88696>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, 16 Jul 2008, Nicolas Pitre wrote:
>> 
>> Junio: if you could just apply them, tag the result as v1.4.4.5 and
>> push it out then at that point it simply will be up to Debian to make
>> it available as a "major usability fix".
>
> Actually, it fixes a crash. Didn't 1.4.4 SIGSEGV without this on pack-v2?
>
> So you don't even have to sell it as a usability issue, but literally as a 
> bugfix.

It's tagged and pushed out to both kernel.org and repo.or.cz.  Thanks, Nico.

I won't be doing my usual full release engineering on this one, but I did:

 - repack a copy of git.git to use pack idx version #2 for trial.

	Hint.  A handy way to tell which version of packfile you have is
	to run this:

	$ od -c .git/objects/pack/pack-$your_pack_id.idx | head -n 1
        
        If the output begins with "377 t 0 c", you have pack idx version
        #2.

 - check "git log" from v1.4.4.4 (fails) and v1.4.4.5 (reads ok)

 - repack this copy with "git repack" from 1.4.4.5.  This produced a
   repository usable by v1.4.4.4.

I also updated /pub/scm/git/git.git/config at kernel.org to use

	[pack]
        	indexVersion = 1

for now.  The repository is also repacked with pack idx version #1.
