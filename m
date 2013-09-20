From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Local tag killer
Date: Fri, 20 Sep 2013 15:51:27 -0700
Message-ID: <xmqqd2o3p0nk.fsf@gitster.dls.corp.google.com>
References: <52327E62.2040301@alum.mit.edu>
	<CAPc5daXvCf90WYoUWC+DxRyZEQhXGL7Bd_ZJKwfoqxeKt8TADQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 21 00:51:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VN9Y7-0002wj-OI
	for gcvg-git-2@plane.gmane.org; Sat, 21 Sep 2013 00:51:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753297Ab3ITWvb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Sep 2013 18:51:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56321 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752079Ab3ITWva (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Sep 2013 18:51:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C5D5443550;
	Fri, 20 Sep 2013 22:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lrbQ/xfYCObOeC/AnUcq7Sa3B1M=; b=MkwZKD
	pt9ADGMjnsWF6LDrbRN9Dw8tuAt6FOKBVa/BLJbMvudMcyUgR6MWuNxEtn8sElWG
	t+Acq477FbBBdq6eggyLLB9LFpg8+wFgg1euHNmsdd5l+AjdgWICCHSXnD9cUNQE
	rC/Q+4QHPc0ltlVpeptjCSO/gVAbBXf98c018=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZWOBK42NsSXQfVLg120a0C7NTM8XoG6+
	26DZWs8zY2M08d4RYN/Yf4jXtS7bPciBykOR5rFoA91xRrwjEQwp09CLkYNeBthy
	QU8BFMxYpM18VHr22HGqQlbbgfdi/2C6SHuVVygwnKAX8KZjuJEhoPI3BOETWMB+
	F1jdSlobdw8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B8E694354F;
	Fri, 20 Sep 2013 22:51:29 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 30FDB4354D;
	Fri, 20 Sep 2013 22:51:29 +0000 (UTC)
In-Reply-To: <CAPc5daXvCf90WYoUWC+DxRyZEQhXGL7Bd_ZJKwfoqxeKt8TADQ@mail.gmail.com>
	(Junio C. Hamano's message of "Thu, 12 Sep 2013 21:03:53 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2FDA4828-2247-11E3-8CA7-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235086>

Junio C Hamano <gitster-vger@pobox.com> writes:

> I also agree that the documentation is misstated; "remote-tracking branch"
> may have been a convenient and well understood phrase for whoever wrote
> that part, but the --prune is designed to cull extra refs in the
> hierarchies into
> which refs would be fetched if counterparts existed on the other side, so
> culling tags that do not exist on the remote side should also be described.

(gleaning-leftovers mode)


 Documentation/fetch-options.txt | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index ba1fe49..a6c581b 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -41,8 +41,20 @@ ifndef::git-pull[]
 
 -p::
 --prune::
-	After fetching, remove any remote-tracking branches which
-	no longer exist	on the remote.
+
+	After fetching, remove any local ref that was not updated
+	only because the remote ref that was supposed to update it
+	was missing.
++
+For example, `git fetch origin refs/heads/*:refs/remotes/origin/*`
+tries to update local `refs/remotes/origin/frotz` if `origin` has
+`refs/heads/frotz`.  With this option, `refs/remotes/origin/frotz`
+will be removed from our repository if `origin` does not have
+`refs/heads/frotz`.
++
+This is used to remove remote-tracking branches which no longer
+exist on the remote.
+
 endif::git-pull[]
 
 ifdef::git-pull[]
