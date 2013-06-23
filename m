From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] remote: Add warnings about mixin --mirror and other remotes
Date: Sun, 23 Jun 2013 14:22:00 -0700
Message-ID: <7vvc54ed53.fsf@alter.siamese.dyndns.org>
References: <1371809051-29988-1-git-send-email-dennis@kaarsemaker.net>
	<1371809051-29988-2-git-send-email-dennis@kaarsemaker.net>
	<7v8v23mhjy.fsf@alter.siamese.dyndns.org>
	<1371994516.24315.8.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Sun Jun 23 23:22:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uqrjd-00037D-52
	for gcvg-git-2@plane.gmane.org; Sun, 23 Jun 2013 23:22:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267Ab3FWVWE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Jun 2013 17:22:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51799 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751125Ab3FWVWD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Jun 2013 17:22:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CE2962A9D3;
	Sun, 23 Jun 2013 21:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ra45flFcxnLydBTx+oK2HxAOWN0=; b=Mf3Jwt
	RznQHXPaOatJQCnOZGK2hgXUHnwgTWgG2F5GQnHY3Hk2TDnAg/gIhqy7mlA9flmT
	SSZguwKp0FjxgTTwo6Y5QrDdWCsbra8ayuYBBG/1GWCvT86sWNo81ibObHkQireb
	ImngxJsE0mS0Lw9EDOCKLrp4mGm8o42w6LVnk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cdvmSVXCifkO3U1FLfsSfDdLljQN8zF4
	h46HpEILCv/hgRjfdqTUbpfeBbXRtvjCsSmcVIIUpsxMIR9a6XQM09XHNWdUh2UA
	k0xtgT7p8ljGuh4tVR3fuddjX6JNLol2epqeqnob3hZkU11UMKaDcillhs7m0V/N
	+R4QK8C5nuA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C508C2A9D2;
	Sun, 23 Jun 2013 21:22:02 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 44E592A9D0;
	Sun, 23 Jun 2013 21:22:02 +0000 (UTC)
In-Reply-To: <1371994516.24315.8.camel@localhost> (Dennis Kaarsemaker's
	message of "Sun, 23 Jun 2013 15:35:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F227A936-DC4A-11E2-96EB-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228761>

Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:

> Equality for
> wildcards is allowed and tested for, so do we really want to 'outlaw'
> equality of non-wildcard refspecs?

I am not sure what you mean by "equality for wildcards is allowed".
Do you mean this pair of remote definition is sane and not warned?

	[remote "one"]
        	fetch = refs/heads/*:refs/remotes/mixed/*

	[remote "two"]
        	fetch = refs/heads/*:refs/remotes/mixed/*

For non-wildcard ones, I think these pairs are both suspects for
possible clashes and want to be warned.

(1) literal-vs-literal

	[remote "one"]
        	fetch = refs/heads/master:refs/heads/origin

	[remote "two"]
        	fetch = refs/heads/master:refs/heads/origin

(2) literal-vs-wildcard

	[remote "one"]
        	fetch = refs/heads/*:refs/remotes/origin/*

	[remote "two"]
        	fetch = refs/heads/master:refs/remotes/origin/master
