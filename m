From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Require a struct remote in transport_get()
Date: Tue, 03 Nov 2009 21:42:59 -0800
Message-ID: <7vbpjin8v0.fsf@alter.siamese.dyndns.org>
References: <alpine.LNX.2.00.0911032133540.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Nov 04 06:43:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5YeR-0001T0-GA
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 06:43:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbZKDFnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 00:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbZKDFnL
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 00:43:11 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45325 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750859AbZKDFnL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 00:43:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 912B273964;
	Wed,  4 Nov 2009 00:43:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=LqE4VIGPLLEjOZktX8kxSDC3VWY=; b=ilJPr6YyYRRuRu4ZJr14t4N
	v3XSre9SZ2yfKjiDup8IrWF6fjWlZ0InM1/K3DMvOvqIZ4CiTukG+lnwfzOZdhGR
	IpTUTs/YYANWV0w+QCeg7Xr2vm3VZNxA8SXdgqk1Tai+lvyrHV2ASV6meDBo4AGx
	G8fUOgEI0/rnJ6z+Oa60=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=cY6qaRrFttDAJ/u+O7OGo7cProZZseoqMDjOYyaobDR6CZ0yj
	KtuLIh6XMPxy3zIxDSkGop1nItjbDgCEd2hs+6fCRR30Grs4hMs2PNkiLx75vfLR
	pCbbSYr3jICNdNkza1356n3TICAVnqkCggTu7v4W+vES9NwH9wD0CysNjI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 72F1473963;
	Wed,  4 Nov 2009 00:43:11 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3CC8B73962; Wed,  4 Nov
 2009 00:43:01 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F01AA54C-C904-11DE-9AE9-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132037>

Daniel Barkalow <barkalow@iabervon.org> writes:

> cmd_ls_remote() was calling transport_get() with a NULL remote and a
> non-NULL url in the case where it was run outside a git
> repository. This involved a bunch of ill-tested special
> cases. Instead, simply get the struct remote for the URL with
> remote_get(), which works fine outside a git repository, and can also
> take global options into account.
>
> This fixes a tiny and obscure bug where "git ls-remote" without a repo
> didn't support global url.*.insteadOf, even though "git clone" and
> "git ls-remote" in any repo did.
>
> Also, enforce that all callers provide a struct remote to transport_get().
>
> Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> ---
> This is sufficient to stop the segfault when tring "git ls-remote 
> http://..." outside of a repo, but not to make it work, which requires 
> either something simple but not ideal or something complex.

Thanks; I think this and your other patch are important fixes, and should
go directly on 'maint'.  Do you prefer to queue them on 'next' to cook for
a week instead?
