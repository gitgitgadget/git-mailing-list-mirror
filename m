From: Junio C Hamano <gitster@pobox.com>
Subject: Re: wishlist; unify behavior while cloning non-bare repos over http to be in line with ssh/local
Date: Tue, 10 May 2016 13:11:36 -0700
Message-ID: <xmqqfutpoepz.fsf@gitster.mtv.corp.google.com>
References: <20160506131855.GD7907@onerussian.com>
	<20160510190652.GI7907@onerussian.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Gurus hangout <git@vger.kernel.org>,
	Benjamin Poldrack <benjaminpoldrack@gmail.com>,
	Michael Hanke <michael.hanke@gmail.com>
To: Yaroslav Halchenko <yoh@onerussian.com>
X-From: git-owner@vger.kernel.org Tue May 10 22:12:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0E0d-0005Pb-NP
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 22:12:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753427AbcEJULm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 16:11:42 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51058 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753396AbcEJULk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 16:11:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EDC6D1961F;
	Tue, 10 May 2016 16:11:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Sof6fWsAZULI6ZG3/NbDwNvgxFg=; b=m0UfTA
	Tb2Uyr0QTC/b7PE/GBomTP9ZdbJA3XAsLUyRdCBRuhuYONvQjcKcM3N8Xt622uzu
	bO37e5IfOxJQ3wGvMe7LGK5CKGMj776/CXGUb15b1xHzZeeI0e/vMYrUEHXdojVE
	ueHpmH1pVOKT2Ue6lmrVXzziy6132rKYWMjGM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CpwXl95VglPFXShRbKKY3+oSbyWmTCKY
	xEEYTi4V3hvSpSZvQD38e4Kka132g8ROyHeJtiuAx5swpmMhACTkYYmsSELc+Gd0
	h7Lre/SlenmZ/Wntt5nBx7EY45HNoBgjajr+oyib0EYzims1peSH+LkQXZd/0ntm
	S8y/4vKdRzE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E54041961E;
	Tue, 10 May 2016 16:11:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6F9BE1961D;
	Tue, 10 May 2016 16:11:38 -0400 (EDT)
In-Reply-To: <20160510190652.GI7907@onerussian.com> (Yaroslav Halchenko's
	message of "Tue, 10 May 2016 15:06:52 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6720CAF0-16EB-11E6-8D60-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294183>

Yaroslav Halchenko <yoh@onerussian.com> writes:

> On Fri, 06 May 2016, Yaroslav Halchenko wrote:
>
>> Dear Git Folks,
>
>> Originally this issue was mentioned in previous thread [1], and I have decided
>> to bring it into a separate thread.  ATM there is a dichotomy in git behavior
>> between cloning non-bare repos:  if I clone over ssh or just locally by
>> providing url without trailing /.git, git senses for /.git and works just fine
>> with ssh or local repositories, but fails for "dummy" http ones, the demo
>> script is here [2] which produces output listed below.  From which you can see
>> that  cloning using http URL to the repository without /.git fails (git version
>> 2.8.1, Debian).  As it was noted in [1], concern could have been to not
>> traverse website since could lead to dangerous places.  But .git is under
>> originating url directory, as well as info/ or HEAD or any other object
>> accessed by git, so IMHO this concern is not a concern.

I am afraid that the reason why you saw no response is primarily
because nobody is interested in extending dumb commit-walker HTTP
transport after the world has largely moved on and abandoned it.

The necessary update to the client might as simple as using
$GIVEN_URL/.git/ and attempting the request again after seeing the
probe for $GIVEN_URL/info/refs fails.
