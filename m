From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 7/7] grep: honor --textconv for the case rev:path
Date: Fri, 10 May 2013 11:11:06 -0700
Message-ID: <7v7gj61z9h.fsf@alter.siamese.dyndns.org>
References: <7vy5c1l6nb.fsf@alter.siamese.dyndns.org>
	<cover.1368197380.git.git@drmicha.warpmail.net>
	<dd973eae534bed5f7106d54e06c7c2172595f402.1368197380.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri May 10 20:11:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uarmk-0002Vg-UP
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 20:11:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752488Ab3EJSLL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 14:11:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57008 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751271Ab3EJSLJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 14:11:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D14BD1DDBF;
	Fri, 10 May 2013 18:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WFzuxXSrVG11Z4HI2epkYhyFvv0=; b=el5CUp
	2bgUcOdsxCaOgpPflA0oWgA4BpEA/cmTEXgcXErTcObQgKFBcXtMZ4w3wRuPjj0N
	sd74W/gXZ8kRzKx9fYi6fOKmqpz6OI1lLKrJTzKnzrvXuO0pE0dR4oAjrkjvcl94
	BUGe+KgiejfB/8+ms1XVilJpc4uaO2so3hN+E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r4r6uQ6rTEpZiQIWspmHzyVTKZGk2Cr2
	sKcazObOB0wizpwcjMbjxvVPePdBRdt8REdiLewUr8ueZf+/sjWpgNpJDXi7QVEQ
	biEnAiEWwxahxja/FAT9HahAJJj75kd5lsYZJu+F4hhdE+3ivbewfev11G+KObjF
	8cJq3GaC2vs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C7CD61DDBE;
	Fri, 10 May 2013 18:11:08 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2C3891DDB8;
	Fri, 10 May 2013 18:11:08 +0000 (UTC)
In-Reply-To: <dd973eae534bed5f7106d54e06c7c2172595f402.1368197380.git.git@drmicha.warpmail.net>
	(Michael J. Gruber's message of "Fri, 10 May 2013 17:10:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FCCD5FFA-B99C-11E2-B55C-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223889>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> diff --git a/object.h b/object.h
> index 97d384b..695847d 100644
> --- a/object.h
> +++ b/object.h
> @@ -13,6 +13,7 @@ struct object_array {
>  		struct object *item;
>  		const char *name;
>  		unsigned mode;
> +		struct object_context *context;
>  	} *objects;
>  };

fsck has to hold this for each and every objects in the repository
it has found but hasn't inspected (i.e. pending), doesn't it? Do we
really want to add 8 bytes for each of them?
