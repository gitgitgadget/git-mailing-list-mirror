From: Junio C Hamano <gitster@pobox.com>
Subject: Re: False positive from orphaned_commit_warning() ?
Date: Wed, 25 Jul 2012 14:52:54 -0700
Message-ID: <7va9ynbj9l.fsf@alter.siamese.dyndns.org>
References: <20120725185343.GA6937@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 23:53:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Su9Vu-0002XL-Se
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 23:53:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752792Ab2GYVw5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 17:52:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57725 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751062Ab2GYVw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 17:52:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C8287A1D;
	Wed, 25 Jul 2012 17:52:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Z2f95WUBWdouOb1+/5RAcS+gjwk=; b=BSs5im
	H1vCfhFqCZgCOiXlJZ/ygAwldQ3/POO6mSDl5/wzlf56lIKUs/NVSubZo1I/vSAy
	xOmpDr27K+DCEGBmxYafWmhz6iO56a8ySHemZpxOXEp2u4Cik5bUMeMEn27h3qYM
	hG/hpJfQgM0x4i5xUUR43Hm+gJX87gylla2r0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=du6+nfQeUd99MyQyUDnAXFMa4KyjyrET
	oKKdqbOVmqV7sk2ZxwWGlmzxV6KYAKlR5iH7inKqgE1ZPlYJyVgOQAf+gSspxRyr
	+/9WvWmCmXB/yZc4vyoBP2FWqeoYWTIg0ZJTbPqbafxuXEYC5qJN7j9GE56Irnf7
	0VEEu91D+gs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A4B27A1C;
	Wed, 25 Jul 2012 17:52:56 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ED9DE7A1B; Wed, 25 Jul 2012
 17:52:55 -0400 (EDT)
In-Reply-To: <20120725185343.GA6937@windriver.com> (Paul Gortmaker's message
 of "Wed, 25 Jul 2012 14:53:43 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 177B87EC-D6A3-11E1-84B4-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202203>

Paul Gortmaker <paul.gortmaker@windriver.com> writes:

> Has anyone else noticed false positives coming from the
> orphan check?

Thanks.  This should fix it.

 builtin/checkout.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 6acca75..d812219 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -606,7 +606,7 @@ static int add_pending_uninteresting_ref(const char *refname,
 					 const unsigned char *sha1,
 					 int flags, void *cb_data)
 {
-	add_pending_sha1(cb_data, refname, sha1, flags | UNINTERESTING);
+	add_pending_sha1(cb_data, refname, sha1, UNINTERESTING);
 	return 0;
 }
 
