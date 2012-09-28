From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git diff-file bug?
Date: Fri, 28 Sep 2012 13:40:48 -0700
Message-ID: <7vr4plkhin.fsf@alter.siamese.dyndns.org>
References: <CAEkqydxRy3ukSWyQ53Tiosq+DMWWLG=AVuZk+Jm79Y5SaRmeDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Scott Batchelor <scott.batchelor@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 28 22:46:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THhRz-0005av-OO
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 22:46:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031527Ab2I1UqG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2012 16:46:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38503 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759555Ab2I1Ukv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 16:40:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 47E90960B;
	Fri, 28 Sep 2012 16:40:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Q5H0veRdLtkx+noITF5PlV5eO2M=; b=aH+IOC
	pppcQxAtb1voHGGZbePkhkluHX5qS4MW+LAuORV4vfxzIoD26ndKq2QpAJ+vlGkJ
	t9xjSHTj/4PO/kDU3k4NEO+hJ4w3F8xPHH76orStwMNH5w5FrwgHzmhpI0zmdpGW
	3kapXAeMvet+NJy8YfKiRkK9IeccYngOXuuqs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wO6hZSo0/95wIvrv5bSfR0DrQGKBHvcD
	LI9986SCrYUjWkDP2AZ/P8JSsY/NAVTf3ELbz48Gz1cF6vzbzusL3RTbidrfuSCa
	QHs9DLDzhGT0QdD4PGOQIpmmv/5Dpmx72fu3ealzcTWVLQfwHFjDj/OuS5I7iGHI
	ST/hib7B4f8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 33101960A;
	Fri, 28 Sep 2012 16:40:50 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A656B9609; Fri, 28 Sep 2012
 16:40:49 -0400 (EDT)
In-Reply-To: <CAEkqydxRy3ukSWyQ53Tiosq+DMWWLG=AVuZk+Jm79Y5SaRmeDw@mail.gmail.com> (Scott
 Batchelor's message of "Fri, 28 Sep 2012 19:55:10 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C9A97F46-09AC-11E2-99FF-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206609>

Scott Batchelor <scott.batchelor@gmail.com> writes:

> I'm fairly new to git and am witnessing some strange behavior with git
> that I suspect may be a bug. Can anyone set my mind at rest.
>
> Every so often (I've not quite figured out the exact set of
> circumstances yet) 

Figure that circumstances out.  That is the key to the issue.
Something in your workflow is futzing with the inode data of the
files in your working tree behind your back.  It sometimes is a
virus scanner.

"git diff-*" plumbing commands are meant to be used after running
"git update-index --refresh" once in the program and when the caller
of these commands (in your case, gitk) knows that any change in the
information returned by lstat(2) on the paths in the working tree
files since that call indicate real changes to the files.

"git status" internally runs an equivalent of "--refresh" before it
goes to find changes, so after running it, until that something
smudges the inode data behind your back, "gitk" will not be
confused.
