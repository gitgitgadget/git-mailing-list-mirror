From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tests: git push mirror mode tests V2
Date: Fri, 09 Nov 2007 12:05:43 -0800
Message-ID: <7vsl3frxpk.fsf@gitster.siamese.dyndns.org>
References: <1194541305.0@pinky> <1194603673.0@pinky>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Whitcroft <apw@shadowen.org>
X-From: git-owner@vger.kernel.org Fri Nov 09 21:06:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iqa7H-0001Tk-Te
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 21:06:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752335AbXKIUFt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 15:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754793AbXKIUFt
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 15:05:49 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:50811 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752335AbXKIUFs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 15:05:48 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id D35AB2F0;
	Fri,  9 Nov 2007 15:06:09 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 606A493BFE;
	Fri,  9 Nov 2007 15:06:07 -0500 (EST)
In-Reply-To: <1194603673.0@pinky> (Andy Whitcroft's message of "Fri, 9 Nov
	2007 10:21:13 -0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64257>

Andy Whitcroft <apw@shadowen.org> writes:

> +test_expect_success 'push mirror does not create new branches' '
> +
> +	mk_repo_pair &&
> +	(
> +		cd master &&
> +		echo one >foo && git add foo && git commit -m one &&
> +		git push --mirror up
> +	) &&
> +	master_master=$(cd master && git show-ref -s --verify refs/heads/master) &&
> +	mirror_master=$(cd mirror && git show-ref -s --verify refs/heads/master) &&
> +	test "$master_master" = "$mirror_master"
> +
> +'

I am quite puzzled by this and many other "does not" in the test
description.  The --mirror option is advertised as

 - newly created will be pushed;
 - locally updated will be force pushed;
 - locally deleted will be removed.

which makes sense as we do want these things to happen for
"mirrors".  Indeed the above updates master branch at the master
repository and makes sure that change is propagated to the
mirror repository.  The description should read "push mirror
creates new branches" shouldn't it?
