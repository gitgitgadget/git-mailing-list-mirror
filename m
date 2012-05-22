From: Junio C Hamano <gitster@pobox.com>
Subject: Re: contrib/credential/osxkeychain: Makefile should allow to set
 CFLAGS
Date: Tue, 22 May 2012 14:00:05 -0700
Message-ID: <7vtxz82ap6.fsf@alter.siamese.dyndns.org>
References: <AB628C35-FEC2-4425-B3D8-EEC7F8D6A66B@samueljohn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Samuel John <mail@samueljohn.de>
X-From: git-owner@vger.kernel.org Tue May 22 23:00:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWwBs-0008HK-Oc
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 23:00:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753642Ab2EVVAS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 May 2012 17:00:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35055 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752680Ab2EVVAQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 17:00:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 30D859072;
	Tue, 22 May 2012 17:00:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=roFKFK83EOmFnoKSjoCgSLa1/qc=; b=PG+bDp
	ejpFGFkhykMIKlnxw76EYpovnn5KicWZb/zzhkemuv+/VfqtsUhlZGhOEa+MdtSX
	ENhRoIpx4qb+LWuW8RjBElF7gnLlUKVS3PJfVRWWV0pcYjkvBBUTQqtWN/9WkV9q
	MeJBVShoDCyG5D4KT3Zm+BJ1e5r1v9QcKwp/s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oLaV1pjZ6TUtwf1rGsnp8fuG2Y/+Y9Ul
	p4EJNnF2TyZuLkjaKPcOC0hYpn4kaPAIPONYbeI4dtIA2DC+zmoUXyh3Z37XjEXp
	0WRdi/6hFpwVJKTjbLdseUuMEyLzVG4CV125HsVCDZrbdN5/Jwig8OkKQlFBmqZl
	AUqQo2l6ZhU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26FF69070;
	Tue, 22 May 2012 17:00:16 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7EBE3905E; Tue, 22 May 2012
 17:00:09 -0400 (EDT)
In-Reply-To: <AB628C35-FEC2-4425-B3D8-EEC7F8D6A66B@samueljohn.de> (Samuel
 John's message of "Tue, 22 May 2012 22:25:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1DC6104C-A451-11E1-A193-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198253>

Samuel John <mail@samueljohn.de> writes:

> Hi there,
>
> the contrib/credential/osxkeychain/Makefile goes like this
>
>> CC = gcc
>> RM = rm -f
>> CFLAGS = -g -Wall
>> 
>> git-credential-osxkeychain: git-credential-osxkeychain.o
>> 	$(CC) -o $@ $< -Wl,-framework -Wl,Security
>
> and does not allow me to pass CFLAGS to build git-credential-osxkeychain.o.
> My hack is to call: make CC="$CC $CFLAGS"
> That is ugly.

Yeah, that is ugly.

It however seems to me that git-credential-osxkeychain.o does honor
$(CFLAGS), either from the user "make CFLAGS=..." or the default the
Makefile in question supplies.

The line you quoted is not using $(CC) as the compiler, but is using it to
link the final build product.  It may not hurt to have $(CFLAGS) on that
line, but shouldn't the line also have $(LDFLAGS) on it?
