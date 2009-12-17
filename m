From: Junio C Hamano <gitster@pobox.com>
Subject: Re: adding additional remote refs to a remote repo
Date: Thu, 17 Dec 2009 10:19:01 -0800
Message-ID: <7v4onpo44q.fsf@alter.siamese.dyndns.org>
References: <a422b4da0912170943q2613faeao208eaa674d1a0afa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Peter Petrakis <peter.petrakis@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 17 19:19:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLKwZ-0000Oi-Tn
	for gcvg-git-2@lo.gmane.org; Thu, 17 Dec 2009 19:19:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935234AbZLQSTO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2009 13:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935226AbZLQSTN
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Dec 2009 13:19:13 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35526 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935124AbZLQSTL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2009 13:19:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0C321A76EE;
	Thu, 17 Dec 2009 13:19:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SgUBXaoFn41QHN7SwlNaB/EhZG4=; b=kGO2+4
	Ebyz9/iT+ExtvGpvkqUc72dJAKDgAqB/+Jsp2FRrWHLTrenSsVI5fzLDw0XxkdkJ
	IXjA9vUnHqkXYELEkCfz99HPb867Zg4y0z3FB2FEs+9I1QjKEQ9oOJmqU9oeYGaY
	7gtiPBZ04KSnYveI6/fCe+VNiql6k9/YFDqQM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R11EUI/E2f07g9msb0ok8l4E46xabM4x
	1ZluJWmtE+WzEC+N6BSvWI+8IBBd1VcfhaztAjpU/idO2XUl/VwA4fkrvPhO8XuV
	rUMSjFJV+3wginTB29SSlkwem10kYhe57UsRTgS+EYyMMKNLNbBDdO+qk4LlzJsm
	NKCMt8s0ey4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DF4CBA76EB;
	Thu, 17 Dec 2009 13:19:06 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E1C7FA76EA; Thu, 17 Dec 2009
 13:19:03 -0500 (EST)
In-Reply-To: <a422b4da0912170943q2613faeao208eaa674d1a0afa@mail.gmail.com>
 (Peter Petrakis's message of "Thu\, 17 Dec 2009 12\:43\:19 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A9E476B0-EB38-11DE-A5E1-B34DBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135379>

Peter Petrakis <peter.petrakis@gmail.com> writes:

> Now if I push this drbd-8.2.7-merge-branch to the central repo, the next
> guy won't know for sure what this was tracking. I also don't want to
> have to 'add remote ...'  every time I clone a new copy. Thanks.

The kind of information you listed above are kept in $GIT_DIR/config of
each repository.  This file is kept private to each repository, i.e. not
cloned, fetched or pushed across repositories [*1*].

This is a deliberate design decision.

 - The file records mostly personal preferences, e.g. how user works with
   his branches in the repository, if the integration is done via rebase
   instead of merge, how the output is colored, etc.  Your colleagues can
   and will use branches other than the ones that may be publicly shared
   (like drbd-8.2.7-merge-branch), and how they use their private branches
   is not something you want to dictate nor interfere with.

 - The [remote "foo"] sections and friends (e.g. [branch "bar"]) in the
   "$GIT_DIR/config" in that bare repository you created specifies how
   that particular repository interacts with the remote named "foo" and
   how branch "bar" is integrated with other things.  These may not
   necessarily match, and if you are using it as a middleman repository
   between your developers and the project upstream, they will in general
   not match, the setting the developer repositories want to use.  This
   should be obvious if you think about where remote.origin.url should
   point at.  In the middleman repository, you would want "git fetch"
   without "origin" to slurp from the upstream and in the developer clones
   of this repository, you would want to "git fetch" to update from this
   middleman repository.

 - The file can has pointers to external programs to be used as filters;
   blindly copying it upon clone has security implications as well.


[Footnote]

*1* Often people use README-like document in-tree to tell developers about
the specific settings the project wants them to use (i.e. "how to work
with this project"), together with coding styles, submission guidelines,
etc., that are not tied to the use of git.
