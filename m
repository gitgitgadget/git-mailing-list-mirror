From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to find the first commit belonging to any branch
Date: Tue, 22 Jul 2008 02:27:30 -0700
Message-ID: <7vej5mmfp9.fsf@gitster.siamese.dyndns.org>
References: <4885A39F.5080209@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Kristian Amlie <kristian.amlie@trolltech.com>
X-From: git-owner@vger.kernel.org Tue Jul 22 11:28:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLEAe-0003Pd-6f
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 11:28:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752827AbYGVJ1g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 05:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752821AbYGVJ1g
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 05:27:36 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40592 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751306AbYGVJ1g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 05:27:36 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DB40E345C9;
	Tue, 22 Jul 2008 05:27:34 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 3ADE2345C6; Tue, 22 Jul 2008 05:27:32 -0400 (EDT)
In-Reply-To: <4885A39F.5080209@trolltech.com> (Kristian Amlie's message of
 "Tue, 22 Jul 2008 11:08:47 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6ADFB60C-57D0-11DD-8D88-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89477>

Kristian Amlie <kristian.amlie@trolltech.com> writes:

> I have a question about git: I have one commit sha1, and I would like
> to know the nearest commit that appears in *any* other branch. The
> sha1 that I have does not belong to any branch.
>
> The obvious thing to do would be to make a for loop and iterate over
> existing branches while calling git merge-base, but I'm wondering if
> there's a more clever method.

If the $commit does not belong to any branch, then:

    $ git rev-list --bounardy $commit^0 --not --branches | sed -ne 's/^-//p'

would give you boundary commits of the above traversal, which says:

    Traverse from $commit following the parents, but stop at anything that
    is reachable from any breanch.

which means that the ones that are output are the candidates that are on
some branch.

So pipe that to name-rev like this, perhaps (untested)?

    $ git rev-list --bounardy $commit^0 --not --branches |
      sed -ne 's/^-//p' |
      git name-rev --stdin
