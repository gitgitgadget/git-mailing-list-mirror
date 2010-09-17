From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH 2/7] gitweb: git_get_heads_list accepts an optional list
 of refs.
Date: Fri, 17 Sep 2010 17:52:23 +0200
Message-ID: <AANLkTi=fF7QGNrAepy8WbzgzQYUbKESO49QBtDLCHgcV@mail.gmail.com>
References: <1284629465-14798-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1284629465-14798-3-git-send-email-giuseppe.bilotta@gmail.com> <201009170014.12483.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 17 17:52:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwdF5-0002oi-DC
	for gcvg-git-2@lo.gmane.org; Fri, 17 Sep 2010 17:52:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754496Ab0IQPwq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Sep 2010 11:52:46 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:33106 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753258Ab0IQPwp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Sep 2010 11:52:45 -0400
Received: by gyd8 with SMTP id 8so767448gyd.19
        for <git@vger.kernel.org>; Fri, 17 Sep 2010 08:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=rZWkgZy/z0hmzkLJ5P/WNZpS73NNYxBnpqYXZOTsBag=;
        b=lJwR/fGjVoLEHnRjnG4FrVcJc8ilHL+fgnMaS+GekLg57egWrhULcdJ2iJVkDAOV52
         a3TsomKakWeH0z6OOaU81QLPXqiPkFuV+oSP4ldbUbGWmkNKBgH7oqSZj2QEajIWmgMs
         vhIxeADCQOXWce0MLxO0xNu0rDY28IZH0XEcA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=FRVyyu5feadOjnZ+529i9cHqnq1j3STkad/JBCeAInxooJR0tDXgs2MqdiykeIx7d+
         Pf6SKLvAE+6AqO+WBs0QN/k1kKQD3AIzjRB2MZLEENsQp+Dw6V+pHqVchML9pP5ZwRE2
         hV2uZvKu8R8ZAQC8+g2XBAvDGFVkFnI13NUpo=
Received: by 10.90.49.18 with SMTP id w18mr3522834agw.64.1284738764146; Fri,
 17 Sep 2010 08:52:44 -0700 (PDT)
Received: by 10.231.150.202 with HTTP; Fri, 17 Sep 2010 08:52:23 -0700 (PDT)
In-Reply-To: <201009170014.12483.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156390>

2010/9/17 Jakub Narebski <jnareb@gmail.com>:
> On Thu, 16 Sep 2010, Giuseppe Bilotta wrote:
>
>> git_get_heads_list(limit, class1, class2, ...) can now be used to re=
trieve
>> refs/class1, refs/class2 etc. Defaults to ('heads') or ('heads', 're=
motes')
>> depending on the remote_heads option.
>
> I like this API very much.

Thank you.

>> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
>> ---
>> =A0gitweb/gitweb.perl | =A0 11 +++++++----
>> =A01 files changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index 7116c26..21e83bb 100755
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>> @@ -3155,15 +3155,18 @@ sub parse_from_to_diffinfo {
>> =A0## parse to array of hashes functions
>>
>> =A0sub git_get_heads_list {
>> - =A0 =A0 my $limit =3D shift;
>> + =A0 =A0 my ($limit, @class) =3D @_;
>
> Nitpick: @class or @classes.

Right, the general gitweb style is for plural for arrays.

>> + =A0 =A0 unless (defined @class) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 my $remote_heads =3D gitweb_check_feature(=
'remote_heads');
>> + =A0 =A0 =A0 =A0 =A0 =A0 @class =3D ('heads', $remote_heads ? 'remo=
tes' : undef);
>
> Same comment as for previous patch:
>
> =A0+ =A0 =A0 =A0 =A0 =A0 =A0 @class =3D ('heads', $remote_heads ? 're=
motes' : ());
>
> Or alternative solution:
>
> =A0+ =A0 =A0 =A0 =A0 =A0 =A0 @class =3D 'heads';
> =A0+ =A0 =A0 =A0 =A0 =A0 =A0 push @class, 'remotes' if gitweb_check_f=
eature('remote_heads');
>

I like the () solution better. Less verbosity

>> =A0 =A0 =A0 my @headslist;
>>
>> - =A0 =A0 my $remote_heads =3D gitweb_check_feature('remote_heads');
>> -
>> =A0 =A0 =A0 open my $fd, '-|', git_cmd(), 'for-each-ref',
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ($limit ? '--count=3D'.($limit+1) : ()),=
 '--sort=3D-committerdate',
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 '--format=3D%(objectname) %(refname) %(s=
ubject)%00%(committer)',
>> - =A0 =A0 =A0 =A0 =A0 =A0 'refs/heads', ( $remote_heads ? 'refs/remo=
tes' : '')
>> + =A0 =A0 =A0 =A0 =A0 =A0 @refs
>
> Nitpick: it is called '<pattern>...' in git-for-each-ref manpage...

I'm not particularly enamoured with @refs, so @patterns it is (if I
get what you mean here)

--=20
Giuseppe "Oblomov" Bilotta
