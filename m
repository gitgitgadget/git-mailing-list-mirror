From: Junio C Hamano <gitster@pobox.com>
Subject: Re: request for documentation about branch surgery
Date: Tue, 07 Jul 2009 08:52:16 -0700
Message-ID: <7v3a98bidr.fsf@alter.siamese.dyndns.org>
References: <200907070105.12821.bruno@clisp.org>
 <7vab3hb40x.fsf@alter.siamese.dyndns.org>
 <200907071213.25418.bruno@clisp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bruno Haible <bruno@clisp.org>
X-From: git-owner@vger.kernel.org Tue Jul 07 17:52:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOCyC-0005QT-Rw
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 17:52:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757273AbZGGPw0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2009 11:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757243AbZGGPw0
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jul 2009 11:52:26 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58001 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756473AbZGGPwZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2009 11:52:25 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 8E59625F6C;
	Tue,  7 Jul 2009 11:52:23 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B8E3E25F6B; Tue, 
 7 Jul 2009 11:52:20 -0400 (EDT)
In-Reply-To: <200907071213.25418.bruno@clisp.org> (Bruno Haible's message of
 "Tue\, 7 Jul 2009 12\:13\:24 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 29620868-6B0E-11DE-9454-DC021A496417-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122851>

Bruno Haible <bruno@clisp.org> writes:

>> If you think "git merge" _copies_, you will never understand what "merge"
>> does. ... There is no copying involved anywhere .  It only creates a new
>> commit 
>
> There are two cases of "git merge" operation: the one that creates a diamond
> commit, and the one that doesn't (the "simple" case of "git merge"). The latter
> operation I found useful in achieving this surgery:
>
>             C---D---E              topic
>            /
>       A---B                        master
>
>   =>
>
>             C---D---E              topic
>            /
>       A---B---C---D---E            master

If C, D, E on the above two lines are the _same_ commit, i.e. with the
same history and same object IDs, then the picture should instead look
like this:

             C---D---E topic
            /
       A---B master

   =>
                       master
             C---D---E topic
            /
       A---B master@{1}

If that is the case, you drew the picture incorrectly, and it shows the
misunderstanding of your git object model and what a git branch is.

The latter I have already explained to you, but here is a hint.

    Do not think of a branch as "the upper line is topic, the lower line
    is master".  A branch is just a pointer to _a commit_.  IOW, in the
    picture I drew to correct yours, master and topic point at "E".  It
    does _not_ point at the line that C, D, and E are on.  Similarly,
    master@{1} points at the commit "B", not at the line A and B are on.

You claimed that you understand in your response, but judging from the way
you wrote the above picture, I can tell that you don't understand what a
branch in git is.  Otherwise you would have drew it like how I did, and
you wouldn't have used the word "copy".

If you instead for some reason _want_ a forked history where C, D and E
are _duplicated_, then you would start from the first picture, fast
forward master to "E", and would force rebase onto B, to end up with
a picture like this.

             C---D---E topic
            /
       A---B---C'--D'--E' master

But there is no reason to do this.
