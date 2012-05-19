From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/2] index-pack: use streaming interface on large blobs
 (most of the time)
Date: Sat, 19 May 2012 12:31:57 +0700
Message-ID: <CACsJy8CypvcS3sTn1isREYzApN273PcKnMJBpWBrOaO2ZaSLSw@mail.gmail.com>
References: <1337172630-23679-1-git-send-email-pclouds@gmail.com>
 <1337172630-23679-2-git-send-email-pclouds@gmail.com> <xmqqzk95168w.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 19 07:32:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVcHM-0002ut-M3
	for gcvg-git-2@plane.gmane.org; Sat, 19 May 2012 07:32:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753481Ab2ESFca convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 May 2012 01:32:30 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:53064 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753173Ab2ESFc3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 May 2012 01:32:29 -0400
Received: by wgbdr13 with SMTP id dr13so3348449wgb.1
        for <git@vger.kernel.org>; Fri, 18 May 2012 22:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=zcw5nPsSZgC/NsCuoCOe2icDQTpaeIKSYDhbR3sR38g=;
        b=HvdpwUfQysqcLpfmWKh3804JlW+g4mYKykcaEZD6eBB/+0NrVR7Urv1YPgdclCzCCe
         gb+DUWY7H5zouYHY/AQeL23WVWs8MDyM8TNNspZKwmTQmTxAD8omPJg91O6zYMr8bXaE
         85DNhbeR1S3WKiTjg4cuVjZPyftZ4Qs/bYNjEippbtnhtQG0mw/e+82aNdXfBDwblTQe
         2fWSDsrADxY6UMuk28jHWAqW+OXjnPdH7KizmmXXNIDObsxadeZtD/Zrsvr89nba/6PW
         A/viflC8VEtMjjTzC4AYSNBHDbtEHZkgHLnvzoj3n5bpZSoELsMHZphoqEOfTuLoUx4n
         H2zg==
Received: by 10.180.99.70 with SMTP id eo6mr7603533wib.17.1337405547999; Fri,
 18 May 2012 22:32:27 -0700 (PDT)
Received: by 10.223.64.208 with HTTP; Fri, 18 May 2012 22:31:57 -0700 (PDT)
In-Reply-To: <xmqqzk95168w.fsf@junio.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198015>

On Sat, May 19, 2012 at 5:20 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> w=
rites:
>
>> unpack_raw_entry() will not allocate and return decompressed blobs i=
f
>> they are larger than core.bigFileThreshold.
>>
>> The blob content is needed by sha1_object() in some cases. When we d=
o
>> need the blob content, we put it back in core with
>> get_data_from_pack(). However we rarely need that in pratice.
>>
>> The first case is when we find an in-repo blob with the same SHA-1. =
We
>> need to do collision test, byte-on-byte. Normally (e.g. in
>> fetch/pull/clone) this does not happen because git avoid to send
>> objects that client already has.
>
> Perhaps the codepath that performs the byte-for-byte comparison can b=
e
> taught to stream from the received pack data and whatever was already
> in the repository, using the streaming interface? =C2=A0That way you =
do not
> have to hold all of the both objects at the same time in core, no?

Sure. But that does not happen until you are attacked. Maybe later.

verify-pack'ing also runs into this, but that's another issue and
should be fixed separately (hopefully by verify-pack users).
--=20
Duy
