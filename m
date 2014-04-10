From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 17/19] Portable alloca for Git
Date: Thu, 10 Apr 2014 10:30:32 -0700
Message-ID: <xmqqbnw9xfbb.fsf@gitster.dls.corp.google.com>
References: <cover.1393257006.git.kirr@mns.spb.ru>
	<f08867ee212e27074dbb4cbb06af408b16dba0a1.1393257006.git.kirr@mns.spb.ru>
	<CABPQNSaVQuXBEnSrs6hdHwEbaBKFr-NjKpuBRNnbkM+HtfJ4Ag@mail.gmail.com>
	<CABPQNSadTGfiue6G+6x7_o10Ri1E7D5vZFU=Cp8rAha+j9jwSA@mail.gmail.com>
	<20140228170012.GA5247@tugrik.mns.mnsspb.ru>
	<CABPQNSYnDjhxjpyZQkNP_qwect_tnPvJ_nEfGSq9qnYFMpehWg@mail.gmail.com>
	<20140305093151.GA3994@tugrik.mns.mnsspb.ru>
	<xmqq1txrp8ur.fsf@gitster.dls.corp.google.com>
	<20140327142250.GC17333@mini.zxlink>
	<20140409124827.GA24672@tugrik.mns.mnsspb.ru>
	<CABPQNSbiyzGLC=Y1kiFPOc4WLWnu=ZpPd6aRwSBzBjZYEih5Tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kirill Smelkov <kirr@mns.spb.ru>,
	GIT Mailing-list <git@vger.kernel.org>,
	Brandon Casey <drafnel@gmail.com>,
	Marius Storm-Olsen <mstormo@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Gerrit Pape <pape@smarden.org>,
	Petr Salinger <Petr.Salinger@seznam.cz>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Schwinge <tschwinge@gnu.org>, kirr@navytux.spb.ru
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Thu Apr 10 19:30:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYIoG-0004eY-QK
	for gcvg-git-2@plane.gmane.org; Thu, 10 Apr 2014 19:30:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030466AbaDJRah (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2014 13:30:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47837 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752484AbaDJRag (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2014 13:30:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E1037A6BA;
	Thu, 10 Apr 2014 13:30:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dOrYr6gwouWwQ0OnHpCM8zTzho0=; b=pkLJMP
	acNYCbSMpdAm1KBgq/NfJKddLcW564ahRk0AXOeQ+sgTPTi9LWYygiHuv2OkrHzp
	lojG7YC5yxrrvg+xK9CPGiZjgT+upCHmtsMY6IlAe7hvktKE7h/Hth9DxXXReud1
	cSvhLQj3hZd5mlaaPWNJG8gtuzcLvFvZJ3rDA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XogvxcSK4mg5fqNP7vcPwUrQMp6WFV7O
	kHUnnT9/oYWhh7rjzsEr7z2DUoGU0qHTkbs304gDv7TZ/lXrIo5daO+9a8eErmBr
	R9SBV/qIPVdq70BcjlttIMyi4yGQO9jYOWCDYTI3jzpYOWXjRLuZomZAVVGfUGxu
	HhVZQHoVrU8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1CAEA7A6B9;
	Thu, 10 Apr 2014 13:30:35 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 018227A6B7;
	Thu, 10 Apr 2014 13:30:34 -0400 (EDT)
In-Reply-To: <CABPQNSbiyzGLC=Y1kiFPOc4WLWnu=ZpPd6aRwSBzBjZYEih5Tw@mail.gmail.com>
	(Erik Faye-Lund's message of "Wed, 9 Apr 2014 15:01:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D2593BCC-C0D5-11E3-8A42-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246021>

Erik Faye-Lund <kusmabite@gmail.com> writes:

>> Subject: [PATCH] mingw: activate alloca
>>
>> Both MSVC and MINGW have alloca(3) definitions in malloc.h, so by moving
>> win32-compat alloca.h from compat/vcbuild/include/ to compat/win32/ ,
>> which is included by both MSVC and MINGW CFLAGS, we can make alloca()
>> work on both those Windows environments.
>>
>> In MINGW, malloc.h has explicit check for GNUC and if it is so, defines
>> alloca to __builtin_alloca, so it looks like we don't need to add any
>> code to here-shipped alloca.h to get optimum performance.
>>
>> Compile-tested on Windows in MSysGit.
>>
>> Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
>
> Looks good to me!

Thanks; queued and pushed out on 'next'.
