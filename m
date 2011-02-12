From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] string_list_append: always set util pointer to NULL
Date: Fri, 11 Feb 2011 23:43:50 -0800
Message-ID: <7v4o89zoi1.fsf@alter.siamese.dyndns.org>
References: <20110212051850.GA715@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 12 08:44:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PoA9C-0001t4-N1
	for gcvg-git-2@lo.gmane.org; Sat, 12 Feb 2011 08:44:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751720Ab1BLHn6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Feb 2011 02:43:58 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45824 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499Ab1BLHn5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Feb 2011 02:43:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C69CC2563;
	Sat, 12 Feb 2011 02:44:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZK56cL2wQ4pLTFKMu3xTnW9cohU=; b=rRyT5s
	/zug2iFY6CLDFJ5agSZ8GWloU11ItFbKwl6i3soBjj2aD+ZOzVBgLQuqWgnXhYYi
	Ytd4ePE1RinoKp2n36d8rJGFBgNQ8RhyTaEaqi/8Nu/BkYBpo2O05YRnkNvhA/1F
	lyxHx5kilDoP6C9R9pqRtvhg4g600Cw6zDHbs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DO9XvHa2NO68k5oOX8Wb9LNg7fBwu8S6
	XSP6sI/KMZBHuR7G3pPl00VJEZpP7Bti0YnkCuUovZSrHa3fxAf9Q0225d+RYGaB
	p3iGxrQWeTYYtJoy2YbMuFd1F4KEGYkZjhnUHoyzznjAJXjNrFWmmnpkGSv5Xkhs
	sxk0Dxtkop0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A4B2E255F;
	Sat, 12 Feb 2011 02:44:57 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D12BF255D; Sat, 12 Feb 2011
 02:44:54 -0500 (EST)
In-Reply-To: <20110212051850.GA715@sigill.intra.peff.net> (Jeff King's
 message of "Sat\, 12 Feb 2011 00\:18\:51 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FD1A541E-367B-11E0-85A5-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166597>

Jeff King <peff@peff.net> writes:

> It is not immediately obvious that the util field may
> contain random bytes after appending an item. Especially
> since the string_list_insert* functions _do_ explicitly zero
> the util pointer.
>
> This does not appear to be a bug in any current git code, as
> all callers either fill in the util field immediately or
> never use it. However, it is worth it to be less surprising
> to new users of the string-list API who may expect it to be
> intialized to NULL.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This bit me in some new code I was writing. I consider it a bug fix, but ...

Of course; the "Especially since" part is very convincing.
