From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http.proxy: also mention https_proxy and all_proxy
Date: Sun, 04 Mar 2012 15:07:55 -0800
Message-ID: <7vhay455is.fsf@alter.siamese.dyndns.org>
References: <20120303145053.GA29948@ecki>
 <20120303174252.GC28602@sigill.intra.peff.net>
 <7v399p72a8.fsf@alter.siamese.dyndns.org> <20120304124627.GA1596@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Mar 05 00:08:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4KX7-00067e-BE
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 00:08:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755762Ab2CDXH7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Mar 2012 18:07:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37971 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755334Ab2CDXH6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2012 18:07:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A0BDC6078;
	Sun,  4 Mar 2012 18:07:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5kZhdsT72nv7PVHoBhcAlgNevR8=; b=qbMqH0
	sGd55eRc6GM/+1z2677IPi+eR8B8l/XmRUnbDEbnEcruWjzQItaOzXBP76cNmFT6
	gf2OvPQSPwdRSoOOSOGecrQLhUiLEEJbL6zZHXky4nMCqUwDRfzZikW5mVx93ExG
	0A1r/fugbJ5MIbkQxSFqD2nKsCEHPUxWskWqM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YKAulPrlebSwotw/1r+394u3s0J+7QHP
	hUrmQ43ORhOeuhJUiOO30kWZHEeH9F5ARW+mW6Ne4Enf4R7Ogf3hT/c6ica2VfDE
	B+z/9pcD7NigsMQp+uKXzPvKb8tsnU0IjV63etW50weanC4QTiQfxVyLyYCjft6x
	EivKBGFqbVE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 98D046077;
	Sun,  4 Mar 2012 18:07:57 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2BA436075; Sun,  4 Mar 2012
 18:07:57 -0500 (EST)
In-Reply-To: <20120304124627.GA1596@ecki> (Clemens Buchacher's message of
 "Sun, 4 Mar 2012 13:46:28 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E15732B6-664E-11E1-998C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192178>

Clemens Buchacher <drizzd@aon.at> writes:

> On Sat, Mar 03, 2012 at 02:22:39PM -0800, Junio C Hamano wrote:
>> 
>> As to the way forward, I suspect that http.proxy was a mistake to begin
>> with, considering the structure of namespace our configuration variables
>> fit in.  Shouldn't they be proxy.http, proxy.https, etc.?
>
> I actually prefer the current behavior, which is to configure only one
> proxy for all protocols. I have not seen a setup where HTTP and HTTPS
> are routed through different proxies before. But if this is really
> needed, one has the option to use the environment variable, or
> remote.<name>.proxy.
>
> I suggest instead that we map curl's CURLOPT_PROXY to core.proxy.  That
> would also fit well with the remote.<name>.proxy scheme.

Contaminating core.* namespace would not solve anything.

People are already relying on http.proxy to apply to any cURL transport,
so we will keep supporting it anyway.  There is no justification to teach
new people to learn that both exists, and the transport is not core anyway; 
it is still cURL specific.

I forgot about remote.<name>.proxy that already can let you use different
proxies for http/https, and the use of different ones per protocol would
be rare to begin with, so I agree that we would not have to worry about
introducing proxy.{http,https,...}.

Thanks.
