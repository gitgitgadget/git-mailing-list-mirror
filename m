From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make git add -n and git -u -n output consistent
Date: Thu, 22 May 2008 21:40:59 -0700
Message-ID: <7vabihtyxw.fsf@gitster.siamese.dyndns.org>
References: <4835E1AE.6030201@isy.liu.se>
 <1211493582-13400-1-git-send-email-hendeby@isy.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: vmiklos@frugalware.org, git@vger.kernel.org
To: Gustaf Hendeby <hendeby@isy.liu.se>
X-From: git-owner@vger.kernel.org Fri May 23 06:42:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzP6T-0006tQ-ME
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 06:42:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751800AbYEWElO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 00:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751668AbYEWElO
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 00:41:14 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53364 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447AbYEWElN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 00:41:13 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BA31F2DE3;
	Fri, 23 May 2008 00:41:11 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 04C81161E; Fri, 23 May 2008 00:41:06 -0400 (EDT)
In-Reply-To: <1211493582-13400-1-git-send-email-hendeby@isy.liu.se> (Gustaf
 Hendeby's message of "Thu, 22 May 2008 23:59:42 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 78247D8E-2882-11DD-9F24-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82679>

Gustaf Hendeby <hendeby@isy.liu.se> writes:

> Signed-off-by: Gustaf Hendeby <hendeby@isy.liu.se>
> ---
>
> This would be one way to go to get a more coherent behavior or the -n
> switch to git add.  It would also unify the implementation somewhat.
> I'd suggest amending this to your patch, or would the output be likely
> to be used by scrips?  In that case I'd vote for changing the output
> of git add -n -u,

The commit log message should describe what kind of consistency you are
talking about to people who are not familiar with the topic.

Output format from "git add -n $path" lists path to blobs that are going
to be added on a single line, separated with SP.  On the other hand, the
suggested "git add -u -n" shows one path per line, like "add '<file>'\n".
Of course, these two are inconsistent.

Plain "git add -n" can afford to only say names of paths, as all it does
is to add (update).  However, "git add -u" needs to be able to express
"remove" somehow.  So if we need to have them formatted the same way, we
need to unify with the "git add -n -u" format.  Incidentally, this is
consistent with how 'update-index' says it.

I do not think we need to worry about people who wrote script around
output from "git add -n".  Output from Porcelain commands is a fair game
for improvements.
