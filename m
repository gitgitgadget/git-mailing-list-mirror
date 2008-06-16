From: Junio C Hamano <gitster@pobox.com>
Subject: Re: using git-blame with patches as input
Date: Mon, 16 Jun 2008 14:45:59 -0700
Message-ID: <7vej6x9hpk.fsf@gitster.siamese.dyndns.org>
References: <20080616213517.GE20727@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Don Zickus <dzickus@redhat.com>
X-From: git-owner@vger.kernel.org Mon Jun 16 23:47:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8MXj-0005iC-1G
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 23:47:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758277AbYFPVqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 17:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756785AbYFPVqM
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 17:46:12 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:32888 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758262AbYFPVqK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 17:46:10 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 676FED629;
	Mon, 16 Jun 2008 17:46:07 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id BA75FD627; Mon, 16 Jun 2008 17:46:02 -0400 (EDT)
In-Reply-To: <20080616213517.GE20727@redhat.com> (Don Zickus's message of
 "Mon, 16 Jun 2008 17:35:17 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A053B512-3BED-11DD-9B70-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85237>

Don Zickus <dzickus@redhat.com> writes:

> I deal with a lot of backported patches that are a combination of multiple
> commits.  I was looking to develop a tool that would help me determine
> which chunks of the patch are upstream (not necessarily currently in HEAD
> but at some point in the file's history).
>
> For example, if I took the top three commits from HEAD and appended them
> into one patch file and then ran this tool with the patch as input, I
> would hope that it gave as output the three original commits.

A quick and dirty hack would be to:

	rm .git/index
	sed -ne 's/^[+ ]//p' -e '/^@@/p' patches... >file
        git add file
        git commit -m 'only "a file" remains'
        git blame -C -C -w file

which would try blaming all the postimage concatenated together ;-)
