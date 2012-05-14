From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-diff-tree does not use alternate objects for submodules
Date: Mon, 14 May 2012 11:03:20 -0700
Message-ID: <7vr4umhc7r.fsf@alter.siamese.dyndns.org>
References: <CAGHpTBLfbMU1WevW6XnY_N2BnfwPZ0_6jJDf45rCkVjWGwA9xg@mail.gmail.com>
 <7v1umuznuj.fsf@alter.siamese.dyndns.org>
 <20120509215815.GC74366@book.hvoigt.net>
 <7v1umtq9pm.fsf@alter.siamese.dyndns.org>
 <7vwr4lotjl.fsf@alter.siamese.dyndns.org>
 <20120513172301.GA58961@book.hvoigt.net>
 <7v7gweiu7b.fsf@alter.siamese.dyndns.org>
 <20120514175125.GD58058@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Orgad and Raizel Shaneh <orgads@gmail.com>, git@vger.kernel.org,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon May 14 20:03:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1STzcG-0005Vs-Ob
	for gcvg-git-2@plane.gmane.org; Mon, 14 May 2012 20:03:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757403Ab2ENSDY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 May 2012 14:03:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34495 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757033Ab2ENSDW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2012 14:03:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 67589872A;
	Mon, 14 May 2012 14:03:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UZxk5mX+aHXHBF4Qlt9BnCBgjtI=; b=fENmTO
	Nkvlxjjkss7zo5skPt/ckCsILxTZQTnLGm+ZR7t2BZh9PgIEuXK9XwViBjXM6m3O
	EkDv2dBPdyoCH/kNBVBqQl1HJ0xboquruSDp4VBsJRYdenS5MX7GZKqN0jSnEodo
	R5wRa4ZMBTwtz6VypoNDw6IRXq4kneSVbzXvk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mSou+FtJvRkivb7qdzxENerNNIdIqEgH
	PYaLWHnVHpTgGuBWNeSVT3R8mmJ5j0xukEewuWqtwFTrwZtAlq/y5QElmuAldiUk
	osfnsWqG9p/mp++HysV4GzUQORcpK2oOjvpsUhLkJZlf3AZjXyi1NeuBJg1zC1OH
	Mvx45IPz1r8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E93D8729;
	Mon, 14 May 2012 14:03:22 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D1DA28728; Mon, 14 May 2012
 14:03:21 -0400 (EDT)
In-Reply-To: <20120514175125.GD58058@book.hvoigt.net> (Heiko Voigt's message
 of "Mon, 14 May 2012 19:51:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 17BAF6D0-9DEF-11E1-ADB3-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197794>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> link_alt_odb_entry() uses realpath to combine relative entries with
> relative_base before recursively passing the entry to
> read_info_alternates().
>
> For entries with absolute path relative_base does not seem to be
> relevant.

I wasn't worried about "entries with absolute paths".  I was worried about
relative_base that the caller passes may not be absolute but relative to
something (perhaps the processe's getcwd()); it seems that the call to
real_path() to turn it into an absolute one at the very beginning of the
link_alt_odb_entry() function does indeed take care of that case.

Thanks.
