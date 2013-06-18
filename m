From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] GIT-VERSION-GEN: support non-standard $GIT_DIR path
Date: Tue, 18 Jun 2013 07:36:52 -0700
Message-ID: <7vwqpr8ozf.fsf@alter.siamese.dyndns.org>
References: <20130615230108.GA21005@kaarsemaker.net>
	<7v38sgcxjp.fsf@alter.siamese.dyndns.org>
	<7vy5a8biu8.fsf@alter.siamese.dyndns.org>
	<1371540006.32543.5.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Tue Jun 18 16:37:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uox1r-0001rK-Ts
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 16:37:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175Ab3FROg5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 10:36:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60327 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755833Ab3FROgz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 10:36:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F1F43280A9;
	Tue, 18 Jun 2013 14:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hY6v4mbNT3jF31SfmYR+rvm6jOU=; b=rG2ISZ
	Uj4v1epoEb3xrDQnOx82p+FfV+n9Y7qGsH+gz+FEqE2WXxROt89eJJOSEGhUssBp
	r8SOzAFBzzEOpTweR8sJ8drKxtBdO9TvV8bcz0Z9HsnIP85X9AAd3Ur/grrdyh+l
	pxqL6vtBkMiREz4lDH3eALVD475Yo2MdRuxDI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H1m0yB9XKSPNW9Z5IsFT6A89O1GA5+hm
	T9UxgNdhIpBPA5P1FBGbhT98RJsIdJDFoSrXAr1nQr2VdsOKXbcEimoGbX6owCnn
	vn+6CMSoSVMLgSlHF/DnU1Y0X2vklZCwjmZdZze9b/VubhHd3hj5gem7bqULBWBq
	jo/SmxZquuk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E5B05280A7;
	Tue, 18 Jun 2013 14:36:54 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 44A69280A3;
	Tue, 18 Jun 2013 14:36:54 +0000 (UTC)
In-Reply-To: <1371540006.32543.5.camel@localhost> (Dennis Kaarsemaker's
	message of "Tue, 18 Jun 2013 09:20:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8564833E-D824-11E2-8B5B-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228242>

Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:

> On ma, 2013-06-17 at 13:09 -0700, Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>> 
>> > Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:
>> >
>> >>  I'm doing daily builds of git, using many workers and a shared git.git,
>> >>  with per-worker checkouts
>> >
>> > OK, so GIT_DIR is explicitly specified in these "workers".
>
> Yes, both GIT_DIR and GIT_WORK_TREE are set and the use of .git/HEAD and
> anything relying on it is shunned, so workers can run checkout as they
> please.
>
>> > Makes sense.
>>
>> Actually it does not.  What if GIT_DIR is an empty string or not set
>> at all?  The patch breaks the build for everybody else, doesn't it?
>
> It does indeed, I only tested in my setup and not with a normal make
> test. Apologies.
>
>> Perhaps like this instead?
>>
>>  GIT-VERSION-GEN | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
>> index 2908204..91ec831 100755
>> --- a/GIT-VERSION-GEN
>> +++ b/GIT-VERSION-GEN
>> @@ -11,7 +11,7 @@ LF='
>>  if test -f version
>>  then
>>  	VN=$(cat version) || VN="$DEF_VER"
>> -elif test -d .git -o -f .git &&
>> +elif test -d ${GIT_DIR:-.git} -o -f .git &&
>>  	VN=$(git describe --match "v[0-9]*" --abbrev=7 HEAD 2>/dev/null) &&
>>  	case "$VN" in
>>  	*$LF*) (exit 1) ;;
>
> Yes, that makes a lot more sense and actually works in normal make test
> and with a detached .git. Do you want me to send an updated patch?

I think I've locally amended it already before queueing it to 'pu',
so no need to resend.

Thanks.
