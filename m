From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] unpack-trees: add the dry_run flag to
 unpack_trees_options
Date: Wed, 25 May 2011 14:36:01 -0700
Message-ID: <7vr57m1n0e.fsf@alter.siamese.dyndns.org>
References: <4DDC1DF9.9030109@web.de>
 <7v39k37kmo.fsf@alter.siamese.dyndns.org> <4DDD615E.7020809@web.de>
 <4DDD6197.7060209@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed May 25 23:36:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPLkX-00062D-2I
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 23:36:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754202Ab1EYVgK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 17:36:10 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60377 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753075Ab1EYVgJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 17:36:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F04C35A04;
	Wed, 25 May 2011 17:38:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zh0Son9qsw0WqQG9z1hUr0OZZqc=; b=YFVfxb
	mTnPr0xSb4TgKLA89E3zgUriEg+pHUWODU1OVPQaRl0poIvelAm0XE9qqZ8g0jfV
	raIdZGvsIvt1g3FDRzx9oczEDUCjYStB0bkdUiJTTsVGoTVq+eeRBTU7tDQSZXOa
	JDrNT4WH07/7BjFxUz9tIjO1vA4+E5mDOjsbY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a2RimvkWj8eCzIQxE4MSAsYAN9OUWWj6
	hhXaDYznhYHXS6RcxveR+07GcbfWC/+2eIlW0s5qdMvmeG2Jy43bJWeB4RvBgnq1
	QKIzh1CZZjPLpKZBInlX1pMt3tfPycujd7TO6Qm1xb1j60I6MJmQJaFyhbJ09ToJ
	fNh9OkU9mZM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BBBA75A03;
	Wed, 25 May 2011 17:38:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C74055A02; Wed, 25 May 2011
 17:38:10 -0400 (EDT)
In-Reply-To: <4DDD6197.7060209@web.de> (Jens Lehmann's message of "Wed, 25
 May 2011 22:07:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4B3431CE-8717-11E0-A2D7-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174467>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Until now there was no way to test if unpack_trees() with update=1 would
> succeed without really updating the work tree. The reason for that is that
> setting update to 0 does skip the tests for new files and deactivates the
> sparse handling, thereby making that unsuitable as a dry run.
>
> Add the new dry_run flag to struct unpack_trees_options unpack_trees().
> Setting that together with the update flag will check if the work tree
> update would be successful without doing it for real.
>
> The only class of problems that is not detected at the moment are file
> system conditions like ENOSPC or missing permissions. Also the index
> entries of updated files are not as they would be after a real checkout
> because lstat() isn't run as the files aren't updated for real.
>
> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
> ---

Looks good.  remove_marked_cache_entries() does not touch the working
tree, and because you are not calling unlink_entry(), you won't trigger
schedule_dir_for_removal() hence remove_scheduled_dirs() won't cause us
any trouble either.

Will queue.  Thanks.
