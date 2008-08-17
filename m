From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [RFC PATCH 0/9] Narrow/Sparse checkout round 3: "easy mode"
Date: Sun, 17 Aug 2008 20:36:28 +0700
Message-ID: <fcaeb9bf0808170636j3c273ef9sfa55c8e432ab1293@mail.gmail.com>
References: <20080815142439.GA10609@laptop>
	 <7v1w0pdze0.fsf@gitster.siamese.dyndns.org>
	 <fcaeb9bf0808162212y756465a5ib7ce3a8849765033@mail.gmail.com>
	 <7vbpzs9om7.fsf@gitster.siamese.dyndns.org>
	 <7v3al49nos.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 17 15:37:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUiRs-0005aC-6e
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 15:37:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753109AbYHQNgb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 09:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753111AbYHQNgb
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 09:36:31 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:27331 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753081AbYHQNga (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 09:36:30 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1418291fgg.17
        for <git@vger.kernel.org>; Sun, 17 Aug 2008 06:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Yj3uB0s8hcpPpU1jWQ+0qADuyA0OcixHbt+aIHg1vGY=;
        b=IzjUBE1VQe6EU4B/ja02aYB1bQJD7nDnX1LqIVPSvOWdsrgJeSE5QjZ7o/K59AUbRf
         mAl/+NVXttwlwiuJH8P2ghGuH7Ufc8gfMCX0zgBgztFyKZYiDm7Yo7/IKNIEcc5+0uD0
         qJsKb3lrisYTRucLfFVetXHCbd/0M6tXgA15c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=KWEyhze+X/OnAP5Rt3Urt4mBaFhbuzGRMcnlOmSjScqh03VnOrc0i9KoDxY1lE9tAY
         T8c8Txe/WeKdV49tM9bHajIHnCZZ9HPmKYQl4ya59Jl1j/t7eG7J1aGjnekHFu1unDHI
         Z1wCx9A423ILIk0458Mz2l6cwW+thKDw2da/8=
Received: by 10.86.80.5 with SMTP id d5mr3768705fgb.26.1218980188541;
        Sun, 17 Aug 2008 06:36:28 -0700 (PDT)
Received: by 10.86.93.13 with HTTP; Sun, 17 Aug 2008 06:36:28 -0700 (PDT)
In-Reply-To: <7v3al49nos.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92611>

On 8/17/08, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>  > "Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:
>
> > ...
>
> >> The problem is "narrow rules" may change over time in a way that git
>  >> may handle it wrong. Assume that you have a directory with two files:
>  >> a and b. You first narrow checkout a (which would save the rule
>  >> "checkout a"). Then you do "git checkout b". When you update HEAD,
>  >> what should happen?
>  >
>  > I'd expect that this sequence:
>
> > ...
>
> > you can record list of pathspecs (with positive and negative) to implement
>  > that semantics, no?
>
> By the way, I was just mentioning the index extension area as a means to
>  store the rules if _you wanted to_.  I do not insist you to actually store
>  the rules, and in fact, I do not know if it is even a good idea to do so.

I was more worried about those rules getting out of control because
git-checkout is not the only command that can change narrow rules.
After enough commands, the rules can become a mess that you don't even
want to look at them. I don't do negative rules now, but yes that's
possible.

>  > Ok.  We would need to use an extra bit for this.
>  >
>  > The bit 0x4000 is the last one available, so we would want to use it as
>  > "this index entry uses more bits than the traditional format" bit, and
>  > define a backward incompatible on-disk index entry format to actually
>  > record CE_NO_CHECKOUT and other flags we will invent in the future.
>  >
>  > Perhaps ondisk_cache_entry structure will have an extra "unsigned int
>  > flags2" after "flags" when that bit is on, and we can have 31 more bits in
>  > flags2, with the highest bit of flags2 signalling the presense of flags3
>  > word in the future, or something like that.
>
>
> It might make sense to do this first as a futureproof, if we really want
>  to go this route.  We can ensure that an index that does use the new flag
>  bits won't be misinterpreted by older git.

The patch is fine. Still we need to do something to prevent older git
from using new index format.
-- 
Duy
