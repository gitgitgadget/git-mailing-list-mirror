From: Junio C Hamano <gitster@pobox.com>
Subject: [RFD] minor frustration in 'git add' pathname completion
Date: Thu, 24 Mar 2016 14:44:07 -0700
Message-ID: <xmqqr3ez7dqw.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 24 22:44:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajD3A-0001z1-PW
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 22:44:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbcCXVoM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 17:44:12 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:50788 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750736AbcCXVoL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 17:44:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8DFD64D087;
	Thu, 24 Mar 2016 17:44:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=z
	JTA+G6XE5JWkg+1G6UToZo+MM4=; b=wyfXQXQX/nbpwYOXiww9LxsMeyzMMIgXi
	9uOI10Z75NX/p+TnUmgJE/Sf0T3Psoc1HcF6SP+OhB99PyIMs43fbAzaN/5Cbsli
	7l6FAxWJKoXGJflIwtB2aiiHdicIGgqCT8Ghw16idhOsKvJBMMwPLSfHRXXd7FyN
	AQmatlJ23E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=oFd
	W2swjUj2cD+fEFGKXOUcMRlARoi0j1MORFsfAAaLM+a0dki5CpxbC7OIobSv+e6h
	ietItG+VSwT4RusQeYjs/cI9R/RsbmKH1ZeyP2q3C4uiGJRkp23T6QVZ4yUXL1Cm
	gTsCsPUkxHRwIEdwxilThsXK6cK1pSW2soG68xiU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 742154D086;
	Thu, 24 Mar 2016 17:44:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E26F24D085;
	Thu, 24 Mar 2016 17:44:08 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8A0CC9EE-F209-11E5-92BC-EB7E6AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289804>

It seems that "git add foo<TAB>" completes to files

 (1) whose names match 'foo*',

 (2) that are not ignored (i.e. "foobar~" will not be offered for
     Emacs users), and

 (3) are different from the index.

The last one is somewhat frustrating at times.  For example, I keep
a backup version of whats-cooking.txt in the working tree that I use
to manage the 'todo' branch as whats-cooking.txt+, and this is not
explicitly "ignored".  Most of the time, I have changes to the real
file, so

    $ git add whats<TAB>

would complete to "whats-cooking.txt" (because there are two
candidates, "whats-cooking.txt" and "whats-cooking.txt+", and the
first completion is done up to the common prefix) and everything is
good.

Immediately after I did "git add whats-cooking.txt", however,
because of (3), the completion for 

    $ git add whats<TAB>

offers "whats-cooking.txt+", because that is the only candidate that
passes all three criteria.  This is quite annoying and even dangerous,
because it does not happen most of the time.

I am wondering if there is a downside to removing (3) from the
completion logic.

Discuss.

Thanks.
