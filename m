From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] (trivial) add helpful "use --soft" for bare reset
Date: Thu, 30 Jun 2011 13:06:26 -0700
Message-ID: <7vwrg3ozi5.fsf@alter.siamese.dyndns.org>
References: <20110626221428.GA26780@spacedout.fries.net>
 <7vk4c3qlqa.fsf@alter.siamese.dyndns.org>
 <20110630190608.GB26701@spacedout.fries.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Scott Bronson <bronson@rinspin.com>
To: David Fries <david@fries.net>
X-From: git-owner@vger.kernel.org Thu Jun 30 22:06:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QcNVS-0006CQ-RR
	for gcvg-git-2@lo.gmane.org; Thu, 30 Jun 2011 22:06:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754121Ab1F3UGa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jun 2011 16:06:30 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61727 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753877Ab1F3UG3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2011 16:06:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CD00A511D;
	Thu, 30 Jun 2011 16:08:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xK5x21tlFf31JkPLQi2yk20OVvk=; b=vnNSy3
	TWnBxk9CIbPk+68IPAKmAWEfQNTaMtFDYBFt0OAhAWDkNArJpZq95uxriMBW2JWM
	YchvGd5X9u0D/2s/rJdiDXQYJZkQWGewrJYC+T1Vkw3+GdtwVE+Zr/1Hkbd4G+tk
	LcnSeTQjD+7jfWVcsbgjbzq3gpxYLrMIs9qrU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IM+l326UOGEi6KrGH5EZrbbzSNPH/EAS
	wFDQCdbZKe8Ne8etJj0P+9nNX6/br0TbXetV0NbQlXQe9b8yrVu8bw2/FNSEiDqn
	KKvEifPR+1jQNoH34HBk3y+ikGdD3upi2jl0OPqWJ3a43RsNHmzeisUs4t1fmVIK
	LY5Gu0Hr03o=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C5260511C;
	Thu, 30 Jun 2011 16:08:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 19C2B511B; Thu, 30 Jun 2011
 16:08:42 -0400 (EDT)
In-Reply-To: <20110630190608.GB26701@spacedout.fries.net> (David Fries's
 message of "Thu, 30 Jun 2011 14:06:08 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C05F194C-A354-11E0-87CE-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176506>

David Fries <david@fries.net> writes:

> diff --git a/builtin/reset.c b/builtin/reset.c
> index 98bca04..d0d4d66 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -332,7 +332,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
>  		setup_work_tree();
>  
>  	if (reset_type == MIXED && is_bare_repository())
> -		die(_("%s reset is not allowed in a bare repository"),
> +		die(_("%s reset is not allowed in a bare repository, see update-ref"),
>  		    _(reset_type_names[reset_type]));

There still is one thing that worries me remains here, even though I may
be worried too much. I tend to think that giving an incorrect advice is
far worse than not giving one.

Are you absolutely sure that the user wanted to update only the tip of a
ref without affecting the index nor the working tree, when a mixed reset
is issued in a bare repository, and there is _no other_ explanation why
the user issued a forbidden command?

For example, I have ~/git.git and /pub/scm/git/git.git on a single machine
somewhere. The former is with a working tree and the latter is a bare
repository. I usually live in ~/git.git/ on that machine, but sometimes I
would do things like:

	$ git repack -a -d ;# working area
	$ cd /pub/scm/git/git.git ;# clean up from time to time ...
        $ git repack -a -d ;# ... the public one as well

I may disconnect from my screen session to the machine after I do this,
and I may have forgotten where I was the next time I come back to the
machine.  After I reconnect to the same screen session, I may say "git
reset" to get back to a known state, which is what I often want to do in
the working area repository ~/git.git, mistakenly thinking that I am in my
usual ~/git.git directory.

In such a scenario, the mistake is not that I used a wrong command "reset"
in an attempt to update the tip of the branch. The mistake is that I tried
to use the right command to update the index, but I did it in a wrong
place. "Did you mean to do that somewhere else?" would be a much more
appropriate advice in that case.
