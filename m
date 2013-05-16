From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-bzr: fix cloning of non-listable repos
Date: Thu, 16 May 2013 09:29:17 -0700
Message-ID: <7vli7e7usi.fsf@alter.siamese.dyndns.org>
References: <1368698645-28429-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 16 18:29:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud13U-0001NH-HP
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 18:29:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752450Ab3EPQ3V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 12:29:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48265 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752224Ab3EPQ3U (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 12:29:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 36B0A1FDF8;
	Thu, 16 May 2013 16:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=slvWSBVscLoZ3J1CWTEFgwos9PI=; b=jDQjGL
	sN9uw4yp3xcJuJKwu2yBwo2bMzqp30K5bMNN8XMErnlCI5HbEYLlGxMuIfKASKFr
	y/ku9pGuCcy1FABxWpWbq0VGicFCiVOHH9EwzHjsRWKcMugh+paKln84Pf5gY/tO
	YmiHum9+/KduzQWfrOy95VHXQEzR1uaN5mGFk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QgaHbaBav6sg6/olMd/w2UyyqhAy1AJY
	H15lBUgh34yZPx0TbuNZaPQmfFyHVZCDJaq46C6IhXokMrbH4PbY7bK5SMw9MaY7
	8kduL25fSQ40+JhSRcew/lPnRA//V550OUpJnOFRJ648sblnDcr+CoZpbIpcYdct
	McDLMQpjfqI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E0F91FDF7;
	Thu, 16 May 2013 16:29:19 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9500F1FDF2;
	Thu, 16 May 2013 16:29:18 +0000 (UTC)
In-Reply-To: <1368698645-28429-1-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Thu, 16 May 2013 05:04:05 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C1B125DE-BE45-11E2-A2FB-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224594>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Commit 95b0c60 (remote-bzr: add support for bzr repos) introduced a
> regression by assuming all bzr remote repos are listable, but they are
> not.
>
> If they are not listable they are basically useless, so let's assume
> there is no bzr repo.
>
> Reported-by: Thorsten Kranzkowski <dl8bcu@dl8bcu.de>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>
> We want this on master for v1.8.3.

Sure.

>
>  contrib/remote-helpers/git-remote-bzr | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
> index b295dd4..ad42317 100755
> --- a/contrib/remote-helpers/git-remote-bzr
> +++ b/contrib/remote-helpers/git-remote-bzr
> @@ -840,6 +840,9 @@ def get_repo(url, alias):
>  
>      try:
>          repo = origin.open_repository()
> +        if not repo.user_transport.listable():
> +            # this repository is not usable for us
> +            raise bzrlib.errors.NoRepositoryPresent(repo.bzrdir)
>      except bzrlib.errors.NoRepositoryPresent:
>          # branch
