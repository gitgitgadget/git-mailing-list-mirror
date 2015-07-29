From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v6 0/10] port tag.c to use ref-filter APIs
Date: Wed, 29 Jul 2015 15:27:21 -0400
Message-ID: <CAPig+cQv4BWFwgx7mDHh=gNpxbEeR7auw4os-tOpf3cGah=zpw@mail.gmail.com>
References: <CAOLa=ZR6_2NBB4v0Ynq391=8Jk2RZON6R0YG=HKUNwKx249b7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 21:27:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKX0k-0005SW-TL
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 21:27:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752616AbbG2T1W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Jul 2015 15:27:22 -0400
Received: from mail-yk0-f176.google.com ([209.85.160.176]:33995 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752406AbbG2T1W convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jul 2015 15:27:22 -0400
Received: by ykax123 with SMTP id x123so16582059yka.1
        for <git@vger.kernel.org>; Wed, 29 Jul 2015 12:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=1ggVVl8jBTSERc9s9zbdAuqUKgahGxsMHLrHv6i3sfo=;
        b=TpK1Ush4kwpzAgzu2XcdA832+aocA+GzFCGtApxseghUoqxk02H9BC9wDfiUNlGgGp
         1P1I1bGt4HVInPjC3S73k+maQluqC9C5w3Y1P3eqUY98d4JhvSYfjlCO2G5CmgRzn2DX
         20bbSScTttDBLGkxvwp3GPaysG69magUuvW6S+1tDcWVA4RNKeKDtFoR21m+PWgng6cc
         nNMPFE6K/q1F3tTN2iKhkk4x2qL96e6jD/gzocjmSfbuUHABxVWyTQyIlfJYayVo49He
         aDZX1tGObAYlpkh0xbi+VBjJXOr0yVJI+Isd6XOZF5XwirKaSHj1O1QIXIGEr4a8cCeJ
         J2kA==
X-Received: by 10.13.202.204 with SMTP id m195mr45995733ywd.48.1438198041492;
 Wed, 29 Jul 2015 12:27:21 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Wed, 29 Jul 2015 12:27:21 -0700 (PDT)
In-Reply-To: <CAOLa=ZR6_2NBB4v0Ynq391=8Jk2RZON6R0YG=HKUNwKx249b7Q@mail.gmail.com>
X-Google-Sender-Auth: ctJJ5vMwWNNhKMHmBLtcyzt4Ic0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274942>

On Tuesday, July 28, 2015, Karthik Nayak <karthik.188@gmail.com> wrote:
> Changes in v6:
> * Change the flow of commits, introduce rest_formatting_state.
> * Rename
> ref_formatting -> apply_formatting_state
> apply_pseudo_state -> store_formatting_state
> * Remove the patch for making color a pseudo atom, and rename
> pseudo_atom to modifier_atom.
> * Small grammatical changes.
>
> Side Note: --format=3D"%(padright:X)" applies to the next available a=
tom
> and not to the next span. I find this more accurate as I don't see wh=
y
> we'd want to pad something of known length. But its up for discussion

This isn't supported by the current %(padright:) syntax, but an
example would be if someone wants to pad a string composed of atoms
and literal strings. For instance, the user might want to right-pad
the composed string "%(refattribute1) glorked %(refattribute2)=E2=80=9D=
=2E

One possible syntax to support this sort of thing would be
%(padright:n:content). For instance, using the example above:

    %(padright:20:%(refattribute1) glorked %(refattribute2))

Another would be %(padright:n)content%(end). The %(end) token could
work with other formatting directives, such as left padding,
alignment, etc. For instance:

    %(padright:20)%(refattribute1) glorked %(refattribute2)%(end)

In fact, this sort of thing has come up multiple times, with the most
general being actual embedding of a full-blown scripting language to
support pretty much any desired formatting. Other less ambitious
proposals have also been suggested.

This isn't a suggestion that you should implement any of these, but
just a heads-up that, when it comes to formatting, it's not at all
uncommon for people to come up with needs not anticipated by the
design.
