From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git filter-branch failed to suppress a file with an
 accentuated letter in the filename
Date: Fri, 15 Feb 2008 09:50:11 -0800
Message-ID: <7vd4qygld8.fsf@gitster.siamese.dyndns.org>
References: <87bq6iw42w.dlv@maison.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Remi Vanicat <vanicat@debian.org>
X-From: git-owner@vger.kernel.org Fri Feb 15 18:51:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQ4iF-0006bz-3Q
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 18:51:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754358AbYBORu3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2008 12:50:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754441AbYBORu2
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 12:50:28 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38917 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754290AbYBORu2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2008 12:50:28 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 257BE3741;
	Fri, 15 Feb 2008 12:50:27 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 187CF3716; Fri, 15 Feb 2008 12:50:23 -0500 (EST)
In-Reply-To: <87bq6iw42w.dlv@maison.homelinux.org> (Remi Vanicat's message of
 "Fri, 15 Feb 2008 17:56:55 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73967>

Remi Vanicat <vanicat@debian.org> writes:

> The culprit seem to be those line of filter-branch: (around line 279) 
> 		git diff-index -r $commit | cut -f 2- | tr '\012' '\000' | \
> 			xargs -0 git update-index --add --replace --remove
> git diff-index giving the filename as "foo/bar\303\251"

I have to wonder in what century filter-branch was written ;-)

Shouldn't those two lines be:

	git diff-index -r --name-only $commit |
        git update-index --add --replace --remove --stdin

these days, without any of the cut and cruft?
