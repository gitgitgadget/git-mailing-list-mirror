From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH?] Fix 'git show' on signed tag of signed tag of commit
Date: Tue, 01 Jul 2008 16:55:13 -0700
Message-ID: <7vbq1hkvmm.fsf@gitster.siamese.dyndns.org>
References: <1214905624-29517-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Jul 02 01:57:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDpif-0001Jj-FA
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 01:57:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757521AbYGAXzu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2008 19:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756337AbYGAXzt
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 19:55:49 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50896 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755918AbYGAXzW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 19:55:22 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 374B62674E;
	Tue,  1 Jul 2008 19:55:21 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 711F92674D; Tue,  1 Jul 2008 19:55:17 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2A2672A2-47C9-11DD-AECB-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87071>

Thomas Rast <trast@student.ethz.ch> writes:

> The cmd_show loop resolves tags by showing them, then pointing the
> object to the 'tagged' member.  However, this object is not fully
> initialized; it only contains the SHA1.  (This resulted in a segfault
> if there were two levels of tags.)  We apply parse_object to get a
> full object.
>
> Noticed by Kalle Olavi Niemitalo on IRC.
>
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---
>
> I'm not 100% sure this is the right fix; I just had a quick stab at
> the code, made a fix and tested it.  It probably leaks memory too, not
> sure if this is a problem.

The code looks good.  It should not have been accessing the object without
making sure it has been parsed.

And it's not a leak.  Once you instantiate "struct object" derived class,
we hold onto it (at least to its skeleton).

Thanks.
