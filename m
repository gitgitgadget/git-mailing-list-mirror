From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 16/19] pathspec.c: move reusable code from
 builtin/add.c
Date: Fri, 28 Dec 2012 12:48:39 -0800
Message-ID: <7vy5ghhpi0.fsf@alter.siamese.dyndns.org>
References: <1356575558-2674-1-git-send-email-git@adamspiers.org>
 <1356575558-2674-17-git-send-email-git@adamspiers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Fri Dec 28 21:49:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TogrV-0005di-JH
	for gcvg-git-2@plane.gmane.org; Fri, 28 Dec 2012 21:49:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754159Ab2L1Usn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2012 15:48:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33857 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752689Ab2L1Usm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2012 15:48:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 99CB5AED9;
	Fri, 28 Dec 2012 15:48:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KRL53blEKgL6JzTXha0/MZL3LWE=; b=L7urc6
	H+oiR4bBPmwycnb4cldWxvbbp9HAoaP6d5ldm6bdODJo6rdGH8PCKdLg8HhWS/L6
	kUDdXRQqHTcyGoEbBfSEocrN6Jh+e3wpq1Q9uRQhX2WQclK7/Lvuwumr5cRqgJTr
	p5JwXjMgbuiIZBvph1GbLy/FmOrvVGO2ROeOo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aCXWrKxG0CYmn+8OYtTVBldgS2UuFTzc
	FNCx0WnyORORUouWAQrmzvN5kkX9/Ix2afUndYaF4K7aWEhdOZV11myaye6PAtrU
	iFNgNrIv4A48ut2XkD3WORC61byOTi1j7aehLj8QNubtozhdvSqXj2HWrYj6LAZq
	7qb4Ig+0LM0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 87988AED8;
	Fri, 28 Dec 2012 15:48:41 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0640DAED7; Fri, 28 Dec 2012
 15:48:40 -0500 (EST)
In-Reply-To: <1356575558-2674-17-git-send-email-git@adamspiers.org> (Adam
 Spiers's message of "Thu, 27 Dec 2012 02:32:35 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F63230A6-512F-11E2-9E10-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212263>

Adam Spiers <git@adamspiers.org> writes:

> diff --git a/pathspec.c b/pathspec.c
> new file mode 100644
> index 0000000..8aea0d2
> --- /dev/null
> +++ b/pathspec.c
> @@ -0,0 +1,99 @@
> +#include "cache.h"
> +#include "dir.h"
> +#include "pathspec.h"
> +
> +void fill_pathspec_matches(const char **pathspec, char *seen, int specs)
> +{

It did not matter while it was an implementation detail of "git
add", but as a public function, something needs to clarify that this
"fill"s matches *against the index*, not against a tree or the files
in the current directory.  The same comment applies to all the
internal functions this patch exposes to the outside world.
