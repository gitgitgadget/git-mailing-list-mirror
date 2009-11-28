From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] Makefile: fix http-push.o dependencies
Date: Sat, 28 Nov 2009 10:05:06 -0800
Message-ID: <7vk4xah6el.fsf@alter.siamese.dyndns.org>
References: <20091128112546.GA10059@progeny.tock>
 <20091128113115.GB10059@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 28 19:05:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NERfl-0002ey-H9
	for gcvg-git-2@lo.gmane.org; Sat, 28 Nov 2009 19:05:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752120AbZK1SFL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Nov 2009 13:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751737AbZK1SFL
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Nov 2009 13:05:11 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56781 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751852AbZK1SFK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Nov 2009 13:05:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2F883A21D7;
	Sat, 28 Nov 2009 13:05:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=u/0VsCQYu73uZ8oclJL17dJzYvs=; b=DGQDUzk8JJ7SxejcOaoxqi1
	5HXTqTMy8ne5lKyrT0wVM+jCfwSGrZLq/ERnDwWX31D3POAeWsP/9lOtG4F0V/Xb
	TKUTD+QshUQ3O0RjEzNEIeRSiJPRQV88enoUPMFQa7SQGECkU3cm4HRf/E5JMtex
	yVG/sxnpJNU1M/0Ft8n4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=r2G6Us9mBBGjb0BNbl/RcUqY6SXnI7O2wFw190VH5h4xkdoTc
	c6FmSwal80KHci9Z9vlfUGHY1ZKLZVk+knrL4M/+S1iPvmsNpg+mVn27q/xnN8Kx
	EWQOHPg1UC30eaYYnmgaYEL8IRDU7rK3NpAYOoMAG1wDWl1/aEb6KVU7rc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0F418A21D6;
	Sat, 28 Nov 2009 13:05:12 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1E2F9A21D5; Sat, 28 Nov 2009
 13:05:08 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 926EEFAA-DC48-11DE-AB5D-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133962>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Since it is not in LIB_OBJS, http-push.o needs an explicit
> $(GIT_H) dependency.

I think you meant $(LIB_H).

    $ make
    $ touch cache.h
    $ make http-push.o

does rebuild it with the current Makefile without this patch, because
it has this seemingly unrelated line (worse yet, this gives even more than
what are listed in LIB_H).

    $(patsubst git-%$X,%.o,$(PROGRAMS)) git.o: $(LIB_H) $(wildcard */*.h)

Puzzlingly messy.
