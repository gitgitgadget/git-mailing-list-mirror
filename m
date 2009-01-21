From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Merging adjacent deleted lines?
Date: Wed, 21 Jan 2009 13:08:06 -0800
Message-ID: <7vy6x4cqq1.fsf@gitster.siamese.dyndns.org>
References: <57518fd10901211120n62f8d0e9ya8595fc9baa6476c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jonathan del Strother <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 22:12:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPkKu-0005rc-JK
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 22:10:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752676AbZAUVIP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 16:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752583AbZAUVIO
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 16:08:14 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58387 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752614AbZAUVIO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 16:08:14 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6A6951CF6D;
	Wed, 21 Jan 2009 16:08:11 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id DC7DB1CF69; Wed,
 21 Jan 2009 16:08:07 -0500 (EST)
In-Reply-To: <57518fd10901211120n62f8d0e9ya8595fc9baa6476c@mail.gmail.com>
 (Jonathan del Strother's message of "Wed, 21 Jan 2009 19:20:50 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9C32CF86-E7FF-11DD-8756-BE78113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106671>

Jonathan del Strother <maillist@steelskies.com> writes:

> Say I have a file that started out with the following content :
>
> line1
> line2
> line3
> line4
>
>
> I create a branch, which deletes line2.  Someone else's branch deletes line 3.
>
> When I merge those two branches, the conflict looks like :
>
> line1
> <<<<<<< HEAD:lines
> line3
> =======
> line2
>>>>>>>> SomeoneElse:lines
> line4
>
>
>
> Which in my cursory overview, looked an awful lot like the obvious
> merge resolution ought to be
>
> line1
> line3
> line4

Why?  The obvious resolution would be:

    line1
    line4

as it is obvious that you do not want line2 and the other does not want
line3.

But that is only true if it is obvious to you.  When you cannot remember
what each side did since they forked, there are two ways you can use to
understand the history better without resorting to graphical merge tools.

  $ git log -p --merge <path>

which shows you the commits involved in the conflict, what they did, and
why they did what they did (of course, this assumes that your project
participant did their commits properly).

  $ git checkout --conflict=diff3 <path>

This will add an extra block to the conflicted output to show the common
ancestor's version, after showing yours.  The conflicts left in <path>
would look like this:

    line1
    <<<<<<< ours
    line3
    |||||||
    line2
    line3
    =======
    line2
    >>>>>>> theirs
    line4

which may make it clearer that you deleted line2 and they deleted line3.
