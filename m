From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/4] Refactor skipping DOS drive prefixes
Date: Sun, 24 Jan 2016 14:12:11 -0800
Message-ID: <xmqqzivubpac.fsf@gitster.mtv.corp.google.com>
References: <cover.1452536924.git.johannes.schindelin@gmx.de>
	<cover.1452585382.git.johannes.schindelin@gmx.de>
	<05cb9e00756e8a364f972cd227804764f6a6380c.1452585382.git.johannes.schindelin@gmx.de>
	<56A279DA.8080809@kdbg.org>
	<xmqq60ylv3bk.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1601230924090.2964@virtualbox>
	<56A3CE34.20808@kdbg.org>
	<alpine.DEB.2.20.1601241152060.2964@virtualbox>
	<56A4C534.6040503@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Jan 24 23:13:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNSuB-0002nE-9g
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jan 2016 23:13:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756131AbcAXWND (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2016 17:13:03 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58329 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754931AbcAXWMO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 17:12:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1F3B43E519;
	Sun, 24 Jan 2016 17:12:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=otpyBdZZ3epOCh6YKvTZgjE9H8M=; b=b5ezHQ
	cTTBKOJHXQUp5I2xkBxNYDki5OD9Dob4eE0dGtndAumdoFutx+apI1dugqh/zeVv
	MCbPlCGitbHxYKYNkiQFXrPn4lM/nDuUhwfkh5bFcqxYPcPUOrnteatoR10QQdsy
	QQLo7+nTU1i/c9X+CmSvZMR0e0I31WT2hMfCM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kq8rr9EVDBNUL5uMNW+c5QrwjOSyJUNQ
	xeKrRqIyYh0fb4gMYQtp6LS6Uw/IZxWeQ6qJcfKCjDDMoaG6r+QvJoHCVbBIeW2+
	PeWTygq3giKVaXJoNX3ZoCZlkobNIPL5QXFB5JKrpqn+usmt8qRlMUUOnmz6Nw85
	ajNxhtPMis0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1703E3E518;
	Sun, 24 Jan 2016 17:12:13 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8A2D13E517;
	Sun, 24 Jan 2016 17:12:12 -0500 (EST)
In-Reply-To: <56A4C534.6040503@kdbg.org> (Johannes Sixt's message of "Sun, 24
	Jan 2016 13:36:04 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 84CB49E8-C2E7-11E5-AB44-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284698>

Johannes Sixt <j6t@kdbg.org> writes:

> Am 24.01.2016 um 11:56 schrieb Johannes Schindelin:
>> $ grep -w isalpha /mingw32/i686-w64-mingw32/include/*.h
>> /mingw32/i686-w64-mingw32/include/ctype.h:  _CRTIMP int __cdecl isalpha(int _C);
>> /mingw32/i686-w64-mingw32/include/ctype.h:#define __iscsymf(_c) (isalpha(_c) || ((_c)=='_'))
>> 
>> I guess that definition gets pulled in somehow.
>
> Ok, then, Junio, kindly replace js/dirname-basename~4 with this patch.
> (I hope I get the patch headers right for git-am.)

Thanks for following it through.

If they are already in 'next', we'd want an incremental fixup, though.

    ... goes and looks ...

Yeah, unfortunately that is already in 'next'; could you make this
into an incremental, which would come with its own log message that
explains why the inlining was wrong?

Thanks.
