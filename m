From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH] gitweb: gravatar support
Date: Sat, 20 Jun 2009 08:30:58 +0200
Message-ID: <cb7bb73a0906192330j7c7a8ed3o39f0eb65d29e334c@mail.gmail.com>
References: <1245405495-7712-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <200906191325.00248.jnareb@gmail.com>
	 <cb7bb73a0906190757o4d083735t1a3f37396af76c2f@mail.gmail.com>
	 <200906200031.55576.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 20 08:31:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHu6h-0002Qt-3v
	for gcvg-git-2@gmane.org; Sat, 20 Jun 2009 08:31:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbZFTGa6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Jun 2009 02:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751022AbZFTGa6
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jun 2009 02:30:58 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:49180 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843AbZFTGa5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Jun 2009 02:30:57 -0400
Received: by bwz9 with SMTP id 9so2132898bwz.37
        for <git@vger.kernel.org>; Fri, 19 Jun 2009 23:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xkcQfLV0pv20tEty7jobKHkIbu48y5nypKCBl7W8ye0=;
        b=PId61w8qWB3rVZIL2Bp2UuDq2NpbbNeG7aOSPFjDPr8b1wmbsC1PMVNnWSk7son9G/
         ou+bpETn9MwrU9sVBYVut8ahGCn3qz6EDZoXLZeVCxK2x2Nc21dCCShsn2eQlZOI4cko
         uCwMDBbsaRsdE9KOiqZh/VFG6Da9K2JOL7mpY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Qf2oJpp+qjIFpKu5h1C18Ad5eQpHc+RG6GUqkLo/y/EyU/IvUmWCeiIQGDsXhGBPWW
         YZExRLr5o3GY6i+c9tPFsFptuyR5BrEuv59tixaqIIW4a0prm/kSN+SodLPrtgg9XLOL
         8Do27zD71XKusz7wdhfMxS34Z63UISVdX0avg=
Received: by 10.204.31.201 with SMTP id z9mr3355301bkc.79.1245479458659; Fri, 
	19 Jun 2009 23:30:58 -0700 (PDT)
In-Reply-To: <200906200031.55576.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121932>

On Sat, Jun 20, 2009 at 12:31 AM, Jakub Narebski<jnareb@gmail.com> wrot=
e:
>>> Question: why it is not overridable (why project specific override
>>> is not supported for this feature)? =A0Some projects may use Gravat=
ars,
>>> some might not, although I guess that usually it is deployment spec=
ific
>>> feature.
>>
>> I see it as a deployment feature, and considering that it adds an
>> (admittedly small) extra load on the server, I thought it was sensib=
le
>> to make it non-overridable. OTOH, since the load is small, it might =
be
>> possible to make it per-project without big issues.
>
> Well, I was not asking you to change it; I was asking about
> justification behind making it non-overridable.

I decided to go for the override because it was little effort and it
whether or not the override can take place can still be decided at a
central place.

>>> You would probably want to protect against $size being undefined:
>>>
>>> =A0+ =A0 =A0 =A0 =A0 =A0 =A0 $size =3D 32 if (!defined($size) || $s=
ize <=3D 0);
>>>
>>> Because currently when you are not passing size parameter to use
>>> default size you would get the following warning:
>>>
>>> =A0Use of uninitialized value in numeric le (<=3D) ...
>>
>> Oh right.
>
> Well, as you use 'undef' (do not pass parameter) for default value
> and you _do not_ use negative (or zero) value, then
>
> + =A0 =A0 =A0 =A0 =A0 =A0 $size =3D 32 if !defined($size);
>
> would be enough (in Perl 6 / Perl 5.10 it would be "$size //=3D 32" ;=
-)
>
> The question is: does gravatar.com accepts any size? =A0What does it =
do
> if it gets negative size passed? =A0I have not used gravatar as
> developer...

If you pass a negative size, the image comes up blank. Using undef for
the default value makes sense. The question rather becomes whether it
makes sense or not to provide a safety fallback for when the size
comes up negative.

>>> Also gravatars are
>>> not shown in 'history' view, but I guess that could wait for proper
>>> refactoring of all log-like views/actions to use common infrastruct=
ure.
>>
>> That's part of the reason, the other being that I couldn't find a
>> satisfactory way to do it 8-P
>
> What is the problem?

I really don't remember, I created the patch a long time ago. As you
can probably seen from v2, I just decided to go with the same code
everywhere (which asks for a refactoring).

>>> Those all look nice with the *default* font sizes. =A0But as the si=
ze of
>>> gravatar is used when constructing gravatar URL, to pass to gravata=
r.com
>>> I don't see how this problem can be resolved... =A0Beside making it
>>> configurable, I guess...
>>
>> That's something I hadn't thought about, honestly. The problem of
>> course is that the font sizes get customized via CSS, but the gravat=
ar
>> size would get customized at the cgi level ... so unless we parse th=
e
>> CSS from the cgi it cannot be done automatically.
>
> What I though here was to use %gravatar_size hash, with keys such as
> 'default' and 'double' (for "double line height"). =A0If you change o=
r
> add CSS, changing configuration, you can change also this in config.

And since the sices could be used for other things than gravatar, we
could call it just %avatar_size_hash or whatever, and future support
for picons or whatever else can use it too.


--=20
Giuseppe "Oblomov" Bilotta
