From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH 1/4] gitweb: Fix utf8 encoding for blob_plain, blobdiff_plain,
 commitdiff_plain, and patch
Date: Wed, 10 Apr 2013 12:23:39 +0200
Message-ID: <51653DAB.4070907@gmail.com>
References: <m2zjx8bxaj.fsf@blackdown.de> <7vd2u4vg4o.fsf@alter.siamese.dyndns.org> <5163FC2D.9050408@gmail.com> <m28v4r9xgs.fsf@zahir.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?UTF-8?B?SsO8cmdlbiBLcmVpbGVkZXI=?= <jk@blackdown.de>
X-From: git-owner@vger.kernel.org Wed Apr 10 12:24:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPsCD-0005rm-AG
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 12:24:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936517Ab3DJKX6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Apr 2013 06:23:58 -0400
Received: from mail-ea0-f172.google.com ([209.85.215.172]:38711 "EHLO
	mail-ea0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752428Ab3DJKXo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 06:23:44 -0400
Received: by mail-ea0-f172.google.com with SMTP id z7so141496eaf.17
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 03:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=HtckAT/moaGepHfjUicDuX7uHy1BCPS/39w+NR1QdQg=;
        b=zZ5ErDA9nEzPGf1FcWTnENc84dpKfE5spnkrCjD/r/Jx2K4dgBOrEUGq5Hdi+73Jvn
         V8LUiTmeR2hpawu74UeMJlKsI5wXgLIvFiRJ5hzw5lpAhgQq/i8rM4scg38YhCXnWA3D
         XeetHIh12BKQwVsaS6HGAKeBBlbvrlM/5nTMf5BXZ4VSPxOz1nH/DLrBEHqQBDc5nBDa
         BFDgScpPOl1qOznVIT653Pvrsa/qRf2r2kwyAGpR0GUcKmlmuRqycHhDTBnB3HdZnB2h
         OfaHVrmW2Hvt25Lco2mHGEo66ZqIy2QTFTj3SixBJKEtwdiMXrsRCuCwhHu0FpS27U5o
         VDUw==
X-Received: by 10.14.107.69 with SMTP id n45mr4181178eeg.23.1365589423266;
        Wed, 10 Apr 2013 03:23:43 -0700 (PDT)
Received: from [192.168.1.14] (dce9.neoplus.adsl.tpnet.pl. [83.23.56.9])
        by mx.google.com with ESMTPS id f47sm42830332eep.13.2013.04.10.03.23.40
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 10 Apr 2013 03:23:41 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <m28v4r9xgs.fsf@zahir.fritz.box>
X-Enigmail-Version: 1.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220678>

On 09.04.2013 at 23:59, J=C3=BCrgen Kreileder wrote:
> Jakub Nar=C4=99bski <jnareb@gmail.com> writes:
>=20
>> On 08.04.2013, Junio C Hamano wrote:
>>> jk@blackdown.de (J=C3=BCrgen Kreileder) writes:
>>>
>>>> Fixes the encoding for several _plain actions and for text/* and *=
/*+xml blobs.=20
>>>>
>>>> Signed-off-by: J=C3=BCrgen Kreileder <jk@blackdown.de>
>>
>> I see that this patch does (or tries to do) two _independent_ things=
,
>> and should be split into at least two separate commits:
[...]
>> First, it extends adding "; charset=3D$default_text_plain_charset" t=
o
>> other mimetypes for 'blob_plain' view to all 'text/*' and '*/*+xml'
>> mimetypes (without changing name of variable... though this is more
>> complicated as it is configuration variable and we would want to
>> preserve backward compatibility, but at least a comment would be,
>> I think, needed).
>> =20
>> Originally it applied only to 'text/plain' files, which can be
>> displayed inline by web browser, and which need charset in
>> 'Content-Type:' HTTP header to be displayed correctly, as they
>> do not include such information inside the file.
>=20
> What prompted the change is that some browsers (Chrome and Safari) al=
so
> display other file types inline: text/x-chdr, text/x-java, text/x-obj=
c,
> text/x-sh, ...
>=20
> At least on my system these files do get served with charset set!
> (ISO-8859-1 even though Apache has "AddDefaultCharset UTF-8"...)
[...]

I think this (the reason behind this change) should be explained in the
commit message.

>> 'text/html' and 'application/xhtml+xml' can include such information
>> inside them (meta http-equiv for 'text/html' and <?xml ...> for
>> 'application/xhtml+xml').  I don't know what browser does when there
>> is conflicting information about charset, i.e. which one wins, but
>> it is certainly something to consider.
>=20
> As shown above, even without my patch, this already can happen!
>=20
>> It might be a good change; I don't know what web browser do when
>> serving 'text/css', 'text/javascript', 'text/xml' to client to
>> view without media type known.

There are few options on how to handle this.

=46irst, there is an issue of $default_text_plain_charset configuration
variable.  Any changes to its use (or adding new configuration
variables) should be accompanied with changing / adding comment near th=
e
place where the default value is set, and changing / adding to
the documentation, namely gitweb.conf.txt

We can either:
1.) Use $default_text_plain_charset variable both for 'text/plain'
    and 'text/*' etc. content types in 'blob_plain' (aka 'raw') view
    for backwards compatibility, just add comment that it applies more
    than 'text/plain'

2.) Add new configuration variable, e.g. $default_blob_plain_charset
    and use it in place of $default_text_plain_charset as above,
    initializing it to $default_text_plain_charset.

    This practically renames $default_text_plain_charset preserving
    backward compatibility.  Documentation would talk now about new
    variable name.

3.) Add new configuration variable, e.g. $default_text_other_charset,
    or $default_blob_plain_charset, or $default_inline_charset, etc.
    which will be used for files other than 'text/plain'.  This would
    make it possible to turn this new feature on and off.

3.a.) New feature default to on, i.e. to $default_text_plain_charset
3.b.) New feature default to off, i.e. undef


Second, there is an issue of file types, like HTML or XML (or XHTML,
or sometimes for LaTeX), which have the information about encoding
embedded in file.

We can:

A.) Skip this issue, and always add charset for 'text/*' and
    '*/*-xml' files

B.) Threat those few media types in special way, excluding them from
    adding charset

C.) Make which types to be added charset configurable.


Anyway I think this feature is much less urgent.  It fixes an annoyance
rather than bug, as you can always choose which charset to use to
display content in a browser.  We can take time to implement it well,
especially that it interacts with config (and backward compatibility
of config variables).

>> BTW I have noticed that we do $prevent_xss dance outside
>> blob_contenttype(), in it's only caller i.e. git_blob_plain()...
>> which for example means that 'text/html' converted to 'text/plain'
>> don't get '; charset=3D...' added.  I guess that it *might* be
>> what prompted this part of change... but if it is so, it needs
>> to be fixed at source, e.g. by moving $prevent_xss to
>> blob_contenttype() subroutine.
>=20
> Jep.

But I see this is yet another separate issue.

>> Second it changes 'blobdiff_plain', 'commitdiff_plain' (which I thin=
k
>> that should be abandoned in favor of 'patch' view; but that is
>> a separate issue) and 'patch' views so they use binary-safe output.
>>
>> Note that in all cases (I think) we use
>>
>>    $cgi->header(
>>      -type =3D> 'text/plain',
>>      -charset =3D> 'utf-8',
>>      ...
>>    );
>>
>> promising web browser that output is as whole in 'utf-8' encoding.
>=20
> Yes.
>=20
>> It is not explained in the commit message what is the reason for thi=
s
>> change.  Is it better handing of a situation where files being diff-=
ed
>> being in other encoding (like for example in commit that changes
>> encoding of files from legacy encoding such like e.g. iso-8859-2
>> or cp1250 to utf-8)?
>=20
> I do see encoding problems when comparing utf8 to utf8 files (i.e. no
> encoding change).

Ah, O.K.

>  For instance:
> https://git.blackdown.de/old.cgi?p=3Dcontactalbum.git;a=3Dcommitdiff_=
plain;h=3Dcc4eaa64c2b399dd9bdbf1f67f6d621aa24df5f8

Nice to have online example, BTW.

> I don't claim to be an expert in Perl's utf8 handling but I guess thi=
s
> because Perl's internal utf8 form differs from the normal utf8 out fr=
om
> git commands.  Switching to :raw fixes that: We write plain utf8 (and=
,
> as noted above, charset is set to utf8 already)

Hmmm... I wonder if it is yet another case of concatenating content
marked as utf8 and not marked as utf8...

Anyway this fact that it is workaround, or that it fixes symptoms
of said issue, should be in the commit message (perhaps with TODO
explained).  This way we would be able to see it and perhaps fix
underlying issue, maybe with 'open' pragma, i.e.

  use open IN =3D> ':encoding(utf-8)';

(though then we loose $fallback_encoding), or

  use open IN =3D> ':encoding(utf-8-with-fallback)'

(which needs writing a Perl module for gitweb use).

> With the patch: https://git.blackdown.de/?p=3Dcontactalbum.git;a=3Dco=
mmitdiff_plain;h=3Dcc4eaa64c2b399dd9bdbf1f67f6d621aa24df5f8
>=20
>> But what about -charset =3D> 'utf-8'  then?
>=20
> That's a good question.  I think I never tried git with anything besi=
des
> ISO-8859-1 (rarely), UTF8 (mostly), and UTF16 (some Xcode files).
> (UTF16 definitely causes problems for gitweb.)
>=20
>> About implementation: I think after this change common code crosses
>> threshold for refactoring it into subroutine, for example:
>>
>>   sub dump_fh_raw {
>>   	my $fh =3D shift;
>>
>>   	local $/ =3D undef;
>>   	binmode STDOUT, ':raw';
>>   	print <$fh>;
>>   	binmode STDOUT, ':utf8'; # as set at the beginning of gitweb.cgi
>>
>>   	return $fh;
>>   }
>=20
> OK.
>=20
> I'll submit an updated patch for the second part ('blobdiff_plain',
> 'commitdiff_plain', and 'plain') tomorrow.

Thanks in advance.
--=20
Jakub Nar=C4=99bski
