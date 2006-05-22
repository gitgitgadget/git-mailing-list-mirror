From: Jim Meyering <jim@meyering.net>
Subject: Re: avoid atoi, when possible; int overflow -> heap corruption
Date: Mon, 22 May 2006 15:31:28 +0200
Message-ID: <878xoufaof.fsf@rho.meyering.net>
References: <87mzdcjqey.fsf@rho.meyering.net>
	<7v3bf3jl15.fsf@assigned-by-dhcp.cox.net>
	<871wumim28.fsf_-_@rho.meyering.net>
	<118833cc0605220616t75a182b1oa404d5efe8a1f5d9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 22 15:31:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiAVQ-0004gS-Tw
	for gcvg-git@gmane.org; Mon, 22 May 2006 15:31:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbWEVNba (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 09:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbWEVNba
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 09:31:30 -0400
Received: from mx.meyering.net ([82.230.74.64]:60896 "EHLO mx.meyering.net")
	by vger.kernel.org with ESMTP id S1750832AbWEVNb3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 May 2006 09:31:29 -0400
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 2984134B8D; Mon, 22 May 2006 15:31:28 +0200 (CEST)
To: "Morten Welinder" <mwelinder@gmail.com>
In-Reply-To: <118833cc0605220616t75a182b1oa404d5efe8a1f5d9@mail.gmail.com>
	(Morten Welinder's message of "Mon, 22 May 2006 09:16:50 -0400")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20504>

"Morten Welinder" <mwelinder@gmail.com> wrote:
>> There are about 20 uses of atoi, and most calls can return
>> a usable result in spite of an invalid input -- just because
>> atoi returns the same thing for "99" as "99-and-any-suffix".
>> It would be better not to ignore invalid inputs.
>
> atoi has undefined behaviour for "99-and-any-suffix".  You might
> get lucky and get back 99, but you might also get a random value
> or a core dump.

I've never heard of that.
POSIX says that atoi(str) is equivalent to:

    (int) strtol(str, (char **)NULL, 10)
    except that the handling of errors may differ.
    If the value cannot be represented, the behavior is undefined.

Since strtol works fine with such a suffix, and since 99 can be
represented, I don't see why there would be any undefined behavior.

Do you know of an implementation for which `atoi ("99-and-any-suffix")'
does anything other than return 99?
