From: Junio C Hamano <gitster@pobox.com>
Subject: Re: push race
Date: Tue, 16 Oct 2012 12:09:53 -0700
Message-ID: <7vhapus072.fsf@alter.siamese.dyndns.org>
References: <CAB9Jk9Be4gGaBXixWN7Xju7N6RGKH+FonhaTbZFJ6uYsJDk8dg@mail.gmail.com>
 <CACBZZX5keWVDZ-rvQfHFChKRC1YwXcUvfiqzgeMjVTydnQCdmg@mail.gmail.com>
 <507C1DB4.2010000@xiplink.com> <20121015185608.GC31658@sigill.intra.peff.net>
 <CAJo=hJu=eqgUhJvvpMLJ05AT6o+nVUDcm+tHV8en8OCX2-2qgA@mail.gmail.com>
 <20121016045118.GA21359@sigill.intra.peff.net>
 <CACsJy8AJVAoUHft6+rdOjWCpLWWj3m0NgvFd9pToQRQ5uD8_gg@mail.gmail.com>
 <20121016053750.GA22281@sigill.intra.peff.net>
 <CACsJy8D14sv5=+5zfiwgYCb7OoEqvQoVQ0ObAeWtUUSjRAgBeQ@mail.gmail.com>
 <7vtxtus58h.fsf@alter.siamese.dyndns.org>
 <20121016172502.GC27243@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Shawn Pearce <spearce@spearce.org>, marcnarc@xiplink.com,
	=?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= 
	<avarab@gmail.com>, Angelo Borsotti <angelo.borsotti@gmail.com>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 16 21:10:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOCWn-00062n-0U
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 21:10:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752381Ab2JPTJ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 15:09:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57185 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751491Ab2JPTJ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2012 15:09:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB7D6862A;
	Tue, 16 Oct 2012 15:09:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=k+RU/pa4fAXsQssErsB0JIfAyoc=; b=pttaD+
	0ZHtzawTAb7UWgDMs1jWf0Xtv0mXhwm/JzvjCMFEcxcA4F4UR/Ve7Uk4qjtIkMVU
	A5fIHc46S1vZZSgar1bgk2XoUv8d0+KbN2Z6BSn/LbyvbGzU+wXKwOKkAVigZpIy
	CsE16amqWPv7wiCqdzPILP/QlMkrFsPno/32U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Lxq4KeiNSznbRj2vqmrTeyU6ijq2e5T7
	2lmey5ka7RXidOfSNZO8Cj3qv0SI6MKhaCw8RFQl8b6JEh+5BOrbEh9DmBuHsCse
	UHX73Gin8UcnJLzffjjkJvQShSRQnsBPjQNBnI4MBd/mrQo2bWGR0z6XzA10m2IB
	UB1s6DyVMEo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D7B998629;
	Tue, 16 Oct 2012 15:09:55 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 297418621; Tue, 16 Oct 2012
 15:09:55 -0400 (EDT)
In-Reply-To: <20121016172502.GC27243@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 16 Oct 2012 13:25:02 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 11F4EA30-17C5-11E2-A470-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207871>

Jeff King <peff@peff.net> writes:

> But still...the complexity is ugly, and we do not even have a measured
> problem in the real world. This is not worth thinking about. :)

Yup.
