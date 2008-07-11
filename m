From: "Geoffrey Irving" <irving@naml.us>
Subject: Re: [PATCH] cherry: cache patch-ids to avoid repeating work
Date: Fri, 11 Jul 2008 08:41:36 -0700
Message-ID: <7f9d599f0807110841r329dfb95g786a576bd981dd1b@mail.gmail.com>
References: <7f9d599f0807082053w4603d0bbgfead9127c33b78b5@mail.gmail.com>
	 <7f9d599f0807082226oee83bedrf13d254ae12be274@mail.gmail.com>
	 <7vprpnlglh.fsf@gitster.siamese.dyndns.org>
	 <7f9d599f0807092034n438f0976pf44d4c9305871087@mail.gmail.com>
	 <7f9d599f0807100709u778f0ab1y28776d7efb831b61@mail.gmail.com>
	 <alpine.DEB.1.00.0807101526380.18205@racer>
	 <7f9d599f0807100733s4435a9bga89749f2f6e10cf@mail.gmail.com>
	 <7v3amglxmb.fsf@gitster.siamese.dyndns.org>
	 <7f9d599f0807110758y6c4ea7bepd726daf4fe5f074c@mail.gmail.com>
	 <alpine.DEB.1.00.0807111635400.8950@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 11 17:42:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHKlh-0000nz-4z
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 17:42:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752580AbYGKPlk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 11:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758363AbYGKPlj
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 11:41:39 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:4701 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059AbYGKPlj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 11:41:39 -0400
Received: by yx-out-2324.google.com with SMTP id 8so1316406yxm.1
        for <git@vger.kernel.org>; Fri, 11 Jul 2008 08:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=9vbfpz2VqAp4bCRF3b6ndDs4ME8alR9IgkdshPIbjxg=;
        b=Vv2l9qGAROrCmbKpa8+RYE3sD7ob9bixapbIK38Mfk5SMNGFgW7ZE7qjjK05xPbArW
         iphpM+gjtGY+VUAcuNevI8PlrpX108HklN0UkhnNgG8M5kdGGs/cZ8nVIJkMbBIzex83
         GWZzWSkYFqDUBFK0Ds9e5cspKdFOUDHC1Odxc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=bltxgtzAmcxsLhVTTuWkZzGF30M3B9P3QUVIw78WgQ2DrjGuGUUPYmgpFJf1+BSb+t
         bRTmbZpvIKDGKpnpIcKgKi2Dd9zCVuSJy8UrIzQu+gCCTFDPwyNKukRRzchtw5yEVqQ/
         JLbht0YpvP2ASr98JYoS+YS7Gekf5+m7AyLzo=
Received: by 10.115.49.11 with SMTP id b11mr14084677wak.117.1215790897033;
        Fri, 11 Jul 2008 08:41:37 -0700 (PDT)
Received: by 10.141.202.6 with HTTP; Fri, 11 Jul 2008 08:41:36 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0807111635400.8950@racer>
Content-Disposition: inline
X-Google-Sender-Auth: 8b0ed858eae4aad3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88129>

On Fri, Jul 11, 2008 at 8:36 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Fri, 11 Jul 2008, Geoffrey Irving wrote:
>
>> On Thu, Jul 10, 2008 at 11:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> > "Geoffrey Irving" <irving@naml.us> writes:
>> >
>> >>>> Oops: avoiding the infinite loop only requires reading expected O(1)
>> >>>> entries on load, so I can fix that if you like.  It would only be all of
>> >>>> them if it actually did detect the infinite loop.
>> >>>
>> >>> I have to admit that you lost me there.  AFAIR the patch-id cache is a
>> >>> simple commit->patch_id store, right?  Then there should be no way to get
>> >>> an infinite loop.
>> >>
>> >> If every entry is nonnull, find_helper loops forever.
>> >
>> > Isn't it sufficient to make this part check the condition as well?
>> >
>> > +       if (cache->count >= cache->size)
>> > +       {
>> > +               warning("%s is corrupt: count %"PRIu32" >= size %"PRIu32,
>> > +                       filename, cache->count, cache->size);
>> > +               goto empty;
>> > +       }
>> >
>> > At runtime you keep the invariants that hashtable always has at most 3/4
>> > full and whoever wrote the file you are reading must have honored that as
>> > well, or there is something fishy going on.
>>
>> Good point.  There's no reason not to check the 3/4 condition.  It isn't
>> sufficient to avoid the infinite loop, though, since we don't verify
>> that count is accurate.
>
> Why so complicated?  I mean, you can count in that "infinite" loop
> yourself, no?

Yeah, I was just trying to avoid the extra termination condition,
because I don't think it adds any real safety.

Geoffrey
