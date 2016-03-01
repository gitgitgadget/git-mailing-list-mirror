From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Mark win32's pthread_exit() as NORETURN
Date: Tue, 01 Mar 2016 09:57:36 -0800
Message-ID: <xmqq60x684j3.fsf@gitster.mtv.corp.google.com>
References: <69eef72cfc77e62ad7ad17c6df5f2d2396c64991.1456840324.git.johannes.schindelin@gmx.de>
	<d584d8bdaa8645a406c96f2a11f04febf57b2c25.1456841593.git.johannes.schindelin@gmx.de>
	<56D5A955.8010904@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <stefan.naewe@atlas-elektronik.com>, <git@vger.kernel.org>,
	<peff@peff.net>, <tboegi@web.de>
To: <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 01 18:57:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaoYK-0008M0-NI
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 18:57:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751772AbcCAR5k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 12:57:40 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58845 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751139AbcCAR5j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 12:57:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 02CE148A2F;
	Tue,  1 Mar 2016 12:57:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UMo5VM9G/7QPR3xEPnx0QwhlEUk=; b=kib4qy
	QoURhWfKHPbxX4tKcQbf7WEZ6fyblYvV43OLTTQg5DcVL9aUc5P6NhDsynNyHQhG
	OnkPRkRf5M2MZe1bpFaOFA1s1R1L450eOIDc/nYez6N/cGK9ArW25657BV3gxIrx
	5umyL6MtKPTugl6npbRsIZWRtzLAIm6IhwKwM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=afNl9A01Hv1O04dYJKT1G2flSyGzLxVx
	kjOXoR5cIk7qDgqKchxZajYH+sycIty5qgF3bBuONFOfV5w19WdpDL1Vl3+PePAH
	iWgEJ8klOLBIVG1St+n64GJQ5i7xoecLgNd33uMf5fl0ON3iZ0cOChkDv3Nl/Ita
	kmBdDw/YGu0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id ED5A948A2E;
	Tue,  1 Mar 2016 12:57:37 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 63CBF48A2D;
	Tue,  1 Mar 2016 12:57:37 -0500 (EST)
In-Reply-To: <56D5A955.8010904@atlas-elektronik.com> (stefan naewe's message
	of "Tue, 1 Mar 2016 15:38:13 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 155FF4B6-DFD7-11E5-81DF-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288048>

<stefan.naewe@atlas-elektronik.com> writes:

> Am 01.03.2016 um 15:13 schrieb Johannes Schindelin:
>> The pthread_exit() function is not expected to return. Ever. On Windows,
>> we call ExitThread() whose documentation claims: "This function does not
>> return a value.":
>
> Does this really mean that ExitThread() does not return ?
>
> Just wondering...

;-).

That made me re-read the patch and notice another thing... Dscho, I
think you would need s/int/void/, too, no?

>
>>         https://msdn.microsoft.com/en-us/library/windows/desktop/ms682659
>> 
>> Pointed out by Jeff King.
>> 
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> ---
>> 
>>         Relative to v1, only the commit message changed (to clarify that
>>         ExitThread() indeed never returns).
>> 
>>  compat/win32/pthread.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/compat/win32/pthread.h b/compat/win32/pthread.h
>> index 20b35a2..148db60 100644
>> --- a/compat/win32/pthread.h
>> +++ b/compat/win32/pthread.h
>> @@ -78,7 +78,7 @@ extern int win32_pthread_join(pthread_t *thread, void **value_ptr);
>>  #define pthread_equal(t1, t2) ((t1).tid == (t2).tid)
>>  extern pthread_t pthread_self(void);
>> 
>> -static inline int pthread_exit(void *ret)
>> +static inline int NORETURN pthread_exit(void *ret)
>>  {
>>         ExitThread((DWORD)(intptr_t)ret);
>>  }
>> --
>
>
> Stefan
