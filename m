From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/2] finding the fork point from reflog entries
Date: Thu, 24 Oct 2013 12:11:22 -0700
Message-ID: <1382641884-14756-1-git-send-email-gitster@pobox.com>
References: <xmqqhac6o5hj.fsf@gitster.dls.corp.google.com>
Cc: Martin von Zweigbergk <martinvonz@gmail.com>,
	John Keeping <john@keeping.me.uk>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 24 21:11:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZQJg-0003Cj-0p
	for gcvg-git-2@plane.gmane.org; Thu, 24 Oct 2013 21:11:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756069Ab3JXTL2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Oct 2013 15:11:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60021 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756021Ab3JXTL1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Oct 2013 15:11:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D1704D049;
	Thu, 24 Oct 2013 19:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=IT9f
	mrKPBMeoO45Z71pg0jN0OZ8=; b=ChDe0nO5Y34zv3VCHFYyhuMS+MUeKBwtkK2r
	Qk5jO1z/yVHlG/JRUWG+q2lXurbt8/q2jDdL1T8m/n89Qi6ruuSe9d6t5a60Wzwa
	3lRfkqqXxKQRn+MgA6r0gG269m2Qs6km5/1pzAmS251pj9OrIEzLlEcGjRtk5Tyz
	bwJS2PA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	nJMK1ok5xAqOfZJbEUmGrY2BxcPVafMGl6o5VMjmSzEWq3IEVbkeO25bWItZ+oFP
	B/FTwaE4TctB4B8/TbZwbQji+tIYKfim+Dlf4/sSGbSVTwrnM/RK5+QSwK61CNHx
	uF7lwgtjTWeTx04U6EBClGTn5HSnIKHUfW5sf6jrW40=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2ACFE4D048;
	Thu, 24 Oct 2013 19:11:27 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 82D424D044;
	Thu, 24 Oct 2013 19:11:26 +0000 (UTC)
X-Mailer: git-send-email 1.8.4.1-799-g1c32b8d
In-Reply-To: <xmqqhac6o5hj.fsf@gitster.dls.corp.google.com>
X-Pobox-Relay-ID: 147F34CC-3CE0-11E3-AD3B-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236609>

The first one is a clean-up of the code to parse command line
options to "git merge-base".  Options such as "--independent",
"--is-ancestor" and "--octopus" are mutually exclusive and it is
better expressed in terms of the recently introduced OPT_CMDMODE.

The second one implements the entire logic of the for loop we see in
"git pull --rebase" directly using get_merge_bases_many() and
postprocessing the result.

Junio C Hamano (2):
  merge-base: use OPT_CMDMODE and clarify the command line parsing
  merge-base: "--reflog" mode finds fork point from reflog entries

 builtin/merge-base.c  | 115 +++++++++++++++++++++++++++++++++++++++++++-------
 t/t6010-merge-base.sh |  27 ++++++++++++
 2 files changed, 126 insertions(+), 16 deletions(-)

-- 
1.8.4.1-799-g1c32b8d
