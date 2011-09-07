From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v17 1/7] bisect: move argument parsing before state
 modification.
Date: Wed, 07 Sep 2011 04:29:52 -0700
Message-ID: <7vobyw4mkv.fsf@alter.siamese.dyndns.org>
References: <1312459263-16911-1-git-send-email-jon.seymour@gmail.com>
 <1312459263-16911-2-git-send-email-jon.seymour@gmail.com>
 <201109070816.16655.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Seymour <jon.seymour@gmail.com>, git@vger.kernel.org,
	j6t@kdbg.org, jnareb@gmail.com, jrnieder@gmail.com
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Sep 07 18:06:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1KeI-0001oa-Fd
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 18:06:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753215Ab1IGQGm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Sep 2011 12:06:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40322 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752944Ab1IGQGj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2011 12:06:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2FE0A5A9C;
	Wed,  7 Sep 2011 07:29:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MugR8NZ2UA8qgJSPDWQJiDeDrbE=; b=nhW0cK
	quBoika3THSvlvm0vO3sMtSTOK8WFtaEpS1QU7dAeiIbtHSQukklmsipj0hnCn6U
	U6wSUcl0VB6xnu6mBrI23QiwWPpRDVJL4u08AhlqrmXImUZNXyoYP66BL87f6vCj
	8/RFVBXNDK5mb8E+As/K3ghPOr/v+GP+jdZig=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TDS/bZMqbpl5/9cXcQZ9iDKjzbt6uyLB
	uonrumBn8DFmbF796M6bInAAyI7Tm+AW5HgGcqf1RnypjNOeiTYOQPAH7JL4DhGm
	+NG9ln6sZatC8deYg5U41YmMFFKlxr+Ar5x5WG3RhfGiPRD5Iz7BXvMWodaSFAsV
	E5QKWCi48sg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26CDF5A9B;
	Wed,  7 Sep 2011 07:29:54 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B20DA5A9A; Wed,  7 Sep 2011
 07:29:53 -0400 (EDT)
In-Reply-To: <201109070816.16655.chriscool@tuxfamily.org> (Christian Couder's
 message of "Wed, 7 Sep 2011 08:16:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B4EAE804-D944-11E0-9ED4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180857>

Christian Couder <chriscool@tuxfamily.org> writes:

> If we start bisecting like this:
>
> $ git bisect start HEAD HEAD~20
>
> and then we decide that it was not optimum and we want to start again like 
> this:
>
> $ git bisect start HEAD HEAD~6
>
> then issuing the latter command might not work as it did before this patch.

I didn't even know the above was supposed to work. It may have worked, but
I think it was not by design but merely by accident. Besides, wouldn't it
be the same to say "git bisect good" to further limit the suspect range,
instead of giving the second, seemingly nested, "bisect start" that is not
really nesting, which only confuses the users?

Having said that, if you can resurrect the old behaviour without too much
code churn, I wouldn't mind to look at the patch, but I am not sure if it
is worth it.
