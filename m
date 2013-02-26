From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] config: factor out config file stack management
Date: Tue, 26 Feb 2013 14:12:23 -0800
Message-ID: <7vk3pulo6w.fsf@alter.siamese.dyndns.org>
References: <cover.1361751905.git.hvoigt@hvoigt.net>
 <6c69068b4e6a72a2cca5dc6eaffa9982032a7f2a.1361751905.git.hvoigt@hvoigt.net>
 <7v4nh13plo.fsf@alter.siamese.dyndns.org> <20130226193050.GA22756@sandbox-ub>
 <20130226193850.GB22756@sandbox-ub>
 <20130226195449.GA13830@sigill.intra.peff.net>
 <20130226200940.GF22756@sandbox-ub>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Feb 26 23:12:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UASlX-0005OI-93
	for gcvg-git-2@plane.gmane.org; Tue, 26 Feb 2013 23:12:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752828Ab3BZWM0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2013 17:12:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55536 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751644Ab3BZWMZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2013 17:12:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2FC36B8CC;
	Tue, 26 Feb 2013 17:12:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=M5Q6ceKWOflRqGaCH59WQ8I9sYw=; b=tf3LaU
	n9nATdMzF9wTuufJyBPtiLBDCiox3VtO8YS/RqPSbS7cTsKhdVq2X7u3RCWT6gyY
	sFlpJegLnI6Xw4MNOk7eWNWXHi5sgAdxGEDqQs7pMOb3ib+Rd6p4iifODN9/TVli
	eiLdStOxTdOrr4bjvec1Wa8ukVqBdnFfUBlVg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bRsm8elZXE0bm8Yyez0xR9N8bIM9Cjsi
	UkDeqcA7jf9WHbxN5L4SwsoXtOHW7ZNmGbkVvU3qaZ8bi4KGAQ1+wCNzQs120My9
	XF6Bfz+eMbUZTSs/A8o94mMTbDkdJHViAwKnb1h93fHJMj0CgDntindwHLkKQDJL
	1iDMvnNKGac=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 23EE4B8CB;
	Tue, 26 Feb 2013 17:12:25 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 92E2CB8C8; Tue, 26 Feb 2013
 17:12:24 -0500 (EST)
In-Reply-To: <20130226200940.GF22756@sandbox-ub> (Heiko Voigt's message of
 "Tue, 26 Feb 2013 21:09:41 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 994403B8-8061-11E2-97B4-F3C82E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217186>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> The "do_config_from" means "parse from whatever is in 'top'". Later in
> the series its type changes from config_file to struct config.

Yuck.  It would be nice to have it as struct config_src or
something. "struct config" sounds as if it represents the entire
configuration state and you can ask it to add new ones or enumerate
all known configuration variables, etc.
