From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH] Preserve the protection mode for the Git config files
Date: Thu, 23 Jul 2009 07:08:15 +0900
Message-ID: <20090723070815.6117@nanako3.lavabit.com>
References: <20090721152435.16642.47207.stgit@pc1117.cambridge.arm.com>
	<7vab2wlh4y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Catalin Marinas <catalin.marinas@arm.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 23 00:08:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTjzQ-0006Nl-71
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 00:08:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753715AbZGVWIi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2009 18:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753594AbZGVWIh
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 18:08:37 -0400
Received: from karen.lavabit.com ([72.249.41.33]:35432 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753024AbZGVWIg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2009 18:08:36 -0400
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 171AB11B83A;
	Wed, 22 Jul 2009 17:08:37 -0500 (CDT)
Received: from 2862.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id DX7PCYB0KN0K; Wed, 22 Jul 2009 17:08:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=QeN63yByTxieupaNmhjWv15HcO95MaEHMxjDSakCt72jhVkBeqVaKmF5aTM8evEpLYzBDJ+lF9t7tFmpn+WU23yTyWhSr02qpXtl7B0HWKIhHE6nNPAoLD+L5uy5WTBIwILwqP6fbVxmjlTxFmAqh4O/83pM0EUVh/pXA9K5USQ=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <7vab2wlh4y.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123797>

Quoting Junio C Hamano <gitster@pobox.com>

> This change in behaviour is justifiable only because the only thing the
> user who said "core.sharedrepository = true" cares about is that refs are
> readable by the group members (otherwise s/he would have used a more
> explicit setting like "core.sharedrepository = 0660", and the
> adjust_shared_perm() code will do the right thing, with or without your
> patch).
>
> The patch description must defend itself a bit better, perhaps by saying
> something like this at the end.
>
> 	This patch touches the codepath that affects not just .git/config
> 	but other files like the index and the loose refs, so they also
> 	inherit the original protection bits.  In a private repository,
> 	this is not an issue exactly because the repository is private,
>
> 	In a shared repository, a later call made in this function to
> 	adjust_shared_perm() widens the permission bits as configured.
> 	Because adjust_shared_perm() is designed to do so from any mode
> 	limited by user's umask, even though this patch changes the
> 	behaviour in the strict sense, it should not affect the outcome in
> 	a negative way and what is explicitly marked as allowed in the
> 	configuration will still be allowed.

I have two questions.

1. Why would you keep sensitive information in the config file in the first place? Wouldn't it be better to introduce a level of indirection, making a variable in the config file to point to a private file only you can read and store secrets in the latter?

2. Why is your config file more secret than your history? Wouldn't it solve your problem without any patch if you set core.sharedrepository to 0600?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
