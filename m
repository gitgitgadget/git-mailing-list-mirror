From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Replace hard-coded path with one configurable at make
 time
Date: Sun, 04 Apr 2010 14:38:23 -0700
Message-ID: <7vk4sm7vao.fsf@alter.siamese.dyndns.org>
References: <186fa4afcc08ad6ba10906a231c437536fbdb8e9.1270412075.git.chris@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Chris Webb <chris@arachsys.com>
X-From: git-owner@vger.kernel.org Sun Apr 04 23:38:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyXWc-00063Y-QI
	for gcvg-git-2@lo.gmane.org; Sun, 04 Apr 2010 23:38:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752798Ab0DDVib (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Apr 2010 17:38:31 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42671 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752650Ab0DDVi3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Apr 2010 17:38:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1411EA856E;
	Sun,  4 Apr 2010 17:38:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WYc+vFrV60RN/VXjdvrmboJzSgs=; b=yC334U
	5nIQ7Iw2iYzRXFvAAPi/YxoVR6RRx2OLoYmeJ6NseXktreJh7UDbtdHrQPCz/qpX
	DwnggStl6tIkJFSrE30EVdeRVpefjfF1g84QTAr8HrJHDVe8cqT0uV6tAzFIVs+y
	wqPe3Z0bMQ1WsyWJ1qzg0PB30rQwuwXo0nQRw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uXyEh5VekEsva+thpZj2dFuYcz5TTAEj
	gB6I+ZMDGCgPdaPhsuxMzhM5Cn/AGpYhJ937QLfZSotuIHOeLLMy00JV3FXAlnYd
	X6MWKX5DDgZlpaA/oKnV/6lOO+v14wwaZB5rpGPrKsSBE94iGjQKnI4IZh4xfFJ3
	QMVdYERWuYo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E4157A8568;
	Sun,  4 Apr 2010 17:38:26 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5C42CA8567; Sun,  4 Apr
 2010 17:38:24 -0400 (EDT)
In-Reply-To: <186fa4afcc08ad6ba10906a231c437536fbdb8e9.1270412075.git.chris@arachsys.com>
 (Chris Webb's message of "Sun\, 4 Apr 2010 21\:48\:50 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 673DF4C2-4032-11DF-93A6-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143950>

Chris Webb <chris@arachsys.com> writes:

> In exec_cmd.c and git-instaweb.sh, git hard-codes a default path of
> /usr/local/bin:/usr/bin:/bin. Introduce a make variable allowing this to be
> overridden by passing defpath to make.

A question and an issue.

 * What's the point of making this configurable, other than "because we
   can"?

 * Use of "$(x_SQ)" is about protecting whitespaces and single quotes in
   the literal from make and shell, but does not have anything to do with
   protecting things like $foo in that literal from the location $x is
   eventually embedded in.  As long as paths on DEFPATH do not have double
   quote in it (which would be a sane assumption), the patch to exec_cmd.c
   would work fine, but I don't know if you need an extra quoting when
   DEFPATH is used in shell scripts.  E.g. DEFPATH=$GIT_EXEC_PATH:/usr/bin
   would have GIT_EXEC_PATH expanded in mongoose configuration file, but
   will not be expanded in exec_cmd.c, leading to an inconsistent
   behaviour.

   Does this matter?
  
