From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 3/3] Teach mv to update the path entry in .gitmodules
 for moved submodules
Date: Thu, 11 Apr 2013 09:59:45 -0700
Message-ID: <7v61ztj94u.fsf@alter.siamese.dyndns.org>
References: <515C88FE.9020203@web.de> <515C89BA.9020806@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Phil Hord <phil.hord@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	"W. Trevor King" <wking@tremily.us>,
	Peter Collingbourne <peter@pcc.me.uk>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Apr 11 18:59:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQKqr-0004vB-WC
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 18:59:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964871Ab3DKQ7u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 12:59:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36528 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964885Ab3DKQ7t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 12:59:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4CFE615441;
	Thu, 11 Apr 2013 16:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1BS1Qhy2zsZ1ACNX4Y/IZ1LBkoc=; b=Khg9vr
	EJznIaOnnFyy8au/MHZaGs5RHYQ+micrU46Xi1P752I5BKaUr/ejk6awFeeVEvID
	Z7HSKxY2DN7b9nteO/fRukkeRd/09lLUjkgNObiVmA4Uze5vY69ItWIGDnpIQGmO
	JLimnk26gQDY8e43k3U+AYbz6u+bDKYekYzz0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cjefY5zdJgBlG8UaEzd1x9Jsdfs2rVfa
	0Z97eEJ5h01ziPsNtbv4ynPV9z2Dc6SWe/s3CUDqiEHQLYUR5+Juz1kisvmqbbH0
	xJw07jukgJey0z/rhMKzGsPfLlqHUFkw9A74wDLO3txnygDlUKzHYh9ZXSXu87xx
	M/909yWRQrY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4407615440;
	Thu, 11 Apr 2013 16:59:48 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A1A4D1543E; Thu, 11 Apr
 2013 16:59:47 +0000 (UTC)
In-Reply-To: <515C89BA.9020806@web.de> (Jens Lehmann's message of "Wed, 03
 Apr 2013 21:57:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 376F7F20-A2C9-11E2-B7E7-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220892>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Currently using "git mv" on a submodule moves the submodule's work tree in
> that of the superproject. But the submodule's path setting in .gitmodules
> is left untouched, which is now inconsistent with the work tree and makes
> git commands that rely on the proper path -> name mapping (like status and
> diff) behave strangely.
>
> Let "git mv" help here by not only moving the submodule's work tree but
> also updating the "submodule.<submodule name>.path" setting from the
> .gitmodules file and stage both. This doesn't happen when no .gitmodules
> file is found and only issues a warning when it doesn't have a section for
> this submodule.

Should it happen when the user has other changes to .gitmodules that
hasn't been updated to the index?

As this is done in the same final "per-path" loop as adjusting the
gitfile links, the worry I expressed in an earlier message about
"git mv a/ b/" when "a/x" is a submodule turns out to be unfounded,
which is good ;-)
