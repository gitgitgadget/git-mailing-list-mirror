From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] git rm: Support for removing submodules
Date: Fri, 12 Sep 2008 15:42:54 -0700
Message-ID: <7vk5dhm1e9.fsf@gitster.siamese.dyndns.org>
References: <20080912210817.31628.69014.stgit@localhost>
 <20080912210902.31628.7325.stgit@localhost>
 <7v8wtxniez.fsf@gitster.siamese.dyndns.org>
 <7v1vzpnhzj.fsf@gitster.siamese.dyndns.org>
 <20080912210817.31628.69014.stgit@localhost>
 <20080912210902.31628.7325.stgit@localhost>
 <7v8wtxniez.fsf@gitster.siamese.dyndns.org>
 <20080912222429.GE10360@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sat Sep 13 00:44:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeHN8-00026o-Ar
	for gcvg-git-2@gmane.org; Sat, 13 Sep 2008 00:44:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757146AbYILWnF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 18:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756671AbYILWnE
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 18:43:04 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45502 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754891AbYILWnD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 18:43:03 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 43ED260117;
	Fri, 12 Sep 2008 18:42:59 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 920AF60110; Fri, 12 Sep 2008 18:42:56 -0400 (EDT)
In-Reply-To: <20080912222429.GE10360@machine.or.cz> (Petr Baudis's message of
 "Sat, 13 Sep 2008 00:24:29 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 264D53BC-811C-11DD-A320-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95783>

Petr Baudis <pasky@suse.cz> writes:

>> >> +{
>> >> +	char *key = submodule_by_path(name);
>> >> +	char *sectend = strrchr(key, '.');
>> >> +
>> >> +	assert(sectend);
>> >> +	*sectend = 0;
>> >
>> > Here is one caller I questioned in my comments on [1/6]...
>> 
>> Another thing --- can submodule_by_path() ever return NULL saying "I do
>> not see one in the configuration"?
>
> No, it would rather die().

Hmmmm.  If I did...

        $ git init
	$ create and add normal paths
        $ git clone git://..../gitk.git gitk
        $ git add gitk
        : heh, I changed my mind
        $ git rm gitk

the last step would die, because I changed my mind before fully
initializing gitk repository as a proper submodule?

How would I get rid of the index entry to recover from the mistake?

        $ rm -fr gitk
        $ git rm gitk

would presumably fail the same way, no?  I hope I am misreading the
code...

We need to be extremely careful not to break people who do not (yet) have
[submodule "xyzzy"] entries in config and/or .gitmodules when dealing with
the gitlink entries in the index.
