From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/3] diff: Let "git diff -O" read orderfile from any file, fail properly
Date: Tue, 17 Dec 2013 14:09:19 -0800
Message-ID: <xmqq4n67m8og.fsf@gitster.dls.corp.google.com>
References: <1387224586-10169-1-git-send-email-naesten@gmail.com>
	<1387224586-10169-3-git-send-email-naesten@gmail.com>
	<xmqqwqj4mqhe.fsf@gitster.dls.corp.google.com>
	<CAJYzjmd_EWcQ5OzuZBQwhkfAtdxbPbvhVxUSsh98SzMzyz=-8w@mail.gmail.com>
	<xmqqsitrmkhe.fsf@gitster.dls.corp.google.com>
	<CALWbr2zXNF-aJHHnBnW1q1yaCmWt-rmMWypBWFanTBAK1pMWiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Samuel Bronson <naesten@gmail.com>, git <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Anders Waldenborg <anders@0x63.nu>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 17 23:09:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vt2pV-0002wJ-N4
	for gcvg-git-2@plane.gmane.org; Tue, 17 Dec 2013 23:09:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752089Ab3LQWJZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Dec 2013 17:09:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58190 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751963Ab3LQWJY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Dec 2013 17:09:24 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 747FB5C526;
	Tue, 17 Dec 2013 17:09:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YUhFSgL443Z5tXmqpFpDU9eTAqY=; b=c90XyG
	BKDdy79pC8yUb92EJjkS8jjE7GHPlrK6IA7CzjYitnLpU+ptodSyQoTyRf3gAgEo
	7uPVm9w1Uim4CxdD4pEYDjmyvkzCJkU0ZPSzXplmjjfZgc5amEjVSW6q7NF8FHtb
	fmkjbLu3HrnreDNBRU/WNXCNB8Do/2jb5ot4I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F1+W/7fiW1j+9U2VvsyKlVBy99ME4QPd
	XXt7HZ+e9KnO4BVVc7oC6b2vsczPCy/m3NI8Jh1F8YsHrK6MIdMZPi5kUEw3tFBE
	PuL5l5RXkSrw6nqiEMBtIcD+gCiZ5wr89ooFgn9+lYRipGHV1zjKKh0SEJDbECS+
	UbAz5GVLhu4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 53CB35C525;
	Tue, 17 Dec 2013 17:09:23 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2417E5C524;
	Tue, 17 Dec 2013 17:09:21 -0500 (EST)
In-Reply-To: <CALWbr2zXNF-aJHHnBnW1q1yaCmWt-rmMWypBWFanTBAK1pMWiQ@mail.gmail.com>
	(Antoine Pelisse's message of "Tue, 17 Dec 2013 21:37:26 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E1F6E984-6767-11E3-ADD0-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239406>

Antoine Pelisse <apelisse@gmail.com> writes:

>> How about not doing a fifo?
>
> That would certainly defeat the purpose of the test, which is to test
> against a fifo :-)

My point was that I did not see much value in reading the orderfile
data from anything but a file.  At that point, you are not testing
the "diff -O" orderfile option, but if strbuf_readline() reads from
a non-regular file.
