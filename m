From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitk: Use git-difftool for external diffs
Date: Thu, 31 Dec 2009 12:37:31 -0800
Message-ID: <7vbpheswvo.fsf@alter.siamese.dyndns.org>
References: <1258341126-2108-1-git-send-email-davvid@gmail.com>
 <20091230121319.6117@nanako3.lavabit.com>
 <7vy6kk52an.fsf@alter.siamese.dyndns.org> <20091231071642.GA10067@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>, peff@peff.net,
	sam@vilain.net, git@vger.kernel.org, paulus@samba.org,
	Markus Heidelberg <markus.heidelberg@web.de>,
	Jay Soffian <jaysoffian@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 31 21:38:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQRmS-0003hY-IA
	for gcvg-git-2@lo.gmane.org; Thu, 31 Dec 2009 21:38:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567AbZLaUhz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Dec 2009 15:37:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751516AbZLaUhz
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Dec 2009 15:37:55 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63240 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751441AbZLaUhy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2009 15:37:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7C963AB7C8;
	Thu, 31 Dec 2009 15:37:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dIlKCGhZ3pmFPSyLRZaV8ENaR8c=; b=rApJ0x
	D/uADUl3xvwaCU31iI8IkRGUd9HtmBZ06Z3tdxU+C9QgL08lGmbk97pHjFkKzICX
	s8MoWKVi7y7IXi2O+GCceeyKXjF29jwjTTclAMB/Z/TH02qxZrAj+vJ66v/sTPWK
	6aHfWXgEXs7JrOP13h8MtPYfp689sSuC23djE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G7W/nz1GPCOZA9+m+is1ckUxl0iNkYDz
	24L37ApJ8Y9spvPz/AIGlgu0GoVFZ9TaqJPdCiJMu/uaUuaAelrfpuq+onJp9u6f
	2KXPuq03keEAJbTAicfK5VrCj3didj9FXB7ni1qAf5LpNRpH4ystPZliTNNiNmJa
	JLs2NHmOe8Y=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 02644AB7C6;
	Thu, 31 Dec 2009 15:37:43 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8B81EAB7C4; Thu, 31 Dec 2009
 15:37:33 -0500 (EST)
In-Reply-To: <20091231071642.GA10067@gmail.com> (David Aguilar's message of
 "Wed\, 30 Dec 2009 23\:16\:45 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 590D1340-F64C-11DE-A6AD-465EBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135974>

David Aguilar <davvid@gmail.com> writes:

> I started the first step:
>
> http://thread.gmane.org/gmane.comp.version-control.git/135613
> http://thread.gmane.org/gmane.comp.version-control.git/135613/focus=135612

Thanks.

> The 2nd patch implements the the --gui option which Markus
> pointed out would be needed to avoid issues such as calling
> "vimdiff" from a console-less gitk:
>
> http://article.gmane.org/gmane.comp.version-control.git/133386
>
> I marked the --gui patch as "RFC" since it introduced a new
> config variable and I want to make sure that we agreed on its
> name.  I didn't get any feedback about that patch
> (my fault-- we were in RC freeze and I forgot to CC: Markus).

I don't think "diff.guitool" would hurt.  However,...

I think the "--gui" patch is a more or less independent issue to "gitk
runs external diff through difftool", because difftool/mergetool already
have a built-in way to auto-guess which backend to use depending on what
its environment looks like (e.g. do we have $DISPLAY etc.).

The "--gui" patch is about giving a more explicit way for the caller to
control that backend picking decision process and it is more like icing
than a prerequisite for the issue.  IOW, I think the end result will be
usable by gitk users even if they do not configure "diff.guitool".
