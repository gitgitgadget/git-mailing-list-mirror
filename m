From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] Teach rebase to rebase even if upstream is up to
 date with -f
Date: Thu, 12 Feb 2009 13:34:59 -0800
Message-ID: <7vbpt7jq4c.fsf@gitster.siamese.dyndns.org>
References: <1234468061-29923-1-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailinglist" <git@vger.kernel.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Eric Wong" <normalperson@yhbt.net>,
	"Shawn O. Pear, Sverre Rabbelier <srabbelier@gmail.com>"@b-sasl-quonix.sasl.smtp.pobox.com
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 22:36:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXjEa-0003jh-Ab
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 22:36:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758227AbZBLVfK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 16:35:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757290AbZBLVfJ
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 16:35:09 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38876 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755322AbZBLVfI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 16:35:08 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 392BB2AFF5;
	Thu, 12 Feb 2009 16:35:07 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 47CB02AFE8; Thu,
 12 Feb 2009 16:35:02 -0500 (EST)
In-Reply-To: <1234468061-29923-1-git-send-email-srabbelier@gmail.com> (Sverre
 Rabbelier's message of "Thu, 12 Feb 2009 20:47:41 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 045FFBE8-F94D-11DD-BE19-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109663>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> Say I have a bunch of new commits ready to submit to origin, but I want to fix
> some whitespace damage, I could do something like this:
>
> $ git checkout master
> $ git branch -b rebase-me
> $ git reset --hard origin/master
> $ git commit --allow-empty "force rebase"
> $ git checkout rebase-me
> $ git rebase --whitespace=fix master
> $ git rebase -i master # kick out the 'force rebase' commit
> $ git checkout master
> $ git reset --hard rebase-me
> $ git branch -d rebase-me

For that, I would prefer to see:

	git format-patch --stdout origin >my.mbox
	git fetch origin
        git checkout origin             ;# yes, detach
        git am --whitespace=fix my.mbox
        make test
        git format-patch -o to-send-out origin
	git send-email ..options.. to-send-out

for two reasons.

It fixes whitespace breakages, but more importantly, the procedure makes
sure that what you will be sending out will apply cleanly to the origin
that may have progressed since you last looked at it.
