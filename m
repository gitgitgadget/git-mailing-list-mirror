From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 1/5] http: try http_proxy env var when http.proxy
 config option is not set
Date: Sat, 14 Apr 2012 16:27:37 -0700
Message-ID: <7vmx6d28t2.fsf@alter.siamese.dyndns.org>
References: <4F5F5392.5010700@seap.minhap.es>
 <20120413204858.GA7919@sigill.intra.peff.net>
 <20120413205222.GB7919@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Apr 15 01:27:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJCNe-0003l9-NW
	for gcvg-git-2@plane.gmane.org; Sun, 15 Apr 2012 01:27:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753790Ab2DNX1k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Apr 2012 19:27:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38639 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751283Ab2DNX1j (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2012 19:27:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E55DD61FE;
	Sat, 14 Apr 2012 19:27:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZHP4eAP4Q12HxiGL+9wPfZkAH/A=; b=Udxm5W
	w5twS5/4aUowGInx/UZ84T30uVkY+2WKRFUQIZqdYchydLyvwwYOiI/VsFtH24EZ
	8TI0MWO5B+ThmWTfzsdez5cvHXa69V9WnKMnjqqg4BSHK7k/NZzXEJyNVH5hknDi
	A1XopykNaY3/3yPeAmGMgz1Q0jgIfYcl7/3Nk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ktt1GE4k+aU3Yb6gEp2rBTxpi/j9Kvfa
	AzC/AwWBJVtvMdDQzphYthT37YtzYOzL2br9cxdHjpF5hmwXGkcF0qscgPsenr6t
	wnk4L0kiTBAjgLjWwm3RKVFsu3BGhh6BAn0CWwDH8uEeYnqDk1yRgGcEqB6Y6A5L
	rC5rWd6gOFY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DD35561FD;
	Sat, 14 Apr 2012 19:27:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6D72161FC; Sat, 14 Apr 2012
 19:27:38 -0400 (EDT)
In-Reply-To: <20120413205222.GB7919@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 13 Apr 2012 16:52:22 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6C5E6AE6-8689-11E1-942F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195534>

Jeff King <peff@peff.net> writes:

> On Fri, Apr 13, 2012 at 04:48:58PM -0400, Jeff King wrote:
>
>> > +	if (!curl_http_proxy) {
>> > +		const char *env_proxy, *no_proxy;
>> > +		char *env_proxy_var;
>> > +		int read_http_proxy;
>> > +		struct strbuf buf = STRBUF_INIT;
>> > +		credential_from_url(&cre_url, url);
>> > +		strbuf_addf(&buf, "%s_proxy", cre_url.protocol);
>> > +		env_proxy_var = strbuf_detach(&buf, NULL);
>> > +		env_proxy = getenv(env_proxy_var);
>
> Also, shouldn't we be checking HTTPS_PROXY in addition to https_proxy,
> by curl's rules? Only http_proxy is not allowed to be upper-cased.

Good point.
