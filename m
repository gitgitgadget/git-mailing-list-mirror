From: Junio C Hamano <gitster-vger@pobox.com>
Subject: Re: RFC: C code cleanup
Date: Fri, 3 Jun 2011 16:49:15 -0700
Message-ID: <BANLkTikxY8QcGO70Lg0HQAVZ9kwmsD0WF6HEoGC1bojWo4Myog@mail.gmail.com>
References: <3ECEA53B-C82C-4F3D-9E40-1D81EC17682E@petdance.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Andy Lester <andy@petdance.com>
X-From: git-owner@vger.kernel.org Sat Jun 04 01:49:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSe7F-0005xa-96
	for gcvg-git-2@lo.gmane.org; Sat, 04 Jun 2011 01:49:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755338Ab1FCXtR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Jun 2011 19:49:17 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:49629 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753350Ab1FCXtQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2011 19:49:16 -0400
Received: by wwa36 with SMTP id 36so2147822wwa.1
        for <git@vger.kernel.org>; Fri, 03 Jun 2011 16:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=wMpCfe7oldg/0AO4WCQBtWBmdrPN5NK4hiFbT/PILRc=;
        b=ew75wkHAtPD5Zd821b2d5pWjA6c4PT8SRW+fBCOZdmyUpl5RCa9xLvYiOIdmu8KW4p
         YvRl8zSmeVI9snd2qoxr465njHykJUnnPlvr2dYNRLkQaAVFVbU9Nqe8qjOdHE+b/Z+w
         /KuC8SB4heegEheidicjTZm3BRfO/Tg3+a0aM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=FoFmaMB7scu6RKAHvPV+mnyj4oKfhdB1lBwWZx250DVIwMzykTRIJNwXtKR0uaQpol
         xKv+3+YtH9ZwMj31XWfOnM+NmfrIRu7he7u8kgBarLp9gUeH5JHAi/ppKSTJL6K4KU2N
         WXUtZ3Fus8LcnILqi7aNdEHf+d0pfj1bL99aQ=
Received: by 10.216.171.18 with SMTP id q18mr973683wel.47.1307144955347; Fri,
 03 Jun 2011 16:49:15 -0700 (PDT)
Received: by 10.216.179.136 with HTTP; Fri, 3 Jun 2011 16:49:15 -0700 (PDT)
In-Reply-To: <3ECEA53B-C82C-4F3D-9E40-1D81EC17682E@petdance.com>
X-Google-Sender-Auth: yYO6uSpk-XjDS2tZpuyYcJtL-Ts
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175043>

Thanks. The ones I don't comment on below looked like sensible changes
(except that their log messages need to conform to the project's
style).

> diff --git a/test-date.c b/test-date.c
> index 6bcd5b0..42642ed 100644
> --- a/test-date.c
> +++ b/test-date.c
> @@ -16,7 +16,7 @@ static void show_dates(char **argv, struct timeval =
*now)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0}
>
> -static void parse_dates(char **argv, struct timeval *now)
> +static void parse_dates(char **argv)
> =C2=A0{

As parse-dates mode does not handle any "relative" dates now, the
parameter happens not to be used in today's code. But judging from the
caller and other callers in the same if/else cascade, it probably is
better to leave this as-is.

> @@ -61,7 +61,7 @@ int main(int argc, char **argv)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!strcmp(*argv, "show"))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0show_dates(arg=
v+1, &now);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (!strcmp(*argv, "parse"))
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 parse_dates(argv+1=
, &now);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 parse_dates(argv+1=
);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (!strcmp(*argv, "approxidate"))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0parse_approxid=
ate(argv+1, &now);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0else

> commit 151ad9c45f08aa81598664e6e198af881fe52b77
> Author: Andy Lester <andy@petdance.com>
> Date: =C2=A0 Wed Jun 1 23:16:10 2011 -0500
>
> =C2=A0 =C2=A0Removed unnecessary test in fuzzy_matchlines(). size_t c=
an never be negative
>
> diff --git a/builtin/apply.c b/builtin/apply.c
> index 530d4bb..7e6fa4d 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -250,9 +250,6 @@ static int fuzzy_matchlines(const char *s1, size_=
t n1,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *last2 =3D s2 + n2 - 1;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int result =3D 0;
>
> - =C2=A0 =C2=A0 =C2=A0 if (n1 < 0 || n2 < 0)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
> -

Looks like the author wanted to assert() to make sure the length
adjustments were not screwed up (a possible bug can be to update *.len
by subtracting too many, causing it to wrap around to become a
negative value but because size_t is unsigned, this is a wrong test to
catch it).

Perhaps casting these to ssize_t and dying with die("BUG: len
adjustment error") would be a better fix that is more faithful to the
intention of the original.
