From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-compat-util: do not step on MAC_OS_X_VERSION_MIN_REQUIRED
Date: Fri, 06 Feb 2015 12:05:28 -0800
Message-ID: <xmqq7fvuhkl3.fsf@gitster.dls.corp.google.com>
References: <f2a35ed9fba20d48ef5736ee4564101@74d39fa044aa309eaea14b9f57fe79c>
	<CAPig+cT0-ftZZyRORx-W2_Nit6XdgrpiyGS=pRjGtHoz1jW+Kg@mail.gmail.com>
	<28F603A7-610B-4711-9D2F-CD9866C96A74@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git mailing list <git@vger.kernel.org>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 06 21:05:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJpA2-0001Gn-Ap
	for gcvg-git-2@plane.gmane.org; Fri, 06 Feb 2015 21:05:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757239AbbBFUFo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2015 15:05:44 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56480 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756665AbbBFUFm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2015 15:05:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7BE6134F90;
	Fri,  6 Feb 2015 15:05:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=obK4efuhC//qFuXGaE3wwjt88FM=; b=XtXlEt
	Txdd0w33yH0Lte/wldbgMhEgGJ93BMYZrXTJXxcmu6pYnqeUW/mV2F/HoVm3/sz9
	WdAyZHJNZOl+yll5CFksg6Qg0/5jGdEHEBXztjq6CAhiJrAUY9JlQofvYHwAiFpj
	33fW3oDqDT7oVbuWbom5yzAtBwMAy+H2VIJ6o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mFmF5IqkWFPFnEVkDLASRoxUsLnsgjv2
	t7i/zcNTO3oYgsOYWAciguEnATb57Q7xiWttufWVHV4qKuuc3z5hTjy/DrpvZXeh
	AuSOxPwbBDn/MtGFbQCB6oFss6g9R0B4IkmtG1ZgBcg8Oo9TNqZXVlAlFbLVsqCc
	V1iXzWI0h9Y=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7332034F8F;
	Fri,  6 Feb 2015 15:05:41 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C749234F82;
	Fri,  6 Feb 2015 15:05:29 -0500 (EST)
In-Reply-To: <28F603A7-610B-4711-9D2F-CD9866C96A74@gmail.com> (Kyle J. McKay's
	message of "Fri, 6 Feb 2015 11:47:51 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7FCAC020-AE3B-11E4-8699-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263423>

"Kyle J. McKay" <mackyle@gmail.com> writes:

> Actually I just tested it.  If we #undef it we could end up producing  
> these:
>
>    error: syntax error before DEPRECATED_ATTRIBUTE
>
> So I think it needs to stay #define'd to nothing to be safe in case  
> anything later on ends up including stuff that uses it.

Doesn't the fact that your test failed indicates that it is not jsut
"to be safe in case" but is required for correctness?

The first hit for "MAC_OS_X_VERSION_MIN_REQUIRED" was this:

  https://opensource.apple.com/source/CarbonHeaders/CarbonHeaders-18.1/AvailabilityMacros.h

which marks quite a many macros to that value.  I do not know what
changes they make to openssl/*.h (which is included just after the
above header is included, but I would imagine that is where the
AVAILABLE_MAC_OS_X_VERSION_XXX_AND_LATER_BUT_DEPRECATED_IN_MAC_OS_VERSION_YYY
macros are checked and annoying warnings that are being squelched by
the previous change are given?
