From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/2] Safety for "stash save"
Date: Mon,  1 Jul 2013 14:59:09 -0700
Message-ID: <1372715951-3224-1-git-send-email-gitster@pobox.com>
References: <20130628150532.GD12252@machine.or.cz>
Cc: Petr Baudis <pasky@ucw.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 01 23:59:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Utm85-0002db-4i
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jul 2013 23:59:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755125Ab3GAV7P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jul 2013 17:59:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57865 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754808Ab3GAV7O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jul 2013 17:59:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B83F72DC2A;
	Mon,  1 Jul 2013 21:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=d7tI
	f4YB3ACXbQ23rlquoPKGDXw=; b=Y9UhH1ALeMpayxG/Cu0d7e1SEp38MVDorqig
	8HeV2/eoAH9kFjEzbl6XZtpyHzqDTMSEX7bjGozJvUGeWsTeVEsnmxWVdvmnNXtg
	5aqqZkB4ijCQgpVB0hlehN3bjIEhoKhfQgnRSmc6ZqTHH3B15px9TOdMRKNggJuy
	Z3k8qpo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	r2wUcMXWyYlADLSQmB2IWVJ1xEyyx62QU35sd3QuN+P83GIZU+o3aSCQJa9mlNDp
	BqTvIC5+LO/tstQCzwmyKYDbUHxCwiwGkz/mJm32A98iUNufVvd/1kpfDTUeoyj4
	UYCnhEpoThUlwe9ynAjuBSptx8dtSkxrdTZXsHXEWPA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD35F2DC29;
	Mon,  1 Jul 2013 21:59:13 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 314CF2DC26;
	Mon,  1 Jul 2013 21:59:13 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.2-795-g615e8f0
In-Reply-To: <20130628150532.GD12252@machine.or.cz>
X-Pobox-Relay-ID: 7730AF5C-E299-11E2-9F9C-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229330>

The second patch is the real thing, but "ls-files --killed" needed
to be taught about submodules to avoid breaking "stash save" in a
repository with submodules, as the new safety uses it to detect what
will need to be killed (i.e. file D/F in the working tree getting
removed because we need to check out D as a file, or file D in the
working tree getting removed because we need to check out D/F as a
file) when reverting to the state in HEAD.

Junio C Hamano (1):
  treat_directory(): do not declare submodules to be untracked

Petr Baudis (1):
  git stash: avoid data loss when "git stash save" kills a directory

 Documentation/git-stash.txt         | 12 ++++++++++--
 dir.c                               |  4 +---
 git-stash.sh                        | 12 ++++++++++++
 t/t3010-ls-files-killed-modified.sh | 23 ++++++++++++++++++++---
 t/t3903-stash.sh                    | 18 ++++++++++++++++++
 5 files changed, 61 insertions(+), 8 deletions(-)

-- 
1.8.3.2-798-g923e168
