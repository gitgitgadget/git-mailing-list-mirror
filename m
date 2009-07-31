From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH] gitweb: suppress 'Use of uninitialized value' error
Date: Fri, 31 Jul 2009 08:06:27 +0200
Message-ID: <cb7bb73a0907302306k691b1d4fy85d7b460077bc639@mail.gmail.com>
References: <1248988540-8971-1-git-send-email-giuseppe.bilotta@gmail.com> 
	<200907310100.42786.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 08:07:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWlGe-00039M-FD
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 08:07:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbZGaGGu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 31 Jul 2009 02:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751034AbZGaGGu
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 02:06:50 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:63213 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870AbZGaGGt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Jul 2009 02:06:49 -0400
Received: by fxm17 with SMTP id 17so1182763fxm.37
        for <git@vger.kernel.org>; Thu, 30 Jul 2009 23:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=9ltGKnQNB6pavimlG4g9LoDjMA1BnznWC1CJfP1w114=;
        b=IRbcceRNgTgbSUy9gLQ4femaKOkvJPRZ5pKUrss+zDroAjlD/Ru3IXlpIz6g9Lt6z+
         W74XNmX0Cmf6P0yzPtrUhnjzZNdZXWZi1l+9lirHECg/WvgMjGu7/yS4XwnbjaoZ5QWT
         zempM02G7hJkhmRuz37Uk6q+uw4cfilYnky8E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=fMgqyTL0L6d9Ggi/hgx8UC7Ni3E31AjpUvEZqkwLYxwKgDfMcfyhj8ZAOJkmp9mXld
         f9D/q8slSmLgJdeqyj0i+PXrStzaX7X5zp/l26R7HBxpmJxne1V9gM/SzYcWmkHcC3qd
         79a8SIiBD4926uZpcOcJqhfHfr1RnsaeJf4J4=
Received: by 10.204.66.17 with SMTP id l17mr2352455bki.51.1249020407589; Thu, 
	30 Jul 2009 23:06:47 -0700 (PDT)
In-Reply-To: <200907310100.42786.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124505>

2009/7/31 Jakub Narebski <jnareb@gmail.com>:
> On Thu, 30 July 2009, Giuseppe Bilotta wrote:
>
> Thanks for catching this.
>
> However... First, the subject should be more specific and less generi=
c.
> At least provide where 'Use of uninitialized' value was generated, e.=
g.:
>
> =A0Subject: [PATCH] gitweb: Fix 'Use of uninitialized value' error in=
 href()
>
> or a bit shorter
>
> =A0Subject: [PATCH] gitweb: Fix 'Use of uninitialized value' in href(=
)

Agreed.

> Second, it would be nice to have more detailed description in the bod=
y
> of a commit message, in this case stating when mentioned error occur:
>
> =A0This warning was generated when 'hash_parent_base' parameter was
> =A0defined, and either 'file_name' or 'file_parent' was not defined.
>
> Note that from above description you can notice that you protect agai=
nst
> 'file_parent' being not defined, but not against 'file_name', so you
> should I think write why it is not a problem:
>
> =A0In gitweb code 'file_parent' is used only if 'file_name' is filled=
=2E
>
> Well... almost. =A0This does not cover href(..., -replay=3D>1) with h=
and
> crafted broken/invalid gitweb URL. =A0BTW. a question for you: how di=
d
> you detect/found this breakage?

I was looking at the error log of my webserver and spotted the lines,
coming from a spider indexing my git pages. An URL that caused it is
http://git.oblomov.eu/git/commit/32ae83194b0f287a9b6644cdad175c56417c31=
f3
(the tree link, I suspect).

>=A0I don't think gitweb generates such
> broken links (with 'hash_parent_base' but not 'file_parent') normally=
,
> but I might be mistaken.

Do you think it would be worth to protect against this case?

> Third, we would probably want to have additional case in t/t9500 test
> to protect against regression here. =A0But that is not as important,
> I think.

I'll see if I can cook that up.

>> =A0gitweb/gitweb.perl | =A0 11 +++++++----
>> =A01 files changed, 7 insertions(+), 4 deletions(-)
>>
>> The patch could have been a one-liner by adding the defined check at
>> line 943, but that pushed the line to 120 char, so I decided for thi=
s
>> slightly more complex form.
>
> That is IMHO a good solution. =A0Better not abuse 'if' modifier form.
>
>>
>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index 7fbd5ff..c7f257e 100755
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>> @@ -940,10 +940,13 @@ sub href {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (defined $params{'has=
h_parent_base'}) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $href .=3D=
 esc_url($params{'hash_parent_base'});
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 # skip t=
he file_parent if it's the same as the file_name
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 delete $pa=
rams{'file_parent'} if $params{'file_parent'} eq $params{'file_name'};
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (define=
d $params{'file_parent'} && $params{'file_parent'} !~ /\.\./) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 $href .=3D ":/".esc_url($params{'file_parent'});
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 delete $params{'file_parent'};
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (define=
d $params{'file_parent'}) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 if ($params{'file_parent'} eq $params{'file_name'}) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 delete $params{'file_parent'};
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 } else if ($params{'file_parent'} !~ /\.\./) {

And I'm an idiot 'cause this should be 'elsif'.

Resend coming soon.

--=20
Giuseppe "Oblomov" Bilotta
