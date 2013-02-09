From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git bisect result off by 1 commit
Date: Fri, 08 Feb 2013 18:03:54 -0800
Message-ID: <7v1ucqxmyd.fsf@alter.siamese.dyndns.org>
References: <1360374853.17632.182.camel@schen9-DESK>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, ak <ak@linux.intel.com>
To: Tim Chen <tim.c.chen@linux.intel.com>
X-From: git-owner@vger.kernel.org Sat Feb 09 03:04:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3znh-0008H0-1I
	for gcvg-git-2@plane.gmane.org; Sat, 09 Feb 2013 03:04:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760493Ab3BICD5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 21:03:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37953 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756077Ab3BICD5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 21:03:57 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C4E7BFB9;
	Fri,  8 Feb 2013 21:03:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BXXKTKm0CuoNFSxiDMijt9SmEdQ=; b=Yz0mT6
	nqqSuZrl0W3sUFKqz3qXBQlWX0II8nJGcfQd6vfqqp5z61cTXhgBmGervgaBNXcu
	CnwLZuZDFw+0cj/KtxazxGlt52All+EHaESBCevL25An+tXm3DQnABZSNSST3h5p
	uz14R1A+/l3wLBtzp/6p1PhN2ffSHr9uYxyH0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lcEIeDifAILvokGUKGP8K1aotXvO4lF2
	Q5fH6tGK1xZ10RGDO5Q+rl/cWMvV5gT1JYt8VA0XelLXEVwl91wRSn/gULqp8PyU
	q8oMHoBEyK71/2RbKZWoBQb/xwviJQLBNyCsbq2ZNgLtC1tm5CKUP3elkr8bid6x
	G+glj0r5pB4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 713C2BFB8;
	Fri,  8 Feb 2013 21:03:56 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EC633BFAE; Fri,  8 Feb 2013
 21:03:55 -0500 (EST)
In-Reply-To: <1360374853.17632.182.camel@schen9-DESK> (Tim Chen's message of
 "Fri, 08 Feb 2013 17:54:13 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F5BAEA02-725C-11E2-8926-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215844>

Tim Chen <tim.c.chen@linux.intel.com> writes:

> When I am doing a git bisect to track down a problem commit on the Linux 
> kernel tree, I found that git bisect actually led me to a patch that's one
> before the problem commit.
>
> In particular,
>
> $ git bisect replay bisectlog 
> Previous HEAD position was d54b1a9... perf script: Remove use of die/exit
> HEAD is now at a0d271c... Linux 3.6
> Bisecting: 0 revisions left to test after this (roughly 0 steps)
> [d54b1a9e0eaca92cde678d19bd82b9594ed00450] perf script: Remove use of die/exit
>
> However, the patch that is problematic is the one before the one git bisect indicated.
> [commit 8d3eca20b9f31cf10088e283d704f6a71b9a4ee2].

Looks perfectly normal to me.  The message above:

> HEAD is now at a0d271c... Linux 3.6
> Bisecting: 0 revisions left to test after this (roughly 0 steps)
> [d54b1a9e0eaca92cde678d19bd82b9594ed00450] perf script: Remove use of die/exit

is asking you to test the commit at d54b1a9e and tell it the result
of the test.  The message says "0 left to test *after* this";
doesn't it mean you still need to do *this*?

A bisecct session ends when it tells you

	XXXXXX is the first bad commit

which I do not see in the above.  You seem to have stopped before
that happens.
