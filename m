From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 11/15] builtin/check-attr: fix a memleak
Date: Fri, 20 Mar 2015 21:02:01 -0700
Message-ID: <xmqqfv8zathi.fsf@gitster.dls.corp.google.com>
References: <1426897692-18322-1-git-send-email-sbeller@google.com>
	<1426897692-18322-12-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Mar 21 05:02:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZAc4-00027m-8b
	for gcvg-git-2@plane.gmane.org; Sat, 21 Mar 2015 05:02:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbbCUECH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2015 00:02:07 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56021 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751236AbbCUECE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2015 00:02:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 20D6142F60;
	Sat, 21 Mar 2015 00:02:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=md8NkawcxScaqRzJEwuzZ0ZZjog=; b=VmJmFp
	B86Pcx1B6RgqRzvH/Oah0d4JtUhV/AbYloyq7bNkLAcaQsGqTiPWuTvRemKCmUBK
	dr0wqmC+D8jt0gcOTDBmsmsGyXWYU86dle86otNCAaQo8yPHLgyCg4y0FdL2khVm
	duUnx6jaWOPqU9gT02C7qOo/cn8PbqwOG5Z50=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XqX5Z232/JBi5JImqAGHlkjIKqOmYOSc
	b+Mr5Ec2/LbRFDTeEG8bS1vXC8y7+hVPuHHsUYh0po+2qTKm0yfsnocqWQXV3VcV
	saveF0k709FNlTrGFVLME7nmM4dxkZMQpfUNMAk1HGxbxWIgX9EONTbAzsI3R7HL
	QVk3rCUjuCE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0161042F5F;
	Sat, 21 Mar 2015 00:02:04 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E3A6242F5E;
	Sat, 21 Mar 2015 00:02:02 -0400 (EDT)
In-Reply-To: <1426897692-18322-12-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Fri, 20 Mar 2015 17:28:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 07F8D4F0-CF7F-11E4-B12E-6DD39F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266006>

Stefan Beller <sbeller@google.com> writes:

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
> Notes:
>     I do not quite recall a discussion about such fixes
>     when I started doing these fixes like 2 years ago.
>     
>     As this is a main function of a subcommand the freed
>     memory is likely to have no impact as the process
>     is done soon, so then it gets freed by the OS which
>     is likey to be faster as the OS frees the whole pages
>     of the process.

You seem to understand it well without "recalling" ;-)

As you said, unless the false hits from valgrind on these overwhelm
the real issues we are looking for, it is usually not worth the
patch churn to fix these.  Another valid reason is if we plan to
libify a function that used to be a top-level.
