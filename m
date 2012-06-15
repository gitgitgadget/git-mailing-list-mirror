From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i -p: use rerere to resolve conflicts if enabled
Date: Fri, 15 Jun 2012 08:52:14 -0700
Message-ID: <7vwr38bmj5.fsf@alter.siamese.dyndns.org>
References: <1339769855-94161-1-git-send-email-ddkilzer@kilzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "David D. Kilzer" <ddkilzer@kilzer.net>
X-From: git-owner@vger.kernel.org Fri Jun 15 17:52:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SfYoy-00043z-Qp
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jun 2012 17:52:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257Ab2FOPwU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jun 2012 11:52:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61653 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932110Ab2FOPwT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2012 11:52:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D348C9092;
	Fri, 15 Jun 2012 11:52:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QDAOh88m5ExLPMbc1UkhyZwjeAY=; b=QMipaR
	Qhg2pj+1toNRCEy0Yks4QidWY3ujPV08WvtHBP9uK+b+q2B1mtJM4YjPklhA/lau
	lKHjk3BCkmIGvjZQ1zlUY0RtLyMhdUlV/P7HiL/E2R5hNxhOr2HeXINbyeCy+FG7
	5Jok2BBnCOiXi9FY0/8CakJhHLgUxp9yDII68=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EM6YBwQnqZ8zNRYxYldlXaDXuLZYx6eD
	FLzp7d8HETnWXZl+gVda6PuwdI14NOp+Hw0tvr0/KxqLk+RCJjvyX4/Esx07N4c9
	hLpJeuW0wLVYwzyRo+wh0pFAXKCP4xqhuiR7nuBYj1UleGup9m5VDisVSEB0lFbg
	hc6G1xnlV10=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C9FC89091;
	Fri, 15 Jun 2012 11:52:16 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 59BFB908F; Fri, 15 Jun 2012
 11:52:16 -0400 (EDT)
In-Reply-To: <1339769855-94161-1-git-send-email-ddkilzer@kilzer.net> (David
 D. Kilzer's message of "Fri, 15 Jun 2012 07:17:35 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 14C01286-B702-11E1-BF06-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200062>

"David D. Kilzer" <ddkilzer@kilzer.net> writes:

> From: "David D. Kilzer" <ddkilzer@kilzer.net>
>
> When performing an interactive rebase that preserves merges with
> rerere enabled, the --rerere-autoupdate switch should be passed
> to git-merge.

I do not understand the above reasoning.

"rerere" is enabled in "merge" used in this codepath already, so
after it runs, you will see the result of automatically replaying
a previous resolution without your patch.

The configuration rerere.enabled *never* meant that the user blindly
trusts the result of replaying a previous resolution.  If you were
checking rerere.autoupdate configuration variable, the patch may
have made some sense, but basing the decision on rerere.enabled
(which by the way is not necessary to trigger the rerere machinery
these days, as long as $GIT_DIR/rr-cache/ directory exists) sounds
very wrong.
