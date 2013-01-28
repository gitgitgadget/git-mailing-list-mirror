From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/2] for-each-repo: new command used for multi-repo
 operations
Date: Mon, 28 Jan 2013 10:51:22 -0800
Message-ID: <7vr4l5w385.fsf@alter.siamese.dyndns.org>
References: <1359290777-5483-1-git-send-email-hjemli@gmail.com>
 <1359290777-5483-2-git-send-email-hjemli@gmail.com>
 <7vk3qywiqf.fsf@alter.siamese.dyndns.org>
 <CAFXTnz6GTVgY4DK-FLELGF-Cb1=iNYyWcUsUiaUytGRx9Tr4Ow@mail.gmail.com>
 <20130128081006.GA2434@elie.Belkin> <7vham1xktx.fsf@alter.siamese.dyndns.org>
 <CAFXTnz6xBMo42jWdqahYX-bnTBucVmQpFPN29X8tGRd7L=g2wQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 19:51:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tzto3-00032K-U9
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 19:51:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390Ab3A1Sv0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 13:51:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51517 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751068Ab3A1SvY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 13:51:24 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F32FB8C2;
	Mon, 28 Jan 2013 13:51:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5R/mZ63oMo/xNLUqwjhw8Af4oIk=; b=nNq8mT
	uVw797ouvKUOxZr76nkx+YWJwJicY61+v9ze8dmkwvIswSlcy3h8tk+/fLf8zBo0
	9ZbnZVlN92H6hIii85uVFot3X+4aP2yYhVgmxa5Zb1K+hd5GdLXWdu107015ERrv
	N1/DVI5wSHsAUgGojVislTUEer2Utu0zrvOds=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d2LDPOe2a482Xk9IGsJvA8MWImA/a31q
	QJMp3W5ZQEBTv/oYkmv3CAL6nLeP3OY3Uayca6492DcERMyIOJSJf/XHAjTibZSA
	hG40SzGEBqN4ETFUqBnfK21gL5kkV9D54XvMx1wPm8ejGc+Rc3rjVUQUkl5qQqeL
	PMGgB54tC3k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 53872B8C1;
	Mon, 28 Jan 2013 13:51:24 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C5B03B8BE; Mon, 28 Jan 2013
 13:51:23 -0500 (EST)
In-Reply-To: <CAFXTnz6xBMo42jWdqahYX-bnTBucVmQpFPN29X8tGRd7L=g2wQ@mail.gmail.com> (Lars
 Hjemli's message of "Mon, 28 Jan 2013 19:35:21 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B67EA3D6-697B-11E2-AC2F-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214856>

Lars Hjemli <hjemli@gmail.com> writes:

>> Come to think of it, is there a reason why "for-each-repo" should
>> not be an extention to "submodule foreach"?  We can view this as
>> visiting repositories that _could_ be registered as a submodule, in
>> addition to iterating over the registered submodules, no?
>
> Yes, but I see some possible problems with that approach:
> -'git for-each-repo' does not need to be started from within a git worktree

True, but "git submodule foreach --untracked" can be told that it is
OK not (yet) to be in any superproject, no?

> -'git for-each-repo' and 'git submodule foreach' have different
> semantics for --dirty and --clean

That could be a problem.  Is there a good reason why they should use
different definitions of dirtyness?

> -'git for-each-repo' is in C because my 'git-all' shell script was
> horribly slow on large directory trees (especially on windows)

Your for-each-repo could be a good basis to build a new builtin
"submodule--foreach" that is a pure helper hidden from the end users
that does both; cmd_foreach() in git-submodule.sh can simply delegate
to it.

> All of these problems are probably solvable, but it would require
> quite some reworking of git-submodule.sh

Of course some work is needed, but we do not have to convert all the
cmd_foo in git-submodule.sh in one step.  For the purpose of
unifying for-each-repo and submodule foreach to deliver the
functionality sooner to the end users, we can go the route to add
only the submodule--foreach builtin, out of which we will get
reusable implementation of module_list and other helper functions we
can leverage later to do other cmd_foo functions.
