From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Thu, 04 Apr 2013 16:08:31 -0700
Message-ID: <7vli8xgahc.fsf@alter.siamese.dyndns.org>
References: <1365100243-13676-1-git-send-email-artagnon@gmail.com>
 <CA+55aFz1D_dMtMHHMpiGi3KL=Y-m4DVxHVr=1ZX8zYWQ2TPvwA@mail.gmail.com>
 <CALkWK0nNjvV5VGvT_eaubFoOhMnJ-N8FECAayd5A2K3BzeRh6Q@mail.gmail.com>
 <CA+55aFyQwJfiYo06y1bRNpKT6wOquhG9a9M_4YvLG_UT3b34-w@mail.gmail.com>
 <515DEE86.3020301@web.de> <7vd2uagd10.fsf@alter.siamese.dyndns.org>
 <CALkWK0kQ8qYXHKr4e93A1dh3Y1vL+HZvMR_1xtKkUr-_7bMS6Q@mail.gmail.com>
 <7vy5cyexuf.fsf@alter.siamese.dyndns.org>
 <CALkWK0kpf+AAzrLuqKQx5iv3nNKJ48R5etcBrcdoG46Z1ipgbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git List <git@vger.kernel.org>, Heiko Voigt <hvoigt@hvoigt.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 05 01:09:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNtHD-0004LW-NQ
	for gcvg-git-2@plane.gmane.org; Fri, 05 Apr 2013 01:09:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764656Ab3DDXIe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 19:08:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36630 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763778Ab3DDXId (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 19:08:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 69AC81372A;
	Thu,  4 Apr 2013 23:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uL45nyz5Op3/MXY3owdPy8TWNMo=; b=wglRav
	ZSjkhou2/qcrgSm9mZzJo3Lgh51oj8KML8HLUK6NWkzcO2v2E74nSFD1eT4n4ta9
	4HlSPfYNEgRdPpUvk3Ptu9TVGkJGw7Xg4uLZ9XNEIAnKOTq7IUiLCgtwoqNG/+uF
	zTVH5bINqdzOoxTsIBZOCgADKCiI7GvDc7B0M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iByC8P58z5g+qZ+wWi9Y3hpG6VWsdiIH
	PzsSywALcv9WOvSNK2qU/K9qJR9LfCrHor4C10Uqlg9Q6P6pJMcZKCLgiYnM/II3
	Hash8xNMS+GIUVV0jFpsrrTZ9HV1Cxn83DJhLR/1ZNhu5HQDAEnVfC/e/lEuc9iO
	sw6dbWYyMhc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 60B7013729;
	Thu,  4 Apr 2013 23:08:33 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C382413725; Thu,  4 Apr
 2013 23:08:32 +0000 (UTC)
In-Reply-To: <CALkWK0kpf+AAzrLuqKQx5iv3nNKJ48R5etcBrcdoG46Z1ipgbQ@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Fri, 5 Apr 2013 04:02:48 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 92272CC6-9D7C-11E2-A9D1-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220122>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> Sounds like you are saying that you can pile a new command on top of
>> new command to solve what the existing tools people are familar with
>> can already solve in a consistent way without adding anything new.
>> Are you going to dupliate various options to "git diff" and "git
>> log" in "git diff-link"?  Will you then next need "git log-link"?
>
> What I'm saying is: As always, we start with plumbing and work our way
> up to porcelain.  We do have git diff-files, diff-index, diff-tree, so
> I don't see what the problem with diff-link is.  The point is that we
> can get an initial scripted version out quickly.
>
> And no, I never suggested a git log-link.

"git log -p .gitmodules" would be a way to review what changed in
the information about submodules.  Don't you need "git log-link" for
exactly the same reason why you need "git diff-link" in the first
place?

So you may not have suggested it, but I suspect that was only
because you haven't had enough time to think things through.
