From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 1/4] sha1_file.c: support reading from a loose object of unknown type
Date: Fri, 17 Apr 2015 12:23:10 -0700
Message-ID: <xmqqlhhqpnj5.fsf@gitster.dls.corp.google.com>
References: <552E9816.6040502@gmail.com>
	<1429117143-4882-1-git-send-email-karthik.188@gmail.com>
	<xmqqmw29jg78.fsf@gitster.dls.corp.google.com>
	<20150415221824.GB27566@peff.net> <20150417142310.GA12479@peff.net>
	<553154C8.5090001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	sunshine@sunshineco.com
To: karthik nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 17 22:17:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YjChF-0005RA-Mp
	for gcvg-git-2@plane.gmane.org; Fri, 17 Apr 2015 22:17:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751874AbbDQURB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2015 16:17:01 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51646 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751528AbbDQURA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2015 16:17:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 67A7449CA9;
	Fri, 17 Apr 2015 16:16:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2dA9OuhqEcj5abGK1bySWSwqRjw=; b=HBs6KT
	VB/HtwzxSoowzMGlu3kcvTGOkI4X4zxHp7QrmZk9MFmHvtaW/I/IvBzeABSa0Sd3
	WOu3gOHRvyjAMlGteGN3KuDUlBzsW/kM4ZNR5MqcYfT9dtLfu/8ihIo43JKh3Syc
	FYUb/IPXfNesBT/75VTV7M7EDkVhDrTmXZC1g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xhn2Tv194/NFhBRYuozjShQO9DNPp/b9
	BraZLezLYhPM/Qp3a+cwKI4k+IR4lFZsFNs1Ax+VoHUJ+St6eU8ENskGg9secM34
	F7sF2YyDIGQtYX4NpeC7rRDyYRn7ujO56KzDQwoNdNkrZ2YsxHs/YF9trZxcuEOD
	/szgk25UFxk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5B8C649CA8;
	Fri, 17 Apr 2015 16:16:59 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CD13E477F2;
	Fri, 17 Apr 2015 15:23:11 -0400 (EDT)
In-Reply-To: <553154C8.5090001@gmail.com> (karthik nayak's message of "Sat, 18
	Apr 2015 00:15:28 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2FF5A7EE-E537-11E4-8D2A-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267385>

karthik nayak <karthik.188@gmail.com> writes:

> +       type = type_from_string_gently(buf, len, 1);
> +       if (oi->typename) {
> +               strbuf_add(oi->typename, buf, len);
> +               strbuf_addch(oi->typename, '\0');

add() has setlen() at the end so you do not have to NUL terminate it
yourself.  Doing addch() is actively wrong, as oi->typename->len now
counts the terminating NUL as part of the string, no?
