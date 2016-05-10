From: Junio C Hamano <gitster@pobox.com>
Subject: [Bug?] log -p -W showing the whole file for a patch that adds to the end?
Date: Tue, 10 May 2016 14:51:03 -0700
Message-ID: <xmqqh9e5mvjs.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 23:51:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0FYe-0001Ju-Jk
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 23:51:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751574AbcEJVvH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 17:51:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59919 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751293AbcEJVvG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 17:51:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B75E41A640;
	Tue, 10 May 2016 17:51:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=G
	zPcLLMu/CDb0Na49Yl8ARHYvFs=; b=u//rMwHcFwEBJwjPaWc+b+ZUwLDxAq1zN
	78Hmnhz25IxF4YVOhI/vQdFPVfC3e7xcujaeX0g8gN39n5poveBAssaJB8TfgqNq
	An5QDsjlNqOB23UnGtciRtjjNed7QPje6w5BkKsuk+/d0IQZmi+H+0KoNH5HIcdi
	bRhuxdyVrk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=v8fv0wguWJxJhpgh0lKTynoPoTUuL7YFnhHfw2CslLX8QOLGPZB9wnNa
	YPamc+GDV+66Rbt9GZ4ff47PnpJFHz0nQNs1DOjhB3lNSkppku9FgEP6VIaranP1
	jrpPAXtCMi+XB36i1UIXQW1LA0CMjgGUm5Wvo38wEUfnK+1quvg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AF80D1A63F;
	Tue, 10 May 2016 17:51:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 345D81A63E;
	Tue, 10 May 2016 17:51:05 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4B976C4A-16F9-11E6-8385-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294199>

Just noticed a curiosity:

    $ git show -W 3e3ceaa58 quote.c

shows the entire file.  The commit in question adds a whole new
function at the end of the file.  If I move that addition to just
before the last function the file already had before the change and
amend the commit, "show -W" would work as expected, i.e. addition of
the function, with three lines before and three lines after context.

The -W feature was added by 14937c2c (diff: add option to show whole
functions as context, 2011-10-09).
