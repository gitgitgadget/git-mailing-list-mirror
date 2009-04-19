From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH RFC3.5 08/12] send-email: Move Subject sanitization from 
	--compose code to send_message
Date: Sun, 19 Apr 2009 10:13:30 -0400
Message-ID: <76718490904190713l3d6b5abcmf54544512de87413@mail.gmail.com>
References: <1240074128-16132-1-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-3-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-4-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-5-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-6-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-7-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-8-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-9-git-send-email-mfwitten@gmail.com>
	 <76718490904181854o380fe118y9f3a52c926bd1f6d@mail.gmail.com>
	 <b4087cc50904181937q38ef45fm7409e020ecf40792@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 19 16:15:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvXnX-00008C-Qp
	for gcvg-git-2@gmane.org; Sun, 19 Apr 2009 16:15:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758636AbZDSONd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Apr 2009 10:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758218AbZDSONd
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Apr 2009 10:13:33 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:60727 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757380AbZDSONc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Apr 2009 10:13:32 -0400
Received: by yx-out-2324.google.com with SMTP id 3so539418yxj.1
        for <git@vger.kernel.org>; Sun, 19 Apr 2009 07:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=koj0gX+BTORtrGl24eWQJDcSz7t2rs6hGRuBTW08yl4=;
        b=Q9kNBZNmY8Z358e5mcKPm1l3iki/jDJiNAdMU/QnRvFErAP3WDabopGTHEKra8psyH
         v8o3U50NGiZbMKkhxb+7tn5aE/bl45mOvr1QJiln5mZ7eW/bILv4p+AD9HlCtBhOqllx
         qVjSU1xF4zwxLWkhTaUe1n9yXwF3DA3rXvc+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=OhfEKuk1oTLNxadkiMjkrdK+u0L+/qO+FxxZkbYXoIO1ukQgkJXpJGyjLaC9e/HHRi
         rHvK89wob9cik++TkkoBYGyg90T4vUoIGGAS0dOaFKbfCaFi1D2pgv2wlt1yVhVXYPYE
         1GzbR5CA+Y0HXMi7KXqz3l3FnNIE2U/RKo++0=
Received: by 10.151.7.11 with SMTP id k11mr6504783ybi.170.1240150410955; Sun, 
	19 Apr 2009 07:13:30 -0700 (PDT)
In-Reply-To: <b4087cc50904181937q38ef45fm7409e020ecf40792@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116896>

On Sat, Apr 18, 2009 at 10:37 PM, Michael Witten <mfwitten@gmail.com> w=
rote:
> On Sat, Apr 18, 2009 at 20:54, Jay Soffian <jaysoffian@gmail.com> wro=
te:
>> On Sat, Apr 18, 2009 at 1:02 PM, Michael Witten <mfwitten@gmail.com>=
 wrote:
>>> + =C2=A0 =C2=A0 =C2=A0 my $sanitized_subject =3D ($subject =3D~ /[^=
[:ascii:]]/) ? quote_rfc2047($subject) : $subject;
>>
>> I wonder if it would be clearer to always call quote_rfc2047, then
>> have that function just return its input unaltered if quoting is not
>> needed.
>
> It actually ALWAYS changes the input. This code:

I think I was not clear. My suggestion was to move the /[^[:ascii:]]/
check to the inside of quote_rfc2047 exactly so that it doesn't always
change its input. i.e.

> =C2=A0 =C2=A0 =C2=A0 =C2=A0sub quote_rfc2047 {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0local $_ =3D s=
hift;

Add this:
                 return $_ unless /[^[:ascii:]]/;

> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0my $encoding =3D=
 shift || 'utf-8';
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s/([^-a-zA-Z0-=
9!*+\/])/sprintf("=3D%02X", ord($1))/eg;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s/(.*)/=3D\?$e=
ncoding\?q\?$1\?=3D/;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return $_;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}

This simplifies things for the function caller I think.

j.
