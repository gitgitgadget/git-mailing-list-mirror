From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2] Add default merge options for all branches
Date: Mon, 02 May 2011 16:36:23 -0700
Message-ID: <7voc3kk748.fsf@alter.siamese.dyndns.org>
References: <4DBF04C5.1080608@dailyvoid.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, vmiklos@frugalware.org, deskinm@umich.edu
To: Michael Grubb <devel@dailyvoid.com>
X-From: git-owner@vger.kernel.org Tue May 03 01:36:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QH2fY-0001ga-Gr
	for gcvg-git-2@lo.gmane.org; Tue, 03 May 2011 01:36:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757027Ab1EBXgj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2011 19:36:39 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:65394 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756306Ab1EBXgi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2011 19:36:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3AE644610;
	Mon,  2 May 2011 19:38:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=R1M0Wy0vn+pSbaiANOIRQgua3Zs=; b=SaQV6D
	yDOYo7AonpYBEt71gl69eGAs4S0kbH7UyEu9u4ftQq8LTwUGevNxy8hHEvtsC8SR
	KcLUr9ons2ex8DZJCZQB2rBq3UcoKIIztdQpB1NAybNqP6+zKguQGfoeny74JaMv
	y8f5AoOx6fdT/D8SnXNdr8gTA39XKGd9I7K1Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dk86ucSeH38HaNDqIxWWeCBbbD1OS3OC
	dbEMQYPlayBVqJUm8PGSpthSw6T+bbqPmtpwWdLelFES2hz9Ieh9ZWEUCYEVtoYS
	ULtFRk6JMK3HEHXFiN6CqburpFkSl58K2rZCKfHUNjJCsRYBYv/ZWpTPI85o2ceM
	GQwD83oqw8w=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EA668460F;
	Mon,  2 May 2011 19:38:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9E91A460A; Mon,  2 May 2011
 19:38:28 -0400 (EDT)
In-Reply-To: <4DBF04C5.1080608@dailyvoid.com> (Michael Grubb's message of
 "Mon, 02 May 2011 14:23:49 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4B446D82-7515-11E0-9B9B-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172639>

Michael Grubb <devel@dailyvoid.com> writes:

> diff --git a/builtin/merge.c b/builtin/merge.c
> index 0bdd19a..9e5b6bd 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -505,9 +505,18 @@ cleanup:
>  
>  static int git_merge_config(const char *k, const char *v, void *cb)
>  {
> -	if (branch && !prefixcmp(k, "branch.") &&
> -		!prefixcmp(k + 7, branch) &&
> -		!strcmp(k + 7 + strlen(branch), ".mergeoptions")) {
> +	static int branch_merge_options_set = 0;

I prefer to avoid "static int" that you cannot easily clear here.  It
would make it impossible to call the function twice.

I think it is easily doable by using the callback parameter (cb).

I am also wondering how this will scale, both in the direction of "later
it is likely that we would want to support a glob not just '*' here", and
also "later it is likely that we would want to support other per-branch
variables, not just "mergeoptions" here".
