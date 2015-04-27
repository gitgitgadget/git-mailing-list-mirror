From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-compat-util.h: implement a different ARRAY_SIZE macro for for safely deriving the size of array
Date: Mon, 27 Apr 2015 11:11:55 -0700
Message-ID: <xmqqsiblwidw.fsf@gitster.dls.corp.google.com>
References: <1430140269-11784-1-git-send-email-gitter.spiros@gmail.com>
	<xmqq1tj5xxo1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 20:12:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YmnVm-000325-1V
	for gcvg-git-2@plane.gmane.org; Mon, 27 Apr 2015 20:12:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbbD0SL7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2015 14:11:59 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50176 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932995AbbD0SL7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2015 14:11:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7A38F4C6A1;
	Mon, 27 Apr 2015 14:11:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=m6jVOw9P+KrOFNy+NRTTRCdL32w=; b=PgBLvE
	dG15Uyxn38J6a08fdqYPmMFoE4wgEapt6m5cfPv/GSM8GWKggX84FaxVg4/Qmi1A
	gKSoWdYfkFsaZ2p4k8r1FAQAnDlYCj23j/zpCVGVi0Z9zG62BW6py+9dbifrOeqq
	2qIjFjMJ7BgPAAaHAssja5tKTYTH+YmNFA9lU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GCMZsEvuCHTTQundjVB+gF2RKPwlnFe6
	A11eXp6P10CSaGZUfsKJ3WQgekKQFxTs8wL+N2RGbMzDSONx9dJOimQs7b67k8+6
	quCYDhID4QYGSi+YPgfVdbKpx90HyMeWebAgKMAvAUZ5Ib3pnFRa3zzj0v1XmyDR
	IjAOBjw2kbY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 720004C6A0;
	Mon, 27 Apr 2015 14:11:58 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DD3DF4C698;
	Mon, 27 Apr 2015 14:11:56 -0400 (EDT)
In-Reply-To: <xmqq1tj5xxo1.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 27 Apr 2015 10:56:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E4079D9A-ED08-11E4-8B73-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267863>

Junio C Hamano <gitster@pobox.com> writes:

>> +#if SUPPORT__BUILTIN_TYPES_COMPATIBLE_P
>> +/* &arr[0] degrades to a pointer: a different type from an array */
>> +#define _array_size_chk(arr)						\
>> +	BUILD_ASSERT_OR_ZERO(!__builtin_types_compatible_p(typeof(arr), \
>> +							typeof(&(arr)[0])))
>> +#else
>> +#define _array_size_chk(arr) 0
>> +#endif
>
> Wouldn't there be a more sensible name?  _chk does not tell us
> anything about what is being checked, and the only thing this name
> gives us is "what uses it" (i.e. it is some magic used by array-size
> and does not say what it checks and what for).
>
> I think you are checking arr is an array and not a pointer.  Perhaps
> "#define is_an_array(arr)" or something along that line may be a
> more descriptive name for it.
>
> I doubt the leading underscore is particularly a good idea, though.

And "is_an_array(arr)" is probably not quite a good name, as that
sounds as if it would give 1 and adding it to sizeof(x)/sizeof(x[0])
does not make sense.  barf_if_not_an_array() is what the macro does.
