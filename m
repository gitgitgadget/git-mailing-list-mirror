From: Junio C Hamano <gitster@pobox.com>
Subject: Re: bug with partial commit and pre-commit hook updating the index
Date: Fri, 10 Oct 2014 14:18:29 -0700
Message-ID: <xmqqy4sn4o9m.fsf@gitster.dls.corp.google.com>
References: <20141010171834.GB21355@kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Fri Oct 10 23:18:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xcha8-0005LN-FD
	for gcvg-git-2@plane.gmane.org; Fri, 10 Oct 2014 23:18:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754746AbaJJVSc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2014 17:18:32 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51717 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751797AbaJJVSc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2014 17:18:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7A65514079;
	Fri, 10 Oct 2014 17:18:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qKpf/Ur2JW+BsH0Gnkmcl8siSGk=; b=CjKqxN
	mdY78hOaFZOg+RewAfyNcwNRZ1rPAUl6wjb72IDzKTlb4eluoLIv5ecngD6mab41
	rNnddKCTsVfxIDGpyffl5iLoQdy7zw985G/onKleNeDAKRM/4XAKEhiEmJGWhGlV
	GojMfTovG6PMCoanqivf5+WHkjqu/NJiJwfe0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=etKzqTZOE/MKN8UlWrN2IGpgpY5hrXXo
	OklMhrUUN8ojKe157UOZ941KPTQu75v7V9Z6rMU4hiaXTBb2o6UHwfZr9gceKPdj
	V5QU3B6aO59JyMmeCAHu9q+QiCnOH6Ca+7Ik2qN2VHAQDFvYzj7YU+SlILnvfCUm
	K+rLDxTkZVc=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 716FC14078;
	Fri, 10 Oct 2014 17:18:31 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EBA4414076;
	Fri, 10 Oct 2014 17:18:30 -0400 (EDT)
In-Reply-To: <20141010171834.GB21355@kitenet.net> (Joey Hess's message of
	"Fri, 10 Oct 2014 13:18:34 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FC00AEEC-50C2-11E4-9E32-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joey Hess <joey@kitenet.net> writes:

> I have found many uses for the feature that lets a pre-commit hook stage
> changes in the index that will be included in the commit. But now I seem
> to have found a bug in the support for that, involving partial commits.
>
> It seems that, after a partial commit in which the pre-commit hook
> stages a modification of a file, the index is is left without that
> staged change. This only occurs with "git commit $file", not "git commit -a".

Aren't pre-* hooks about verifications?  Who told you that you are
allowed to muck with the index there?
