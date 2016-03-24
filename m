From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFD] minor frustration in 'git add' pathname completion
Date: Thu, 24 Mar 2016 15:27:02 -0700
Message-ID: <xmqq7fgr7brd.fsf@gitster.mtv.corp.google.com>
References: <xmqqr3ez7dqw.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kaUPf=kBCuH__8BahjM3WjSGaijiQr05pMKe+TNdg3W9w@mail.gmail.com>
	<xmqqbn637cpe.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 23:27:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajDii-0001NV-Rh
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 23:27:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbcCXW1I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 18:27:08 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:57721 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750949AbcCXW1G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 18:27:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C2AA54DB37;
	Thu, 24 Mar 2016 18:27:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TXoYTbzADcwDktCn6ukmgi4pyhA=; b=sGA7ui
	HdKsxDAeq6N1o8XdgQYs1fO4isaxIekk1ALVSoAggVZsXRAlIFOtXhPEPwAnt5AG
	gBBy8Bx59VN1IPRgCmuUpsw5/C1ZjIuoJ7RbI8ABvFdqOayveRmdlmqq/YYSjeot
	q2SY59kgzgF4kzgdvq2UPna0nOXXKNIACq20o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wQEtwI0xj4FAcHZFbQA7M5ciwSLOf6Kn
	hnfvF/rPGLCHXsdaN1prfPiEC+Q36/oHB2UXycgJLcbdMb9co5mXDj4R2s97HXnh
	Od1rpIyfRQRRol6TXGT1ut3AP89Wf9Pdb8fxrdZV2GbeAhi0Q6A+gwxQIv+iRz4t
	M1C8ZS9/ULk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B9AD44DB36;
	Thu, 24 Mar 2016 18:27:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3C8D24DB35;
	Thu, 24 Mar 2016 18:27:04 -0400 (EDT)
In-Reply-To: <xmqqbn637cpe.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Thu, 24 Mar 2016 15:06:37 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 890FD094-F20F-11E5-A258-E95C6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289814>

Junio C Hamano <gitster@pobox.com> writes:

> Stefan Beller <sbeller@google.com> writes:
>
>> On Thu, Mar 24, 2016 at 2:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Discuss.
>>
>>> For example, I keep
>>> a backup version of whats-cooking.txt in the working tree that I use
>>> to manage the 'todo' branch as whats-cooking.txt+, and this is not
>>> explicitly "ignored".
>>
>> Completely side tracking thought: Have you considered ignoring
>> whats-cooking.txt+ locally?
>
> The point is that I shouldn't have to.  I wasn't asking for a
> workaround.

More importantly, I suspect that it would not work very well as a
workaround.

If I were to explicitly ignore that file, then even though I know
whats-cooking.txt is not ignored,

    $ git add whats-coo<HT>

would not offer anything.  I'd be left scratching my head, wondering
if I mistyped the early part of the filename (e.g. "wahts-coo<HT>"?).

I think the source of the irritation comes from the fact that the
command line completion can only say "I do not see anything worth
adding with the prefix you gave me" by not completing the prefix
string to anything, and it cannot explain why it thinks so
(e.g. "because the path that matches the prefix is up-to-date and
there is no point adding it again" vs "because there is no path that
matches the prefix, perhaps you made a typo?").  Loosening (3) might
be an effective way to address it.
