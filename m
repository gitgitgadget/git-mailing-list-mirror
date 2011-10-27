From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] pack-objects: optimize "recency order"
Date: Thu, 27 Oct 2011 15:05:48 -0700
Message-ID: <7vy5w6xf7n.fsf@alter.siamese.dyndns.org>
References: <1310084657-16790-1-git-send-email-gitster@pobox.com>
 <1310084657-16790-3-git-send-email-gitster@pobox.com>
 <CACBZZX6Ss4jLtdrDhLUNKCUjEHjHHKzfv-LMkOyTPDhRUXm4sQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 28 00:05:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJY5E-0001qs-Cc
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 00:05:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755155Ab1J0WFv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Oct 2011 18:05:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58127 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755136Ab1J0WFv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Oct 2011 18:05:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A0086189;
	Thu, 27 Oct 2011 18:05:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=oCj1n86XEJp2
	CQoaiKtbRCWw0k0=; b=WmODjZxFizDEmMkUNNjcpHRm7v1p7M5UimI5Hb7WTNC8
	tviJ/4cwf+2VVSmjadkEnVtoc/svXUPn9yo2mc+pW+lQ0evKy7j7r8YXZxq6owlH
	sWfVXA/TtDN1irLKA5WYN1jKv7FxL+aMbo7w5IItA1qJ34PqD4aLier7n6pWUCM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=t50AyA
	P3XLs6yX8y31xf8mP05SnqLbTLq+y937pQNglWj+Qsl5uW//Y2PnKZle34700ZzP
	XMbHLPtL7RqVwnqQmIwMucVfB1C/VtiuTvkL9Jm4MnJabF5BEJPyf50+fmHp+/Zu
	poHmzTIenZlc70aQ8lT7dFsZ4WBVUxhh4yu/Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 323666188;
	Thu, 27 Oct 2011 18:05:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A8A896187; Thu, 27 Oct 2011
 18:05:49 -0400 (EDT)
In-Reply-To: <CACBZZX6Ss4jLtdrDhLUNKCUjEHjHHKzfv-LMkOyTPDhRUXm4sQ@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 27 Oct
 2011 23:01:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D44C1D92-00E7-11E1-B418-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184322>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> We recently upgraded to 1.7.7 and I've traced a very large slowdown i=
n
> packing down to this commit.

Does Dan McGee's series leading to 38d4deb (pack-objects: don't travers=
e
objects unnecessarily, 2011-10-18) help?
