From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 2/4] cat-file: teach cat-file a '--literally' option
Date: Tue, 21 Apr 2015 13:36:38 -0700
Message-ID: <xmqqh9s9gqw9.fsf@gitster.dls.corp.google.com>
References: <552E9816.6040502@gmail.com>
	<1429117174-4968-1-git-send-email-karthik.188@gmail.com>
	<20150419002807.GA11634@hashpling.org>
	<xmqq7ft7nz8l.fsf@gitster.dls.corp.google.com>
	<20150420074433.GA30422@hashpling.org>
	<8CBC4DEB-EC50-4DD7-A687-443AA93A96A8@gmail.com>
	<20150420091920.GA31279@hashpling.org> <553520CF.6070304@gmail.com>
	<20150421101641.GA13202@hashpling.org>
	<CAPig+cRmPv5u_OCtUPNoYOUcOoa9xn++Xw-rkD6EP6_eq0YvEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Charles Bailey <charles@hashpling.org>,
	karthik nayak <karthik.188@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 22:36:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkeuU-00010D-AO
	for gcvg-git-2@plane.gmane.org; Tue, 21 Apr 2015 22:36:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbbDUUgl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2015 16:36:41 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50089 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756058AbbDUUgl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2015 16:36:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 45DE34A51F;
	Tue, 21 Apr 2015 16:36:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=66hFl9IdZWpZcNub2VERiVBJwfI=; b=OXw5Vj
	IXiaWBJEBcRhgwLC8THYBEkw2PckCl5lv4GAgkKvrpsfEzAzWMbSuNjslQtsXFmZ
	kJDDKyQ37SVuazyz46xXE2GFWOuAglImTEknIJDdq3+ez6th/AFElDeZhK5gm9n+
	3nZAZ7g49qNVxd6i+jo9KPXCBl+R932b5Wvw0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lCuduRqsQNabkct54DznxSIq537ne34O
	leMwvQyJge5y0oQrbl7Zyx1jsuSIVUcisiPqSHOwHvssAd+i7AgIFsXb3yABHcTe
	XSB84yZfqRN8lhNX4MDYtndcSGfUGxX1fj2koZY3RXhU19/lvJmO7CQ9sV14LBDG
	OhloHr/SmdM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3ED944A51E;
	Tue, 21 Apr 2015 16:36:40 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B701E4A51D;
	Tue, 21 Apr 2015 16:36:39 -0400 (EDT)
In-Reply-To: <CAPig+cRmPv5u_OCtUPNoYOUcOoa9xn++Xw-rkD6EP6_eq0YvEQ@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 21 Apr 2015 15:40:35 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1CEE7F4A-E866-11E4-8583-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267552>

Eric Sunshine <sunshine@sunshineco.com> writes:

> It's easy to be blinded into thinking that cat-file's new option
> should be named --literally since it was inspired by the --literally
> option of hash-object, but indeed it may not be the best choice.

Yeah, I wouldn't even say "inspired".  It was envisioned as a
counter-part debugging aid, nothing more.

Is there any other way to make cat-file looser other than accepting
an unknown type name from the future?  If so, then perhaps it may
make sense to give it a generic name that implys that we would
trigger such additional looseness in the future.  But as the
inventor of it as a debugging aid, I would say a name that spells
out the specific way this option is being loose, e.g.

>     --allow-bogus-type

or with s/bogus/unknown/, best describes what it currently does.

Thanks.
