From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] fast-import: treat SIGUSR1 as a request to access
 objects early
Date: Wed, 24 Nov 2010 12:28:22 -0800
Message-ID: <7vpqtusbyx.fsf@alter.siamese.dyndns.org>
References: <20101122081601.GA9722@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Barr <david.barr@cordelta.com>,
	Raja R Harinath <harinath@hurrynot.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Tomas Carnecky <tom@dbservice.com>,
	Gabriel Filion <lelutin@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 24 21:28:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLLxQ-00028I-R3
	for gcvg-git-2@lo.gmane.org; Wed, 24 Nov 2010 21:28:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756505Ab0KXU2m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Nov 2010 15:28:42 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60451 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756449Ab0KXU2m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Nov 2010 15:28:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CE0422B01;
	Wed, 24 Nov 2010 15:28:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6oP7Ebd3jCUM0I0t2Ugsn2VaZO0=; b=t9dq+d
	GlypeaZ4vDbFjyVfV1a59T9AccaEKXDlr9cxKvOe7dsWwLYBbnHzrEcgvhSH6b3r
	JPYr5txfEqxvBiBQX1plTHT36PdBtc+ibeQT6+ytKkhhiBhE9GJ4C0KFQVvOjk9k
	SZk9SV48RpoLW5cLjqpGKWMBdEUs+3u618Vqo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Vca9nzsvcDOL8PozzxgQstjoE+7qfLQC
	dt1l+F+U65iGvEXLgywPBC0bKBL9qxOL0eKZgVIB7ModTLPoxem+lhNi6wil/zY+
	y/ZlbqO9gNCcHzgSBQrChF28UNgH8teJydPK3OIXYQAK9tKESfg1ACB632Dp+1t6
	OlULPpP1usc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 59E742B00;
	Wed, 24 Nov 2010 15:28:47 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4CB0E2AFF; Wed, 24 Nov 2010
 15:28:38 -0500 (EST)
In-Reply-To: <20101122081601.GA9722@burratino> (Jonathan Nieder's message of
 "Mon\, 22 Nov 2010 02\:16\:02 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 70AD7368-F809-11DF-8483-DF8536391E49-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162082>

Jonathan Nieder <jrnieder@gmail.com> writes:

> +static void parse_checkpoint(void)
> +{
> +	do_checkpoint();
>  	skip_optional_lf();
>  }

I would have expected the new implementation of parse_checkpoint() to just
set the checkpoint_requested variable to true, so that the checkpoint
always happens in the main loop, which somehow feels cleaner.  But that is
a minor point.
