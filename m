From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH (BUGFIX)] Respect core.autocrlf in combined diff
Date: Sat, 23 Aug 2008 18:24:31 -0700
Message-ID: <7vy72nurw0.fsf@gitster.siamese.dyndns.org>
References: <200808232321.21795.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 24 03:25:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KX4MQ-0008NT-T8
	for gcvg-git-2@gmane.org; Sun, 24 Aug 2008 03:25:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752939AbYHXBYh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 21:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753357AbYHXBYh
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 21:24:37 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62597 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752914AbYHXBYh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 21:24:37 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1FCE96B112;
	Sat, 23 Aug 2008 21:24:36 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8C9056B111; Sat, 23 Aug 2008 21:24:33 -0400 (EDT)
In-Reply-To: <200808232321.21795.angavrilov@gmail.com> (Alexander Gavrilov's
 message of "Sat, 23 Aug 2008 23:21:21 +0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 69D09910-717B-11DD-B1FD-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93509>

Alexander Gavrilov <angavrilov@gmail.com> writes:

> 		...
> 		git commit -m aaa
> 		git config core.autocrlf true
> 		git merge b
>
> 	Then look at the output of git diff.

Come to think of it, this test sequence is totally bogus, isn't it?

After making the "aaa" commit, you change core.autocrlf setting, which
means that at that point your work tree is invalid and needs to be checked
out with the right crlf.

IOW, shouldn't you need to do something like this:

 		git commit -m aaa
 		git config core.autocrlf true
+		rm -f .git/index && git reset --hard
		git merge b

for the test sequence to be a valid one that (may or may not) exposes the
problem you are trying to solve?
