From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/4] cat-file: add --batch-disk-sizes option
Date: Mon, 8 Jul 2013 17:30:21 +0530
Message-ID: <CALkWK0ktNK49zBM4tD8fpNN3VMan7DegfWRtDcOEgTyEbSK9Uw@mail.gmail.com>
References: <20130707100133.GA18717@sigill.intra.peff.net> <20130707100949.GC19143@sigill.intra.peff.net>
 <7vtxk645vp.fsf@alter.siamese.dyndns.org> <CACsJy8A8ZO3DL8Vr=S1G-3yiJz3WaZ-7jV_eA+v6rPAWrd9NAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 08 14:01:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwA8T-0007jc-Sm
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 14:01:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752328Ab3GHMBh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jul 2013 08:01:37 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:35700 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752158Ab3GHMBC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jul 2013 08:01:02 -0400
Received: by mail-ie0-f174.google.com with SMTP id 9so9535645iec.5
        for <git@vger.kernel.org>; Mon, 08 Jul 2013 05:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=GF8y1aFVYoLl26o82qfIvPymK4pZ5LgTp++m9vkwwh0=;
        b=cFDmGYn4leuoL/nMVbIFipVZPPppOAOUjun3TyM7/N8eQudExw2cWU+ZoM+wy84M6u
         589kuwHNAd49p6Pakcdh/yVE33bQYCkIyCadKq4PRh/rvomxT4P/SjxCGyS2pqdWLUv8
         4GLUPy4pi3ho/GrCbK4F1V2DV4wx6ciS2il4EbBFyNcudw6Kh1uG/rMSzc6TuOmK8IPN
         0kkCtW39xV1MOnJu/XIfnL593BmqwopitGTz/pW6qkeGU/H+7MF2Fu9o5msDDZoFDBHf
         FE8gyTKd8SSHAxzq+gacYaNvUAwbo9d7enfFntiJ9P6wLjT3MxsMPi4TYzdeMjcioqU3
         WbMQ==
X-Received: by 10.50.225.66 with SMTP id ri2mr8336086igc.55.1373284861613;
 Mon, 08 Jul 2013 05:01:01 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Mon, 8 Jul 2013 05:00:21 -0700 (PDT)
In-Reply-To: <CACsJy8A8ZO3DL8Vr=S1G-3yiJz3WaZ-7jV_eA+v6rPAWrd9NAw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229842>

Duy Nguyen wrote:
> Ram, are you still interested in the awesome branch series?

Yep, but it got stalled due to lack of reviewer-interest :/

I'm a bit under the weather at the moment, but it's good to see that
you're back: let's finish this soon.

>>> Perhaps we need
>>>
>>>   git cat-file --batch-format="%(disk-size) %(object)"
>>>
>>> or similar.
>
> This is what I wanted to do with the in for-each-ref's pretty
> formatting [1]. I used to hack cat-file --batch to extract info I
> needed for experimenting with various pack index extensions. If you
> are not in hurry, maybe we can introduce something similar to your
> syntax, but applicable for all for-each-ref, branch and log family.

I'm still quite confused about this "grand plan".  We have short
commit-specific format specifiers that don't work with refs, among
several other quirks in [1].  I personally think we should absolutely
stay away from short format-specifiers (like %H, %f, %e; we'll soon
run out of letters, and nobody can tell what they are without the
documentation anyway) for the new options, and just start adding new
long-form ones as and when they are necessary.  I think refname:short,
upstream:track, upstream:trackshort are very sensible choices, and
that we should continue along that line.  I'm fine with
format-specifiers having meanings only in certain contexts as long as
we document it properly (how can we possibly get %(refname) to mean
something sensible in cat-file?).

As far as this series is concerned, I think Peff can implement %H and
%(object:[disk-]size) locally without worrying about code-sharing or
waiting for us.  Then, after the for-each-ref-pretty thing matures, we
can just replace the code underneath.
