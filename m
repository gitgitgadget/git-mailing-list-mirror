From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: add a planning document for the next CLI
 revamp
Date: Sun, 02 Nov 2008 13:53:44 -0800
Message-ID: <7vy70123rr.fsf@gitster.siamese.dyndns.org>
References: <1225338485-11046-1-git-send-email-sam@vilain.net>
 <20081030132453.GB24098@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Vilain <sam@vilain.net>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sun Nov 02 22:55:18 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kwkui-0001Kd-2j
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 22:55:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754256AbYKBVyB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 16:54:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754275AbYKBVyA
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 16:54:00 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33930 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754231AbYKBVyA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 16:54:00 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C6ED7773B8;
	Sun,  2 Nov 2008 16:53:58 -0500 (EST)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id BAE0E773B6; Sun,  2 Nov 2008 16:53:50 -0500 (EST)
In-Reply-To: <20081030132453.GB24098@artemis.corp> (Pierre Habouzit's message
 of "Thu, 30 Oct 2008 14:24:53 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C0B7450A-A928-11DD-8017-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99878>

Pierre Habouzit <madcoder@debian.org> writes:

> * 'git track' would do what git add -N does now.
> * 'git untrack' would do what 'git rm --cached' does now.

Ok with me up to here.

>> +  * 'git undo' would do what 'git checkout HEAD --' does now
> ...
> I have no constructive proposal to replace it though, but I believe git
> undo would cause lots of harm.

I'm in agreement.

>   * git-send-email should be either more interactive, or less: either
>     just use the damn configuration, or propose a mode where it spawns
>     an editor for each patch so that you can add further comments.

In principle I'd agree, but I use send-email non-interactively myself (I
type Meta/SE where Meta is an independent checkout of my 'todo' branch),
so I am not sure if the "just use the configuration" is an added
requirement.  I also have this in .git/config in the repo:

        [sendemail]
                smtpserver = /usr/bin/msmtp
                to = git@vger.kernel.org
                suppressfrom
                signedoffcc = false

>   * git-send-email should be able to format-patches by himself (IOW
>     accept most of format-patch arguments and deal with the patch list
>     by himself, which is usable if the previous point is implemented).

I earlier was against this, mostly out of the "each tool to do the job it
was designed to do well" principle, but with your workflow description and
Peff's comment, I am open to add this kind of "run format-patch internally"
wrapper behaviour to send-email which is already a Porcelain anyway.

>> +  * 'git am -3' the default; with global option to make it not the
>> +    default for those that prefer the speed of -2

I am moderately negative on this, but not because of performance concern.

The --3way fall back is done only when it is necessary, and there is no
"prefer the speed" involved.  It is between "stop when the patch does not
apply because there may be something iffy going on" and "assume it is Ok
in such an iffy case to pretend that you apply the patch to the original
copy and cherry-pick the result to your updated tree".  IOW, it is a
safety concern.
