From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 06/11] commit: add tests of commit races
Date: Tue, 10 Feb 2015 11:12:29 -0800
Message-ID: <xmqq1tlxwpgi.fsf@gitster.dls.corp.google.com>
References: <1423412045-15616-1-git-send-email-mhagger@alum.mit.edu>
	<1423412045-15616-7-git-send-email-mhagger@alum.mit.edu>
	<CAGZ79kYmgeXt1k22h3fbDR04BTHOQRxryNVSJDOL2DC5yLLHpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 20:12:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLGEg-0003Nj-3b
	for gcvg-git-2@plane.gmane.org; Tue, 10 Feb 2015 20:12:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753454AbbBJTMd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2015 14:12:33 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57760 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752422AbbBJTMc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2015 14:12:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9688A366C4;
	Tue, 10 Feb 2015 14:12:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KUp4Y7Wbkrjd65b+54F4dmjdCFg=; b=em0eiM
	WeAHw9xF9rpkc8GPUzSvun6KDGINubKbUnipaWI9fDpRnojN23W+8DIPGoIQ408Q
	3hLcfQSqEQ/zOmeLKtiqnBU6kCY4509kj30BUuZcJgn2p9zK0wUOodj/rglccNmN
	CMrgVsGUWQ/L/JQHy2WqzzC+k/RMT+Ycj3cFY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qAhMWHdJuu8mV+1G4ojcNsOvva3cGpsT
	xnIQHnLkCknt6Eq/fNpCSNzvUjkrm3IqINBQHF8Rbb6SKcr9e7ICHa4XtZI9pMBl
	9s+ynskhwbEGJ9fmTgMv2jhn5k26HREX3SjApRaOUPUeUZ6wiZ3df1FC2KhbgLlH
	Z22LKE3OKRY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8C817366C3;
	Tue, 10 Feb 2015 14:12:31 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 046F4366C2;
	Tue, 10 Feb 2015 14:12:31 -0500 (EST)
In-Reply-To: <CAGZ79kYmgeXt1k22h3fbDR04BTHOQRxryNVSJDOL2DC5yLLHpw@mail.gmail.com>
	(Stefan Beller's message of "Mon, 9 Feb 2015 10:31:59 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C2C6685A-B158-11E4-82B1-38A39F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263643>

Stefan Beller <sbeller@google.com> writes:

> On Sun, Feb 8, 2015 at 8:14 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>
>> +# Copyright (c) 2014 Michael Haggerty <mhagger@alum.mit.edu>
>
> What is the projects stance on copyright lines?

I do not think we have a strong one.

> I've seen files (most of them from the beginning) having some copyright lines,
> other files (often introduced way later) not having them, "because
> we're git and have
> history, so we know who did it".

I personally agree with that statement.  Also, a copyright notice
per file is often added when a new file is added, but that ends up
giving false sense of "ownership" to everybody else down the line
even after the file has been extensively modified.  It's not like
Michael solely owns all lines in this file in later versions.  And
even if people added their name at the top every time they make any
change, their names tend to stay even when their contributions are
later completely rewritten or removed.

In a sense, my agreement with your statement is stronger than "Yes,
Git can tell us who did what anyway".  What we can find in the
history is the sole source of truth, and in-file copyright notice is
misleading.  You do not even have to have one in the Berne signatory
nations anyway.

> The tests themselves look fine.
>
> Is there a reason you did not append the tests in 7509 ?

Hmph.
