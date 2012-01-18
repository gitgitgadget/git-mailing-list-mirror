From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 2/2] diff --word-diff: use non-whitespace regex by default
Date: Wed, 18 Jan 2012 15:32:29 +0800
Message-ID: <CALUzUxqXTXZv4RE=4rBa79T3_1y7UdqZ6okjC1y-Ve+=NDbQ2g@mail.gmail.com>
References: <1326302702-4536-1-git-send-email-rctay89@gmail.com>
	<1326302702-4536-2-git-send-email-rctay89@gmail.com>
	<87lipexawp.fsf@thomas.inf.ethz.ch>
	<CALUzUxo3DcKqC6sQFQ1Oi0vgASFSHCcmOgHAj2_4c3vEjy663w@mail.gmail.com>
	<87ipkhqnr8.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Jan 18 08:32:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnQ0d-0001cn-Oz
	for gcvg-git-2@lo.gmane.org; Wed, 18 Jan 2012 08:32:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752243Ab2ARHce convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Jan 2012 02:32:34 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:35713 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751380Ab2ARHcd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jan 2012 02:32:33 -0500
Received: by dake40 with SMTP id e40so1089675dak.19
        for <git@vger.kernel.org>; Tue, 17 Jan 2012 23:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=bM12RpFqSecwBxplW1INyWEMOn/nsRBgGowqOc7nygY=;
        b=WOD7miSUGo0l9yPR/qkf9yFz+k+7YS22Jx2s7Fx3l7o8l/BHJo+mdf0lv3giFlwvQT
         W0jyHCk8oLzv4VgHcnU8T3mg2C8QzgneoL6t+6UE7wieqNc1DRuioVV7sK1Vu5xwEio1
         63qF+AXis6Xo6zRkPTicbMGmMlAf9wY8p5RmA=
Received: by 10.68.75.11 with SMTP id y11mr41824810pbv.51.1326871949917; Tue,
 17 Jan 2012 23:32:29 -0800 (PST)
Received: by 10.143.31.18 with HTTP; Tue, 17 Jan 2012 23:32:29 -0800 (PST)
In-Reply-To: <87ipkhqnr8.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188740>

On Thu, Jan 12, 2012 at 5:22 PM, Thomas Rast <trast@student.ethz.ch> wr=
ote:
> [snip]
> Case in point, consider my patch sent out yesterday
>
> =A0http://article.gmane.org/gmane.comp.version-control.git/188391
>
> It consists of a one-hunk doc update. =A0word-diff is not brilliant:
>
> =A0-k::
> =A0 =A0 =A0 =A0 =A0Usually the program [-'cleans up'-]{+removes email=
 cruft from+} the Subject:
> =A0 =A0 =A0 =A0 =A0header line to extract the title line for the comm=
it log
> =A0 =A0 =A0 =A0 =A0[-message,-]
> =A0[- =A0 =A0 =A0among which (1) remove 'Re:' or 're:', (2) leading-]
> =A0[- =A0 =A0 =A0whitespaces, (3) '[' up to ']', typically '[PATCH]',=
 and-]
> =A0[- =A0 =A0 =A0then prepends "[PATCH] ".-]{+message.+} =A0This [-fl=
ag forbids-]{+option prevents+} this munging, and is most
> =A0 =A0 =A0 =A0 =A0useful when used to read back 'git format-patch -k=
' output.
> [snip the rest as it's only {+}]
>
> But character-diff tries too hard to find common subsequences:
>
> =A0$ g show HEAD^^ --word-diff-regex=3D'[^[:space:]]' | xsel
>[snip]
> =A0w-]{+. =A0T+}hi[-te-]s[-paces, (3) '[' up t-] o[-']', ty-]p[
>
> is just line noise? =A0The colors don't even help as most of it is re=
moved
> (red).

You missed the '+' quantifier, as in

  [^[:space:]]+

Using that regex, that abomination of a word-diff that you mentioned
disappears, like this:

-k::
	Usually the program [-'cleans up'-]{+removes email cruft from+} the Su=
bject:
	header line to extract the title line for the commit log
	[-message,-]
[-	among which (1) remove 'Re:' or 're:', (2) leading-]
[-	whitespaces, (3) '[' up to ']', typically '[PATCH]', and-]
[-	then prepends "[PATCH] ".-]{+message.+}  This [-flag
forbids-]{+option prevents+} this munging, and is most
	useful when used to read back 'git format-patch -k' output.

> [snip]
> That being said, I can see some arguments for changing the default to
> split punctuation into a separate word. =A0That is, whereas the curre=
nt
> default is semantically equivalent to a wordRegex of
>
> =A0[^[:space:]]*
>
> (but has a faster code path)

Oh right, there *is* a sensible default implemented in. Somehow I was
under the impression that there wasn't.

I wonder which is faster, using the non-whitespace regex, or the
isspace() calls...

> and your proposal is equivalent to
>
> =A0[^[:space:]]|UTF_8_GUARD
>
> I think there is a case to be made for a default of
>
> =A0[^[:space:]]|([[:alnum:]]|UTF_8_GUARD)+
>
> or some such. =A0There's a lot of bikeshedding lurking in the (non)ex=
tent
> of the [[:alnum:]] here, however.

Care to explain further? Not to sure what you mean here.

--=20
Cheers,
Ray Chuan
