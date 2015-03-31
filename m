From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Allowing weak references to blobs and strong references to commits
Date: Tue, 31 Mar 2015 13:23:23 -0700
Message-ID: <xmqq8uecrk5g.fsf@gitster.dls.corp.google.com>
References: <20150331100756.GA13377@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Tue Mar 31 22:23:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yd2hC-0004K1-Mi
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 22:23:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754602AbbCaUXa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2015 16:23:30 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63656 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754520AbbCaUXZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2015 16:23:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8DB10454E1;
	Tue, 31 Mar 2015 16:23:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yu7K5N4i1E+YMGkgSFZd8ytktNk=; b=ozRARD
	L2aSmVM6MWQb5QQA1XoKeU3MsYWFW3RHXU29n+0kXsbLxarpPRmC/vBsjkBvYZj3
	1r52nW5JhR2aufgrJe1wxGtXNDhtu47tyYgIV81eK7cl71dYt0aed4Kzx3XFxVn2
	/OXCVYLCUlbRDvkstkfOQcAz0Ah9ZDklX7wqY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n51NMLS9k40s/b8frMlAEq43f5Z6y9d+
	OrcN9DM8igbiBpNhhxGisSKovj61e8ZRHqT/kccwBRCZH9Yqb+LtcdnStKCF6E/6
	rJEadZe26lmc+3kHfyjyNcIr8pqVXYnIpOBDM1nhZ7wGbfXGM7ShxFEtgIC/K7QT
	rWQdb7IwvaQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 867BD454E0;
	Tue, 31 Mar 2015 16:23:24 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0C92A454DF;
	Tue, 31 Mar 2015 16:23:23 -0400 (EDT)
In-Reply-To: <20150331100756.GA13377@glandium.org> (Mike Hommey's message of
	"Tue, 31 Mar 2015 19:07:56 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C7FB5298-D7E3-11E4-8F43-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266552>

Mike Hommey <mh@glandium.org> writes:

> So I thought, since commits are already allowed in tree objects, for
> submodules, why not add a bit to the mode that would tell git that
> those commit object references are meant to always be there aka strong
> reference, as opposed to the current weak references for submodules.

Unless you are recording the paths to these "commits" to be
potentially checked out on the filesystem, do not put them in a
"tree".  The entries in a tree object represent "This thing go to
this path in the working tree".

It is not clear to me (and because you said "I won't bother you with
all the whys and hows", I am guessing that it is OK for readers to
be unclear), but I think you only want to make sure "git fetch" and
"git push" transfers these objects, the graph formed by which is
*not* any part of the main history of the project.  It is perfectly
OK to represent these objects as a special purpose history and have
a ref point at its tip.  The "notes" database is represented that
way, for example.  And I do not see anything wrong to use octopus
merges in the history if you want to represent "here are the commit
objects that I care about at this point in the 'special purpose'
history (not the main history)".
