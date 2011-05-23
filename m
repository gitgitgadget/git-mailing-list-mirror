From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 04/10] receive-pack: Prepare for addition of the new
 'limit-*' family of capabilities
Date: Mon, 23 May 2011 13:21:49 -0700
Message-ID: <7v8vtxt3yf.fsf@alter.siamese.dyndns.org>
References: <1306111923-16859-1-git-send-email-johan@herland.net>
 <1306111923-16859-5-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue May 24 01:03:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOe9v-0004N5-Se
	for gcvg-git-2@lo.gmane.org; Tue, 24 May 2011 01:03:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757809Ab1EWXDb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2011 19:03:31 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46007 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757760Ab1EWXDa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2011 19:03:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 324014AB3;
	Mon, 23 May 2011 19:05:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=Cn8G3JKUVOLPI774lMQJTTyGH88=; b=sdzlOAai+44p5omy+KO1
	QgQ+/ubAJ9MyMbL/NbVW0aTVzxzrRbQsl+luP2I2SHvlsCiXO9LCrr8gNyVwZ1iY
	fPuNAg3LYCrQxoQYwyZi2Mf0uP8+t4baBSD05lEaBHS4iXAgNi1HcVRUTUL1O038
	OV7eIyBXRJB0BNtTcBsarSw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=glrIwtNkNkx2CxX4uoWcC7U2bmeCmKhGWI8DRS3me6fmAJ
	pd7VLTvJzR9SklS81Hr3UstU/Mvrv0Nht3o1fdJY9zuUcdjFcgLUT/k506/XNHhS
	bZg6rFYjm06zpB8RNpg6c04PwuGY2WU0LVkTrMOy6QP0ysMgalBzHd3WgYHg8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F2BBC4AAE;
	Mon, 23 May 2011 19:05:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4FEDD4AAA; Mon, 23 May 2011
 19:05:30 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2A64FB86-8591-11E0-A41F-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174289>

Johan Herland <johan@herland.net> writes:

> This adds some technical documentation on the 'limit-*' family of
> capabilities that will be added in the following commits.
>
> Also refactor the generation of the capabilities declaration in receive-pack.
> This will also be further expanded in the following commits.
>
> Signed-off-by: Johan Herland <johan@herland.net>
> ---
> ...
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index e1ba4dc..c55989d 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -106,15 +106,23 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
>  	return git_default_config(var, value, cb);
>  }
>  
> +static const char *capabilities()

static const char *capabilities(void)
