From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Allow gitweb tab width to be set per project.
Date: Wed, 29 Sep 2010 11:22:00 +0200
Message-ID: <201009291122.01272.jnareb@gmail.com>
References: <1285673709-24924-1-git-send-email-magnus@hagander.net> <m34odagioh.fsf@localhost.localdomain> <AANLkTikMjVQgEzLQ5Z95cmb5fkQ5iSzqfA4T=D1zzy=j@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Magnus Hagander <magnus@hagander.net>
X-From: git-owner@vger.kernel.org Wed Sep 29 11:22:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0srj-00015Y-9m
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 11:22:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754253Ab0I2JWO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Sep 2010 05:22:14 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41244 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600Ab0I2JWN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Sep 2010 05:22:13 -0400
Received: by fxm14 with SMTP id 14so309995fxm.19
        for <git@vger.kernel.org>; Wed, 29 Sep 2010 02:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=R/QCb3P/61oFzBfULoOYw4TdutjYgh0HZfdPE7k/cuM=;
        b=jTpZy8BbfPkjqCFcdIH4pKANU33J1lTDqLVfaL8ZwanlxDISZjg3Pd5qaTerr4vADc
         UgpsjtiQSvZofWIYEqtCHpUGwjFLxCARxLDkj719fufn9y7hGSAOL3YiBpA5o0rSnu7v
         1ZRRyY4GjIA09IO7kLE3LKAWZ5tyE3U1IT6dI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=SK4xIJNPxi0Ya0aRVDsUw01gWkXnGxebhN5ChMQZLG/FzXsHXSm+TRmNNIjn054CFf
         eL/7PhcUs/DpMdF91xlmMhez4r6vPDb96KHZhBzsaV4HW8hk32IbZh1QnkbJX3Akcsqf
         oKFAdCLg+tOWja2YL1dqmfnNmcGiltn1mT6es=
Received: by 10.223.126.65 with SMTP id b1mr1303972fas.44.1285752132307;
        Wed, 29 Sep 2010 02:22:12 -0700 (PDT)
Received: from [192.168.1.13] (abwl162.neoplus.adsl.tpnet.pl [83.8.235.162])
        by mx.google.com with ESMTPS id t6sm3643411faa.27.2010.09.29.02.22.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 29 Sep 2010 02:22:10 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTikMjVQgEzLQ5Z95cmb5fkQ5iSzqfA4T=D1zzy=j@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157549>

On Wed, 29 Sep 2010, Magnus Hagander wrote:
> On Tue, Sep 28, 2010 at 14:25, Jakub Narebski <jnareb@gmail.com> wrot=
e:
>> Magnus Hagander <magnus@hagander.net> writes:

>>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>>> index a85e2f6..ef92a4f 100755
>>> --- a/gitweb/gitweb.perl
>>> +++ b/gitweb/gitweb.perl
>>> @@ -1465,9 +1465,11 @@ sub unquote {
>>> =A0# escape tabs (convert tabs to spaces)
>>> =A0sub untabify {
>>> =A0 =A0 =A0 my $line =3D shift;
>>> + =A0 =A0 my $tabwidth =3D git_get_project_config('tabwidth', '--in=
t');
>>
>> Note that untabify() is called once for each _line_ in a file or a
>> diff...
>=20
> Ha, that's what I get for thinking it was too easy. It actually was :=
-)
>=20
>=20
>> This has acceptable performance only because gitweb config is cached
>> in %config hash by git_get_project_config() subroutine.
>>
>>
>> I'm not sure if it wouldn't be better to have $tabwidth be passed as
>> an (optional) argument to untabify(), and calculated either in calli=
ng
>> sites for untabify(), or be calculated per-request and save in a
>> global variable.
>=20
> Given that it's cached, will it actually make a big difference?

Well, I agree that with config cached it could be left like this...
but I would like very much to perhaps have a comment about this, so oth=
er
people don't have to wonder.
=20

>>> + =A0 =A0 $tabwidth =3D 8 if ($tabwidth <=3D 0);
>>
>> git_get_project_config('tabwidth', '--int') can return 'undef' if a
>> configuration key does not exist, resulting in
>>
>> =A0Use of uninitialized value in numeric le (<=3D) at
>>
>> warning in web server logs.
>=20
> Ah, I knew that would go somewhere. Interestingly enough, it doesn't
> show up in the logs of the server I run it on now. But still should b=
e
> fixed.

Whether such warning shows in web server logs might depend on whether
you are running gitweb under mod_perl, or as plain CGI script.
Nevertheless it is a good practice to check if a change passess
appropriate tests from git testsuite; t9500-gitweb-standalone-no-errors
should detect this.

Simply use

    +     $tabwidth =3D 8 if (!defined $tabwidth || $tabwidth <=3D 0);

or

    +     $tabwidth =3D 8 if (!$tabwidth || $tabwidth <=3D 0);

(though second version is more cryptic).


P.S. If it is not a %feature, we might want to add description of
gitweb.tabwidth to the "Per-repository gitweb configuration" section
in gitweb/README (as next to last item)

--=20
Jakub Narebski
Poland
