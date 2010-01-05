From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH v3 5/6] transport-helper.c::push_refs(): ignore
 helper-reported status if ref is not to be pushed
Date: Tue, 5 Jan 2010 18:01:13 +0800
Message-ID: <20100105180113.6e0572dc.rctay89@gmail.com>
References: <20091224154352.ecefd242.rctay89@gmail.com>
	<20091224154258.08b4fe44.rctay89@gmail.com>
	<20091224154158.15ba580f.rctay89@gmail.com>
	<20091224154057.33611ae7.rctay89@gmail.com>
	<20091224154005.a642c8ec.rctay89@gmail.com>
	<20091224154445.ad4b7a01.rctay89@gmail.com>
	<20100105063253.GA19368@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 05 11:03:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NS6GN-0003YM-2I
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jan 2010 11:03:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751563Ab0AEKB0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Jan 2010 05:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179Ab0AEKB0
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 05:01:26 -0500
Received: from mail-gx0-f211.google.com ([209.85.217.211]:61198 "EHLO
	mail-gx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751086Ab0AEKBZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Jan 2010 05:01:25 -0500
Received: by gxk3 with SMTP id 3so3564326gxk.1
        for <git@vger.kernel.org>; Tue, 05 Jan 2010 02:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=B7pJVW4wG8EanR9YD2hG2iONefJe5K/JhUlihaAkrcI=;
        b=Iji0CdwT7IDXLJ4X8x3YbOpNT3rG8xmYnd0Q1VWhhximxWpVvteRM1pKGBqcvTrtrB
         MuJnYA/8vuHBiBGY6vfvr7jbSZCxUmnUYBDUT51uND/d1H9M1huxgFTS2wv/iTJHw6yU
         zAw0KCO3rVjufYlMse3Q8kI2XsEhr6xZMY1po=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=kufZaKd83HI48bIXIkLd9do1Teo1mWXqQyKVW0FUbozIYzAU2dcz5awODnRGrIoCBK
         yA6zgR35ZXtgUpMcA4qBwwIPxKMlnGaLuU1D5Nv3UPizosmsJpN+BU6RKi4CoRt8+x8Q
         jLAIbmMK1vu4/8wkDjlifOM/V19djQIvH0pqE=
Received: by 10.91.51.23 with SMTP id d23mr1333395agk.94.1262685684347;
        Tue, 05 Jan 2010 02:01:24 -0800 (PST)
Received: from your-cukc5e3z5n (cm154.zeta152.maxonline.com.sg [116.87.152.154])
        by mx.google.com with ESMTPS id 16sm9114132gxk.3.2010.01.05.02.01.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 05 Jan 2010 02:01:23 -0800 (PST)
In-Reply-To: <20100105063253.GA19368@coredump.intra.peff.net>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136180>

Hi,

On Tue, Jan 5, 2010 at 2:32 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Dec 24, 2009 at 03:44:45PM +0800, Tay Ray Chuan wrote:
>
>> - =A0 =A0 =A0 =A0 =A0 =A0 ref->status =3D status;
>> - =A0 =A0 =A0 =A0 =A0 =A0 ref->remote_status =3D msg;
>> + =A0 =A0 =A0 =A0 =A0 =A0 switch (ref->status) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 case REF_STATUS_REJECT_NONFASTFORWARD:
>> + =A0 =A0 =A0 =A0 =A0 =A0 case REF_STATUS_UPTODATE:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Earlier, the ref was =
marked not to be pushed, so ignore what
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* the remote helper sai=
d about the ref.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> + =A0 =A0 =A0 =A0 =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ref->status =3D status;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ref->remote_status =3D msg=
;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>
> It seems like this should be checking for REF_STATUS_NONE explicitly
> instead of trying to enumerate the reasons we might not have tried to
> push. Shouldn't helpers _only_ be pushing REF_STATUS_NONE refs?
>
> I think right now the two cases are equivalent, since non-ff and
> uptodate are the only two states set before the helper is invoked. Bu=
t
> we have discussed in the past (and I still have a patch floating arou=
nd
> for) a REF_STATUS_REWIND which would treat strict rewinds differently
> (silently ignoring them instead of making an error). Explicitly check=
ing
> REF_STATUS_NONE future-proofs against new states being added.

I'm not really sure if this is true (ie. that if status is not non-ff
or uptodate, then it is REF_STATUS_NONE), but we could step around this
by introducing a property, say, ref->should_push, that is set to 1,
after all the vetting has been carried out and just before we talk to
the server.

That way, we just check that property, without having to know the ref
statuses that would mark a ref not-for-pushing. Sounds future-proof (in
your sense) to me.

--
Cheers,
Ray Chuan
