From: Junio C Hamano <gitster@pobox.com>
Subject: Re: push race
Date: Tue, 16 Oct 2012 10:21:02 -0700
Message-ID: <7vtxtus58h.fsf@alter.siamese.dyndns.org>
References: <CAB9Jk9Be4gGaBXixWN7Xju7N6RGKH+FonhaTbZFJ6uYsJDk8dg@mail.gmail.com>
 <CACBZZX5keWVDZ-rvQfHFChKRC1YwXcUvfiqzgeMjVTydnQCdmg@mail.gmail.com>
 <507C1DB4.2010000@xiplink.com> <20121015185608.GC31658@sigill.intra.peff.net>
 <CAJo=hJu=eqgUhJvvpMLJ05AT6o+nVUDcm+tHV8en8OCX2-2qgA@mail.gmail.com>
 <20121016045118.GA21359@sigill.intra.peff.net>
 <CACsJy8AJVAoUHft6+rdOjWCpLWWj3m0NgvFd9pToQRQ5uD8_gg@mail.gmail.com>
 <20121016053750.GA22281@sigill.intra.peff.net>
 <CACsJy8D14sv5=+5zfiwgYCb7OoEqvQoVQ0ObAeWtUUSjRAgBeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	marcnarc@xiplink.com,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Angelo Borsotti <angelo.borsotti@gmail.com>,
	git <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 16 19:21:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOApS-00006p-M4
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 19:21:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754741Ab2JPRVI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 13:21:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41682 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753976Ab2JPRVF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2012 13:21:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0B17A933F;
	Tue, 16 Oct 2012 13:21:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=htX00FsKUbTEtGVmFZgqi8QF2lU=; b=yNCuiB
	TaPrP7zefrJFjJAQB42sHNm0YjhCjdas31nH62CZjdZlD1m+yFUfRQHsoHnGrtW2
	eMuzM5ojwgkUGu85Gy0iVQJqmH3RTB7yyLL1H4h5qP4viHHbRBHLgYILL0uXVMlk
	av++laG4UxwvHW/W82dXLOMQi7hxin1DG+H7M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QSDguISt7W6fH/RFQJyWx6dJ5jtW0pAG
	ytqDaXTtNnOSFxkDP1SQeC0j8vwxKIIkyZ3ze5JyWh7x/ZNP0SQmAshoIuML3vie
	JREGQGdhB+sN6o12b+AKSqV58gmeYcWa2Q99kuSAH8sE8QRHVwai49Qnxdtdm149
	3//yeLsYIXU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ECBDD933E;
	Tue, 16 Oct 2012 13:21:04 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 65B7D9339; Tue, 16 Oct 2012
 13:21:04 -0400 (EDT)
In-Reply-To: <CACsJy8D14sv5=+5zfiwgYCb7OoEqvQoVQ0ObAeWtUUSjRAgBeQ@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Tue, 16 Oct 2012 17:45:12 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DD56E166-17B5-11E2-A5B5-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207851>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Tue, Oct 16, 2012 at 12:37 PM, Jeff King <peff@peff.net> wrote:
>> I suspect a site that is heavy on alternates is invoking the index-pack
>> code path more frequently than necessary (e.g., history gets pushed to
>> one forked repo, then when it goes to the next one, we may not share the
>> ref that tells the client we already have the object and receive it a
>> second time).
>
> I suppose we could do the way unpack-objects does: prefer present
> objects and drop the new identical ones, no memcmp. Objects that are
> not bases, or are ref-delta bases, can be safely dropped. ofs-delta
> bases may lead to rewriting the pack. Do-able but not sure it's worth
> the effort.

Until you read all the incoming pack data, you won't know what
objects are used as bases for others, so unless you are keeping
everything in core, you would have to spool the incoming data to a
file and then rewrite the final pack file to "drop" these "can be
safely dropped" objects, with or without offset delta encoding.
