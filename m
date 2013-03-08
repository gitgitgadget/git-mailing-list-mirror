From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Adding "--ignore-submodules" switch to git-describe
Date: Fri, 08 Mar 2013 13:26:53 -0800
Message-ID: <7vy5dxfuqq.fsf@alter.siamese.dyndns.org>
References: <CAC9WiBjHEoX154Y2q1NxEB1my78Gqf__+v-KR5jNVqT-MN9ZaQ@mail.gmail.com>
 <7v621bggi5.fsf@alter.siamese.dyndns.org>
 <CAC9WiBhHmqn7QZMLFcLjqGPamHmbMFNxvQ6Yzv5dr=+fe+F3_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 08 22:27:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UE4p1-0002BL-LX
	for gcvg-git-2@plane.gmane.org; Fri, 08 Mar 2013 22:27:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932704Ab3CHV05 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Mar 2013 16:26:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62220 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932413Ab3CHV04 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Mar 2013 16:26:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 08C33B139;
	Fri,  8 Mar 2013 16:26:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RM6MPvwQtxmXEcQo/Ga5UJ3qFAg=; b=JeRRf+
	MgI13MpIMdo8DnIMuxck4Updnr2CfqrtQDasP3ByFzrnz640JTeg3WzvLWylAbBH
	1z6H+kejSflsr+b2Z0wPcPqOQPmnDqU5oR9nUe7hJv4QOyd6Vx0luUo+Ylvq9knf
	Zv5xf9nuiq5khVMPciaJhfMQ3ZilOh2ubnGZk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ydWgdyEO6b8TayU8szudUJ1+ygimgtIM
	88Q6EOuIs0YBv+sEgFZ8R4seGC74DIHFRs0PJBtZkygZopOYwCHvL9QQJq7xjphE
	/tlNRQRxMn0/+dAX79MXv4iBvatT9c8xJET8NX5Xo+bPNMDl12XKUF8wHvW8u8hg
	6haDX1QL0xo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F180AB138;
	Fri,  8 Mar 2013 16:26:55 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6091CB136; Fri,  8 Mar 2013
 16:26:55 -0500 (EST)
In-Reply-To: <CAC9WiBhHmqn7QZMLFcLjqGPamHmbMFNxvQ6Yzv5dr=+fe+F3_g@mail.gmail.com> (Francis
 Moreau's message of "Fri, 8 Mar 2013 21:04:30 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E6A9E924-8836-11E2-A16C-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217681>

Francis Moreau <francis.moro@gmail.com> writes:

>> But when we ignore untracked paths in the superproject, we should
>> ignore untracked paths in submodule working trees consistently.
>
> yes I agree.
>
> But in the short term, could you suggest a method to workaround this
> inconsistency ?

Hrm, ... didn't I already?

    As we do not take untracked content at the superproject level into
    account when deciding "--dirty"-ness, I think it is very sensible to
    either do one of the following:

     (1) always ignore untracked files in submodule working trees; or

     (2) if we were to introduce some form of --ignore-submodules,
         ignore untracked files in the superproject working tree when we
         use that mechanism to ignore untracked files in submodule
         working trees.

    Strictly speaking, (1) is a degenerate case of (2).

    ...
    I think what is missing from "--dirty" is not "--ignore-submodules",
    but "--do-not-ignore-untracked" option [*1*].  "describe --dirty"
    ignores untracked files in the superproject by default, and we
    should ignore untracked files in submodule working trees, but the
    current code does not.  Fixing that is (1) above.

I think the right first step without any new option is to make
"describe --dirty" to ignore the dirtiness in submodules coming
solely from having untracked files in submodules' working trees.

You could later add --having-untracked-is-dirty option to mark the
output dirty when there is an untracked file in submodules' working
trees or the toplevel working tree, which would be the second step.
