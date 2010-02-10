From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCHv2 04/10] gitweb: Use Cache::Cache compatibile (get, set) output caching
Date: Wed, 10 Feb 2010 19:22:48 +0100
Message-ID: <201002101922.50010.jnareb@gmail.com>
References: <1265711427-15193-1-git-send-email-jnareb@gmail.com> <201002101228.15732.jnareb@gmail.com> <20100210120257.GP4159@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Feb 10 19:23:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfHDT-0000LG-3f
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 19:23:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755163Ab0BJSXF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Feb 2010 13:23:05 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:45225 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753709Ab0BJSXA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2010 13:23:00 -0500
Received: by fg-out-1718.google.com with SMTP id 16so77111fgg.1
        for <git@vger.kernel.org>; Wed, 10 Feb 2010 10:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version
         :content-disposition:content-type:content-transfer-encoding
         :message-id;
        bh=q3Chg0knso32WkLo9acHpMUf6K8zhs4f35XCbTJNVXQ=;
        b=M5Pp4LyX6KYp5WMdF73jRwaSWgEcjCNqXBt3tyEITH06KrGApnTO8DOWG5/jyHWMVX
         JEDLOgZ5BJWt0GHEZ98cwUzfQz9zpLWNNrInHLdDOxQ/pV1ntxV427nP5buYWK2tjOse
         9E+2P/9AUirkp+pL0GD6R+9mfzkQQFOqfavrc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-disposition:content-type
         :content-transfer-encoding:message-id;
        b=AlffwyWrYKKVmz3FCrAc8Wwiu6BhXUTkBm4l08HV/JvAx/8qwjYHPH5o6S+RL/eauw
         JAFKZaiilzLZICAuz/AaQzpiKESPru5sEqDnAtZ8RNEFOxxS8+lh0U+VfAuEG+I5CqvI
         pYQwcB9WV5qtUnJZ2V37gGpiEOGy08EXKHiEQ=
Received: by 10.87.2.15 with SMTP id e15mr3746691fgi.22.1265826177656;
        Wed, 10 Feb 2010 10:22:57 -0800 (PST)
Received: from ?192.168.1.13? (abvh24.neoplus.adsl.tpnet.pl [83.8.205.24])
        by mx.google.com with ESMTPS id 16sm738613fxm.8.2010.02.10.10.22.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 10 Feb 2010 10:22:51 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20100210120257.GP4159@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139530>

Dnia =B6roda 10. lutego 2010 13:02, Petr Baudis napisa=B3:
> On Wed, Feb 10, 2010 at 12:28:14PM +0100, Jakub Narebski wrote:
>> On Wed, 10 Feb 2010, Petr Baudis wrote:
>>> On Wed, Feb 10, 2010 at 02:12:24AM +0100, Jakub Narebski wrote:

[...]
>>>> So we either would have to live with non-core PerlIO::Util or (pur=
e Perl)
>>>> Capture::Tiny, or do the 'print -> print $out' patch...
>>>=20
>>> All the magic methods seem to be troublesome, but in that case I'd
>>> really prefer a level of indirection instead of filehandle - as is,
>>> 'print (...) -> output (...)' ins. of 'print (...) -> print $out (.=
=2E.)'
>>> (or whatever). That should be really flexible and completely
>>> futureproof, and I don't think the level of indirection would incur=
 any
>>> measurable overhead, would it?
>>=20
>> First, it is not only 'print (...) -> print $out (...)'; [...]
>>=20
>> Second, using "tie" on filehandle (on *STDOUT) can be used also for=20
>> just capturing output, not only for "tee"-ing; [...]
>>=20
>> Third, as you can see below tie-ing is about 1% slower than using
>> 'output (...)', which in turn is less than 10% slower than explicit
>> filehandle solution i.e. 'print $out (...)'... and is almost twice
>> slower than solution using PerlIO::Util
[...]
>>                Rate tie *STDOUT      output print \$out      perlio
>> tie *STDOUT 27636/s          --         -1%         -9%        -45%
>> output      28030/s          1%          --         -8%        -44%
>> print \$out 30319/s         10%          8%          --        -39%
>> perlio      49967/s         81%         78%         65%          --
>> need
=20
> Ok, on my machine it's similar:
>=20
>                 Rate      output tie *STDOUT print \$out
> output      150962/s          --         -1%         -7%
> tie *STDOUT 152769/s          1%          --         -6%
> print \$out 162604/s          8%          6%          --

I wonder why in my case the 'output (...)' solution was faster than tie=
,
and you have tie faster than 'output'... but I guess 1% is the noise
level.
=20
> is roughly consistent image coming out of it.
>=20
> I guess the time spent here is generally negligible in gitweb anyway.=
=2E.
> I suggested using output() because I think hacking it would be _very_
> _slightly_ easier than tied filehandle, but you are right that doing
> that is also really easy; having the possibility to use PerlIO::Util =
if
> available would be non-essentially nice, but requiring it by stock
> gitweb is not reasonable, especially seeing that it's not packaged ev=
en
> for Debian. ;-)

Well, the idea was to use PerlIO::Util if possible, checking it via

  out $use_perlio_layers =3D eval { require PerlIO::Util; 1 };

and fallback to generic mechanism if it is not present.  Only the
generic mechanism would have to be changed from manipulating *STDOUT
(*STDOUT =3D $data_fh etc.) to tied filehandle.

What we need to be careful about is ':utf8' vs ':raw' mode (IO layer).
In the PerlIO layers solution, and in 'print <sth> -> print $out <sth>'
solution where $out =3D $data_fh, and $data_fh was opened to in-memory
file, the data saved in variable is already converted, already passed
via 'utf8' layer, and is saved as bytes.  And if we use binary mode,
it is passed unchanged, and is also saved as bytes.  Therefore we can
save to cache file in ':raw' more, and read from cache file in ':raw'
mode, and that is why we don't need separate files for text and for
binary output.

PRINT method in class tied to filehandle gets _untransformed_ argument,
so we have to use utf8::encode($str) if in ':utf8' mode, and either
use PerlIO::get_layers on *STDOUT, or provide BINMODE method in tied
class to watch for mode changes.  (Note that e.g. for snapshots we=20
print HTTP headers in ':utf8' mode, and the snapshot itself in ':raw'
i.e. binary mode.).

But all that is doable, and not that much work.  Well, perhaps more
than in the case of 'print -> print $out' etc., and opening in-memory
file via

  open $data_fh, '>', \$data;

but not that more, and we don't need extra global variable $out.  But
no large gitweb patch, and no worry about somebody accidentally using
'print <sth>;' or 'printf <fmt>, <sth>;' instead of respectively
'print $out <sth>;' and 'printf $out <fmt>, <sth>;'.


As to how I installed PerlIO::Util for myself (this might be interestin=
g
to other people): in short, I use local::lib bootstrapping and cpan=20
client.  I could from start install some Perl modules from CPAN locally
using 'cpan' client (included in perl RPM).  I have asked on #perl=20
channel on FreeNode what to do, and they recommended local::lib.  After
following the bootstapping technique described in local::lib manpage
(see e.g. http://p3rl.org/local::lib) installing PerlIO::Util in
~/perl5 is as simple as 'cpan -i PerlIO::Util' (or using 'cpan' client
interactively).

You can always put
  use lib '/path/to/perl5/lib';
in your $GITWEB_CONFIG file.

Perhaps adding something like "use lib __DIR__.'/lib';" somewhere near
beginning of file (where __DIR__ is appropriate expression that expands
to directory the gitweb.cgi/gitweb.perl is in) to gitweb would be a goo=
d
idea?  Then you would be able to make __DIR__/lib symlink to local Perl
modules, or put extra modules by hand under __DIR__/lib.
--=20
Jakub Narebski
Poland
