From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH try 2] t1301-shared-repo.sh: don't let a default ACL
 interfere with the test
Date: Tue, 14 Oct 2008 15:32:13 -0700
Message-ID: <7vzll66c5u.fsf@gitster.siamese.dyndns.org>
References: <1224022020.2699.4.camel@mattlaptop2.local>
 <1224022216.2699.5.camel@mattlaptop2.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matt McCutchen <matt@mattmccutchen.net>
X-From: git-owner@vger.kernel.org Wed Oct 15 00:33:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpsSK-0004Ks-Sq
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 00:33:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752114AbYJNWcV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2008 18:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752146AbYJNWcV
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Oct 2008 18:32:21 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53168 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751686AbYJNWcT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2008 18:32:19 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 61B438ABC2;
	Tue, 14 Oct 2008 18:32:18 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8FEAB8ABC0; Tue, 14 Oct 2008 18:32:15 -0400 (EDT)
In-Reply-To: <1224022216.2699.5.camel@mattlaptop2.local> (Matt McCutchen's
 message of "Tue, 14 Oct 2008 18:10:16 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F58738AA-9A3F-11DD-9D55-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98220>

Matt McCutchen <matt@mattmccutchen.net> writes:

> This test creates files with several different umasks and expects the files to
> be permissioned according to the umasks, so a default ACL on the test dir causes

Is "to permission" a verb?

> the test to fail.  To avoid that, remove the default ACL if possible with
> setfacl(1).  (Will work on many systems.)

It is not clear in the comment in parentheses what provision you have made
not to harm people on systems without setfacl.

I think "if possible" which you already have is a good enough description
(i.e. "if setfacl fails we do not barf and if you do not have the command
you probably are not running with a funky default ACL to see this issue
anyway"), so I'd rather drop the comment in parentheses.

> Signed-off-by: Matt McCutchen <matt@mattmccutchen.net>
> ---
> This time with a signoff.
>
>  t/t1301-shared-repo.sh |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
> index dc85e8b..2275caa 100755
> --- a/t/t1301-shared-repo.sh
> +++ b/t/t1301-shared-repo.sh
> @@ -7,6 +7,9 @@ test_description='Test shared repository initialization'
>  
>  . ./test-lib.sh
>  
> +# Remove a default ACL from the test dir if possible.
> +setfacl -k . 2>/dev/null
> +

Makes me wonder why this is _not_ inside test-lib.sh where it creates the
test (trash) directory.  That way, you would cover future tests that wants
to see a saner/simpler POSIX permission behaviour, wouldn't you?
