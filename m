From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] revision: Show friendlier message.
Date: Sun, 24 Jun 2012 22:58:44 -0700
Message-ID: <7vzk7sgcff.fsf@alter.siamese.dyndns.org>
References: <1340478681-58476-1-git-send-email-muhtasib@gmail.com>
 <7vobo8hsee.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Leila Muhtasib <muhtasib@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 25 07:59:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sj2KD-0002HK-JI
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jun 2012 07:59:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754261Ab2FYF6t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jun 2012 01:58:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61658 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752408Ab2FYF6s (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2012 01:58:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 06D0F41A4;
	Mon, 25 Jun 2012 01:58:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zLksRYkEKRLKvnp+clcUQ0u78zA=; b=O+NYvG
	J5OKTTTXEq0oatzD5vubD8gaBVW3RM8wbIkvv6AiNI7+kpoUhrKDrTidBCy3grm1
	Y18LBq24WD9zNDpyKLtIeNt4A1yQmo2FL/EZjON6OKSDrh/ZQgvWFCInFX/xzTVd
	V7MXr075GvX3uYbXhHG7KbxLcw8mS2S73tBZQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KdbNOkK3B3+HLUxJQHeVG0KvqHzXVOH7
	gMM2jvnfLpWZuumP04r3sxn4N5ZqgZZ57qamYnmt/lsiS85zaPN5NmJ8O2fwtxfI
	7hQm3i5OOrCdkb0JgZYkABEUxdOrerinTRF0XIyKSZnmN9RV5StV+hossKgWhrov
	Xr70r+BAqpo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F2DE041A3;
	Mon, 25 Jun 2012 01:58:45 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7F3B741A2; Mon, 25 Jun 2012
 01:58:45 -0400 (EDT)
In-Reply-To: <7vobo8hsee.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 24 Jun 2012 22:28:25 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D3299758-BE8A-11E1-92EB-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200549>

Junio C Hamano <gitster@pobox.com> writes:

> Leila Muhtasib <muhtasib@gmail.com> writes:
>
>> % mkdir test
>> % cd test
>> % git init
>> Initialized empty Git repository in .git/
>> % git log
>> fatal: bad default revision 'HEAD'
>
> I agree that the message, while it is technically correct and does
> not deserve to be called a bug, can be made more friendly.
>
> But setup_revisions() is a very low level routine that is used by
> many plumbing commands, and it is a horrible layering violation to
> tweak its behaviour based on argv[0] and also it is too inflexible
> hack as a solution.  For example, don't you want to give a different
> error message for "git log HEAD" with an explicit "HEAD" from the
> command line?  Would you add a similar support for a command that is
> not "log" by adding yet another strcmp() here?
>
> Wouldn't it be a more reasonable alternative solution if you do this:
>
>  1. Check if HEAD points at a commit _before_ setting opt->def to it
>     in "git log" (and other end-user facing programs in the "log"
>     family, possibly in cmd_log_init_finish() if that function is
>     not called by a program where the current message should not
>     change), and do _NOT_ set opt->def to it;

The last part of the paragraph should read:

	... and do _NOT_ set opt->def to it if HEAD does not point
	at a commit.
