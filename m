From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-compat-util: Avoid strcasecmp() being inlined
Date: Tue, 17 Sep 2013 09:17:35 -0700
Message-ID: <xmqqhadj1kyo.fsf@gitster.dls.corp.google.com>
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
	<CAHGBnuOfYoosgWQdfF+L3=YCqO-MYEx-TpNzBAD-Zt0kqeR_Hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, John Keeping <john@keeping.me.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 17 18:17:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLxyA-0001cX-P2
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 18:17:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752914Ab3IQQRj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 12:17:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50652 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752815Ab3IQQRi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 12:17:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F82740028;
	Tue, 17 Sep 2013 16:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qS6xVH3zn19g5C98KHjvl5yk7LE=; b=vGtKzK
	TRcrl8i6BHIJpHuAFjfvDdVOV4O1Ii43b2vbXFjeByugBiR38llBr64nhsTDR03d
	V2hhrCDon3+UrMcyGg0m/pQLjFVHkjfFFZSXBqJk8YJuZnc/TXcRU3N3VVPZ11N3
	DDftSx1vug59s/a63Tc7cUqg1xvSoDvlLqgs4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LhSSOXS7rDZgmusxxAxSmZNgq08EjNMN
	g1UjpyXw2+P3cMj1ye7hlBOEU0pyIXsfSDIYNUfEk41Grx7FqyixCR6NmCXU0gu5
	wXaXxsFWBOeIMQQck1btl/hG3q/kUMAUyKcFBpxJ6sl8Pjm1rrmTAyjBNqFYBvl8
	kyFDkxLr4cI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E7BA240027;
	Tue, 17 Sep 2013 16:17:37 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4C3D540023;
	Tue, 17 Sep 2013 16:17:37 +0000 (UTC)
In-Reply-To: <CAHGBnuOfYoosgWQdfF+L3=YCqO-MYEx-TpNzBAD-Zt0kqeR_Hw@mail.gmail.com>
	(Sebastian Schuberth's message of "Sun, 15 Sep 2013 14:44:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: AAF45F5C-1FB4-11E3-925B-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234881>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> I think this is less favorable compared to my last proposed solution.

That is only needed if you insist to use C preprocessor that does
not understand include_next.  That choice is a platform specific
decision (even if you want to use such a compiler on a platform it
may not have been ported to yours, etc.).

Keeping the ugliness to deal with the platform issue (i.e. broken
string.h) in one place (e.g. compat/mingw) is far more preferrable
than having a similar ugliness in git-compat-util.h for people on
all other platforms to see, no?
