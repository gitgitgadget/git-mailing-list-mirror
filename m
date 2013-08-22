From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH 3/3] Revert "bash prompt: avoid command substitution when
 finalizing gitstring"
Date: Wed, 21 Aug 2013 17:33:05 -0700
Message-ID: <CA+sFfMfa422PF1inOOeTBRE7HRqL5zwCJNagx9Ya0i_LbpwQcg@mail.gmail.com>
References: <1377118173-23405-1-git-send-email-bcasey@nvidia.com>
	<1377118173-23405-3-git-send-email-bcasey@nvidia.com>
	<xmqq7gfeu35g.fsf@gitster.dls.corp.google.com>
	<CA+sFfMc0BPo8pSLngi=bAWxYNT8xKFEOo77z3a12q+-Sq4qiiA@mail.gmail.com>
	<xmqq7gfesheu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Brandon Casey <bcasey@nvidia.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>, szeder@ira.uka.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 22 02:33:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCIpt-0005X8-PJ
	for gcvg-git-2@plane.gmane.org; Thu, 22 Aug 2013 02:33:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753325Ab3HVAdJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Aug 2013 20:33:09 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:62974 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752981Ab3HVAdH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Aug 2013 20:33:07 -0400
Received: by mail-wi0-f173.google.com with SMTP id en1so1421137wid.6
        for <git@vger.kernel.org>; Wed, 21 Aug 2013 17:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=J+MzTqKpGVHHiHwHKrfSh79Go9QVw0Dlok593i1jbRs=;
        b=xXHst9tzbdSaTf0P6vfErzF3Ol62I5iSTTs4CP1dFKBtJMwpZ1plOevubS3Mqvdecj
         0R1gnY9HOcUnR3ogEa+rbJbE5IfmQyT36houK5dAjHb9EvTT15wHUGwdEWPdJcONWrWY
         g63cF7NM4w8V+b3aRmGUMUWeegVF8DUUFnoAnDJwwDkTCQc56rc7vv6LfLmde3V1F2e9
         pPf8odx6EVemGTt2P5Tpv8LHydTqy7enwnGiBpBKJkeT0VEFkm7/hflld1qseedK6gyM
         sEWYHW4d1hsmBiThVBgzoScY7DFAiTU1GLAGkf2TZZudFE3XOgCOFhLwcd/qItkptVa0
         /FOQ==
X-Received: by 10.180.109.10 with SMTP id ho10mr18480151wib.14.1377131585797;
 Wed, 21 Aug 2013 17:33:05 -0700 (PDT)
Received: by 10.194.85.168 with HTTP; Wed, 21 Aug 2013 17:33:05 -0700 (PDT)
In-Reply-To: <xmqq7gfesheu.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232755>

On Wed, Aug 21, 2013 at 5:22 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Brandon Casey <drafnel@gmail.com> writes:
>
>> On Wed, Aug 21, 2013 at 2:47 PM, Junio C Hamano <gitster@pobox.com> wrote:

>>>         # on load...
>>>         printf -v __git_printf_supports_v -- "%s" yes >/dev/null 2>&1
>>>
>>>         ...
>>>
>>>         if test "${__git_printf_supports_v}" = yes
>>>         then
>>>                 printf -v gitstring -- "$printf_format" "$gitstring"
>>>         else
>>>                 gitstring=$(printf -- "$printf_format" "$gitstring")
>>>         fi
>>
>> Yes, that appears to work.
>
> A real patch needs to be a bit more careful, though.  The variable
> needs to be cleared before all of the above,

Agreed.

> and the testing would
> want to consider that the variable may not be set (i.e. use
> "${var-}" when checking).

Why is "${var-}" necessary?  Wouldn't that be equivalent to "${var}"
or "$var"?  We obviously wouldn't want to do 'if test $var = yes', but
I would have thought it was sufficient to wrap the variable
dereference in quotes as your original did.

-Brandon
