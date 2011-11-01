From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: t5800-*.sh: Intermittent test failures
Date: Wed, 2 Nov 2011 00:02:29 +0100
Message-ID: <CALxABCbKSi-aHezjyn5wJ0-BPW1PvvaC2i9VeV7yXOf4yCdx4Q@mail.gmail.com>
References: <4E417CB4.50007@ramsay1.demon.co.uk> <CAGdFq_jv_T-x7VGqm_j-fDfeW6TsBG95=1TWn91Yk9B3TGZdsQ@mail.gmail.com>
 <7vpqjgyvn1.fsf@alter.siamese.dyndns.org> <4E68FE73.4000005@ramsay1.demon.co.uk>
 <20110908182055.GA16500@sigill.intra.peff.net> <4E6D089C.4090006@ramsay1.demon.co.uk>
 <CALxABCbnZp-y0Fqzoa=Ab92P+hsT7hs3nXZsnA=ph3yGfkXhdA@mail.gmail.com> <7vfwi7lc54.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 02 00:02:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLNM8-0002Bn-F9
	for gcvg-git-2@lo.gmane.org; Wed, 02 Nov 2011 00:02:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259Ab1KAXCv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Nov 2011 19:02:51 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:51614 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754057Ab1KAXCu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Nov 2011 19:02:50 -0400
Received: by qabj40 with SMTP id j40so6257624qab.19
        for <git@vger.kernel.org>; Tue, 01 Nov 2011 16:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=xLitmQ4jDHbgSBoo59fZh0opF+yr/Bdjv4g8AiQ5qvc=;
        b=XRQz/tkcSLqHwzGuIO9Qsx7BK/3b4fsWPGg+7wKMIBR4HkcFf3sQ8p+e+3eCTsHRkX
         ANHmqoCkhhTNrCFf6PYhfeJ5f94DAKw85AkQxIm1pXjoei63+2Irtn0CIYstBA94q1Mo
         JZ8css4juqR//do/LtzHhlU8jre3M243OdH6s=
Received: by 10.182.77.193 with SMTP id u1mr356628obw.33.1320188570107; Tue,
 01 Nov 2011 16:02:50 -0700 (PDT)
Received: by 10.182.193.100 with HTTP; Tue, 1 Nov 2011 16:02:29 -0700 (PDT)
In-Reply-To: <7vfwi7lc54.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184606>

On Tue, Nov 1, 2011 at 23:18, Junio C Hamano <gitster@pobox.com> wrote:
> Alex Riesen <raa.lkml@gmail.com> writes:
>
>> On Sun, Sep 11, 2011 at 21:14, Ramsay Jones <ramsay@ramsay1.demon.co=
=2Euk> wrote:
>>> ... these hangs *are* the failures of which I speak! =C2=A0Yes, the=
 script
>>> doesn't get to declare a failure, but AFAIAC a hanging test (and it
>>> isn't the same test # each time) is a failing test. :-D
>>
>> Was there any outcome of this discussion? I'm asking because I
>> can reproduce this very reliably on a little server here.
>
> I do remember this discussion and recall seeing _no_ outcome.
>
> I did see the hang myself once or twice but did not and do not have a
> reliable reproduction. I have been waiting for somebody to raise the =
issue
> again ;-).
>

I think I managed to bisect it (between 1.7.6 and 1.7.7):

$ git bisect start v1.7.7 v1.7.6
=2E..
$ git bisect good
a515ebe9f1ac9bc248c12a291dc008570de505ca is the first bad commit
commit a515ebe9f1ac9bc248c12a291dc008570de505ca
Author: Sverre Rabbelier <srabbelier@gmail.com>
Date:   Sat Jul 16 15:03:40 2011 +0200

    transport-helper: implement marks location as capability

    Now that the gitdir location is exported as an environment variable
    this can be implemented elegantly without requiring any explicit
    flushes nor an ad-hoc exchange of values.

    Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
    Acked-by: Jeff King <peff@peff.net>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

:100644 100644 1ed7a5651ef5a2320c56856b5a1fe784e178ab23
e9c832bfd3da7db771cc2113027d3e590dc51d59 M	git-remote-testgit.py
:100644 100644 0cfc9ae9059ce121b567406d7941b71cd54b961c
74c3122df1835c45a6b621205fb18b4fc89af366 M	transport-helper.c

Sadly, I'm going to be able to repeat the test in about 20 hours.
