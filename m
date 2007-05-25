From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Enhance unpack-objects for extracting large objects
Date: Fri, 25 May 2007 12:59:28 -0700
Message-ID: <7viragr7xb.fsf@assigned-by-dhcp.cox.net>
References: <46569C37.5000201@gmail.com>
	<7vsl9kr9mz.fsf@assigned-by-dhcp.cox.net>
	<56b7f5510705251249u74b754f1y4f8cafd5f5c35f19@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Dana How" <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 25 21:59:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hrfwk-0002pQ-N8
	for gcvg-git@gmane.org; Fri, 25 May 2007 21:59:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752444AbXEYT73 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 15:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752506AbXEYT73
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 15:59:29 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:65420 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752444AbXEYT73 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 15:59:29 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070525195928.FVRC12190.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Fri, 25 May 2007 15:59:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 3XzU1X0051kojtg0000000; Fri, 25 May 2007 15:59:28 -0400
In-Reply-To: <56b7f5510705251249u74b754f1y4f8cafd5f5c35f19@mail.gmail.com>
	(Dana How's message of "Fri, 25 May 2007 12:49:08 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48405>

"Dana How" <danahow@gmail.com> writes:

>>  * You already have the size here, so if min_blob_size is set
>>    and the size is larger, you do not even have to call
>>    write_sha1_file() at all.
> The way I read the code,  it looks like unpack-objects needs
> the last argument always to be initialized with the SHA-1 computed
> from the object contents.  Therefore I always need to call
> write_sha1_file(),  even if I don't want it to write anything.

Ah, that is what I missed.

There is a separate function to only hash, named (surprisingly)
"hash_sha1_file().  Maybe you can teach the caller's "don't
write it out" codepath to call it.
