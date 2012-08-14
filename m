From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: Add option to limit repositories to be shown by
 ServerName
Date: Tue, 14 Aug 2012 09:04:46 -0700
Message-ID: <7v628l8noh.fsf@alter.siamese.dyndns.org>
References: <d4f61bb06c9a125113442ae63be15ccea9464afd.1344932897.git.minovotn@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michal Novotny <minovotn@redhat.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 18:04:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1Jbz-0001lR-Nh
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 18:04:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752331Ab2HNQEu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 12:04:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63573 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751777Ab2HNQEt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2012 12:04:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 27CE66D03;
	Tue, 14 Aug 2012 12:04:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ukJDGQDBMSKLJDTWFtb4BJaK9gU=; b=fp9UnG
	/kspdN7f7BkOAU5BHMaWpeYRPc1lyzsqfqUFYhRa5pzdh+PvsLT/zknSk9Ek3nsf
	Zkj5Tqy1QJRN2+vnf+384ZNyuxpihziuDAWuUUWZT+v1x9GuMIASEVVkIb/fLbPr
	pklKpn7M08l3nGD9rgaJa7uKqo+aBvOF4rCxw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a/YsKhw7ZUxhwgSRKprqNwKgpeOcpvBk
	XJaFv39G0Pd+D2SPwNIapvTGvlmEa2l2DxYRfuwAJfaYLpLb1vRB+xkfVmZOkP1m
	QKglwqs/+4f3yS17iRtw5fdrwq1tBypvxSOCI057LlRs5/B3+QjD6dLYqLMxCBRE
	csJcCdg2ZM4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 14A5C6D00;
	Tue, 14 Aug 2012 12:04:49 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6CE1A6CFA; Tue, 14 Aug 2012
 12:04:48 -0400 (EDT)
In-Reply-To: <d4f61bb06c9a125113442ae63be15ccea9464afd.1344932897.git.minovotn@redhat.com>
 (Michal Novotny's message of "Tue, 14 Aug 2012 10:47:48 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C5CEBE3C-E629-11E1-A141-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203408>

Michal Novotny <minovotn@redhat.com> writes:

> this is the patch to limit repositories to be shown by the
> ServerName in the gitweb.cgi script. This is useful for cases
> you're hosting multiple websites on a single machine and you don't
> want all the repos to be shown in all of them.
> ...
> Use case scenario: Imagine you have one server running HTTPd
>                    for 3 domains, let's call them domain1,
>                    domain2 and domain3, and you want all of
>                    them to have a git server accessible via
>                    gitweb at these URLs:
>                    1) http://domain1/git
>                    2) http://domain2/git
>                    3) http://domain3/git


I do not run gitweb myself, but isn't the problem you are describing
merely a symptom caused by your <VirtualHost /> sections that are
not configured correctly, and instead having a single instance of
gitweb cgi enabled for all the virtual hosts?  Why does such a
physical host want to have git repositories for different domains in
a single place that is covered by a single instance of gitweb (hence
a single $projectroot) in the first place?  After all, domain1's
notion of "kernel git repository" http://domain1/git/kernel.git
might be totally different from that of domain2's, so wouldn't it be
far more natural to have one $projectroot (hence one instance of
gitweb) per such domains, configured in their own <VirtualHost />
sections?

Also, there may even be http://domain3/git that does not want to be
served by gitweb but something else, e.g. cgit, on the same physical
host, and in such a case, the approach taken by this patch still uses
gitweb only to fail the request without letting cgit have its
chance, no?
