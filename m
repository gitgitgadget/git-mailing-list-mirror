From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/8] mingw: make failures to unlink or move raise a
 question
Date: Tue, 14 Dec 2010 19:05:00 -0800
Message-ID: <7v1v5jrb1f.fsf@alter.siamese.dyndns.org>
References: <20101214220604.GA4084@sandbox> <20101214222122.GD4084@sandbox>
 <AANLkTi=cHb2kV2MaYu72nXVOksO7O9HhJLEo-fU0sV5N@mail.gmail.com>
 <alpine.DEB.1.00.1012150109340.1461@bonsai2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>, Johannes Sixt <j6t@kdbg.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	msysgit@googlegroups.com, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Albert Dvornik <dvornik+git@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 15 04:05:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PShgH-0004MY-O1
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 04:05:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759088Ab0LODFY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 22:05:24 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54599 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758813Ab0LODFW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Dec 2010 22:05:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EA6963A7C;
	Tue, 14 Dec 2010 22:05:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=O2aggxh+NfZqwQET3oue+fvXO+4=; b=LUSLTM
	Eb9neWsT6i2p4NzgR912+xDUwKR/hWCvrJN7jyZPu6xZ3tfeGl1QS0IQaBq02wA1
	FnTSquX4JnxsrU3/C7LdYu2MhlsRAJbJxX6EZ725C5LPKveW6fqPUhbXgx1scZ3O
	ojtfiS2iFYqq9Hofaw/qZFUpkxYNLjpmT66EI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZtDy/w4fnyVcv7oJ85VqLsuBht11jXWu
	fPl07uPaB7PTRDmWQzBOl5+Y9QFaXO7jzb0yPtOTl8ui3QaB8qluODtHJNwO03BB
	rtB3kBvdy9kxRskrjgNHndpIAYi9j0j5SZrxyF5LGs+mRy7JEjXT/hoH+cWRmM79
	tRyrozUbk40=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6A5B73A71;
	Tue, 14 Dec 2010 22:05:40 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E7E783A6B; Tue, 14 Dec 2010
 22:05:28 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.1012150109340.1461@bonsai2> (Johannes
 Schindelin's message of "Wed\, 15 Dec 2010 01\:11\:03 +0100 \(CET\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 32A32B04-07F8-11E0-82C3-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163730>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > @@ -129,6 +130,78 @@ static inline int is_file_in_use_error(DWORD errcode)
>> >        return 0;
>> >  }
>> >
>> > +static int read_yes_no_answer()
>> 
>> Perhaps "static int read_yes_no_answer(void)" for portability?
>
> LOL. This file is called compat/mingw.c... :-)

I had the same reaction.  Maybe MinGW will get a different compiler
someday ;-)

> But I have no objection to stay with the convention of the rest of Git. 
> Nobody needs to convince me that consistency is good.

I recall there are a few old-style declaration in compat/ directory,
especially in borrowed code like nedmalloc/ and possibly regex/, and
I am not so sure if we want to touch them.

I'll leave this up to msysgit folks.

Thanks.
