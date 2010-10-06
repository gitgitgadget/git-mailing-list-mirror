From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCHv5 06/17] gitweb/lib - Simple select(FH) based output capture
Date: Wed, 6 Oct 2010 23:03:16 +0000
Message-ID: <AANLkTikVumyaJoM3=Nbf9igVheLvMB5tcc5+E+wSkb40@mail.gmail.com>
References: <1286402526-13143-1-git-send-email-jnareb@gmail.com>
	<1286402526-13143-7-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 01:03:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3d1G-0007Jz-RK
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 01:03:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755039Ab0JFXDT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Oct 2010 19:03:19 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37213 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753183Ab0JFXDT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Oct 2010 19:03:19 -0400
Received: by iwn9 with SMTP id 9so309iwn.19
        for <git@vger.kernel.org>; Wed, 06 Oct 2010 16:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=rvNBhzknHslFcQINYs8gAKLJ+6fBuqD+GpE171CwvDU=;
        b=uI+eo55PzhDOGWo19BdxCvt6G3KXjs5cT5edCJdBW8EOw48AcSYqbUoSSUM0k5Wt7V
         uQ+cDZyDhGt/PHnuzLg8eGi/hcybt55tOdVNcUmQ+ZPvkRSuZz1zD3UIQ318esSp3RnJ
         1+RDhHGpa6HQawEtKlopmRjLu+gjkCBA86SRU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=oSw1NRnBzNOP2tXO1LwnoknFikFsyMLtLqmqenr3XUez3MkQhgWfc19nkBYy39p8Gc
         LIo6CDr3wfTS4+xsfLYrVh7g+eKQbWz82LnoXesctstzb6iLgnYglysp98RT6pbWXuoT
         URjd3/N6kR+c198LLfSbdsZ2TVlWFSIKarZ80=
Received: by 10.42.145.134 with SMTP id f6mr1481230icv.153.1286406196213; Wed,
 06 Oct 2010 16:03:16 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Wed, 6 Oct 2010 16:03:16 -0700 (PDT)
In-Reply-To: <1286402526-13143-7-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158346>

On Wed, Oct 6, 2010 at 22:01, Jakub Narebski <jnareb@gmail.com> wrote:

> * The most important issue is that I/O "layers" (PerlIO), like ':utf8=
'
> =C2=A0or ':raw', are *already applied* to the output that is captured=
=2E
> =C2=A0This means that captured output is *always* in binary (':raw') =
mode.
> =C2=A0In Perl 6 language it means that data returned by capturing eng=
ine
> =C2=A0is an equivalent of Buf, a collection of bytes, whether Buf or =
Str
> =C2=A0(a colection of logical characters) is printed.

> + =C2=A0 =C2=A0 =C2=A0 # note: this does not cover all cases
> + =C2=A0 =C2=A0 =C2=A0 binmode select(), ':utf8'
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((PerlIO::get_l=
ayers($self->{'oldfh'}))[-1] eq 'utf8');

I'm not sure but maybe we want to use ":Encoding(UTF-8)" everywhere in
this series where you've used ":utf8". I.e. use the Encoding UTF-8
layer instead of the internal utf8 layer.

It's more strict, see perldoc Encode's "UTF-8 vs. utf8 vs. UTF8". But
maybe we don't care.
