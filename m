From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC] rebase: add --revisions flag
Date: Wed, 09 Dec 2009 12:10:42 -0800
Message-ID: <7vmy1roqm5.fsf@alter.siamese.dyndns.org>
References: <20091208144740.GA30830@redhat.com>
 <7vfx7lcj18.fsf@alter.siamese.dyndns.org> <vpqiqcgp95t.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@redhat.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Dec 09 21:11:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NISsE-0001bH-Gv
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 21:10:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757555AbZLIUKr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Dec 2009 15:10:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757426AbZLIUKq
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Dec 2009 15:10:46 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41091 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756117AbZLIUKq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2009 15:10:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 15B67A59DE;
	Wed,  9 Dec 2009 15:10:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JBmvPFdOxo0+zmG7Gzl5qFRiEBg=; b=ULac5z
	8tKopQTXCkJtsnwlpvsuucNocRk9RoqgBdj5poN3suZpyTK2HfijvxhJDxhQOoB6
	yTr/537sCfygjmOcGRPzrQDg4Uh1wPu3Y71GToDoQYt5yLubNqZ+yjOOXzFEyk77
	sDjxHwRtE0moWqKSOzaiDM3lKU4lEfSVQ2xu0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MS8DXCz/K7Pv0/UTl10ZmyzTHp70IC03
	iODAht1utH2BHZ/utMOXv+1jOspmasC/2gLJpyQwtjDYie/NaZbU74gHAVqIDpSh
	WXz4661jyyXlDPW+gnNLH659aVNwSO+NQ5nTrDqloiH2M5MQdwIcvYN6m1NSshuW
	D/pdKidBA4s=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DA1D2A59DD;
	Wed,  9 Dec 2009 15:10:48 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 96809A59D8; Wed,  9 Dec 2009
 15:10:44 -0500 (EST)
In-Reply-To: <vpqiqcgp95t.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Wed\, 09 Dec 2009 14\:30\:06 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F1474D6A-E4FE-11DE-A89D-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134996>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Perhaps "git rebase --cherry-pick A..B" would be a better name. No
> objection for --opposite either.

As somebody mentioned, "--cherry-picking", similar to "am --rebasing" that
is also an unadvertised internal implementation detail, is a good name.

In the very old days, the original "rebase" command was a command to
"set-up and run 'am -3' command in order to transplant the current branch
onto somewhere else."

That was obviously too long for a command name and description, and I
shorten it to "rebase", to name the command after what it is _for_ (not
"what it does", nor "how it does it").  Because the command was to "set up
and run am-3", it was natural at the conceptual level that the way to
continue after a failed/conflicted patch application was "am --resolved".

But since then, the concept of "rebasing" got established more firmly and
how "rebase" can be done has become much less relevant.  The original name
"rebase" stopped being short for "set up and run am-3 for rebasing", but
about what it _does_ (i.e. "it rebases").  And "rebase --continue" has
become a natural way to drive "am --continue" at that point, to accomodate
for the change in the end-user conception. These days, "set up and run
am-3 for rebasing" is not even _how_ it does the "rebase", as "rebase -i"
does not even use am-3.  So "rebase --continue" was a logical conclusion
of the command's evolution.

The lesson to be learned from this history is that "cherry-pick A..B" that
internally runs "rebase --cherry-picking" will need a similar "--continue"
support that delegates to "rebase".  "running am", which was originally
the whole point of "rebase", later became an implementation detail, and we
needed to teach "--continue" to "rebase" at that point.

Because from day one "running rebase -i" will be an implementation detail
of "cherry-pick A..B", we need to teach "cherry-pick" to pass "--abort",
"--continue", etc. to underlying "rebase" for the same reason.
