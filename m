From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: Conditionally define vars to improve portability
Date: Tue, 8 Sep 2015 13:09:15 -0700
Message-ID: <CA+P7+xopnAfmKNfL=p5wrqfLx5CENcBoFkdZ1swLe+3PchcONQ@mail.gmail.com>
References: <81961DE1-FA30-4E55-8818-9FCA3BC59B81@FreeBSD.org>
 <20150908063034.GF26331@sigill.intra.peff.net> <xmqqvbbk7n8r.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Renato Botelho <garga@freebsd.org>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 08 22:09:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZPD2-0000Xm-Hb
	for gcvg-git-2@plane.gmane.org; Tue, 08 Sep 2015 22:09:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751912AbbIHUJh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2015 16:09:37 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:35628 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751674AbbIHUJf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2015 16:09:35 -0400
Received: by igbkq10 with SMTP id kq10so83389264igb.0
        for <git@vger.kernel.org>; Tue, 08 Sep 2015 13:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=RrxoEFZ9BXyFfuPpzjAhf0bM34avr5aQ6wHXEV+9emw=;
        b=032g3onS2Q0iGHKH6IsTkwEnKNzXGi9wHVDDIxfxfDOLYUzz2yRGRcynqLRlwvHZ74
         cjKP2WDhBAX73n8XOP7W25zyHP6aPJeai/ULk6XnFziLNZ4DCrXHs4YP4iFRTKTjZi/X
         TnNm9KYxWi12ZMN1Cno6OmgekK+ZAc/lcviHn8bdpTsbEvC6q6R4a2KSG0P7Mjze0yRP
         Uvi3osldlxB1F4l+n35O2u1CGfj8nKh0aDuS2DqMdpfagoVGdscCz75rektsetqeMzyo
         N+55w1p60NnJu8jtALOmQ+z3p+jeOA9f8Q4JaWh6ZIe+VPODfNsmydChWvOFEsGSEyeP
         vMfQ==
X-Received: by 10.50.78.161 with SMTP id c1mr45234502igx.35.1441742975035;
 Tue, 08 Sep 2015 13:09:35 -0700 (PDT)
Received: by 10.107.5.203 with HTTP; Tue, 8 Sep 2015 13:09:15 -0700 (PDT)
In-Reply-To: <xmqqvbbk7n8r.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277523>

On Tue, Sep 8, 2015 at 11:57 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Common things like CC are not so problematic, but more problematic
> are various Git build customization in our Makefile that can be left
> behind from a previous build.  It is easier for users to forget, as
> a "GIT_FOO=NoThanks; export GIT_FOO" that was run previously in the
> same shell does not leave trace once the shell exits, compared to
> other avenues of customization including config.mak and explicit
> command line settings given to the 'make' utility (i.e. can be seen
> in 'history' as a single entry, without having to trace the sequence
> of 'GIT_FOO=NoThanks', 'export GIT_FOO' and possible 'unset GIT_FOO'
> to find what was in effect when 'make' was run).  So from that point
> of view, if you encourage users to be less explicit by keeping them
> in the environment, you are making it easier for the users to hurt
> themselves.

It should be noted that a common idiom is also "VARIABLE=VALUE Make"
where we set the variable in the environment before running the
command. This would begin working if you allow the =? setting of
variables.

That being said, since "make VARIABLE=VALUE" already works, and is
really just as easy to type as above, I think I prefer your argument
overall. We shouldn't encourage people to use the environment, and
instead use config.mak or other methods which are far more explicit.
