From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH] push: introduce implicit push
Date: Mon, 15 Apr 2013 14:47:35 +0530
Message-ID: <CALkWK0kzpgucLbe5TtwbZ0st51+9ZW2hkML4=yHV4y--USfynA@mail.gmail.com>
References: <1365780835-2853-1-git-send-email-artagnon@gmail.com>
 <7v38uvcrjl.fsf@alter.siamese.dyndns.org> <CALkWK0=-GcOF17Q-y-Aqj0ThX5pPQFrriDqoJ2qsr=CS+wUNGA@mail.gmail.com>
 <7vehed7ilu.fsf@alter.siamese.dyndns.org> <CALkWK0k6bmjFxTSMAutgu2EjWRZ_cyTU9jZ3Er-aaV78T16RtQ@mail.gmail.com>
 <7vppxw335o.fsf@alter.siamese.dyndns.org> <516BA732.4080405@viscovery.net>
 <7vzjx01cqn.fsf@alter.siamese.dyndns.org> <20130415083558.GB2278@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Apr 15 11:18:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URfYN-0001pK-25
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 11:18:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752730Ab3DOJST convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Apr 2013 05:18:19 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:61021 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287Ab3DOJSS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Apr 2013 05:18:18 -0400
Received: by mail-ie0-f180.google.com with SMTP id a11so5596221iee.11
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 02:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=gJ0glSd/Cf6Cxo64rU/S4cBvGcXsYPtIwHqdqHSIuio=;
        b=Y19IK+809V/O7YbCOSGTBK1kGCTssWldPcRJDOt+4G5hqlPhRjry6JY1fOjsz6jCxC
         kxaXVAsor3A4AlM9s7/s56YMdnALbnQxrLo2nhMgpW++gT1HC9CZPnQ+IvIimlfAVEjv
         Rm8JpvvH3qWBaFlIMKAR5B5DUI3pcJDxegvLERhiO893TzuFMMrRvWGzvfNS061M01/7
         S8fyE0Il/2AI3IdFfrjli+mS9BHFlMMkRNGiz4Y3tlZ8rpAeCPg/PXVU2JdB031NpCOK
         bm/WkGLjBmclnyTPNMYdgM65UqdZpEBIjDfWAffK2G1qyDulm/RDBUG+9Ueq28vU98h+
         BY3A==
X-Received: by 10.50.108.235 with SMTP id hn11mr4593466igb.107.1366017495738;
 Mon, 15 Apr 2013 02:18:15 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Mon, 15 Apr 2013 02:17:35 -0700 (PDT)
In-Reply-To: <20130415083558.GB2278@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221206>

John Keeping wrote:
> I may be an atypical user, but my expectation currently is that
> branch.<name>.remote is what is used when I run "git push" with no
> additional arguments.
>
> This is probably because whenever I add additional arguments (current=
ly)
> I have to specify where I am pushing to.
>
> So I think breaking user expectations is a red herring here because t=
he
> current behaviour means that users cannot have any expectation of wha=
t
> will happen in this case.  Either you don't say anything and "git pus=
h"
> DTRT for your current branch or you must specify precisely what you w=
ant
> to happen (or at least the remote to use if you have push.default =3D
> matching or remote.<name>.mirror set).
>
> Personally I'd vote for "git push -- master" pushing to
> remote.pushdefault, but I really don't know how you handle "git push =
--"
> with the na=C3=AFve implementation of that - is it the same as "git p=
ush" or
> "git push $(git config remote.pushdefault)"?

We're not changing, or even discussing, what a plain git push without
destination or refspecs specified should do (yes, that means git push
-- too); it depends on push.default, which already exists.  My
proposal does not aim to change the current behavior of _any_ current
invocation (that means git push, git push origin master, git push next
master v1.2, and so on). It aims to make the new syntax git push
master +next behave logically.  I think we can all agree that the
logical solution (leaving aside founded/ unfounded user expectations)
is to pick destinations for each of the branches specified
individually.  As I explained in my last email, using
remote.pushdefault is Wrong because it treats branches like tags, and
invents a new precedence.  Voting without a basis is useless: do you
have a counter-argument for the points I raised as to why it is Wrong?
