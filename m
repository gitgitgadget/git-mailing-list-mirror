From: Junio C Hamano <gitster@pobox.com>
Subject: {bug} warning: unable to access 'RelNotes/.gitattributes'
Date: Wed, 12 Sep 2012 23:32:22 -0700
Message-ID: <7vpq5qa0w9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 13 08:32:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TC2yZ-0007ja-RS
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 08:32:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755836Ab2IMGc1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 02:32:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56513 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755682Ab2IMGc0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Sep 2012 02:32:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9202E6415;
	Thu, 13 Sep 2012 02:32:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=3
	zuUjjZlqpoInnxejr9tZ87/iVw=; b=osqeVj28rxpvuyF+j7rT1FpMfBKhGB95z
	rgz1j4vuCGPgHCOE9cOakGGDxYrqoVbPvZDCpE4W2nGiY4Wq3dGoYGtQzk1UJqY7
	WoYLefFnPYDpNIN35itgMnW/MqwhdT3LpG5hQVaUIPWTggbFU3DPnguciY04Q7i0
	adliq2q23k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=u7znZgh5lSfP++Je7P2TaczhDKatfFS6S3qMkat/avBVlRIIcar0iG4f
	Sh5l1yvrL9VnACkOwKX+EfLw3tX5GeOwGcl1MPcRXb/5bDnVrOCxUNAGH3sonN5h
	ADdMaMTRFYqeGJSbSLFSpjSx7MhdLsTGkMywXCyB4m8oZwjY30M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 803BE6414;
	Thu, 13 Sep 2012 02:32:25 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0AFE76410; Thu, 13 Sep 2012
 02:32:23 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C7577CDA-FD6C-11E1-A0CD-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205355>

"git repack" started giving the above warning, and I am guessing
that the recent 11e50b2 (attr: warn on inaccessible attribute files,
2012-08-21) exposed a bug where we ask stat(2) not lstat(2) by
mistake before deciding to append .gitattributes to see if that
directory has a per-directory attributes file.  We simply used to
notice and ignore any failure from open() and moved on, but we
started distinguishing between ENOENT and others (in this case, we
get ENOTDIR), and added a warning for non-ENOENT cases and I think
that is what I am seeing.

It is getting late so I won't dig it further for now, but just a
heads up.
