From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH RFC3.5 08/12] send-email: Move Subject sanitization from 
	--compose code to send_message
Date: Sun, 19 Apr 2009 09:39:58 -0500
Message-ID: <b4087cc50904190739u54a9a9d7p6f011ab2b47c1d05@mail.gmail.com>
References: <1240074128-16132-1-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-4-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-5-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-6-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-7-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-8-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-9-git-send-email-mfwitten@gmail.com>
	 <76718490904181854o380fe118y9f3a52c926bd1f6d@mail.gmail.com>
	 <b4087cc50904181937q38ef45fm7409e020ecf40792@mail.gmail.com>
	 <76718490904190713l3d6b5abcmf54544512de87413@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 19 16:41:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvYD9-0007Of-Vt
	for gcvg-git-2@gmane.org; Sun, 19 Apr 2009 16:41:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758385AbZDSOkB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Apr 2009 10:40:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758178AbZDSOkA
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Apr 2009 10:40:00 -0400
Received: from mail-qy0-f126.google.com ([209.85.221.126]:52129 "EHLO
	mail-qy0-f126.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757520AbZDSOj7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Apr 2009 10:39:59 -0400
Received: by qyk32 with SMTP id 32so994529qyk.33
        for <git@vger.kernel.org>; Sun, 19 Apr 2009 07:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=S73iy28Lgqqgx6Hgh8DP8+LH0BSt9e8BbxvgvmLZzcI=;
        b=IM4x1qLJyZnjaHkBczZVIlBoyoEe3EskQWVk2JOrlegyVBMifJOnVG0bZs1qx7SUjD
         goFmDoUBQvkbuQvSnJr3nEyUgl1vxDf8/IYRH9O6co5zO/N+ANE8H6oAkM0/JsTRg1ma
         bZ0HMYAi9Tiorn483Q7F6hiMs+kNxNPF29FdY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ttaX6XUSy9tEx+U7RHf+2aOdQf3wciyFQ5d9y2s7woA+bQhfwb/gdwImmxglHS8/4/
         hRIBNiJc8GNZSLw7k+Wtd8oJI9YfDhKpeok9jgHFtcmgeWbOEAgghcmqOednrFZaoUtp
         pVkl1OKJ/+itzlCmFVtrixSkXPvUKdmEuvCx4=
Received: by 10.224.67.75 with SMTP id q11mr5410122qai.278.1240151998223; Sun, 
	19 Apr 2009 07:39:58 -0700 (PDT)
In-Reply-To: <76718490904190713l3d6b5abcmf54544512de87413@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116901>

On Sun, Apr 19, 2009 at 09:13, Jay Soffian <jaysoffian@gmail.com> wrote=
:
> I think I was not clear. My suggestion was to move the /[^[:ascii:]]/
> check to the inside of quote_rfc2047 exactly so that it doesn't alway=
s
> change its input. i.e.

Ah. However, there is still the question of whether the actual email
headers are present to declare the right encoding. I don't know enough
to comment on this, though; before this patch, this quoting was
performed by code that new to right the correct "Content-Type" and
"Content-Transfer-Encoding" headers. I suppose I'll have to read the
RFC.

>
>> =A0 =A0 =A0 =A0sub quote_rfc2047 {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0local $_ =3D shift;
>
> Add this:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return $_ unless /[^[:ascii:]]/;
>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0my $encoding =3D shift || 'utf-8';
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0s/([^-a-zA-Z0-9!*+\/])/sprintf("=3D%0=
2X", ord($1))/eg;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0s/(.*)/=3D\?$encoding\?q\?$1\?=3D/;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return $_;
>> =A0 =A0 =A0 =A0}
>
> This simplifies things for the function caller I think.

I'm morally opposed to this kind of thing. The caller should be
required to test whether quote_rfc2047() is required, as it's not the
job of quote_rfc2047 to validate. Suppose that quote_rfc2047 were
actually part of a library of useful functions that my program
imports. Perhaps my program knows that it must always quote some piece
of text. Why, then, should my program be forced to waste the cycles to
perform a useless test?

IMnsHO, verification should always be done by the caller with one
exception: Interactive (human) input should always be verified,
because humans represent an unreliable component in the system (in
terms of digital systems, their asynchronous input must be
synchronized with the clocked system). WIth this model, there's are
fewer wasted cycles, because you can reuse verification across similar
functions, and the code (particularly library code) is easier to
understand.
