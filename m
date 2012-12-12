From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] submodule: add 'deinit' command
Date: Wed, 12 Dec 2012 15:35:59 -0800
Message-ID: <7vsj7a268w.fsf@alter.siamese.dyndns.org>
References: <50BA3412.60309@web.de> <7vy5hhmcwp.fsf@alter.siamese.dyndns.org>
 <50BBB22A.7050901@web.de> <7vhao31s9e.fsf@alter.siamese.dyndns.org>
 <50BE6FB9.70301@web.de> <50C89DF3.20303@drmicha.warpmail.net>
 <50C8BD6B.9010702@web.de> <7vr4mv3w2x.fsf@alter.siamese.dyndns.org>
 <50C90469.8080303@web.de> <7vlid23nnc.fsf@alter.siamese.dyndns.org>
 <20121212230926.GC7729@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Phil Hord <phil.hord@gmail.com>, Git <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>, Jeff King <peff@peff.net>,
	Shawn Pearce <spearce@spearce.org>,
	Nahor <nahor.j+gmane@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Thu Dec 13 00:36:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tivqf-0000g8-Mn
	for gcvg-git-2@plane.gmane.org; Thu, 13 Dec 2012 00:36:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754876Ab2LLXgE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 18:36:04 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47559 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754724Ab2LLXgC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 18:36:02 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B26CAE73;
	Wed, 12 Dec 2012 18:36:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EtnqDrMhLSYR7RH87ousS+KvPBs=; b=uFHJBQ
	Zt9fO3QdseiQLVkL8pEaWDZG9Bu0rGYpsc4wJldXmwXt4sJUhJpVXhKoX+fUkf4m
	/l69PbeehN2NkDkcU87VThB4qel+rawEPK8OYbvZqDGqVS/09tdN1Ylos9s0C9Go
	LuKxhFvT9wBmQ0GycrdHIfKaVAGW3rC+ltoTU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TkUXoHnpuehOHKGmzjCXBvSumxu1D1/o
	Qd9UrMeDXnt3fepYYMy2B5PcuPX63NmeIOk7NK1fIfa7Bj83mzrcrn2iWZjP52v3
	qMpCmcQgkr7fLiT0p3eBG4NhVxssztb/Fm7qo5GGXbZ1wKbdOdfVRKhNic04urJT
	HPorswI18Z0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 68396AE72;
	Wed, 12 Dec 2012 18:36:01 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AB5B7AE70; Wed, 12 Dec 2012
 18:36:00 -0500 (EST)
In-Reply-To: <20121212230926.GC7729@odin.tremily.us> (W. Trevor King's
 message of "Wed, 12 Dec 2012 18:09:26 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AFC44078-44B4-11E2-9A35-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211419>

"W. Trevor King" <wking@tremily.us> writes:

> Should `deinit` remove the submodule checkout, replace it with the
> original gitlink, and clear the .git/config information then?  That
> would restore the user to the state they'd be in if they were never
> interested in the submodule.

AFAIU, "restore the user to the state" is the goal.  I am not sure
what you meant by "replace it with the original gitlink", though.  A
checkout with a submodule that the user is not interested in would
have an empty directory at that path, no?
