From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] name-hash: don't reuse cache_entry in dir_entry
Date: Wed, 21 Oct 2015 12:49:04 -0700
Message-ID: <xmqqpp08uhn3.fsf@gitster.mtv.corp.google.com>
References: <1445450051-7430-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Oct 21 21:49:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZozNp-0002Xk-QC
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 21:49:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756106AbbJUTtJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2015 15:49:09 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61549 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753500AbbJUTtH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2015 15:49:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 38E782388F;
	Wed, 21 Oct 2015 15:49:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bqT7n51DRXZSOLAeX5wWX/0nshA=; b=byEbj4
	1X8PRsUaeccASlpkYSR+gvuV7fbbW2fnDHJrHG8K2fTy/DLlIq9JY4tTUgYg5O7Z
	welia9yQwZC6+Yt7kVpZ5hS1X/uB0HpDc0ZbjAlG6IJi2J3nD3QOo+ry8xWkWA8e
	ENcDg7dW0E8frTXswO9OSXCSuTJT4ndP/xTOE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qxcugwseJWkWhv1zuN9N0znRAy/g3fiI
	gov3pPH3qqBIPbQnAp0nh6VG7C6w1QVs0PzKAA7/9a9wsR0GGGex/sSPJAMcgEl3
	tIn2dIx3Hdu983L7jHM0vdVDNRIHU69eMib38hsvK6wk+073fxoDwgrN2XRx3PT9
	p75dMjp7BvI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 19E5C2388E;
	Wed, 21 Oct 2015 15:49:07 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8F1FB2388D;
	Wed, 21 Oct 2015 15:49:06 -0400 (EDT)
In-Reply-To: <1445450051-7430-1-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Wed, 21 Oct 2015 13:54:11 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C9E7F734-782C-11E5-A18E-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280006>

David Turner <dturner@twopensource.com> writes:

> Stop reusing cache_entry in dir_entry; doing so causes a
> use-after-free bug.
>
> During merges, we free entries that we no longer need in the
> destination index.  But those entries might have also been stored in
> the dir_entry cache, and when a later call to add_to_index found them,
> they would be used after being freed.
>
> To prevent this, change dir_entry to store a copy of the name instead
> of a pointer to a cache_entry.  This entails some refactoring of code
> that expects the cache_entry.
>
> Keith McGuigan <kmcguigan@twitter.com> diagnosed this bug and wrote
> the initial patch, but this version does not use any of Keith's code.
>
> Helped-by: Keith McGuigan <kmcguigan@twitter.com>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---

The patch looks good to me.  Will replace the ce-refcnt one with
this.

Thanks for following it through.
