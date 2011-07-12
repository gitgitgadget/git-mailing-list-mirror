From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/3] teach --histogram to diff
Date: Tue, 12 Jul 2011 10:43:12 -0700
Message-ID: <7vfwmb8ken.fsf@alter.siamese.dyndns.org>
References: <1310451027-15148-1-git-send-email-rctay89@gmail.com>
 <CAJo=hJu5ubkzUyyPM0nqP+J9CU3hBtAHfuzaLSuN214Hux4qTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jul 12 19:43:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QggzQ-0005mp-J8
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 19:43:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754281Ab1GLRnQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jul 2011 13:43:16 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41105 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753288Ab1GLRnP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2011 13:43:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8A66C47C9;
	Tue, 12 Jul 2011 13:43:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bV2OjxNBM8y5mf/pJsjnJyhWJek=; b=X2Jvto
	1uHBbVQzs20hI9LbxcYZP/OlDtsXQ2vdU0TmuL1Lgszhm0z1yaa65sRgxltQMamI
	8OmLixmt8pC88GEDCUEb9x6bk5151wkSr3GUlQ0GEre7LwG2KxupnwEEE1uTHUwQ
	wxgr+5aUwbqvd3rQj8XAtSrl8F8kMRzh5xIZw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W4AKtT3j0Rj6rHa671jdB9vrzeFowOfs
	IPczJnaeiZaTmxPeUw0mrWNHUq6NT3mh4nzeXOnNukZ6FjKYC9SuuZZd5waX2y12
	cjjErWGfZ4lLaiFPZv4NLJcsZZUqSFGFGJCv3wdOiaVGZhL9mvynab5qtaKqVZRy
	tZ2nlWUCMgM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 837D547BE;
	Tue, 12 Jul 2011 13:43:14 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CECAA47BB; Tue, 12 Jul 2011
 13:43:13 -0400 (EDT)
In-Reply-To: <CAJo=hJu5ubkzUyyPM0nqP+J9CU3hBtAHfuzaLSuN214Hux4qTA@mail.gmail.com> (Shawn
 Pearce's message of "Tue, 12 Jul 2011 07:19:47 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6AE15030-ACAE-11E0-98C4-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176956>

Shawn Pearce <spearce@spearce.org> writes:

> Have you looked at a patch that differs in output between Myers and
> patience, and then compared those to the histogram version?

$ git log -p v1.6.6..v1.7.6 | git patch-id >/var/tmp/md
$ git log --histogram -p v1.6.6..v1.7.6 | git patch-id >/var/tmp/hd
$ diff -u0 /var/tmp/md /var/tmp/hd |
  sed -ne '/^+/s/^+[0-9a-f][0-9a-f][0-9a-f]* //p' |
  while read commit
  do
  	git show "$commit" >/var/tmp/1
        git show --histogram "$commit" >/var/tmp/2
        interdiff /var/tmp/1 /var/tmp/2
  done

shows there is one that gives vastly different appearance, but it all
boils down to which lines to take as common, and for this particular
example neither is more readable over the other (9560808f2ef5a34d2a).

Running the above "show" with larger -U$n value shows there don't seem to
be any discrepancies between the two.
