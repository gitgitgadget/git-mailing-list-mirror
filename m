From: Chirayu Desai <chirayudesai1@gmail.com>
Subject: Re: "git tag --contains <id>" is too chatty, if <id> is invalid
Date: Sat, 19 Mar 2016 22:19:02 +0530
Message-ID: <CAJj6+1Fcp+Fjx9N6Mon1A5uP-_npnPL1Acu5-cR_bHVfs3EMWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, peff@peff.net
X-From: git-owner@vger.kernel.org Sat Mar 19 17:49:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahK3q-0001Ot-VO
	for gcvg-git-2@plane.gmane.org; Sat, 19 Mar 2016 17:49:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754685AbcCSQtG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Mar 2016 12:49:06 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:34277 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750783AbcCSQtD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Mar 2016 12:49:03 -0400
Received: by mail-io0-f171.google.com with SMTP id m184so170027841iof.1
        for <git@vger.kernel.org>; Sat, 19 Mar 2016 09:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to
         :content-transfer-encoding;
        bh=c5cI3ICSQDXBTbJ/uq9ELNIdXkD8CPEn/wmizqnttv0=;
        b=m2QGycGlLbmd0KxiQ2osLtL/VJFNdGLQ4W5BfdN7skqajrrkjKPJtq1bT8Hj4+iK+W
         eSq8LAPZnvGhdLUYkoIeJZECjVqOC61x2KXdEDzGRc+ALWFBqkV282Kw4hOXXUModqi6
         DevVSFPczRDzlr8jPvo14yAp6tGFyvh/IsPXBJ4cOelJQLkvMHx4VqtKfWRsfg5OMaAj
         S/ek3vVQuXoi8ABrXlenYdXAlv6LlEeZnvmuKOFJwlkg1DTZavL2h/5DdN0X9pKoFkKn
         nA6QhD9EBJXnwo51c7yhIzSvxJJRq/dpCNTut24mC4edlMA8073KJxhhxL03KAh2T+NA
         YwaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-transfer-encoding;
        bh=c5cI3ICSQDXBTbJ/uq9ELNIdXkD8CPEn/wmizqnttv0=;
        b=R2xCFP91Lsu5KKE3noI6IT9Z1Vkyka0lVEnbe65E5my3hfnRBsR0jYaFuze3qGm17F
         eyFh6VZPIU2NoZIbIX2MMJ9pTiUkdbpJIUxgjgJtsB9A+KMQZkZdFQQ/2ifYLGJss1Nj
         Mkmk3w4QTubpSrd45s/GTxSTJsRPQEfSL3xVpBJ3sVDYtXYZO7M/a+JLGcEwoTkklZrB
         Gk0GcpAv0l9COJrJPiFE2+zSIefo1C52mYxlfPRPHpE8WgZ0WCEGpkxh2MIaiDv1cWLR
         sK/j10YJ3RAigzop+GoiqdYfNC2vUMOVZe0Dxuxkt+2kIRv/MZycKoL6n6hvQI45kw/G
         QnyQ==
X-Gm-Message-State: AD7BkJKHyN+lPXnLQ7TkafX/L1N/ZFMyAyhd8eNFafxXIs4d9UH8gkz2By19F4acfknJf7+4k+BvuHZHNuc+4A==
X-Received: by 10.107.134.94 with SMTP id i91mr21721923iod.95.1458406142050;
 Sat, 19 Mar 2016 09:49:02 -0700 (PDT)
Received: by 10.79.31.7 with HTTP; Sat, 19 Mar 2016 09:49:02 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289312>

Hi, I want to work on this as my GSoC micro project.

> On Mon, Jan 18, 2016 at 10:24:31PM +0100, Toralf F=C3=B6rster wrote:
> > very first line is "error: malformed object name <id>" which tells =
all, or ?
> Yeah, I agree that showing the "-h" help is a bit much.
> This is a side effect of looking up in the commit in the parse-option=
s
> callback. It has to signal an error to the option parser, and then th=
e
> option parser always shows the help on an error.
> I think we'd need to do one of:
> 1. call die() in the option-parsing callback (this is probably a bad
> precedent, as the callbacks might be reused from a place that wants
> to behave differently)
I assume you mean parse-options-cb.c:parse_opt_commits() by the callbac=
k.
I see that it is currently used only by commands which have a "--with"
or "--contains" option,
and all of them behave the same way, printing the full usage, so a one
line change in that function would fix it for all of those.
> 2. have the callback just store the argument string, and then resolve
> the commit later (and die or whatever if it doesn't exist). This
> pushes more work onto the caller, but in this case it's all done by
> the ref-filter code, so it could presumably happen during another
> part of the ref-filter setup.
I'm not quire sure how exactly to do that.
> 3. teach parse-options to accept some specific non-zero return code
> that means "return an error, but don't show the usage"
This sounds good, but also the most intrusive of 3.
> I think any one of those would be a good project for somebody looking=
 to
> get their feet wet in working on git. I think (2) is the cleanest.
> -Peff

What would be the best way to proceed with this?

Thanks,
Chirayu Desai
