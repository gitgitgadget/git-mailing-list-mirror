From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 19/29] refs: don't dereference on rename
Date: Wed, 27 Apr 2016 11:55:46 -0700
Message-ID: <xmqqy47y98zx.fsf@gitster.mtv.corp.google.com>
References: <cover.1461768689.git.mhagger@alum.mit.edu>
	<27f8b223e42dcf1cf3c010833e0aff7baa4559c2.1461768690.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, David Turner <dturner@twopensource.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Apr 27 20:56:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avUcy-0007gX-DB
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 20:56:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753662AbcD0Sz4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 14:55:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52914 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753656AbcD0Szz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 14:55:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F2A83172B0;
	Wed, 27 Apr 2016 14:55:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wEsAyxx68dX9YAzHrryDMW1z3BE=; b=syk9i4
	cUKE045f8JstVH8vTh7uO3tcjFmxEKOvG+wxV+4jsD6ec8KuhyRANoQdN05CT5mx
	MQhkc2XmSlpsq69irvTh4yxU0Y0drw9p7HVl6JWrt+xQhdw5BZU6IO+uU2TA+gaR
	Z9fiqwgrUanJr8IbR1Mnk7xPHNeoXX6xX++OE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v9knIIhXvwaK4noknWsWSwwOG8eXXtT+
	eeQ6jO1DHbU+nX/6sGmYet2vBDFDGqSkbI7kHgRtv27X3P08h56ZGIUTnTWYXECP
	3kkt1jKSbuwufJk/Ui50bXgyn4lFCJHWNqfqoLDsjvKuOCWnhXu9IsYo9cbgpMLH
	0cWXLW9hbWA=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E8F2C172AF;
	Wed, 27 Apr 2016 14:55:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3A7BA172AE;
	Wed, 27 Apr 2016 14:55:48 -0400 (EDT)
In-Reply-To: <27f8b223e42dcf1cf3c010833e0aff7baa4559c2.1461768690.git.mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Wed, 27 Apr 2016 18:57:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A7A7550E-0CA9-11E6-B170-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292787>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> @@ -2380,8 +2381,8 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
>  		goto rollback;
>  	}
>  
> -	if (!read_ref_full(newrefname, RESOLVE_REF_READING, sha1, NULL) &&
> -	    delete_ref(newrefname, sha1, REF_NODEREF)) {
> +	if (!read_ref_full(newrefname, resolve_flags, sha1, NULL) &&
> +	    delete_ref(newrefname, NULL, REF_NODEREF)) {

Could you explain s/sha1/NULL/ here in the proposed log message?

>  		if (errno==EISDIR) {
>  			struct strbuf path = STRBUF_INIT;
>  			int result;
