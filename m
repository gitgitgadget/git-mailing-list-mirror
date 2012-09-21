From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Quickly searching for a note
Date: Fri, 21 Sep 2012 10:21:00 -0700
Message-ID: <7vy5k370n7.fsf@alter.siamese.dyndns.org>
References: <505C7C80.3000700@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Fri Sep 21 19:21:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TF6ug-0005rw-PC
	for gcvg-git-2@plane.gmane.org; Fri, 21 Sep 2012 19:21:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111Ab2IURVE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2012 13:21:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56509 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756665Ab2IURVD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2012 13:21:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 786499739;
	Fri, 21 Sep 2012 13:21:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RA3B46newfzELXTddkJvOy8ZTdc=; b=gKdWVW
	1kzqhsrhn7U8NVll0guI0QXu1o4R1UC4hKwoMgTo1kCcqECdR0dFEHwW6S9SAlzg
	qpKmNI8MYwmvSFSN0lxCo6GiPMDHihEXP9StCmP7P7aJiltPvlQRDt1vZCEgU/A+
	a4OdBIJhbZGh6obXxjxbx9XSA93EmtUl/lxKo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RaAzBi6vHV4ItcweKODFYzzR8BLPkD1h
	h6eJg2zo9ct8IRonrTJQ5b7siTcH3AfUJ/c9YYqVk+7RCTjd+douLKB6297zO1lj
	LbAxubnJNxGZfU5pmd+BWPuvxQBBNel8QbFrc5BfSVKkWFfgR6XIHPjBgeC/tikv
	1ZaM/GGCoTs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 653F39737;
	Fri, 21 Sep 2012 13:21:02 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D7C559734; Fri, 21 Sep 2012
 13:21:01 -0400 (EDT)
In-Reply-To: <505C7C80.3000700@workspacewhiz.com> (Joshua Jensen's message of
 "Fri, 21 Sep 2012 08:41:04 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B77C76DA-0410-11E2-AF2A-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206138>

Joshua Jensen <jjensen@workspacewhiz.com> writes:

> Background: To tie Perforce changelists to Git commits, I add a note
> to a commit with the form "P4@123456".  Later, I use the note to sync
> down the closest Perforce changelist matching the Git commit.
>
> I search for these notes by getting a list of revisions:
>
>         git rev-list --max-count=1000
>
> I iterate those revisions and run git show and grep on each:
>
>         git show -s --format=%N%n%s --show-notes=p4notes COMMIT
>
> For short runs, this isn't so bad.  For longer runs of commits (I just
> walked through approximately 100), it takes a long time. Running 'git
> show' is costing me about 7/10 of second, presumably because I am on
> Windows.

Is there any particular reason you do that as two separate steps?
It would feel more natural, at least to me, to do something along
the lines of

	git log --show-notes=p4notes -1000
