From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 09/19] documentation: add documentation for the bitmap format
Date: Fri, 25 Oct 2013 13:47:06 +0000
Message-ID: <CAJo=hJvmL0=MN7W-NW4bACK0m+Y39+LBVZ+ufXTEh8KzyjFbKg@mail.gmail.com>
References: <20131024175915.GA23398@sigill.intra.peff.net> <20131024180347.GI24180@sigill.intra.peff.net>
 <CACsJy8DFisnZZiPOWjktuMC2J289AYGtgefZob=4YFAJAxBc6w@mail.gmail.com> <20131025032144.GB26283@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Vicent Marti <vicent@github.com>
To: Jeff King <peff@peff.net>, Colby Ranger <cranger@google.com>
X-From: git-owner@vger.kernel.org Fri Oct 25 15:47:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZhjg-00038z-Tt
	for gcvg-git-2@plane.gmane.org; Fri, 25 Oct 2013 15:47:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752995Ab3JYNr3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Oct 2013 09:47:29 -0400
Received: from mail-wg0-f54.google.com ([74.125.82.54]:45331 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752573Ab3JYNr2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Oct 2013 09:47:28 -0400
Received: by mail-wg0-f54.google.com with SMTP id c11so3909571wgh.9
        for <git@vger.kernel.org>; Fri, 25 Oct 2013 06:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=4tPHKwk2GLp+LF56lT8QFETBRL/SI4mYtcR1hOnwEvk=;
        b=IwPiLCZyK3njevjf6IqNXZ4U8GdFOGXR3UkfDPwfdiBcRR1+8qKdiv+7niRfUsF142
         GyKtcEc+KWZaDFVfsnVTbxfapJMcv9TFrrQxBjt6bLvFHAbTi3PHauYy1U6SCbp+Qm6B
         ClYXpA6T6uWEfRX+nLfW4tZjHV+r4V7tM3Dj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=4tPHKwk2GLp+LF56lT8QFETBRL/SI4mYtcR1hOnwEvk=;
        b=FN595Ilo+Gxj6JhrXRPcBeSG7i7wLQVMTDXueD4gqqujCXn6WEgQN31qzVDll5sWuU
         A6tTjCRT6NJ7RI+OjawvW++MjcPFF5MYDIE+a9Lh5vT4gSBCBTJebXOEbPAIpAcZMNh+
         gFmOMbTiEXZ7M6yNDv/bKp0GEduWqLh7t/wZybTXBmHFTJ8sGsRPMgPRj3xXQfeYFPR4
         H2JOVCnnGtb6t1puhTMRXiTDyFnaPEw3JGl+04IYntq3hWvOuU2S0uM6f3b/2SooYHpQ
         aR0xuu8lHz7IoxjjljiGdMledRP5GTR1tfynwj86VXJP3fUNLn2hCT66JlQVHXu5JcJ6
         Sx0Q==
X-Gm-Message-State: ALoCoQkwkIdx//JklFf8f4a35otXB8V3FypI006Bs2d6orn326FVgDuhWPl1fs6Gw+NBfE8xd8w0
X-Received: by 10.180.187.169 with SMTP id ft9mr2704170wic.14.1382708846705;
 Fri, 25 Oct 2013 06:47:26 -0700 (PDT)
Received: by 10.227.62.140 with HTTP; Fri, 25 Oct 2013 06:47:06 -0700 (PDT)
In-Reply-To: <20131025032144.GB26283@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236702>

On Fri, Oct 25, 2013 at 3:21 AM, Jeff King <peff@peff.net> wrote:
> [+cc spearce; sorry, I really should have cc'd the whole series to you
>      in the first place]
>
> On Fri, Oct 25, 2013 at 08:16:18AM +0700, Nguyen Thai Ngoc Duy wrote:
>
>> > +       - A header appears at the beginning:
>> > +
>> > +               4-byte signature: {'B', 'I', 'T', 'M'}
>> > +
>> > +               2-byte version number (network byte order)
>> > +                       The current implementation only supports version 1
>> > +                       of the bitmap index (the same one as JGit).
>>
>> I suppose this means if I want to extend pack bitmaps to be used on
>> shallow clones, I need to step version to 2 before adding the shallow
>> points in .bitmap file as there's no chance of modifying v1 anymore,
>> correct?
>
> It depends on how you want to change it. And what Shawn says. :)

Correct, I think we need to bump to version 2 for any changes.

> This is an attempt to document the JGit format. My feeling is that there
> should be a version bump if an existing implementation would barf on it,
> and I assume Shawn would agree.  But if you want to simply add extra
> data that would be ignored by an existing implementation, it would be OK
> to add the data and mark it with a flag:
>
>> > +               2-byte flags (network byte order)
>> > +
>> > +                       The following flags are supported:
>> [...]
>
> That's how we added the name-hash cache in the final patch.
>
> That being said, JGit is _not_ happy with that, and complains when any
> flags besides OPT_FULL are used.  Whether that is because I am
> misinterpreting the intent of the flags field, or because JGit is being
> overly strict is up for debate.

Flags was created by Colby, I don't think he intended to use it for
determining if an optional section exists in the file or not. There is
insufficient information using only 1 bit to skip over an optional
section. The dircache file uses a length field with each extension
name to allow a reader to skip over sections it does not recognize
(and whose name is lowercase).

I think Colby and I talked about having additional optional sections
in this file, but Colby didn't want to overcomplicate the format early
on. So v1 is probably not very extensible and we may have to go to v2
to safely create an extension with the name hash cache used in this
series.

Given that the JGit v1 bitmap format has been shipping since JGit 3.0
and in Gerrit Code Review 2.6, its in use in the wild. So we aren't
going to go back and redefine v1.
