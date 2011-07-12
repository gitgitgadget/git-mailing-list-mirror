From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Interpreting git merge failures
Date: Tue, 12 Jul 2011 09:40:29 -0700
Message-ID: <7vy6038nb6.fsf@alter.siamese.dyndns.org>
References: <CAKmUPx5Qt2K+7F+BsW3WTmRjodBSrteuyG8p9oRHZuhApTu4+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Scott Bronson <bronson@rinspin.com>
X-From: git-owner@vger.kernel.org Tue Jul 12 18:40:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qgg0k-0001uw-7j
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 18:40:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754092Ab1GLQkd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jul 2011 12:40:33 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36528 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753738Ab1GLQkc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2011 12:40:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0DE0A5F9C;
	Tue, 12 Jul 2011 12:40:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6o2L4G7mg/BJVx3ZAGQLDgzhWMA=; b=AjHFTP
	7giZY+KEHwEPP9aeuVrDhje+pZEWYFFCKiwBOI6HlFWxLZ0pW1n4sz8SDfztms1v
	f3D8l7OAg0I3AfGrqKtnMrPBH9jtP8nZaupHJfDhRlsphzkcx1nPP64EdZHSShp/
	TC6qBT5aMgWsrv09H9MIxF6CGxCg8JHAqkKzQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LZYwWr1rAFwKNaWhLggw3gmkri/ErxB7
	f1/tnmD8cjceW3+B4i+mYNAhitCLDco+XjMgijOOxpMifWP+7C9HvBId8iuk5dSA
	Q20HKzXRDSr18J/F9wanJsCfuqBsGkcyyUpZlVtCmJHv9vUumGULVBVB+CSgMruM
	6RMqiLGwaWI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 067B25F9B;
	Tue, 12 Jul 2011 12:40:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 66ABE5F9A; Tue, 12 Jul 2011
 12:40:31 -0400 (EDT)
In-Reply-To: <CAKmUPx5Qt2K+7F+BsW3WTmRjodBSrteuyG8p9oRHZuhApTu4+g@mail.gmail.com> (Scott
 Bronson's message of "Thu, 7 Jul 2011 11:45:57 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A84C901E-ACA5-11E0-AB88-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176948>

Scott Bronson <bronson@rinspin.com> writes:

> What is the best way to determine why a git merge failed?

If you get exit code 0, the merge did not fail.

Otherwise you can inspect the index after getting the non-zero exit code.

If you have an unmerged entry in the index, there could be two cases.  The
most typical is that the merge was attempted and stopped due to an
conflict. "ls-files -u" will show these paths. Another is a user error to
run "git merge" when your index is already unmerged, but you can easily
avoid this at the beginning of your script, stopping without running "git
merge" when the index is unmerged to begin with.

If you do not have an unmerged entry in the index, the merge refrained
from overwriting either your local modifications in the working tree, or
your local modifications to the index.  Again the latter is a user error
that you can detect before running "git merge" in your script.
