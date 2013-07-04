From: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: allow extra breadcrumbs to prefix the trail
Date: Thu, 4 Jul 2013 17:34:58 +0200
Message-ID: <CANQwDwfCYPBjGfmKOLju-Zey4WrVrXfaymJtu9g1OYvOUfBTcw@mail.gmail.com>
References: <E1Uu3IT-0008U1-3c@hermes-2.csi.cam.ac.uk> <20130703215930.GT408@google.com>
 <CANQwDwcneUzzXS-Du-3Aca3-Vp8ycSzVqUv1rVRVhaNUWfeokw@mail.gmail.com>
 <alpine.LSU.2.00.1307040940400.26246@hermes-2.csi.cam.ac.uk>
 <CANQwDwd9siyeu5xqS5Un+=8ioEaDbpT30vBpgJCVNUEcszcv1g@mail.gmail.com> <alpine.LSU.2.00.1307041559140.26246@hermes-2.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Tony Finch <dot@dotat.at>
X-From: git-owner@vger.kernel.org Thu Jul 04 17:35:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UulZ7-0006mb-15
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jul 2013 17:35:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756748Ab3GDPfU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Jul 2013 11:35:20 -0400
Received: from mail-qa0-f50.google.com ([209.85.216.50]:48540 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756590Ab3GDPfT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Jul 2013 11:35:19 -0400
Received: by mail-qa0-f50.google.com with SMTP id l18so838069qak.9
        for <git@vger.kernel.org>; Thu, 04 Jul 2013 08:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=buTYzEGml7f2BOPdidbicjbqHRNGXS7rrOM8zjmJEeU=;
        b=iirhhiLOdB1iBgw3gNjqmul9vNCETJBJj8ZIQ1rDEYxVlvDZ7vCHz/3PyerqLC1s4L
         jvlNiadXkrjw8zZLlfnp3OAmIpHeyoslFrpLYP6M1Nno8Tnd/cHQI5l/f0QApCCCwzZL
         ALAB3Mon/awI7sgDLjypkFmZuk9fW7QbeIaxPy0bcGY2r6/+ECd4AT+PzLY+1+U2Q0TZ
         5dd9//P+aDs+iaku9FL8U6WDROmuNCQoueLcs2H/Ow/zTPwbhaV38oLYJZq1pyvNB5pb
         4XthECn1EfZIEio56hjUVcy1B+jWD0KKjX5QWzIKE7ZMVOW6giAV6CPn/7JkIyLFhLyE
         QyRg==
X-Received: by 10.229.197.6 with SMTP id ei6mr1227207qcb.32.1372952119022;
 Thu, 04 Jul 2013 08:35:19 -0700 (PDT)
Received: by 10.49.75.169 with HTTP; Thu, 4 Jul 2013 08:34:58 -0700 (PDT)
In-Reply-To: <alpine.LSU.2.00.1307041559140.26246@hermes-2.csi.cam.ac.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229593>

On Thu, Jul 4, 2013 at 5:11 PM, Tony Finch <dot@dotat.at> wrote:
> Jakub Nar=C4=99bski <jnareb@gmail.com> wrote:
>>
>> It would be better to improve documentation, than follow current bad
>> practice... ;-P
>
> The v2 patch does just that :-)

Thanks.

>> Perhaps even make ( [ $home_link_str, $home_link ] ) to be default
>> value for @extra_breadcrumbs, making new feature generalization
>> of $home_link*, similarly to how it was done for $stylesheet -> @sty=
lesheets
>> transition.
>
> I don't think that's a win. There's a lot of existing gitweb.conf out
> there which sets $home_link_str, so the code would have to either pri=
nt
> the last element of @extra_breadcrumbs or the $home_link variables
> depending on whether the variables were modified. And the documentati=
on
> would have to explain this complicated arrangement.

=46irst, do I understand corrctly that @extra_breadcrumbs are rendered =
*after*
$home_link*, and in exactly the same manner?

Second, I misremembered how $stylesheet / @stylesheets is handled.
I was thinking more about having in gitweb.perl the following default
initialization for @extra_breadcrumbs:

  our @extra_breadcrumbs =3D ( [ $home_link_str, $home_link ] );

Then one can add breadcrumbs with

  push @extra_breadcrumbs, [ $foo_html, $foo_url ], [
esc_html($bar_txt), $bar_url ];

But now I think that we can do better, simply put $home_link_str and $h=
ome_link
in @extra_breadcrumbs / @top_level_breadcrumbs / @nav_breadcrumbs befor=
e
using it, either via

  unshift @nav_breadcrumbs, [ $home_link_str, $home_link ];

or

  for $breadcrumb ([ $home_link_str, $home_link ], @nav_breadcrumbs) {

=2E.. unless we treat home link in some special way (do we?).


P.S. It is a bit late, but wouldn't { name =3D> $link_name, href =3D> $=
link_url }
(like %features hash) be a better solution than [ $link_name, $link_url=
 ],
i.e. hashref (named parameters) instead of arrayref (positional paramet=
ers).
You wouldn't have to remember which is first: text or URL.

--=20
Jakub Narebski
