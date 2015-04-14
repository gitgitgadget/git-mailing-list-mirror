From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to combine git repos with similar code and keep all branches and tags?
Date: Tue, 14 Apr 2015 10:25:06 -0700
Message-ID: <xmqqfv8239n1.fsf@gitster.dls.corp.google.com>
References: <BBAA9EAE77388248BCAB045DA762C5A83EFE242F@EXBE01-ENSIM.ms.ensim.com>
	<vpqr3rm8wn6.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jose de Leon <jdeleon@ensim.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Apr 14 19:25:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yi4aL-00088L-7d
	for gcvg-git-2@plane.gmane.org; Tue, 14 Apr 2015 19:25:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbbDNRZM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2015 13:25:12 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52028 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932176AbbDNRZK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2015 13:25:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8E01747871;
	Tue, 14 Apr 2015 13:25:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+cNz36zm32Hah3t/55r/H8+siTo=; b=EABswA
	pLf9ZtOLOrTvxL5ad3cGM16bjOq12NV6Beik1/BT19rscKuNHlWOlbsWkIKtjsIQ
	jFwlGR/KdhZPiKLhsiMhOcWHv9O++U+TeS73nzw01rNtL8zYdRohgDe8tX1K7c/0
	kFHkVbgoEzNhRqGfk+we7yz8dk4unywYVFuiA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Jd+ZdAYt/oa4L6iBd5RrKF67X/8LQ/Il
	OUmRk7OWA7Q3J9DqhXN1/DkJv2P9qij9rwjqqFXOMdjkqUXogK2JaemPur3keLFA
	CIZnV1EdJip2WIwreYg17L/95ZTsygB/hLUyCsidIcfgElQ1hSXvtYKOXQmzzcqb
	0dR9RcS8bVw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7906C47870;
	Tue, 14 Apr 2015 13:25:09 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 72F314786B;
	Tue, 14 Apr 2015 13:25:07 -0400 (EDT)
In-Reply-To: <vpqr3rm8wn6.fsf@anie.imag.fr> (Matthieu Moy's message of "Tue,
	14 Apr 2015 19:09:17 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 321B447A-E2CB-11E4-AE78-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267151>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Jose de Leon <jdeleon@ensim.com> writes:
>
>> For some unknown reason to me, our developers started a git project,
>> called Ver1, this was the first version. Then sometime later, they
>> created a new git repository called Ver2, the initial commit for Ver2
>> was essentially a copy of the code in Ver1 from the master. They
>> didn't clone it, they just copied the code at the latest point.
>
> This is why "graft points" were created, and then superseeded by "git
> replace".
>
> See http://git-scm.com/blog/2010/03/17/replace.html and
> http://git-scm.com/docs/git-replace

After setting up either grafts or replaces, I'd strongly recommend
running filter-branch or bfg to rewrite the history of the combined
result, and have the developers use that rewritten history _after_
removing the grafts (or replaces).

And if you are going to go that route, then graft is sufficient and
a lot more light-weight.  The only advantage replace has over grafts
is that they can be transferred using "git push" and "git fetch"
(while grafts can be transferred with some file transfer mechanism
outside Git) but if you are rewriting the history, that advantage is
lost.
