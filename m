From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [RFC/PATCHv2 2/6] add metadata-cache infrastructure
Date: Wed, 13 Jul 2011 10:45:52 +0200
Message-ID: <CAKPyHN1tixwJPJHG+wY34HVLYGT4fD9Sc-qJ8=on8EWfW-H6aw@mail.gmail.com>
References: <20110713064709.GA18499@sigill.intra.peff.net>
	<20110713070405.GB18566@sigill.intra.peff.net>
	<CAKPyHN1FgK6NXqZFZ=OvMgouhfxnGF0aXU+--y-P1u9BcK9Z4A@mail.gmail.com>
	<20110713083139.GA26838@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, "Ted Ts'o" <tytso@mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 13 10:46:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qgv4y-000876-9O
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 10:46:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965100Ab1GMIpx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jul 2011 04:45:53 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:43327 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965073Ab1GMIpx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jul 2011 04:45:53 -0400
Received: by vws1 with SMTP id 1so4045770vws.19
        for <git@vger.kernel.org>; Wed, 13 Jul 2011 01:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=dzpmh0BoTwpHdrpOvTHbvCBHcjzqshYj9Bi8D3tZLBk=;
        b=e2+Ep5ip9V6FQpKc3cMVJ5du8FyZAOwSIQPTzllB2ooi/cNHDwXJ+Mir2K3R8ncP20
         SK8eBRY1DLUSPV5d0acpsvLhhHK9v3P6A9W68FPhdcOsLkzYMydLIey4ViE1Q1I1w3Vb
         315mPQFsmh8sqUagWvSF0gjfdMNGfn8kR9bD0=
Received: by 10.52.72.161 with SMTP id e1mr978747vdv.195.1310546752392; Wed,
 13 Jul 2011 01:45:52 -0700 (PDT)
Received: by 10.52.107.228 with HTTP; Wed, 13 Jul 2011 01:45:52 -0700 (PDT)
In-Reply-To: <20110713083139.GA26838@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177016>

On Wed, Jul 13, 2011 at 10:31, Jeff King <peff@peff.net> wrote:
> On Wed, Jul 13, 2011 at 10:18:28AM +0200, Bert Wesarg wrote:
>
>> > +static int record_size(const struct metadata_cache *c)
>> > +{
>> > + =C2=A0 =C2=A0 =C2=A0 /* a record is a 20-byte sha1 plus the widt=
h of the value */
>> > + =C2=A0 =C2=A0 =C2=A0 return c->mem.width + 20;
>>
>> You are circumventing your own API. Why do you don't use the
>> decoration_width() accessor here? I don't see any check that
>> METADATA_CACHE_INIT("frotz", 0, NULL) is invalid neither in the
>> documentation nor in the code.
>
> "struct decoration" has the "0 width means store a void pointer" rule
> for compatibility with existing callers. But I never intended for
> metadata-cache to have such an exception. Nor would it make sense to
> store a void pointer. The pointer would be written to disk, and would
> then be meaningless during the next run of the program.
>
> I didn't figure anyone would assume the same special rule held for
> metadata-cache; the fact that it is implemented using "struct
> decoration" is not part of its public API. But I guess I was wrong.

You're right here, that it is not part of the public API, but you're
not wrong about your guess. But when reading this patch series, the
reader obviously knows that the metadata-cache uses a struct
decoration for the in-memory values. Thus the reader knows that 0 is
special for struct decoration, and that there is an API to get the
width from the struct decoration.

>
> It might make sense to put:
>
> =C2=A0if (!c->mem.width)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0die("BUG: zero-width metadata-cache=
");
>
> into the initialization function to make it more clear, and make a no=
te
> in the API documentation.

That should be good. Thanks.

Bert

> -Peff
>
