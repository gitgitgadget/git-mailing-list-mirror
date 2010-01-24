From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Handle double slashes in make_relative_path()
Date: Sun, 24 Jan 2010 10:31:01 -0800
Organization: 
Message-ID: <7v8wbn8ie2.fsf@alter.siamese.dyndns.org>
References: <379d55c6a4110736aadb8ace3b050de879a9deab.1264118830.git.trast@student.ethz.ch> <7viqasbmtc.fsf@alter.siamese.dyndns.org> <201001232141.49556.j6t@kdbg.org> <201001241744.57139.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Jan 24 19:32:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZ7FC-0000t4-N9
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jan 2010 19:31:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751817Ab0AXSbS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2010 13:31:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751727Ab0AXSbS
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jan 2010 13:31:18 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60014 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751683Ab0AXSbR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2010 13:31:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EFE0193F02;
	Sun, 24 Jan 2010 13:31:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sHZv0C/22ijcp3i/xCttSJtzpYo=; b=XN+aSE
	a2EhWURU2spdvPAwfkKAkyYHYKN1m4b9c89LKcpUPs4grziyo1k4q96/DiiLZzSy
	OGRbwXPHTXw2X5JGZhWY4aIvx4rF0qttqA68hsTMzgSfExolAAq1pkLixEwB2O1w
	mQT3EoV0T24UA0of2nwY5stc/aYti3tx0d5hQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gGJNZ6lVlljh9Gr/l2meEJqGUefUtKj6
	R6tPxydw9LGbKAGbdMulZ3qRRyotzdWB204rvPZ/1XXdNiqup37qEd0S12dJk56q
	xmcJ92HXqmqfjtPRzPwvr6PYHwpXCD3oMIS/1V3ghM6IcD3mJXhF42vEF47fz6PK
	o1A1+bvPIiM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D89493F01;
	Sun, 24 Jan 2010 13:31:09 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A3EC593EFF; Sun, 24 Jan
 2010 13:31:03 -0500 (EST)
In-Reply-To: <201001241744.57139.j6t@kdbg.org> (Johannes Sixt's message of
 "Sun\, 24 Jan 2010 17\:44\:56 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A4611D0A-0916-11DF-B1C1-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137907>

Johannes Sixt <j6t@kdbg.org> writes:

> On Samstag, 23. Januar 2010, Johannes Sixt wrote:
>> On Samstag, 23. Januar 2010, Junio C Hamano wrote:
>> > What happens if you did this?
>> >
>> > 	git --git-dir=//git/repo/repo.git --work-tree=/git/repo
>> >
>> > where "//git/repo" is on the "git server" and you are working in local
>> > hierarchy "/git/repo"?
>>
>> Ah, right, this would not do the right thing. (But I can't verify this
>> claim right now.)
>
> I tested it, and it does the right thing. The reason is that before 
> setup_work_tree() calls make_relative_path(), the --work-tree argument has 
> been processed by make_absolute_path(), which adds the drive prefix.
>
> As long as setup_work_tree() remains the only caller of make_relative_path(), 
> we are safe.

Thanks; I think a more correct description of your findings is:

 - msysgit's make_absolute_path() does the right thing (i.e. adds "drive
   prefix" to "git/repo" given to --work-tree); and

 - as long as the callers feed what the platform considers absolute paths
   in abs and base, make_relative_path() does the right thing.

So I think we are Ok.  We _might_ want to add Windows-only test at the
beginning of make_relative_path() to make sure that the both inputs have
double-slashes at the beginning to catch future broken callers, but I
think that is a separate topic, and we don't have to do that as long as
setup_work_tree(0 remains the only caller, as you said.
