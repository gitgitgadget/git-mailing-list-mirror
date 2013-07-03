From: Junio C Hamano <gitster@pobox.com>
Subject: Re: unexpected file deletion after using git rebase --abort
Date: Wed, 03 Jul 2013 16:04:23 -0700
Message-ID: <7vip0rckjs.fsf@alter.siamese.dyndns.org>
References: <20130703224402.GF9016@localhost.localdomain>
	<20130703225642.GU408@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Paul A. Kennedy" <pakenned@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 04 01:04:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuW6A-00011N-SG
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jul 2013 01:04:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933110Ab3GCXE1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 19:04:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57934 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932988Ab3GCXE0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 19:04:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BEA472D974;
	Wed,  3 Jul 2013 23:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=g5TbwjzsD+AbZMfAw3/7QWN9dl0=; b=HtoUNH
	G57a+pYixbX9EUO1QVeMET7BjqQLsFR8PCqSz0/vx4AX4FxaYdFStxJs0dYHrgLX
	BlnCI+pL/IGIccLY2L9ZWQoodv3UCW2nF666oeoKdjovhsCGlD7WQ6NjAOq+39F0
	i9AxH/RGLJfz3ud8ioeXTW4uTIlBeQgJIV9ec=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VOgMhYutAJgjvLWF6l8clhajSf4FFBhp
	0m73QYLsjUYdGvBs0cuwQ5OaVLHMea21Ov/H4ErvLhkYJ2fFyb7fy96uOcMhAdMc
	bumPT0NNuB5+PPygaJMlUqlSS8vZKXpIdoZrmM+R4Y1j34Br9ZF9m66NxDEr/6GK
	5014v6MZT8w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B52882D973;
	Wed,  3 Jul 2013 23:04:25 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 125262D971;
	Wed,  3 Jul 2013 23:04:24 +0000 (UTC)
In-Reply-To: <20130703225642.GU408@google.com> (Jonathan Nieder's message of
	"Wed, 3 Jul 2013 15:56:43 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E7ACC6E8-E434-11E2-8FA7-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229545>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Paul A. Kennedy wrote:
>
>> If we don't expect this, should we update the documentation for the
>> --abort heading in the git rebase man page to indicate that newly
>> staged content will be lost after a git rebase --abort?
>
> How about something along these lines?
>
> diff --git i/Documentation/git-rebase.txt w/Documentation/git-rebase.txt
> index 6b2e1c8..dcae40d 100644
> --- i/Documentation/git-rebase.txt
> +++ w/Documentation/git-rebase.txt
> @@ -240,6 +240,9 @@ leave out at most one of A and B, in which case it defaults to HEAD.
>  	started, then HEAD will be reset to <branch>. Otherwise HEAD
>  	will be reset to where it was when the rebase operation was
>  	started.
> ++
> +This discards any changes to files tracked in the working tree or <branch>.
> +You may want to stash your changes first (see linkgit:git-stash[1]).
>  

"rebase --abort" is typically used to get rid of conflicted mess the
user does not want to resolve right now, and "stash" would not be a
sensible thing to use in such a situation, I think.  Doesn't it even
refuse to work if there is a conflicted entry in the index?
