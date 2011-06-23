From: Junio C Hamano <gitster@pobox.com>
Subject: Re: ''git submodule sync'' should not add uninitialized submodules
 to .git/config
Date: Thu, 23 Jun 2011 07:35:28 -0700
Message-ID: <7v7h8c4nv3.fsf@alter.siamese.dyndns.org>
References: <0D2618D7-0681-4E71-B412-36D490D45B9D@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Andreas =?utf-8?Q?K=C3=B6hler?= <andi5.py@gmx.net>
To: Maarten Billemont <lhunath@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Jun 23 16:35:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZl0M-000081-53
	for gcvg-git-2@lo.gmane.org; Thu, 23 Jun 2011 16:35:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751975Ab1FWOfc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jun 2011 10:35:32 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41574 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486Ab1FWOfb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2011 10:35:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D05A54891;
	Thu, 23 Jun 2011 10:37:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Md2Rz+x4qM+v1BtWzDjcFp/j0AY=; b=t8/JaL
	tHHV4vkPTpgMDB2S0yrOnaYSL2U0jk8FJz74pjv2wF007/N8+Od6VhJ9vwjFqHHZ
	fTHBFwdfHU0PMLWWqZVmwfBIBSGbplRtpR4IsohDWNfZp8YqNzsQhS0GmqXsQnz2
	VcmmudO1ckcT5Gi7KW78pYus8Q9Kf6S+tbdBU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W06ctGK07K6/BLy1zj9EAGs39mbvFeMT
	mlFvlBObQPYyFyE8gCseUcfaebn0GRPYjJgO0lANKv7bcgjwb36oFxQQ9HcLuZZe
	DRcJIHD5stOV2esYu2PfQ3m8ViDbbtgUNZBvyct2UQiqOkntEP3R8h/GXDtVhz+k
	qQXgQrxVITI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C913D488F;
	Thu, 23 Jun 2011 10:37:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 36480488E; Thu, 23 Jun 2011
 10:37:42 -0400 (EDT)
In-Reply-To: <0D2618D7-0681-4E71-B412-36D490D45B9D@gmail.com> (Maarten
 Billemont's message of "Thu, 23 Jun 2011 13:13:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5A110744-9DA6-11E0-9314-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176271>

Maarten Billemont <lhunath@gmail.com> writes:

> When I initialize 2/3 submodules of my git repository and do git
> submodule update, all is fine: Only the 2 submodules that I need are
> updated.
>
> When I run a git submodule sync to update the URLs that may have been
> changed in .gitmodules, it ADDS the URL of the submodule that was NOT
> initialized, thus "initializing" it.
>
> Now, when I run git submodule update, it starts checking out the third
> module and my workflow is broken.

See 33f072f (submodule sync: Update "submodule.<name>.url" for empty
directories, 2010-10-08), which introduced this behaviour.

cmd_update considers anything that has submodule.<name>.url defined as
"the user is interested", so I suspect "git submodule sync" should not do
this.

The situation 33f072f cites as needing this behaviour can easily fixed by
running 'submodule sync' after switching to the branch to which the
submodule _matters_, no?

Jens, what do you think?
