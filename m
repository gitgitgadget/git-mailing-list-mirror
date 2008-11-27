From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix typos in the documentation.
Date: Thu, 27 Nov 2008 01:48:56 -0800
Message-ID: <7vwsepa48n.fsf@gitster.siamese.dyndns.org>
References: <20081127073201.GD8267@ins.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 27 10:51:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5dWb-0008LQ-4l
	for gcvg-git-2@gmane.org; Thu, 27 Nov 2008 10:51:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752620AbYK0JtX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2008 04:49:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752566AbYK0JtX
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Nov 2008 04:49:23 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37696 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752491AbYK0JtW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2008 04:49:22 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id F10CF81FFB;
	Thu, 27 Nov 2008 04:49:21 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3D5E981FF8; Thu,
 27 Nov 2008 04:48:58 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: AAD5F67A-BC68-11DD-A838-465CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101805>

Ralf Wildenhues <Ralf.Wildenhues@gmx.de> writes:

> Signed-off-by: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
> ---
>
> This patch is against pu.

While I appreciate your fix, it would have been nicer to have at least
three patches in this case, organized like this:

 * patch 1 applies to 'maint'. Let's call the result of such application
   'maint plus fix';

   In other words:

	$ git checkout -b rw/maint-typofix maint
        $ git am -s patch-1

 * patch 2 is to be applied on top of the result of merging 'maint plus
   fix' into 'master';

   In other words:

	$ git checkout -b rw/typofix master
        $ git merge rw/maint-typofix
        $ git am -s patch-2

 * patch 3 is to contain everything else (it would be even nicer if they
   are split up to apply to individual topic branches that are responsible
   for introducing the typos, but I realize that it would be asking too
   much).

   In other words:

	$ git checkout pu
        $ git merge rw/typofix
        $ git am -s patch-3

I've done the above splitting myself and further did:

	$ git checkout maint
        $ git merge rw/maint-typofix
        $ git branch -d rw/maint-typofix
        $ git checkout master
        $ git merge rw/typofix
        $ git branch -d rw/typofix

I did not create a single "patch-3" but squashed the fixes in to the
respective commits on the topic branches, as they are only on 'pu' and not
part of 'next' (hence I am free to amend and rebase them).

Thanks.
