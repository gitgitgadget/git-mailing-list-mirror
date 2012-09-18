From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Port to HP NonStop
Date: Tue, 18 Sep 2012 10:03:10 -0700
Message-ID: <7vehlznu0h.fsf@alter.siamese.dyndns.org>
References: <000201cd9569$d16515e0$742f41a0$@schmitz-digital.de>
 <7vvcfbojbl.fsf@alter.siamese.dyndns.org>
 <000401cd9575$38a98b40$a9fca1c0$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "Joachim Schmitz" <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Tue Sep 18 19:03:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TE1D0-0004MA-Ob
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 19:03:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752604Ab2IRRDR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 13:03:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33819 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752598Ab2IRRDO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 13:03:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 089BB9038;
	Tue, 18 Sep 2012 13:03:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ypye9Gj8qZh1Dxz5G83FYPFhGwk=; b=jlTa73
	eZ+XF4OrEMw/vv1i8YHTCoX4/QvZZz0dKuDtaFF+a72V2iXUk8UufRcEeIkcZKji
	H8TGgFGR5secYxn2hkpUzltIgfFxPFwxxXzAPxjok845wsp1JtxuP80Fd5jQhgil
	/zUzYi3BIxWe5pF52B3wPuCCdW34Ts+uD1oHY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T36HzBiTlEDmRRy2Lvy59yzsQhcKtMSV
	4B0CCBb8vdnXu+XT8EyT09kKuMk0wePWeLgB/QF1NnqencGCjNlqjh7dxsjuS2V1
	vaoJL1EJ3BAwAzJqO7LRG3bJMcXg/sjhppPoswZNRxgfRPvtrInlopZJLa7JoPaG
	9HiZ2qUIxSM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E9E649037;
	Tue, 18 Sep 2012 13:03:13 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 59C009035; Tue, 18 Sep 2012
 13:03:12 -0400 (EDT)
In-Reply-To: <000401cd9575$38a98b40$a9fca1c0$@schmitz-digital.de> (Joachim
 Schmitz's message of "Tue, 18 Sep 2012 10:11:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BAC3ECAC-01B2-11E2-91A3-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205838>

"Joachim Schmitz" <jojo@schmitz-digital.de> writes:

>> From: Junio C Hamano [mailto:gitster@pobox.com]
>> Sent: Tuesday, September 18, 2012 9:57 AM
>> To: Joachim Schmitz
>> Cc: git@vger.kernel.org
>> Subject: Re: [PATCH/RFC] Port to HP NonStop
>> 
>> "Joachim Schmitz" <jojo@schmitz-digital.de> writes:
>> 
>> > Needs a different link order in Makefile: libintl before libiconv.
>> > This may affect other platforms, so needs some checking.
>> 
>> It will, and it needs customization, not checking.
>
> How?

By not moving things around to affect other people, but having them
in the order you want only for your platform (and other future ports
that need similar treatment)?

For example, if you need libintl before libiconv, a quick and dirty
way may be

diff --git i/Makefile w/Makefile
index a49d1db..9b2cfd6 100644
--- i/Makefile
+++ w/Makefile
@@ -1552,6 +1552,9 @@ ifdef NEEDS_LIBICONV
 	else
 		ICONV_LINK =
 	endif
+	ifdef NEEDS_LIBINTL_BEFORE_LIBICONV
+		ICONV_LINK += -lintl
+	endif
 	EXTLIBS += $(ICONV_LINK) -liconv
 endif
 ifdef NEEDS_LIBGEN

and your linker command line may have "-lintl -liconv -lintl" but
that wouldn't be an error, and you know you won't be affecting
other platforms that do not use NEEDS_LIBINTL_BEFORE_LIBICONV, no?
