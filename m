From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/4] wt-status: split wt_status_state parsing function
 out
Date: Wed, 06 Mar 2013 15:53:17 -0800
Message-ID: <7vy5e0nl02.fsf@alter.siamese.dyndns.org>
References: <1362303681-6585-1-git-send-email-pclouds@gmail.com>
 <1362572482-20570-1-git-send-email-pclouds@gmail.com>
 <1362572482-20570-2-git-send-email-pclouds@gmail.com>
 <7v4ngoqs8m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jonathan Niedier <jrnieder@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 07 00:53:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDO9b-0001lA-BC
	for gcvg-git-2@plane.gmane.org; Thu, 07 Mar 2013 00:53:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754962Ab3CFXxV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Mar 2013 18:53:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53400 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753109Ab3CFXxU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Mar 2013 18:53:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B0CE8A394;
	Wed,  6 Mar 2013 18:53:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sPYNrLAQ6GiqSkqSDm0J+AP5eUw=; b=M3hXzR
	wTAlk2WXIPECOnfgp+W77xYQQeJCwcqPKj9HYLNUtTQHxglFWz7T6q12eM+nOhKU
	WkVMCKNHzwhN7mAGaQIwUTgKYmeqEdrpuzh6ikIE0H9qSQUvwhTZDzpfaCh7kzdS
	pNyuhap0mLStgofWuh52qyhDLeULRabduBoLs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i9DyvcW/IewEvLWO4O8REYhVXmpAIVJu
	YJdyU+sAC3ej3OhSsb1ONtStpKDOgGIWES/wO+/2l9Y9rwvhmdEgYmaS1B5XLp0I
	fI690E8ef4qdDzsKEgELUa04uVNA74uC+20gxJ+jUHFhqJU+6qwFGrCSFg1Zy+f7
	koEbILvGQ28=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A6574A389;
	Wed,  6 Mar 2013 18:53:19 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 283F4A387; Wed,  6 Mar 2013
 18:53:19 -0500 (EST)
In-Reply-To: <7v4ngoqs8m.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 06 Mar 2013 10:48:41 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 055F4DF2-86B9-11E2-B262-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217560>

Junio C Hamano <gitster@pobox.com> writes:

> In other words, with the new world order, wouldn't a saner function
> signature be:
>
> 	static const char *read_and_strip_branch(const char **path);

Eh, discard an asterisk from there.  "Given a string to name the
file, read it to find the branch name recorded in it".

> after this patch?
>
> Also I notice that the error-return cases of this function may be
> wrong even before your patch.  Shouldn't it be doing *branch = NULL
> (and 'return NULL' after the suggested change)?
