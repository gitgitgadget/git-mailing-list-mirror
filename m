From: Nathan Gray <n8gray@n8gray.org>
Subject: Re: Why aren't tag refs namespaced?
Date: Thu, 26 Apr 2012 16:33:07 -0700
Message-ID: <CA+7g9JzpLkNHT_o1QyJ_r=4DrauWOPFr5XR_CPeAHGcLpLoD+w@mail.gmail.com>
References: <CA+7g9Jxc6eaCUR8aVhqKH--sOrvQVrZn+se7wtFJsOiKNjz9Pg@mail.gmail.com>
	<xmqqty068ffd.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 27 01:34:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNYBa-0005SU-6x
	for gcvg-git-2@plane.gmane.org; Fri, 27 Apr 2012 01:33:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759185Ab2DZXdK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Apr 2012 19:33:10 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:52771 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750864Ab2DZXdJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Apr 2012 19:33:09 -0400
Received: by bkuw12 with SMTP id w12so101552bku.19
        for <git@vger.kernel.org>; Thu, 26 Apr 2012 16:33:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-originating-ip:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=1fuMYyavOcCbxaDZsBF2Rqw+pzKjX+tya11TgWcPJe0=;
        b=dUhtY/6vlX2GDtf8AYdgDoGN885Cv10sZu5yVgtbF92SMEqcR3b9fz9sS7noh7d440
         WOq3kV9EcqlZtPEWaZ0RhDzxHj9M5EblIV+QKjIGsNoXjvrcWitpq0V38crtcIFFQpeL
         bBJBAiiMS7+dbKaI9snBRIpQgN56tnvuYO1nG4zr3wQhFOCW4bboqXuHHSXXyYlSviDr
         m7YFCnd4uaz9DPAsmLT2SW+bq0RQ68+GdymUu8AEWQrLe6se55yk2uPFcQ/KabkKaD/g
         5gd96LcMOUn8g1PysgfgBxb+vZ5+yGZ8+Pgxx8jwsnE5vjyfX1ShYrmr8AA8JVTUvYoB
         1r4g==
Received: by 10.204.128.75 with SMTP id j11mr2914616bks.2.1335483187725; Thu,
 26 Apr 2012 16:33:07 -0700 (PDT)
Received: by 10.205.119.8 with HTTP; Thu, 26 Apr 2012 16:33:07 -0700 (PDT)
X-Originating-IP: [184.182.186.242]
In-Reply-To: <xmqqty068ffd.fsf@junio.mtv.corp.google.com>
X-Gm-Message-State: ALoCoQnpIAbN/uEuMDW98oVgTrskNu9tsh4it8Ms6D2I+9M4yKTf1VvSTrQ9SaGGQR7lRwLQtWtn
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196445>

On Thu, Apr 26, 2012 at 12:24 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Nathan Gray <n8gray@n8gray.org> writes:
>
>> So why is it that tag refs don't follow this model?
>
> Because the assumed development model for "people work inside their
> private world (i.e. "branch"), but integration happens in common
> namespace (i.e. somebody eventually pushes to "master branch" of the
> repository that every project participant considers authoritative) an=
d
> the end product of the project is tagged there for everybody's
> consumption. =A0When something is called "version 1.0", it only invit=
es
> confusion if _my_ Git version 1.0 is different from _your_ Git versio=
n
> 1.0, and it makes no sense for tags used in this manner not to be in =
a
> global single namespace. =A0People need to qualify such "version 1.0"=
 as
> "Junio's version 1.0" vs "Nathan's version 1.0" if they want to avoid
> confusion anyway, and at that point you would not be talking about
> refs/tags/v1.0, but refs/tags/jc/v1.0 vs refs/tags/ng/v1.0 or somethi=
ng.

I see your point, but the assumption that there is some global tagging
authority is quite surprising to me, considering the distributed
nature of git.  And honestly, I don't think it would be so confusing.
Imagine:

[~/src/git]$ git tag
my-tag
my-other-tag

[~/src/git]$ git tag -a
my-tag
my-other-tag
remotes/joeShmoe/v1.0
remotes/junio/v1.0

I think people would know which v1.0 to trust, in the same way that
they know which is the authoritative branch when dealing with multiple
remotes.

I actually think this model is less confusing, in the sense that it
helps unify the concept of "remote".  There's this thing called a
remote that represents the last-known state of a remote repository.
That state includes branches, tags, etc.  You can choose to
incorporate that state into your own or ignore it, but it
fundamentally belongs to the other repo and you can't change it except
by pushing.  Right now that's the way that branches work, but tags
have their own rules for you to learn.

> Other workflows that use private tags are possible and they might
> benefit from having separate namespaces; it is just that they are not
> the workflow Git was originally designed to support.

That makes sense.

Cheers,
-n8

--=20
HexaLex: A New Angle on Crossword Games for iPhone and iPod Touch
http://hexalex.com
On The App Store: http://bit.ly/8Mj1CU
On Facebook: http://bit.ly/9MIJiV
On Twitter: http://twitter.com/hexalexgame
http://n8gray.org
