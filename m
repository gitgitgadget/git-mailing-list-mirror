Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F15851FF40
	for <e@80x24.org>; Tue, 21 Jun 2016 16:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752693AbcFUQqp (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 12:46:45 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51450 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752036AbcFUQqo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 12:46:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AB91824A75;
	Tue, 21 Jun 2016 12:46:42 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+imV8Xe2SoAOZZIpsfDRdBGkXwI=; b=S1UCmL
	XHFwZVrw5l43aMvKcnFoFYCY2P+lWvuCBOPWFFQazFquofLUcWt6SoSIsvkF5PBl
	rFcWvbl/N8sTRNgkqY2UA5QQb1qQ73WWBLfoaiRd50N5aEswc/jKhuE35rZQAgRA
	ymjT7nm/73ecf2b0kGUx7wvXV6SL6KLiMEJr4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hdAteafNo/7FuUZOhrUcVcpmpmAMyPXg
	SakV+drbKYCdRQwDYnM3V30jgkBSCmcQmyIem9xdcLaP/Ket2g6qCfChmguohXMX
	HgtaeOz8pNXwTkN8QCyRfZK9vbcbK606RcQZAs+GYft7SYz/UxHy+2+WFlRCK99f
	hA2vlU0v6PY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A132F24A74;
	Tue, 21 Jun 2016 12:46:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1D76E24A73;
	Tue, 21 Jun 2016 12:46:42 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Konstantin Khomoutov <kostix+git@007spb.ru>
Cc:	Florian Manschwetus <manschwetus@cs-software-gmbh.de>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Problem with git-http-backend.exe as iis cgi
References: <F0F5A56A22F20D4CB4A03BB8D6658797E260E0E3@SERVER2011.CS-SOFTWARE.local>
	<20160310155522.1dee53cf95fead8cfd4e178a@domain007.com>
Date:	Tue, 21 Jun 2016 09:46:39 -0700
In-Reply-To: <20160310155522.1dee53cf95fead8cfd4e178a@domain007.com>
	(Konstantin Khomoutov's message of "Thu, 10 Mar 2016 15:55:22 +0300")
Message-ID: <xmqq60t2sd5c.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BB49C910-37CF-11E6-9B41-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Konstantin Khomoutov <kostix+git@007spb.ru> writes:

> On Thu, 10 Mar 2016 07:28:50 +0000
> Florian Manschwetus <manschwetus@cs-software-gmbh.de> wrote:
>
>> I tried to setup git-http-backend with iis, as iis provides proper
>> impersonation for cgi under windows, which leads to have the
>> filesystem access performed with the logon user, therefore the
>> webserver doesn't need generic access to the files. I stumbled across
>> a problem, ending up with post requests hanging forever. After some
>> investigation I managed to get it work by wrapping the http-backend
>> into a bash script, giving a lot of control about the environmental
>> things, I was unable to solve within IIS configuration. The
>> workaround, I use currently, is to use "/bin/head -c
>> ${CONTENT_LENGTH} | ./git-http-backend.exe", which directly shows the
>> issue. Git http-backend should check if CONTENT_LENGTH is set to
>> something reasonable (e.g. >0) and should in this case read only
>> CONTENT_LENGTH bytes from stdin, instead of reading till EOF what I
>> suspect it is doing currently.
> ...
> So yes, if Git currently reads until EOF, it's an error.

This sounded vaguely familiar.  Isn't this responding to a stale
thread?

http://thread.gmane.org/gmane.comp.version-control.git/290114
proposed a patch along the line, and corrections to the patch was
suggested in the review, but it was not followed through, it seems.



