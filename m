From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 24/25] worktree move: accept destination as directory
Date: Wed, 11 May 2016 14:34:47 -0700
Message-ID: <xmqqbn4cjn2g.fsf@gitster.mtv.corp.google.com>
References: <1460553346-12985-1-git-send-email-pclouds@gmail.com>
	<1460553346-12985-25-git-send-email-pclouds@gmail.com>
	<CAPig+cRtajkynLFj5Fknd72QQ=Eqevh1T9i9MvApwXfNmtMAFQ@mail.gmail.com>
	<CACsJy8CCAan9ALxULPFeGSU7wsfwbrywRWFr4Hsjx3=PGwosLA@mail.gmail.com>
	<CAPig+cTB8tdPo=wd5UdB84owKJ6c5hj6H9d4_YGDRecBdUE0vA@mail.gmail.com>
	<57337ACF.3020402@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Duy Nguyen <pclouds@gmail.com>, Git List <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed May 11 23:34:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0bmS-0005if-Jh
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 23:34:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752061AbcEKVew (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 17:34:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52888 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751670AbcEKVev (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 17:34:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D87E419603;
	Wed, 11 May 2016 17:34:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ihvALIcSh4YonDZIH/nRN3HHiw0=; b=Y0PEUj
	aPHrtuV8/Y2CU9cJGsvCReMqHW6fbt5jqGwaQpFog5+F9A5v+52eXnG36ZRZ8X6u
	1rmUACc/wUTsV3PEApD0FAhqSsoMhTfe3MqK2l+gKfZpDr0wT+2I4KuX1ox9IUbg
	83XWaifEEL+sdI3BybyUGNFA042yusnaaZk9Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yJi8IsVf2YlcfAVFagSyHrP2XHQhj1vO
	d/rFxjmI8tATGi7m34mDFEewtw0vgNYL1ikm5UxM+47e6nkEBG06dxrSrpt5aRNU
	JxRy3pwuX5eCEgcAD0EFuFkq3t/cwj3zL99KbOMPvfHc8uSCjxIvjWqSg+EL+qJm
	GCN9aZEPv9E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D0FDF19602;
	Wed, 11 May 2016 17:34:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4E84B19601;
	Wed, 11 May 2016 17:34:49 -0400 (EDT)
In-Reply-To: <57337ACF.3020402@kdbg.org> (Johannes Sixt's message of "Wed, 11
	May 2016 20:32:47 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 305423CA-17C0-11E6-806B-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294368>

Johannes Sixt <j6t@kdbg.org> writes:

>> As this path is read from a file git itself creates, and if we know
>> that it will always contain forward slashes, then I agree that it
>> could be potentially confusing to later readers to see
>> git_find_last_dir_sep(). So, keeping it as-is seems correct.
>
> Please allow me to disagree. There should not be any assumption that a
> path uses forward slashes as directory separator, except when the path
> is
>
> - a pathspec
> - a ref
> - a path found in the object database including the index

I think standardising on one way for what we write out would give
less hassle to users.  The human end users should not be opening
these files in their editors and futzing with their contents, but
there are third-party tools and reimplementations of Git.  Forcing
them to be prepared for input with slashes and backslashes does not
make much sense to me.

Is there an upside for us to accept both slashes in this file?
