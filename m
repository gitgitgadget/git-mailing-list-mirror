From: Junio C Hamano <gitster@pobox.com>
Subject: Re: --first-parent plus path limiting
Date: Tue, 29 Jan 2008 00:47:34 -0800
Message-ID: <7vk5ltow61.fsf@gitster.siamese.dyndns.org>
References: <479EE405.1010001@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Jan 29 09:48:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJm8f-0000KY-GD
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 09:48:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753344AbYA2Irr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2008 03:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753070AbYA2Irq
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jan 2008 03:47:46 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56417 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751996AbYA2Irq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2008 03:47:46 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 794B23A42;
	Tue, 29 Jan 2008 03:47:44 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C4D1E3A41;
	Tue, 29 Jan 2008 03:47:41 -0500 (EST)
In-Reply-To: <479EE405.1010001@viscovery.net> (Johannes Sixt's message of
	"Tue, 29 Jan 2008 09:29:57 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71968>

Johannes Sixt <j.sixt@viscovery.net> writes:

> While trying to find out when builtin-fetch.c was merged into master, I
> noticed that this:
>
> $ git log --first-parent --pretty=oneline -- builtin-fetch.c
>
> lists b888d61c (Make fetch a builtin), which I did not expect.

Why didn't you?

> This one
> doesn't list it, as expected:
>
> $ git log --first-parent --pretty=oneline

Why did you expect that?  This tells "follow only the first
parent chain, ignoring all merges".

As most everything that is nontrivial is developed on a topic
branch in git.git, "Make fetch a builtin" will not be on the
first parent chain of the "master".

The former is about "First simplify the history with respect to
builtin-fetch.c, and then follow the first-parent of the
simplified history.

As the builtin-fetch topic was worked on for some time on its
own topic, like this:

 ---o---o---o---...---o---A---M--- master
     \                       /
      o---o---X---...---o---B

So if a commit M has two parents A and B, and the file in M is
the same as the file in B, the history simplifies commit A and
the side branch that leads to it away.  Perhaps commit A was the
first parent and B was the last commit of the fetch-pack series,
and "Make fetch a builtin" was an ancestor of B, like X above.

$ gitk b888d61c^..v1.5.4-rc5 -- builtin-fetch.c

is somewhat interesting to view.
