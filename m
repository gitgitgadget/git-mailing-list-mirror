From: Junio C Hamano <gitster@pobox.com>
Subject: Re: share object storage for multiple clones of different
 repositories
Date: Fri, 04 Nov 2011 19:26:11 -0700
Message-ID: <7vobwr9uf0.fsf@alter.siamese.dyndns.org>
References: <j91rcq$1uo$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gelonida N <gelonida@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 05 03:26:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMVxb-0007YN-Nl
	for gcvg-git-2@lo.gmane.org; Sat, 05 Nov 2011 03:26:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752916Ab1KEC0O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Nov 2011 22:26:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47663 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752879Ab1KEC0O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2011 22:26:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4915A67CA;
	Fri,  4 Nov 2011 22:26:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hBgCIO0T3/6V/CG6jS+phog/ppk=; b=ZWnPvf
	2KBvXMkgYZCArHUBuhD5gUqvsMm5OUnF5JsxDpvR/Vi2Y2Nkt/ovGkeA1eJh6jTz
	x570EAKvGfLLNb9DRXKn5zQCLGzW2LiwwfoXz1SdJ9iduscUbB4sRDMNylPXPdM/
	L5icFST394LvF+4xvUcW9vjpVbtwk5BIhCTes=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hPHn4aH8MMrjptH/aq+u8toQ5zlV4o5u
	KanFjLRjlYp0ZTTTwSLxTSakwPA+rSbniiuOj3aTxEwP6q0uXQGSWCnIAeZxBV+K
	aDk+tLCS3W4BLwLcDMcZoEZwfAY3mCXYiaGXZgFTO7iAaR79FAyxNwi903k/xakS
	9S+YPrvye6o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3DCAC67C9;
	Fri,  4 Nov 2011 22:26:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AE7E167C8; Fri,  4 Nov 2011
 22:26:12 -0400 (EDT)
In-Reply-To: <j91rcq$1uo$1@dough.gmane.org> (Gelonida N.'s message of "Sat,
 05 Nov 2011 00:10:18 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 87A62A54-0755-11E1-A2F9-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184813>

Gelonida N <gelonida@gmail.com> writes:

> SHARED_STORAGE=$HOME/shared_storage
> mkdir $SHARED_STORAGE
>
> git clone remotehost1:repo1
> cd repo1
> rsync -av .git/objects $SHARED_REPO

Up to this part it is probably OK.  Repeat that for all your local
repositories to collect all objects in $HOME/shared_storage.

After doing that, do this in all of your local repositories:

	rm -rf .git/objects
        mkdir -p .git/objects/info
        echo $HOME/shared/storage >.git/objects/info/alternates

The reason why nobody should follow your original recipe is because any
"git gc"/"git repack" in any of your local repositories would break others
with that approach.
