From: Junio C Hamano <gitster@pobox.com>
Subject: [RFC] deprecating and eventually removing "git relink"?
Date: Sun, 13 Nov 2011 16:38:26 -0800
Message-ID: <7v4ny7mtbx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 14 01:38:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPkZH-0005Q1-Nt
	for gcvg-git-2@lo.gmane.org; Mon, 14 Nov 2011 01:38:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752399Ab1KNAia (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Nov 2011 19:38:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55911 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751863Ab1KNAi3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Nov 2011 19:38:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DB7D16966;
	Sun, 13 Nov 2011 19:38:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=S
	8CgIq2lyLBZ18ctKYEy0BP0EyE=; b=cren0QsHSP5GakN7JlPM73jS6e1QshcSv
	hET83fglLf3+qFVNRzCbItnILpU+svMocq7AmRhS7GsbLzFK9hy+SAKlHaH59qvl
	JBzt601SAxWd1ipiCJFzZItei0Pd4CsioqF9sgEAwpAE/RrjoOecEhqadLt5tp1a
	S9fbJFmyAY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=w+A
	UCMefDGaY41jEmv/uPOWB0OQnw3y7/iLrAupnfSHDDqKcWaXbR0qa+z82xgXRyo9
	OgYbzRl6NCMYCCRsYN8OhlJRySlWkzH1JKZfg+vMxqkaro2ux5OqOqf+JGKtrEE3
	GDkSFuOUINlOZF+DmwTFGDfX/BCyPxunRC1tvUFc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D3EB96964;
	Sun, 13 Nov 2011 19:38:28 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 672906963; Sun, 13 Nov 2011
 19:38:28 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F859140A-0E58-11E1-9CBE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185357>

What do people think about the subject?  As to the timeframe I am thinking
about deprecation at v1.7.9 (late January 2012) and removal at v1.7.12
(early August 2012) [*1*].

The script more-or-less outlived its usefulness in July 2005 when
packfiles were introduced.

You are better off repacking the repositories in the first place before
accumulating so many loose object that linking the same ones between the
repositories would give you major saving.  It is theoretically possible
that two repositories happen to have the same pack and it would give you
saving to hardlink them together, but even in that case, the saving would
not survive repacking unless they are marked with a ".keep" marker, which
the script does not do anyway.

A more useful feature to attack a similar issue would be to make it easier
to use "--reference" aka "objects/info/alternates". Namely:

 (1) devise a way to make it safer by allowing the repository whose
     objects are borrowed by other repositories a way to protect objects
     that it does not need but may be needed by others from repacking; and

 (2) allowing two repositories that started independently to share objects
     using the alternates mechanism after the fact.

but that is a separate issue.


[Footnote]

*1* Both dates were derived from a mechanical "9-week per release cycle".
