From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] help: respect aliases
Date: Tue, 26 Feb 2008 12:14:49 -0800
Message-ID: <7vve4b4gqu.fsf@gitster.siamese.dyndns.org>
References: <cover.1203890846.git.peff@peff.net>
 <20080224221737.GD31309@coredump.intra.peff.net>
 <76718490802241810m5f473156nc350eea07016e8f9@mail.gmail.com>
 <alpine.LSU.1.00.0802261222570.17164@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 26 21:16:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JU6DU-0001SG-4S
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 21:15:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752827AbYBZUPM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 15:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762881AbYBZUPM
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 15:15:12 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36573 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762611AbYBZUPK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 15:15:10 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2E3DB251A;
	Tue, 26 Feb 2008 15:15:07 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 07DA02517; Tue, 26 Feb 2008 15:14:56 -0500 (EST)
In-Reply-To: <alpine.LSU.1.00.0802261222570.17164@racer.site> (Johannes
 Schindelin's message of "Tue, 26 Feb 2008 12:43:21 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75166>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Sun, 24 Feb 2008, Jay Soffian wrote:
>
>> This too would be less ugly as a built-in:
>> 
>>     alias      = "! sh -c 'if test -z \"$1\"; then git config --list \
>>                   | expand \
>>                   | sed \"/^alias\\./!d; s/^alias\\.//; s/=/ /; s/  */ /g\" \
>>                   | sort | while read n v; do \
>>                   printf \"%-16s\" \"$n\"; echo \"$v\" | gnused \
>>                   \"s/\\(.\\{68\\}\\) /\\1\\n\t\t/g\" | expand; \
>>                   done; else git config \"alias.$1\"; fi' -"
>
> Wow.  This would look less ugly as an alias like this, too:
>
> alias = "!sh -c 'case $# in \
>         0) git config --get-regexp \"^alias\\.\" | sed \"s/^alias\\.//\";; \
>         *) git config \"alias.$0\" ;; \
>         esac'"
>
> which incidentally fixes a bug in your alias: you ignore $0 which is the 
> first parameter when using the sh -c '' idiom.

I notice that he is feeding an exra '-' for that.

> Of course, you can change the sed call to your liking...

Sure.  The combination of expand, sed, and gnused hurts my eyes
;-)

One good lesson to take home is that by ending your lines with
'|', you can tell the shell that you are not done with the
pipeline you are forming yet.  This allows you to lose all these
ugly backslashes, like this:

	xyzzy |
        frotz |
        nitfol

instead of

	xyzzy \
        | frotz \
        | nitfol
