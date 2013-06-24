From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v14 05/16] Refactor write_name_quoted_relative, remove unused params
Date: Mon, 24 Jun 2013 12:19:33 -0700
Message-ID: <7v8v1z8gfu.fsf@alter.siamese.dyndns.org>
References: <cover.1372087065.git.worldhello.net@gmail.com>
	<6e5f34b62ff6a7d6b379a5cabc07b849539fb08f.1372087065.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 24 21:19:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrCId-0003OH-Pp
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 21:19:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751640Ab3FXTTg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 15:19:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33693 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751129Ab3FXTTf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 15:19:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E5122B819;
	Mon, 24 Jun 2013 19:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gyZgQvhGYDy1oiFZL9kIwuiLFDw=; b=l1xWSF
	VnXF0SIwAdhy8DTI2TZj87Eop8pYL7Z7kBkqjmBmhdVPXC57Oz2bb+E9uwyjQ253
	RT4LQ1EHVmQkIQdBgbGE1LvhpF7H4oO9pSigQMMimBUCTediJGUAlRDzzW4K+LLv
	01WKVo2M+eiZciTfpKZPcPGwZx3rbaTgeT8qM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ns4yRok1ujZy84L+iweDPS1p9dCz+N9I
	HbR3hWcmykJ1uU822CIZShGy6CwJXZmPoxVlXiGkUqMmtUVkihzAcpiJfEV6LuZZ
	fIOHxnaiwgezERUz0TQLrh/aEAbhE+e/EK5nQZ6aPUE4FVYq/RPcQQqA6qAMTm7S
	4a1zfRVpJGk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 161E72B818;
	Mon, 24 Jun 2013 19:19:35 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8B22F2B817;
	Mon, 24 Jun 2013 19:19:34 +0000 (UTC)
In-Reply-To: <6e5f34b62ff6a7d6b379a5cabc07b849539fb08f.1372087065.git.worldhello.net@gmail.com>
	(Jiang Xin's message of "Mon, 24 Jun 2013 23:21:29 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0100D564-DD03-11E2-999B-9B86C9BC06FA-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228902>

Jiang Xin <worldhello.net@gmail.com> writes:

> -static void write_name(const char* name, size_t len)
> +static void write_name(const char *name)
>  {
> -	write_name_quoted_relative(name, len, prefix, prefix_len, stdout,
> -			line_terminator);
> +
> +	/* turn off prefix, if run with "--full-name" */
> +	write_name_quoted_relative(name, prefix_len ? prefix : NULL,
> +				   stdout, line_terminator);

Hmmm....

Does this mean that ls-files has been broken in 03/16, because
write_name_quoted_relative() was made to ignore prefix_len and
measure the length of prefix with strlen(prefix), and this change
fixes it?
