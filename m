From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv4 2/2] gitweb: gravatar support
Date: Wed, 24 Jun 2009 22:00:36 +0200
Message-ID: <cb7bb73a0906241300mf10e073j99ad2b09c806d0d7@mail.gmail.com>
References: <1245710999-17763-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1245710999-17763-2-git-send-email-giuseppe.bilotta@gmail.com>
	 <1245710999-17763-3-git-send-email-giuseppe.bilotta@gmail.com>
	 <20090624224430.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Aaron Crane <git@aaroncrane.co.uk>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Wed Jun 24 22:00:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJYeF-0004tC-1N
	for gcvg-git-2@gmane.org; Wed, 24 Jun 2009 22:00:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754777AbZFXUAh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Jun 2009 16:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754176AbZFXUAg
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jun 2009 16:00:36 -0400
Received: from mail-fx0-f213.google.com ([209.85.220.213]:36849 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753904AbZFXUAf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Jun 2009 16:00:35 -0400
Received: by fxm9 with SMTP id 9so1012945fxm.37
        for <git@vger.kernel.org>; Wed, 24 Jun 2009 13:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=x0kIoxJ3OPR6gLq+wP87VK3aHKDRJ3wFS35/I9dHswo=;
        b=bxr6jagXL4lh1x4zmYTqbSL+mj0dwMdVuy8TKrbf6OHr05ZokRMdFKDgJV8P3gDDvA
         EE8pqWpGdgdJ7a/D/wkFmFtbszlYrdlZDwJgsqNMpORnZogGWk6Jic9+UmkIlXcjJ/+V
         cBTQlg734ohJn1aXs4CJNmDtVpm1Wpd6NVj+c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=LpXX9XBa/DAKr+d3pk2NtMKAEdwOnZnkZq9npmB/943ZPtB1qqasXtNb/Zzw/nfav7
         bY5DkUnLiix934CSoLWfKjuWlal89zeKWteUbaE/jHxdCj08IVhS++PmmSHxLQ3U1Dgu
         D8+KO6+mtKqDb+5n1rzA6fHGsg+v5zKFVMFg8=
Received: by 10.204.55.140 with SMTP id u12mr1601424bkg.98.1245873636712; Wed, 
	24 Jun 2009 13:00:36 -0700 (PDT)
In-Reply-To: <20090624224430.6117@nanako3.lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122154>

On Wed, Jun 24, 2009 at 3:44 PM, Nanako Shiraishi<nanako3@lavabit.com> =
wrote:
> Quoting Giuseppe Bilotta <giuseppe.bilotta@gmail.com>:
>
>> diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
>> index 68b22ff..ddf982b 100644
>> ........
>> +img.avatar {
>> + =A0 =A0 vertical-align:middle;
>> +}
>> +
>> .........
>> +# Pixel sizes for avatars. If the default font sizes or lineheights
>> +# are changed, it may be appropriate to change these values too via
>> +# $GITWEB_CONFIG.
>> +our %avatar_size =3D (
>> + =A0 =A0 'default' =3D> 16,
>> + =A0 =A0 'double' =A0=3D> 32
>> +) ;
>> ........
>
> Early parts of the patch talk about "avatars"; compared with "icons" =
Junio
> suggested, I think that is a better generic word to use for this purp=
ose.

Well, I would argue that 'avatar' is pretty commonly understood to be
the name of the picture identifying an individual online. OTOH, I've
been thinking that there are other kind of icons that might be used
across gitweb in the future, and they are likely to use the same
sizes, so I'll go for icon_size here.

>> @@ -1474,7 +1501,7 @@ sub format_author_html {
>> =A0 =A0 =A0 my $tag =3D shift;
>> =A0 =A0 =A0 my $co =3D shift;
>> =A0 =A0 =A0 my $author =3D chop_and_escape_str($co->{'author_name'},=
 @_);
>> - =A0 =A0 return "<$tag class=3D\"author\">" . $author . "</$tag>\n"=
;
>> + =A0 =A0 return "<$tag class=3D\"author\">" . git_get_gravatar($co-=
>{'author_email'}, 'space_after' =3D> 1) . $author . "</$tag>\n";
>> =A0}
>
> But the function that returns a string suitable for embedding in the =
HTML
> page, given an e-mail address, is called get_gravatar(), not get_avat=
ar()?
>
> I expected from an earlier review message by Junio that get_avatar() =
will
> look like this:
>
> sub git_get_avatar {
> =A0 =A0 =A0 =A0my $url =3D undef;
> =A0 =A0 =A0 =A0if ($git_gravatar_enabled) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0my $md5 =3D .......;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$url =3D "http://www.gravatar.com/avat=
ar.php?gravatar_id=3D$md5";
> =A0 =A0 =A0 =A0} else if ($git_picons_enabled) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0my $userpath =3D .......;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$url =3D "http://www.cs.indiana.edu/pi=
cons/db/users/$userpath/face.xpm";
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0return "" unless (defined $url);
> =A0 =A0 =A0 =A0return $pre_white . "<img ... src=3D\"$url\" size=3D$s=
ize />" . $post_white;
> }
>
> (without "picons" part, of course).

Right. I was wondering if it would make sense to factor each avatar
block separately (i.e. have a git_get_avatar that calls
git_get_whatever) but it probably doesn't make sense.

I'll wait for Jakub's (and whoever else wants to chip in) comments,
and then I'll send an update to this patch following your
recommendations.

--=20
Giuseppe "Oblomov" Bilotta
