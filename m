From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Move test-* to t/helper/ subdirectory
Date: Wed, 27 Apr 2016 09:15:41 -0700
Message-ID: <xmqqy47z9geq.fsf@gitster.mtv.corp.google.com>
References: <1460553762-12419-1-git-send-email-pclouds@gmail.com>
	<xmqqwpnkc9ca.fsf@gitster.mtv.corp.google.com>
	<CACsJy8A8vbp4-LrxoNX510Nme97EKfu0hBBs-LDRap1Z5=v3rA@mail.gmail.com>
	<20160427101833.GA5536@lanh>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 18:15:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avS7x-0005Mf-DI
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 18:15:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753135AbcD0QPp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 12:15:45 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59237 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753126AbcD0QPo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 12:15:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 78C1B15823;
	Wed, 27 Apr 2016 12:15:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tcqj+GjBEOMaRXGMQfyJ6lWiHuo=; b=XlDEwz
	d5g1NaCj4dD9yQQ7v5I4lSouA52j69xgKkFPg4+9ypBOvGkvcnofvMKI/aIMRenj
	p49rBuwKb9ynGIdIc60SC7qoCcirgV1+NUx5w/67HFK7lrCTogZX/KRvuDgKDk6T
	7j/0PJOZQPS6N8u30XfFVU1ZHN2Kb0DbjplEs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gmKKAOoDct5Z09WG0xx3/+OE5ivFAd+w
	/90HKrnJkzPicLRKgoQtwxNCytvFREUnZ5lpDksfEMFpiCkJ9bAGoTbgAYgxzVPO
	gQ9NQHkyhQlkD1R5MeoGTIztzL8mfxe+PqyMRohtbWPop6qBlbl3DdYa+UQOi34c
	HztJBVCO2QA=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 70DBF15822;
	Wed, 27 Apr 2016 12:15:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AC24615821;
	Wed, 27 Apr 2016 12:15:42 -0400 (EDT)
In-Reply-To: <20160427101833.GA5536@lanh> (Duy Nguyen's message of "Wed, 27
	Apr 2016 17:18:34 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4A45875C-0C93-11E6-B18E-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292740>

Duy Nguyen <pclouds@gmail.com> writes:

> This patch forces bin-wrappers regeneration every time a test program
> is updated. A bit wasteful, but I don't see a better option (which is
> also why I limit this to test programs only).

In other words, when we update the location where the programs that
would be eventually installed are created, we'd see the same
problem.

I actually wonder if it is a better overall structure to move
t/helper/test-foo back to test-foo, while keeping the source file
that contains main() for test-foo at t/helper/test-foo.c.  Then we
do not have to have many copies that are slightly different in
bin-wrappers, but they can all be

	exec "${GIT_EXEC_PATH}/$0" "$@"

instead of "bin-wrappers/git-bar" being

	exec "${GIT_EXEC_PATH}/git-bar" "$@"

and "bin-wrappers/test-foo" being

	exec "${GIT_EXEC_PATH}/t/helper/test-foo" "$@"
