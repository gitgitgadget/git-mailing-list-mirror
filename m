From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] git-p4: fix submit regression with --use-client-spec
Date: Sun, 26 Feb 2012 16:18:08 -0800
Message-ID: <7vhaydcenz.fsf@alter.siamese.dyndns.org>
References: <1330218385-22309-1-git-send-email-pw@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Laurent =?utf-8?Q?Charri=C3=A8re?= <lcharriere@promptu.com>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Mon Feb 27 01:18:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1oID-00043Y-6k
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 01:18:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753388Ab2B0ASM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Feb 2012 19:18:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50469 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753004Ab2B0ASL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Feb 2012 19:18:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B5DE47E7E;
	Sun, 26 Feb 2012 19:18:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bxbYXFlaDRA03IiAkilgoEMJIxA=; b=ekb+1C
	u1wpgBP2a9X9E8s2uZ9Tgy0leRL2eZp37Ce7ZIbhYyS5h102WpM04uwS3Zed+Hcv
	sd5agg1g4Heaw0VkypTJ+kZ/KaDEBIYNsRXycvrX+RWy2XkK2xe0MUa2Gu0t/JhB
	35QnJ7WTjI7/oljIjUK384vqePj2oGr1KUV24=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vbTNgf7WZw6/bVG/m+0HwmF4JKdMIfO6
	woZ/OwQgASBbJxRxKWuTgRCeR+SPUQclwVGD2hxNJrUli+Yz6BzzADJO+OCtnzG+
	68rmnm33vIYKo1y+/ohaBMvDtyJ6XJX8yu6Wb7KG2/XdRAAmaFdj8O20owQnNL8n
	p7moYvs45eo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ACB1B7E7C;
	Sun, 26 Feb 2012 19:18:10 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3DE557E7B; Sun, 26 Feb 2012
 19:18:10 -0500 (EST)
In-Reply-To: <1330218385-22309-1-git-send-email-pw@padd.com> (Pete Wyckoff's
 message of "Sat, 25 Feb 2012 20:06:23 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 87A32624-60D8-11E1-A77C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191587>

Pete Wyckoff <pw@padd.com> writes:

> This pair of patches fixes a regression that happened with ecb7cf9
> (git-p4: rewrite view handling, 2012-01-02).  There are two factors that
> affect where files go in the client when submitting:  the cilent spec,
> and the depot path.  When the depot path was not exactly the root of
> the client, submit fails.
>
> Fix this by always using the true client root.  And also notice that
> somebody has to tell the submit path that it should be looking at the
> cilent spec.  Save useClientSpec in a configuration variable if it
> was specified as an option on the command line.
>
> Junio: can you put this on maint to go out with the next 1.9.x?

Surely and thanks.

Your "p4: submit with wildcards" seems to conflict with this change and
may need to be rebased, though.

>
> Pete Wyckoff (2):
>   git-p4: set useClientSpec variable on initial clone
>   git-p4: fix submit regression with clientSpec and subdir clone
>
>  Documentation/git-p4.txt      |   10 ++-
>  contrib/fast-import/git-p4    |   97 ++++++++++++++++---------
>  t/t9809-git-p4-client-view.sh |  159 ++++++++++++++++++++++++++++++++++++++---
>  3 files changed, 219 insertions(+), 47 deletions(-)
