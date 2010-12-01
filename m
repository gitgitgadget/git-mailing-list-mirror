From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 5/6] web--browse: use (x-)www-browser if available
Date: Wed, 1 Dec 2010 11:59:13 +0100
Message-ID: <AANLkTinzCeaiFoL4a-+c6wuJoUQ68zC9vE8AoHfmvN-F@mail.gmail.com>
References: <1291042075-19983-1-git-send-email-giuseppe.bilotta@gmail.com>
	<1291042075-19983-6-git-send-email-giuseppe.bilotta@gmail.com>
	<AANLkTinGustedMv9rm+RgGMQckfxgbTPA+Yqpz7vqTfm@mail.gmail.com>
	<AANLkTimec0prJ29MR3N7GtHJ1FCkk+7=1UJtqiaLZqhK@mail.gmail.com>
	<AANLkTik9R2dRDDBUHBZ_OKPKto0wDAxr1V0uL=q4bU+4@mail.gmail.com>
	<AANLkTik-OKsUK2aJCDR0Q-FyQM=rrFQmx=Hwdyr5NzYt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 01 11:59:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNkPA-0004Nd-JZ
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 11:59:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752755Ab0LAK7P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 05:59:15 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:35410 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752147Ab0LAK7P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 05:59:15 -0500
Received: by wyb28 with SMTP id 28so6799500wyb.19
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 02:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=tVM+ViMOvXVaG79KAU9F7A5ZFT+cwlnCICGyPc4bz38=;
        b=wqkZhaCnQ8aVg/EJ6vMmPZXSvnUVlOzhN1+0eb3MzwkDbepv9YwyCyCj9Q/QgMMbFw
         IJC2+b22C3sOKyix40kLgkMM418g/XMwDbEeFAHHIyaSk0uk7UlYUrbD4+2wpMuL3qSP
         q6V/RHMjb01k1DUtwWkpCetX7Z4aBvklE94TI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=C8MDtqzXhtKdb0cZT6ipA+GlCjToCY1c8KxSzmhsAyO8E7KaR34T5ed7dXHtv6Bnct
         4MuiLxb/iFUT7dzfLLAUlgSRQT8GCoTY42FpTgu3ODODCagGVKNPKWH++5awsiNeKvMd
         itiS11SMD0v88Ccgsu8MbBAUtEPaPAJzKdzN8=
Received: by 10.216.5.1 with SMTP id 1mr987795wek.2.1291201153663; Wed, 01 Dec
 2010 02:59:13 -0800 (PST)
Received: by 10.216.85.213 with HTTP; Wed, 1 Dec 2010 02:59:13 -0800 (PST)
In-Reply-To: <AANLkTik-OKsUK2aJCDR0Q-FyQM=rrFQmx=Hwdyr5NzYt@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162497>

On Tue, Nov 30, 2010 at 9:22 AM, Giuseppe Bilotta
<giuseppe.bilotta@gmail.com> wrote:
> On Tue, Nov 30, 2010 at 5:02 AM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> On Mon, Nov 29, 2010 at 8:05 PM, Giuseppe Bilotta
>> <giuseppe.bilotta@gmail.com> wrote:
>>> We allow valid_tool to be false in the x-www-browser case, in which
>>> case we test www-browser, and if it's still not valid we go on and use
>>> the previous paths. So we cannot die in case of an invalid
>>> (x-)www-browser.
>>
>> Yeah, you are right, but we could die after the "for i in $wwwbrowser"
>> loop if both are invalid.
>
> Why? If both are invalid, proceeding with the previous strategy of
> looking for a browser we _should_ be looking for any browser we know
> about, even if it's not set as the default system browser.

Currently we have:

97     if test -n "$browser" && ! valid_tool "$browser"; then
98         echo >&2 "git config option $opt set to unknown browser: $browser"
99         echo >&2 "Resetting to default..."
100         unset browser
101     fi

So if we want to be consistent with that behavior, we should probably do the
same thing if (x-)www-browser is set but we don't support it.

>>> But there's a bug in the www-brower testing, it needs
>>> an else that resets browser to the empty string.
>>
>> I thought it was by design that you did not reset it...
>> So yeah it is clearer and nicer for the user if you either reset
>> browser or just die if both (x-)www-browser are invalid. If you decide
>> to reset browser, perhaps a warning or an information message telling
>> that both are unknown would be nice.
>
> I can do that. Should it be a warning about reporting the lack of
> support to us, or just a warning that we are not going to use it even
> if it's defined?

I think it should be a warning that we are not going to use it even
if it's defined, to be consistent with the code pasted above.

If you think of something better or want to remove the warnings, please do
it in another patch.

> While we're at it: I was considering adding support for the BROWSER
> env var (a colon-separated list of browsers executables or "browser
> %s" strings).
>
> All of this is going to make the web--browse script very similar to
> the sensible-browser script in Debian, with the difference that we go
> at length to ensure that stuff is opened in a new tab, whereas
> Debian's sensible-browser doesn't. Should we just support
> sensible-browser instead of (x-)www-browser/BROWSER, and let it open
> anything?

I think most users prefer to open stuff in a new tab if possible.

Thanks,
Christian.
