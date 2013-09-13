From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-compat-util: Avoid strcasecmp() being inlined
Date: Fri, 13 Sep 2013 15:35:09 -0700
Message-ID: <xmqqtxhogxk2.fsf@gitster.dls.corp.google.com>
References: <523094F0.9000509@gmail.com> <20130911182921.GE4326@google.com>
	<CAHGBnuN0pSmX7_mM6xpRqpF4qPVbP7oBK416NrTVM7tu=DZTjg@mail.gmail.com>
	<20130911214116.GA12235@sigill.intra.peff.net>
	<CAHGBnuP3iX9pqm5kK9_WjAXr5moDuJ1jxtUkXwKEt2jjLTcLkQ@mail.gmail.com>
	<20130912101419.GY2582@serenity.lan>
	<xmqq61u6qcez.fsf@gitster.dls.corp.google.com>
	<20130912182057.GB32069@sigill.intra.peff.net>
	<CAHGBnuPzzokV7YMrx0gAL1VACcmaLwFoaB3n6bX8Y-UDHs7S8A@mail.gmail.com>
	<20130912202246.GF32069@sigill.intra.peff.net>
	<xmqqr4ctokat.fsf@gitster.dls.corp.google.com>
	<CAHGBnuOQ-y1beD_X_jiH+FrhPvLOVJqT0J=Wk988Q4NeCs1-9Q@mail.gmail.com>
	<xmqqppsckcsd.fsf@gitster.dls.corp.google.com>
	<CAHGBnuMNDJhAqNfgVRHRE-7R=UZbd+fMExYeKDWWCFjyQJYYTQ@mail.gmail.com>
	<xmqqppscij8a.fsf@gitster.dls.corp.google.com>
	<CAHGBnuM=QqLxPNNZmoL1jG+oAm2y6o=AuBtkH+FRwZ_8ahGC+w@mail.gmail.com>
	<xmqqli30idfx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, John Keeping <john@keeping.me.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 14 00:35:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKbxQ-0002xW-5s
	for gcvg-git-2@plane.gmane.org; Sat, 14 Sep 2013 00:35:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755514Ab3IMWfO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Sep 2013 18:35:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59178 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754924Ab3IMWfM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Sep 2013 18:35:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 370CE41D80;
	Fri, 13 Sep 2013 22:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mvfEJ+p+MJvOBK/WN2zL8BGO8EE=; b=xEJxVI
	/sDEJ9PDwekT+xuzHV6Ze6zIocdU8O2cmso5r6Wp4ggMu/c9g4bhnxhUKZ1N5w+Y
	5VWHD/THph68omMs3FwB5zew4TTQdsbsYIBN7tMd70/LzX0B1HSQrKO0yj6929WX
	QX4qMuQQeJzNnv8o/5V31WKuXaazAwrixkHFg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dUYLk9OteSXOxv0XMqUeiawgFtib1VP5
	fteGbxXfmepHzv6ZzmN97F1srMrKGiXBqrAjnVOO6pfM0hc3xIB+X/9JRwnj5WVv
	BR44iDl+257uBGEFZbhtvKSgxG+nuymOvum2VmLwBGtQuuhh1kXX1YnZSeJtVM2a
	dir1WF0eyTE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2901241D7D;
	Fri, 13 Sep 2013 22:35:12 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 809AE41D76;
	Fri, 13 Sep 2013 22:35:11 +0000 (UTC)
In-Reply-To: <xmqqli30idfx.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 13 Sep 2013 15:06:42 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C0391936-1CC4-11E3-9E83-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234784>

Junio C Hamano <gitster@pobox.com> writes:

> You can explicitly include the system header from your compatibility
> layer, i.e. 
> ...
> and then in config.mak.uname, do something like this:
> ...
> 	COMPAT_CFLAGS += -DSYSTEM_STRING_H_HEADER=$(SYSTEM_STRING_H_HEADER)

You need to have one level of quoting to keep "" from being eaten;
it should be sufficient to see how SHA1_HEADER that is included in
cache.h is handled and imitate it.
