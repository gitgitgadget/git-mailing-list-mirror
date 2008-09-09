From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Commit templates are not readable after 'make install'
Date: Tue, 09 Sep 2008 12:19:03 -0700
Message-ID: <7v8wu16sbc.fsf@gitster.siamese.dyndns.org>
References: <3665a1a00809091202u295fedabl53b280aad7bedb62@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, johannes.sixt@telecom.at
To: "Anatol Pomozov" <anatol.pomozov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 09 21:40:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kd94W-0006ii-EX
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 21:40:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752898AbYIITjM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 15:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752483AbYIITjM
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 15:39:12 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58926 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751792AbYIITjL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 15:39:11 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 5745F7AA31;
	Tue,  9 Sep 2008 15:39:08 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 4D9667A7D6; Tue,  9 Sep 2008 15:19:10 -0400 (EDT)
In-Reply-To: <3665a1a00809091202u295fedabl53b280aad7bedb62@mail.gmail.com>
 (Anatol Pomozov's message of "Tue, 9 Sep 2008 12:02:01 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F81C832C-7EA6-11DD-9964-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95418>

"Anatol Pomozov" <anatol.pomozov@gmail.com> writes:

> I build git from sources and I have one small permissions issue that
> (I think) should be fixed.
>
> So I build it as described in INSTALL file
> make prefix=/usr all
> sudo make prefix=/usr install
>
> Everything goes fine here and we have a new version of git installed
> $ git --version
> git version 1.6.0.1.285.g1070
>
> But when I want to create a new repo, I have a fatal problem
> $ git init
> fatal: cannot copy
> /usr/share/git-core/templates/hooks/applypatch-msg.sample to
> /personal/sources/opensource/1/.git/hooks/applypatch-msg.sample
>
>
> Because of the template files are readable only for root
> $ ls -l /usr/share/git-core/templates/hooks/
> total 44
> -rwxr-x--- 1 root root  452 2008-08-29 11:04 applypatch-msg.sample
> -rwxr-x--- 1 root root  894 2008-08-29 11:04 commit-msg.sample
> -rwxr-x--- 1 root root  160 2008-08-29 11:04 post-commit.sample
> -rwxr-x--- 1 root root  553 2008-08-29 11:04 post-receive.sample

Didn't 9907721 (templates/Makefile: don't depend on local umask setting,
2008-02-28) take care of that?

    ... goes and looks ...

Ah, that is only to propagate the wish of the person who _built_ it.

You probably have a tight umask and have sources checked out unreadable to
others, which is propagated to the installation (check the permission of
files in your templates/blt directory to verify this conjecture).  And the
build procedure is honoring your wish to make things unreadable to others.
