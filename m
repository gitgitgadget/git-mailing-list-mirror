From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [WIP/PATCH 0/5] git checkout --recurse-submodules
Date: Thu, 26 Dec 2013 11:58:36 -0800
Message-ID: <xmqq61qbcrkj.fsf@gitster.dls.corp.google.com>
References: <20131226155857.GL20443@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 26 20:58:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VwH53-0003zL-8Z
	for gcvg-git-2@plane.gmane.org; Thu, 26 Dec 2013 20:58:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753793Ab3LZT6k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Dec 2013 14:58:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56441 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753763Ab3LZT6k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Dec 2013 14:58:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 45F165C2E6;
	Thu, 26 Dec 2013 14:58:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZW8mx+O2Aws3ed1DgY4/ECVbd9A=; b=ZvMjh1
	RI8i3YNCSvZO7OKHs1b6QQ/8aDsyaMf61eovRjrblai5xYru2O4zYAsw8aWTXvVN
	0IJNC+diov0v4z4mWiTmMottUFRpMStU2jsCbM3nF8UrjzEnDaKxhEhwKfgZXof5
	8PSm9Qcby4Jo+8ko1lJHl8BDVFUhdJYPO0gBc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BdJtYQIBrY7HZIPB8kBdlq5pEDPnWzDD
	DfjrpRtPN+LF6B6T3qfra3KzUsLIW7JcJPqbb6IugsevkvmoG6XW9H7Bz4rY1quM
	w3d9omUzcKzGy+l4xdJorFw9oJUjOdz3SW6LR0ZcQjU7eMYRZrUQfC54mrFpLrjr
	ZARGi3z/CFk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 357935C2E5;
	Thu, 26 Dec 2013 14:58:39 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 916CE5C2E4;
	Thu, 26 Dec 2013 14:58:38 -0500 (EST)
In-Reply-To: <20131226155857.GL20443@google.com> (Jonathan Nieder's message of
	"Thu, 26 Dec 2013 07:58:57 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1C8FA200-6E68-11E3-8F5D-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239710>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Hi,
>
> This patch series comes from
> https://github.com/jlehmann/git-submod-enhancements branch
> recursive_submodule_checkout.  It needed some tiny tweaks to apply to
> current "master" and build without warnings, but nothing major, and I
> haven't sanity checked it much beyond that and letting the kind folks
> that use Debian experimental play with it.
>
> I'm sending it out now to get review and ideas for what needs to
> happen next to get this series in shape to be included in git.git.
>
> Thoughts of all kinds welcome.
>
> Thanks,
> Jonathan
>
> Jens Lehmann (5):
>   submodule: prepare for recursive checkout of submodules
>   submodule: teach unpack_trees() to remove submodule contents
>   submodule: teach unpack_trees() to repopulate submodules
>   submodule: teach unpack_trees() to update submodules
>   Teach checkout to recursively checkout submodules
>
>  Documentation/git-checkout.txt |   8 ++
>  builtin/checkout.c             |  14 +++
>  entry.c                        |  19 +++-
>  submodule.c                    | 217 ++++++++++++++++++++++++++++++++++++++++-
>  submodule.h                    |  11 +++
>  t/t2013-checkout-submodule.sh  | 215 +++++++++++++++++++++++++++++++++++++++-
>  unpack-trees.c                 |  94 ++++++++++++++----
>  unpack-trees.h                 |   1 +
>  wrapper.c                      |   3 +
>  9 files changed, 556 insertions(+), 26 deletions(-)

Looks reasonably clean from a cursory read. Thanks.
