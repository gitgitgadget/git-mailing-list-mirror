From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/11] streaming_write_entry(): support files with holes
Date: Mon, 16 May 2011 07:39:20 -0700
Message-ID: <7v62pan207.fsf@alter.siamese.dyndns.org>
References: <1305505831-31587-1-git-send-email-gitster@pobox.com>
 <1305505831-31587-9-git-send-email-gitster@pobox.com>
 <BANLkTi=VKb44yYuXdKLxrvFCVkfsDZSb4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 16 16:39:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLyxJ-0005Ic-Jk
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 16:39:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755305Ab1EPOj3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2011 10:39:29 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49355 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751812Ab1EPOj2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2011 10:39:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 78A425C35;
	Mon, 16 May 2011 10:41:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gAtJHNcXpThW310LqW0D171UZ7g=; b=tcC+gd
	PwLjrVMvYAeVLC8WlYVyMlp28Ys7nfhTJnmeb7/ZGW4X2FL6gFF4qwbG5i8U2SP3
	3OuRWEM/Vql4Z70OtZ4HiEsXPCz3jzDmFeVjBitbtOIp1geSs24HmaIanG5UZb9+
	T5Hy6Y0ZhG7t6wJ425NgLBlGdhOeaj4yLOOJg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oIAAzDXf5BIVpZDyR/iZIxJW/p3W3KU5
	qR8ocGaCLYPY+GHzBha9H44HBhJLh4rUWDbsGb9RrvQfTThpnxHIMTTPeNAFSHWW
	n75HNVc2oV+0zHE4MQpuzRt+ZXofLC74EUG3FokqxucGZ4VYZGvn3l1xxelgbkhv
	Rq3vCWWEJzQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 50DB15C31;
	Mon, 16 May 2011 10:41:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 753E05C30; Mon, 16 May 2011
 10:41:28 -0400 (EDT)
In-Reply-To: <BANLkTi=VKb44yYuXdKLxrvFCVkfsDZSb4Q@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Mon, 16 May 2011 17:53:39 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 96DF65B6-7FCA-11E0-9C1D-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173737>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Mon, May 16, 2011 at 7:30 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> One typical use of a large binary file is to hold a sparse on-disk hash
>> table with a lot of holes. Help preserving the holes with lseek().
>
> Should that be done only with big enough holes? Random zeros may
> increase the number of syscalls unnecessarily.

I think that is a valid concern, but doesn't the code do that already?
