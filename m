From: Junio C Hamano <gitster@pobox.com>
Subject: Re: does a successful 'git gc' imply 'git fsck'
Date: Sun, 02 Dec 2012 01:31:34 -0800
Message-ID: <7vlidgls09.fsf@alter.siamese.dyndns.org>
References: <CAMK1S_iBq1ReGkjuy2UBENSQXOWyKj2ZzSCcg7Z89FVtVL2wMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 02 10:32:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tf5u6-0006om-Ab
	for gcvg-git-2@plane.gmane.org; Sun, 02 Dec 2012 10:32:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751933Ab2LBJbk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2012 04:31:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50256 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751560Ab2LBJbg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2012 04:31:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C412976E;
	Sun,  2 Dec 2012 04:31:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=K7z6IzkEHHvzKvlep5m/N3HUQuk=; b=NlPE+5
	HS+dPCEmpcAlSMRghK5dljvd39DP2tUawaG5gvV/yRKWPbTSXUgr+JOf/byL81mK
	OXap9qvAXjJelAN5WBHZoT5aSwZavZmfOAFRBc/825NjojVN6IOvOZWRNG3awR1N
	ekAf8StdOIt7ix5EN0IPBBNyxy3G9f3yOO70s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JB5qpW43iF+KcONmWl9QOJLouWLPtAvJ
	I6XVERUtY99wpn2Lf73uoi+YmJ7WdkF7m6GdcX41ldMoxu2lcw1oc1xj9TDf++ri
	9hExQUsrNXEBE0SBHT4xzba+sBYX3EPASbCuc6QhdMPzNlAC7y/ZNjejhaVhs5EZ
	W6js7jU2Eaw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 613E6976D;
	Sun,  2 Dec 2012 04:31:36 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D104B976B; Sun,  2 Dec 2012
 04:31:35 -0500 (EST)
In-Reply-To: <CAMK1S_iBq1ReGkjuy2UBENSQXOWyKj2ZzSCcg7Z89FVtVL2wMw@mail.gmail.com> (Sitaram
 Chamarty's message of "Sun, 2 Dec 2012 08:01:49 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 10F7B3DE-3C63-11E2-A481-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211006>

Sitaram Chamarty <sitaramc@gmail.com> writes:

> If I could assume that a successful 'git gc' means an fsck is not
> needed, I'd save a lot of time.  Hence my question.

When it does "repack -a", it at least scans the whole history so you
would be sure that all the commits and trees are readable for the
purpose of enumerating the objects referred by them (and a bit flip
in them will likely be noticed by zlib inflation).

But a "gc" does not necessarily run "repack -a" when it does not see
too many pack files, so it can end up scanning only the surface of
the history to collect the recently created loose objects into a
pack, and stop its traversal without going into existing packfiles.
