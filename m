From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] status: really ignore config with --porcelain
Date: Mon, 24 Jun 2013 10:16:28 -0700
Message-ID: <7v1u7rbf9v.fsf@alter.siamese.dyndns.org>
References: <1372077912-18625-1-git-send-email-artagnon@gmail.com>
	<1372077912-18625-2-git-send-email-artagnon@gmail.com>
	<vpqhagnwraj.fsf@anie.imag.fr>
	<CALkWK0=F_i95S+53eZmOAJtA+jG=jvi5-sDc3BgW3rNQo=n3Ng@mail.gmail.com>
	<vpqhagnv9xq.fsf@anie.imag.fr>
	<7vk3ljbh5r.fsf@alter.siamese.dyndns.org>
	<vpq7ghjtpv1.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 24 19:16:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrANd-0004CJ-QG
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 19:16:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179Ab3FXRQi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 13:16:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43322 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751129Ab3FXRQh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 13:16:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C2C5D2B4A3;
	Mon, 24 Jun 2013 17:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aVgowi4AUoNk8pHeuJgMxZsti8U=; b=L6nDxp
	JVsJNzO7dW/xzQXiRJty73/TrQzp2pYGnar0wjVrKVxodnmbEkXGm5+0jQ+7hlo8
	JJMBrWOF61dftdqAKLYfjnM3a/SEdSpfhupLe94JkmwscP5xnCRzzlkDK/gk155i
	+1cAyvBn5az4SJsUlmkCCGaUYRH5+qCO5jRHg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uzDRHM4E9cbqn6bJsyLIokY9x3BcPqxC
	T5zT4eU2bl1tkInryxiX7VZknYFsBC/Paaj32z6cGr6Aw8pOC2vgz4ZJ6GJX4Op1
	NumlEDKu/Il5ksqOtIwUailyBJD/5sCIPLQ8c7XDt+v/26tlFbzd5O1+8sYdvMzG
	IpDJrRD8aSo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B720A2B4A1;
	Mon, 24 Jun 2013 17:16:36 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 159C72B49D;
	Mon, 24 Jun 2013 17:16:35 +0000 (UTC)
In-Reply-To: <vpq7ghjtpv1.fsf@anie.imag.fr> (Matthieu Moy's message of "Mon,
	24 Jun 2013 18:50:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D312D00A-DCF1-11E2-BC4F-9B86C9BC06FA-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228878>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Scripts that want the branch information can use --branch.
> Scripts that do not have absolutely nothing to gain in getting this
> extra output (only extra parser complexity).

OK, I could buy that.

I personally have always _assumed_ that the way the "--porcelain"
output was meant to evolve was to make sure scripts are robust to
ignore what it does not care about, so that we allow people to add
more types of information without breaking the syntax, but script
writers have been assuming otherwise and there is no clearly written
rule in the documentation, so it is too late to enforce it now.

That means after we add more and more other options like --branch
that enrich the output in several years, scripts that want to use
the enriched data need to pass tons of options to get what they
want, which is not very nice, but at least it won't break the status
quo, and "ask for only what you use" is a good principle for scripts
anyway.

Thanks for a sanity check.
