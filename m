From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 16/20] transport-helper: update ref status after push
 with export
Date: Tue, 21 Jun 2011 13:05:14 -0700
Message-ID: <7vpqm76jd1.fsf@alter.siamese.dyndns.org>
References: <1308496725-22329-1-git-send-email-srabbelier@gmail.com>
 <1308496725-22329-17-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 21 22:05:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZ7CM-00044P-CD
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 22:05:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756474Ab1FUUFS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 16:05:18 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61160 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751929Ab1FUUFQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 16:05:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 90AD24D67;
	Tue, 21 Jun 2011 16:07:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MF3pYXlh5hRvTMSkZqg7KFvz5Yk=; b=HRqSbY
	LcN0t0vn0Wih74PTGEslM0zm7Wyz6RfhuhGHSCxfC582RlrBgSANce+60jpZXVNJ
	kvmb0HL4z6UVfEH6BvxAzweav12JeGwkF1hRT1lX8EuMBeQEyRTeT11zuQlxOvuN
	aTzYFMPNirmBDBRF84y8rfuHJFPzbFJF8HK68=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OS9KpbB0yWlr7Nsm73kBnHoz8rwnNdG1
	GmwLDeyAGRYyqhynsZmDS2nkD11/RakfpqVO7bOWQTxhQJYowO9j63OnPdP1jFH8
	cu5/+lpVAGPaoPkru8dpXCT/MRHUo/TsxJz1u+4guMZPWsMXvDNpTALzcIGVTe9H
	5/C4PhRlKzM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 89A574D66;
	Tue, 21 Jun 2011 16:07:28 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id DE7EE4D65; Tue, 21 Jun 2011
 16:07:27 -0400 (EDT)
In-Reply-To: <1308496725-22329-17-git-send-email-srabbelier@gmail.com>
 (Sverre Rabbelier's message of "Sun, 19 Jun 2011 17:18:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 16742EEA-9C42-11E0-80DE-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176193>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> +        changed = {}
> +
> +        for name, value in refs_after.iteritems():
> +            if refs_before.get(name) == value:
> +                continue
> +
> +            changed[name] = value

This assumes that nobody will ever _remove_ refs. I think it is a sensible
assumption but somebody might want to give a power to the fast-import stream
to say "I do not want that ref anymore".

I dunno; it is not a big deal to me either way.  Just something to think
about.
