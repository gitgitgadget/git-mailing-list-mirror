From: xzer <xiaozhu@gmail.com>
Subject: Re: [PATCH] generate a valid rfc2047 mail header for multi-line subject.
Date: Thu, 24 Feb 2011 00:16:04 +0900
Message-ID: <AANLkTimUXqKdTDcSVDK44XPhxWbHtQuDWHMED3PKqWE4@mail.gmail.com>
References: <1297670968-28130-1-git-send-email-xiaozhu@gmail.com>
	<7vsjvfby0z.fsf@alter.siamese.dyndns.org>
	<20110223080854.GB2724@sigill.intra.peff.net>
	<20110223094844.GA9205@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 23 16:16:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsGRo-0003wW-Sa
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 16:16:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753245Ab1BWPQH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Feb 2011 10:16:07 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:35457 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753109Ab1BWPQF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Feb 2011 10:16:05 -0500
Received: by iyb26 with SMTP id 26so2848235iyb.19
        for <git@vger.kernel.org>; Wed, 23 Feb 2011 07:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=D1VghktycG9tagi+DrL+ruR5EGDH0Mp8dRKw/6aKltU=;
        b=pmjqQdwBvukby5G7DnS5F5KwT7VqAYPW2Yr4LzawRdzv4ksPnXxfIv6mfk6cXJ58gG
         6wIqY2roCoSlwXMBXgHjE6P+WJfjOZoICAwe81odvb2LS2/PembREm0XubAM8TtL7oTI
         febmvdvpYoa7JjFlocPfSPI3A7keaHhmo9CWY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=sIhdsi/RItSxsrYfbSVekLCg9rxuShMq6x4rbDpDpzVRtyRe2ncYmXBcXjclE1f/cH
         swwZZxIxK5Eu0NUKwcM2917VNGoyQxAjilicW/QXLt5Jl0C9dgVk4hPrj/2VFjw9VHU+
         gUmU6Aja+EGGCH1zwvY/dGCJNUW+ePACQ0+uk=
Received: by 10.42.169.71 with SMTP id a7mr5095046icz.268.1298474164530; Wed,
 23 Feb 2011 07:16:04 -0800 (PST)
Received: by 10.231.35.3 with HTTP; Wed, 23 Feb 2011 07:16:04 -0800 (PST)
In-Reply-To: <20110223094844.GA9205@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167696>

2011/2/23 Jeff King <peff@peff.net>:
> On Wed, Feb 23, 2011 at 03:08:54AM -0500, Jeff King wrote:
>
>> Yeah, I think the best path forward is:
>>
>> =C2=A0 1. Stop feeding "pre-folded" subject lines to the email forma=
tter.
>> =C2=A0 =C2=A0 =C2=A0Give it the regular subject line with no newline=
s.
>>
>> =C2=A0 2. rfc2047 encoding should encode a literal newline. Which sh=
ould
>> =C2=A0 =C2=A0 =C2=A0generally never happen, but is probably the most=
 sane thing to do
>> =C2=A0 =C2=A0 =C2=A0if it does.
>>
>> =C2=A0 3. rfc2047 should fold all lines at some sane length. As it i=
s now, we
>> =C2=A0 =C2=A0 =C2=A0may sometimes generate long lines in headers (th=
ough in practice, I
>> =C2=A0 =C2=A0 =C2=A0doubt this is much of a problem).
>
> So here is a series that does this. It still doesn't preserve subject
> newlines in "format-patch | am", but I don't think that was ever a go=
al
> of the code. If we want to add it as an optional feature on top (mayb=
e
> as part of "-k"?), it should be easy to do (since the rfc2047 encodin=
g
> will now preserve embedded newlines).
>
> =C2=A0[1/3]: strbuf: add fixed-length version of add_wrapped_text
> =C2=A0[2/3]: format-patch: wrap long header lines
> =C2=A0[3/3]: format-patch: rfc2047-encode newlines in headers
>
> -Peff
>

To the first point, I really want to find a way that we can remain the
line breaker
after import a formatted patch. That's why I add a new function to prod=
uct multi
line header, I want to do something which is special to subject. In my =
usage,
I told my men every day that don't write too long in the first
paragraph, but there
are always somebody who forgets it, then I will get a patch with a
very long subject
just like a nightmare(yes, I gave them my temporary fix which I submitt=
ed here,
so they can write as long as they want).

So I want to know whether we can generate a 2047 compatible header so
that mailer
can catch it correctly and the git-am can import it with line breaker
correctly too.
