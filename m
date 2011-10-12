From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: add a knob to turn off hardlinks within same
 directory
Date: Wed, 12 Oct 2011 12:02:51 -0700
Message-ID: <7vaa969go4.fsf@alter.siamese.dyndns.org>
References: <20111012083842.GA21969@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Bastian Blank <waldi@debian.org>,
	Cedric Staniewski <cedric@gmx.ca>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 12 21:03:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RE44x-0006gs-HI
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 21:02:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751915Ab1JLTCy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Oct 2011 15:02:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40990 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751737Ab1JLTCx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2011 15:02:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 607134BF8;
	Wed, 12 Oct 2011 15:02:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=leq32cue9J2Gemb7n/EcmnfqgCs=; b=wkjVGF
	ikP0oipIzcwuv+zID53o7IBguVtXP5RYR0hF+t4s9YWnfrj7gsdVckpoW64Xf+rf
	S2PtcnZE88cingyFKfYc91RtcR54ZvxSGdndxSShN4thJKTQ5JNcZjncQRgIP1dh
	rHO7DpV+NtkZd+D3HADuPozC3ndJ15KCc76qY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qMWzNWBCEnckYHQ8xpUqbKAh03zp7mt4
	6EqJIa1ow29R3fZuq7FAwloJ66F+RlvmoWSVwNpr2rZSC3v7YnMhQbhtAMjUl5X5
	iuz/lQVHZn5Euyear0LE9G+4TIxeOzRqpcRjaJvrEl5rVf2/AlZ/J/0/+kM6Df/n
	f7jmj/eVeiI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 574204BF7;
	Wed, 12 Oct 2011 15:02:53 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E220D4BF6; Wed, 12 Oct 2011
 15:02:52 -0400 (EDT)
In-Reply-To: <20111012083842.GA21969@elie.hsd1.il.comcast.net> (Jonathan
 Nieder's message of "Wed, 12 Oct 2011 03:38:42 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C9707A24-F504-11E0-9F6E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183399>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Typically someone using this setting would want to set
> NO_CROSS_DIRECTORY_HARDLINKS, too, but that is not enforced, so you
> can make $(bindir)/git and $(gitexecdir)/git into hardlinks to the
> same inode and still make sure your tarball avoids the btrfs limits if
> you want.
>
> Requested-by: Bastian Blank <waldi@debian.org>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> Hi,
>
> See <http://bugs.debian.org/642603> for context.  Sane?
>
>  Makefile |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 9afdcf2a..ab64ff4c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -226,6 +226,10 @@ all::
>  # Define NO_CROSS_DIRECTORY_HARDLINKS if you plan to distribute the installed
>  # programs as a tar, where bin/ and libexec/ might be on different file systems.
>  #
> +# Define NO_HARDLINKS if you plan to distribute the installed programs as a tar
> +# that might be extracted on a filesystem like btrfs that does not cope well
> +# with many links to one inode in one directory.
> +#

Hmm....  I would understand if the change were to eventually remove these
"git-foo" anywhere from the filesystem perhaps after a large version bump
in Git 2.0, but that is not what you are trying to do.

Wouldn't your use case be better served with

    $ tar zcf dist.tar.gz --hard-dereference $list_of_files_to_tar_up

instead?
