From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC v7 1/2] Add infrastructure for translating Git with
 gettext
Date: Sat, 5 Jun 2010 14:27:17 -0500
Message-ID: <20100605192717.GB5273@progeny.tock>
References: <1275704035-6552-1-git-send-email-avarab@gmail.com>
 <1275704035-6552-2-git-send-email-avarab@gmail.com>
 <20100605025702.GA2019@progeny.tock>
 <AANLkTil541q0RtZsEmnLOtUNxfltvcFCGxpxR-myhyDl@mail.gmail.com>
 <20100605033626.GA2252@progeny.tock>
 <AANLkTimHZdT3vfuUyG1cnanE3WLrhDGqqw5JyYfza6wD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 05 21:27:24 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKz1f-0005z6-Tl
	for gcvg-git-2@lo.gmane.org; Sat, 05 Jun 2010 21:27:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754245Ab0FET1T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Jun 2010 15:27:19 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:58347 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751719Ab0FET1S (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jun 2010 15:27:18 -0400
Received: by iwn37 with SMTP id 37so2137188iwn.19
        for <git@vger.kernel.org>; Sat, 05 Jun 2010 12:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=vOHldZv434xEqyVSYNbP+ewBfmrKaqtTrIpSILF7kzk=;
        b=u2UF6edvoRCRerpgIgHIFT2U+PoLAWlRUH5fR0DNuphpZo00hfGcfK4pePB2PhKxDI
         GbXDS+F5sXI0mp2FZsUKxeN8IVCXQAwlg0Mm12Xo7Guf51CphnQpfvwYUTS+4TFTPTaK
         3F3YLcQlRVuxFJfE3li4qNqx3atG4wZNHMOWw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=F6K2ZeBEoH1zhe0vvngyTlIn0tJe9y47y3WByGFXo7LqUQoX+TdWhDRMYUecU47IdT
         iDCzhhh4GP2vyMLIxekv2jMs+whgsjo0sGD7KReNHSKGHJ84vKPHhQggxcf9NKV1py4K
         X8jgl4S+uChB1FEn2vcVOMvsWWD0b+GBUIgA8=
Received: by 10.231.114.144 with SMTP id e16mr2454019ibq.188.1275766037358;
        Sat, 05 Jun 2010 12:27:17 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id t28sm11771608ibg.0.2010.06.05.12.27.14
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 05 Jun 2010 12:27:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTimHZdT3vfuUyG1cnanE3WLrhDGqqw5JyYfza6wD@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148487>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> IMO trying to plan in advance what we should and shouldn't translate
> is a bit premature.
>=20
> I think it's better to just add glue so that everything can be
> translated, then we can try decide later if some arbitrary subset
> shouldn't have translations (even for human readable error messages)
> and act appropriately.

Certainly there is no need to commit to decisions that will have no
observable effect.  However, setlocale()

 - takes some small amount of time (probably negligible);

 - changes the semantics of regular expression matching
   (this affects =E2=80=98git grep=E2=80=99, =E2=80=98git diff=E2=80=99=
's search for a function
   header, and http-backend=E2=80=99s service-command regexps);

 - changes the human language used for strerror().

We could avoid these issues by turning translations off by default and
calling it experimental, which might be the right thing to do anyway.

Alternatively we can make some choice and stick to it (e.g., all git
commands use setlocale(), or just the translated ones, or whatever).
I just want to ensure it is a conscious choice.

Jonathan
