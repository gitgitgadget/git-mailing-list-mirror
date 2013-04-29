From: Junio C Hamano <gitster@pobox.com>
Subject: Re: consistency problem on ZFS
Date: Mon, 29 Apr 2013 11:01:54 -0700
Message-ID: <7v61z5jjvx.fsf@alter.siamese.dyndns.org>
References: <m2bo8yxyg2.fsf@jarvis.hodique.info>
	<7vk3nmpcgn.fsf@alter.siamese.dyndns.org>
	<m2haip6x1z.fsf@jarvis.hodique.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yann Hodique <yann.hodique@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 20:02:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWsOq-00040f-Mq
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 20:02:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757968Ab3D2SB6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 14:01:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34344 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752133Ab3D2SB6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 14:01:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4AFDF19A95;
	Mon, 29 Apr 2013 18:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aQyFNNaR7vZ+IrMX4C5Ec2u+s9A=; b=Y0oOlL
	uYbN2nOb1JQJfthL9i5hkDtlQrQoReR3FiIByKu/aqbKmPiZppvANTqK1ggSBapr
	dOPoqz4aC6mr8Eg84dW8ZyRwDS/ayWiXVMOMHk8Ty0bkQBuSiyBj/EEEqh7XSXEE
	MpSPz1sQQxnHpMPzSJQWHO4As24x7Ku1RMFzU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f2PLdLWvaRL7r8UPST/l3blapkGphYgU
	WKH7tiquDG+T806B6ZnSc0G971TR/sjbb30lWWGmIEg6icVt4G0SfgzmD5MlmyFU
	Sg/9Mm6UEYDLd/qH0GEtf147ZBdZici4U4H9b2EjDSK5uJ17UuEIXA4Vd4udsVwg
	UhxKQo+Bh3Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 409B119A94;
	Mon, 29 Apr 2013 18:01:57 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B501019A92;
	Mon, 29 Apr 2013 18:01:56 +0000 (UTC)
In-Reply-To: <m2haip6x1z.fsf@jarvis.hodique.info> (Yann Hodique's message of
	"Mon, 29 Apr 2013 18:55:52 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E192FD16-B0F6-11E2-A9A3-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222831>

Yann Hodique <yann.hodique@gmail.com> writes:

>>>>>> "Junio" == Junio C Hamano <gitster@pobox.com> writes:
>
>> Yann Hodique <yann.hodique@gmail.com> writes:
>>> $ git checkout next; git diff-files; git checkout next; git diff-files
>>> Already on 'next'
>>> :100644 100644 bd774cccaa14e061c3c26996567ee28f4f77ec80 0000000000000000000000000000000000000000 M	magit.el
>>> Already on 'next'
>>> $
>
>> If you run "git update-index --refresh" between the first "checkout"
>> and "diff-files", do you still see the issue?
>
> Yes, although *way* less often. I just ran a quick experiment and have
> seen the issue 2 times in 2500 tries.

Hmph, that indicates somebody other than you or your Git is mucking
with the inodes of your working tree files and perphas affecting
ctime on them (we do not pay attention to atime because dirtying
cached information due to somebody else reading from the file makes
absolutely no sense, but we do notice ctime changes).  Perhaps
background virus scanner or something silly like that?
