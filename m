From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/4] git-submodule: New subcommand 'summary' (2) -
 show commit summary
Date: Wed, 05 Mar 2008 15:57:36 -0800
Message-ID: <7vk5kgiv0v.fsf@gitster.siamese.dyndns.org>
References: <1204481710-29791-1-git-send-email-pkufranky@gmail.com>
 <1204481710-29791-2-git-send-email-pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 00:58:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX3V8-0003R7-7W
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 00:58:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757589AbYCEX5p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 18:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756207AbYCEX5o
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 18:57:44 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53438 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755865AbYCEX5o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 18:57:44 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7BD5124BC;
	Wed,  5 Mar 2008 18:57:42 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id A3BB524B8; Wed,  5 Mar 2008 18:57:38 -0500 (EST)
In-Reply-To: <1204481710-29791-2-git-send-email-pkufranky@gmail.com> (Ping
 Yin's message of "Mon, 3 Mar 2008 02:15:08 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76296>

Ping Yin <pkufranky@gmail.com> writes:

> Example: commit summary for modified submodules sm1-sm5.
> --------------------------------------------
>  $ git submodule summary
>  # Submodules modifiled: sm1 sm2 sm3 sm4 sm5
>  #
>  # * sm1 354cd45...3f751e5:
>  #   <one line message for C
>  #   <one line message for B
>  #   >one line message for D
>  #   >one line message for E
> ...
> 	--A-->B-->C (in src:354cd45)
> 	  \
> 	   -->D-->E (in dst:3f751e5)

The ordering of the commits in the above list is (1) unnatural and (2)
does not match what you would see with "log --left-right --topo-order
C...E".

I do not think "it shows the path to move from C to E" justifies it.  If
you are showing them as a linear list (which you cannot avoid if you are
doing a sequence of one-line description), you cannot represent such a
"path" anyway (think "merge").  If an appliance project rebinds kernel/
path from a project based on linux-2.4 to linux-2.6 while upgrading, such
a "path" may not even exist.

I think I've already said the above to your initial round.  It is a bit
dissapointing to see none of the comments were addressed and makes me
wonder if I have wasted my time reviewing them again.

It also is unnerving that newly added and deleted submodule results in the
full history display.  It would be assuring to be able to see and verify
what the top commit is (or was in "deleted" case) while you are commiting,
but I do not see a reason to show more than that.

I do not think "then set the limit to 1" is a valid answer to that
concern.  Wanting to see a dozen top commits in each for a modified
submodule would be sensible (and 3/4 may implement such a limit) but even
then showing dozen top commits for new/deleted at the same time would be
just an added noise.  Is it really necessary to show more than the top for
new/deleted case?

