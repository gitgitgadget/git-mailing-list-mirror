From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] git-compat-util: do not step on MAC_OS_X_VERSION_MIN_REQUIRED
Date: Fri, 6 Feb 2015 17:01:28 -0500
Message-ID: <CAPig+cTRC5AFKVYx4bwtY1-vYe38KNU+OdYgxmCm-LN8P+4cYg@mail.gmail.com>
References: <f2a35ed9fba20d48ef5736ee4564101@74d39fa044aa309eaea14b9f57fe79c>
	<CAPig+cT0-ftZZyRORx-W2_Nit6XdgrpiyGS=pRjGtHoz1jW+Kg@mail.gmail.com>
	<28F603A7-610B-4711-9D2F-CD9866C96A74@gmail.com>
	<xmqq7fvuhkl3.fsf@gitster.dls.corp.google.com>
	<1FC680E6-2258-4DBB-802C-6FB62D29C378@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 06 23:01:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJqxy-0007OV-EZ
	for gcvg-git-2@plane.gmane.org; Fri, 06 Feb 2015 23:01:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754573AbbBFWBa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2015 17:01:30 -0500
Received: from mail-yk0-f175.google.com ([209.85.160.175]:53173 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116AbbBFWB3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2015 17:01:29 -0500
Received: by mail-yk0-f175.google.com with SMTP id 10so2938816ykt.6
        for <git@vger.kernel.org>; Fri, 06 Feb 2015 14:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=fS9pZQXgVVHjr2sp9l6mppn8lSPYgOQbq3pTTTYJn+8=;
        b=uSUMkLMZmWkn17z3AZ+it92JlPpekBvMyFP28o3Ju/8AA/42t1ha7jj7KCLPEWMDRt
         GJ1ljB06OPNpkXLC3d52UuE+HVH/C/e1O64XhOlI94jmI0+TYvO6t/bBHykCqfJ7XJrY
         rfAGHl+6dduAWzR3vyGPM3dVkukh1zi8frL5PgjgsQmCqTxwbfoHnypPY2aAIpEVHiJD
         lxxl2Q0SLanwgBAGDfval5YQqjAcbgZAl7F4dleR3vypiPs2HPYz0DDrRUbhYja/tOKR
         O9RijIK274l40HuiI0C3Ff+TgqFPnVmSTEgY1kINGpLW4lL+0yf9vZaJ8mSI6GnMYhhP
         btkw==
X-Received: by 10.236.63.6 with SMTP id z6mr2182383yhc.65.1423260088951; Fri,
 06 Feb 2015 14:01:28 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Fri, 6 Feb 2015 14:01:28 -0800 (PST)
In-Reply-To: <1FC680E6-2258-4DBB-802C-6FB62D29C378@gmail.com>
X-Google-Sender-Auth: m1QVxaTFbPPcClENn4hN90EhQu4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263429>

On Fri, Feb 6, 2015 at 3:43 PM, Kyle J. McKay <mackyle@gmail.com> wrote:
> On Feb 6, 2015, at 12:05, Junio C Hamano wrote:
>> "Kyle J. McKay" <mackyle@gmail.com> writes:
>>> So I think it needs to stay #define'd to nothing to be safe in case
>>> anything later on ends up including stuff that uses it.
>>
>> Doesn't the fact that your test failed indicates that it is not jsut
>> "to be safe in case" but is required for correctness?
>>
>> [...] I do not know what
>> changes they make to openssl/*.h (which is included just after the
>> above header is included, but I would imagine that is where the
>> AVAILABLE_MAC_OS_X_VERSION_XXX_AND_LATER_BUT_DEPRECATED_IN_MAC_OS_VERSION_YYY
>> macros are checked and annoying warnings that are being squelched by
>> the previous change are given?
>
> Yes.
>
> Although Eric didn't specify exactly where when he suggested adding this:
>
> On Feb 6, 2015, at 02:00, Eric Sunshine wrote:
>>
>>    #ifdef __APPLE__
>>    #undef DEPRECATED_ATTRIBUTE
>>    #endif
>
> I took the suggestion to be after the openssl/*.h headers are included which
> would avoid the error of having DEPRECATED_ATTRIBUTE be #undef'd for them.
> But, even math.h can end up including AvailabilityMacros.h, so I think
> #undef'ing DEPRECATED_ATTRIBUTE after the openssl/*.h headers are included
> would be unsafe in general.  While we might happen to get away with that
> today, if say compat/apple-common-crypto.h changes in the future (or for
> that matter any sequence of includes in other files or any headers in the
> Apple SDK) we could start seeing the error.
>
> TLDR; yeah, DEPRECATED_ATTRIBUTE needs to remain defined to nothing.

I agree with this analysis. An alternative would be to revert b195aa00
(and not apply this patch), but then we risk having legitimate
Git-related compilation warnings lost in the noise of the useless
Apple deprecation warnings.  Given the glacial pace at which Apple
headers changes, and considering the rapid pace of change in Git, it
still seems the lesser evil to suppress the useless warnings Apple
thrust upon us when they deprecated OpenSSL in its entirety without
providing replacements. It's unfortunate that the DEPRECATED_ATTRIBUTE
#define will bleed beyond the OpenSSL #includes and potentially allow
us to miss some future Apple deprecations, however, given the
shortcomings of b195aa00, the proposed patch seems to be the best we
can do.
