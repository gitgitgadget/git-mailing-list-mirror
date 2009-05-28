From: Ealdwulf Wuffinga <ealdwulf@googlemail.com>
Subject: Re: RFE: "git bisect reverse"
Date: Thu, 28 May 2009 22:07:29 +0100
Message-ID: <efe2b6d70905281407x56bb788aq3dba4b27eb91d7a6@mail.gmail.com>
References: <4A1C6B70.4050501@zytor.com> <4A1CACB2.7000702@vilain.net> 
	<4A1CBF7A.3090708@zytor.com> <200905270726.59883.chriscool@tuxfamily.org> 
	<efe2b6d70905271411g4e1616b5w548141ee9fab2c14@mail.gmail.com> 
	<20090527211836.GA14841@localhost> <efe2b6d70905271507s187babe9yf19a25268ab0b95e@mail.gmail.com> 
	<4A1E00F1.4030709@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Clemens Buchacher <drizzd@aon.at>,
	Christian Couder <chriscool@tuxfamily.org>,
	Sam Vilain <sam@vilain.net>,
	Git Mailing List <git@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Thu May 28 23:08:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9mpU-0004a0-1a
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 23:08:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763530AbZE1VHt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 May 2009 17:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762294AbZE1VHt
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 17:07:49 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:40464 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756638AbZE1VHs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 May 2009 17:07:48 -0400
Received: by ewy24 with SMTP id 24so5819003ewy.37
        for <git@vger.kernel.org>; Thu, 28 May 2009 14:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=amyoNWRFALE1lpdDdIMi5aOBAYiPW3rrrwg89PRN3hc=;
        b=HUmokYtaVPRMzVxhfBSI/EKS4QhtWYvquabvBafSCxqfIiil6RJFUMDYUPZZqcRJoo
         IF9qdoT0MgwEv8ujXnTk2KEV4qLELDewRIf1slewjDHK8ct5BOaQwp20gRVzpNM4MmFI
         HpAZTry/ha1DQhGbN+sACAK2r2DEHIWJZTGps=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ZdsDQjiKYYv4HkIzxDWMgyjesrCrz/uwdduboLIfxk+47GXKfIhDOQXkycPdJLJFVR
         +QopPDWRypku1muyGnig/xWoCUYi/rwvxBKeWVZPH6uqoZ5aDvT3jCBU/nRna3ZhgheU
         KSEcglbweowAbIzP/gNaabuMwTzJTfW3gzSXA=
Received: by 10.216.4.80 with SMTP id 58mr660259wei.173.1243544869085; Thu, 28 
	May 2009 14:07:49 -0700 (PDT)
In-Reply-To: <4A1E00F1.4030709@zytor.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120230>

On Thu, May 28, 2009 at 4:11 AM, H. Peter Anvin <hpa@zytor.com> wrote:

> Again, given a bisection, the information gain by "bisecting" at poin=
t x
> =A0where 0 < x < 1 is:
>
> =A0 =A0 =A0 =A0-(x log2 x)-((1-x) log2 (1-x))
>
> At x =3D 0.5 this gives the optimal 1 bit, but the curve is rather fl=
at
> near the top. =A0You don't drop to 1/2 bit of information until
> x =3D 0.11 or 0.89, and it doesn't drop to 1/4 bit of information unt=
il
> x =3D 0.04 or 0.96.
>
> Thus, the lack of optimality in searching away from a skip point is m=
uch
> smaller than the potential cost of having to having to skip multiple
> nearby points.


I understand that. I didn't mean to imply that there was anything
wrong with your proposal, indeed, it makes sense for git-bisect.

What I am interested in is how to extend bisection to the case of
intermittent bugs; where a test which observes the fault means that it
cannot have been introduced in subsequent commits, but a test which
does not observe the fault cannot guarantee that it must have been
introduced in a subsequent commit.

The simplest way to deal with this is to try to reduce it to the
deterministic case
by repeating the test some number of times. It turns out, that this is
rather inefficient.

In bbchop, the search algorithm does not assume that the test is determ=
inistic.
Therefore, it has to calculate the probabilities in order to know when =
it has
accumulated enough evidence to accuse a particular commit. It turns
out that it is not much more expensive to calculate which commit we
can expect to  gain the most information from by testing it next.

How can I incorporate your skipping feature into this model? The proble=
m is that
while (just thinking about the linear case for the moment) there is a
fixed boundary at one end - where we actually saw a fault - on the
other side there are a bunch of fuzzy probabilities, ultimately
bounded by wherever we decided the limit of the search was.
So when we get a skip we could hop half way toward the limit. That
would be reasonable toward the beginning of the search, but towards
the end when most of the probability is concentrated in a small number
of commits, it would make no sense.

It would fit a lot better into this algorithm to have some model of
the probability that a commit will cause a skip. It doesn't actually
have to be a very good one, because if it's poor it will only make the
search slightly less efficient, not affect the reliability of the
final result.

Ealdwulf
