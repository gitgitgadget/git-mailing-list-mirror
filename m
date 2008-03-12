From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Unclear error message in "git remote update"
Date: Tue, 11 Mar 2008 22:10:18 -0700
Message-ID: <7vve3s7cjp.fsf@gitster.siamese.dyndns.org>
References: <2008-03-09-13-37-55+trackit+sam@rfc1149.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Samuel Tardieu <sam@rfc1149.net>
X-From: git-owner@vger.kernel.org Wed Mar 12 06:11:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZJF3-0003jO-Ka
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 06:11:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752020AbYCLFK2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 01:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753288AbYCLFK1
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 01:10:27 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59760 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751208AbYCLFK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 01:10:26 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3B41F3501;
	Wed, 12 Mar 2008 01:10:25 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 8443534BF; Wed, 12 Mar 2008 01:10:22 -0400 (EDT)
In-Reply-To: <2008-03-09-13-37-55+trackit+sam@rfc1149.net> (Samuel Tardieu's
 message of "Sun, 09 Mar 2008 13:37:55 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76924>

Samuel Tardieu <sam@rfc1149.net> writes:

> One of my colleague seems to have destroyed one of its head in his
> private repository. When fetching from it through "git remote update"
> using next, the repository name is not output:
>
> % git remote update
> error: refs/heads/2.0-uobjects points nowhere!
>
> Using master, I get:
>
> % git remote update
> Updating core
> Updating matthieu
> error: refs/heads/2.0-uobjects points nowhere!
> Updating origin
>
> which is IMO much clearer. Also, I like seeing what remote repository
> it is updating from in case anything gets stuck or slow.
>
> Any objection to reinstating the message as does the following patch?

I do not have objections, but it feels that the message for normal case
(success) is cluttering the output.

If the remote repository is in a bad shape to solicit a "points nowhere"
error, perhaps

 (1) that error message should be squelched out completely, as it does not
     affect the outcome of the fetch anyway, or

 (2) the dangling symref should cause "fetch" to error out but with a
     different error status than the total failure case, so that this
     caller can tell it is a non-grave error, or

 (3) the dangling symref should actually make the fetch fail, as the
     remote repository is corrupt.

For now I'll take your patch, but this is something we may want to
clean-up in 1.6.0 timeframe.
