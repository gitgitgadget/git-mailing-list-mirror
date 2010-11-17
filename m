From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 01/10] add: do not rely on dtype being NULL behavior
Date: Wed, 17 Nov 2010 13:38:14 +0700
Message-ID: <AANLkTi=DUXS8i9oE+2spm3_g=F137AOfKi0rj3Tu=+AG@mail.gmail.com>
References: <1289817410-32470-1-git-send-email-pclouds@gmail.com>
 <1289817410-32470-2-git-send-email-pclouds@gmail.com> <20101115121415.GB14729@burratino>
 <AANLkTikkArsu=NLJWQcP61uf3yrQmdxRQtB+3AmC9tHQ@mail.gmail.com> <7v39r1hz92.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 17 07:38:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIbfF-0001jH-AJ
	for gcvg-git-2@lo.gmane.org; Wed, 17 Nov 2010 07:38:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934350Ab0KQGih convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Nov 2010 01:38:37 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:51235 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933297Ab0KQGig convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Nov 2010 01:38:36 -0500
Received: by wyb28 with SMTP id 28so1630293wyb.19
        for <git@vger.kernel.org>; Tue, 16 Nov 2010 22:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=JQ8UtFw9weWm1yeZCVaTHuVbSTHDAlFJNEh3zTyWFfQ=;
        b=ASXThDm/hIG6ZSo4MeVLFQtaDkfZR/YAOaVa6gwZrK/OizwyebIw14jzbXuu9juB79
         zFAE1fPzhN9PXS+91A2s8WL150PqAHNmInIqixKIxV/vxe7wSnkbv6E7Xuyq+qo7pBU3
         hruL7HgETDgDkd6Q29Ss9gAofcMqTzFniyH4o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=hx/CXLhQ1p+ewZr9IofJ8oUtxFhry8hXqO+exp8MARyRQ1gPNqPArOqNE7ekWjwTyj
         jgXT+B9owS1H009zZ4AWikyQqOUuKYO3QKHGAFFWFDGp/xtpzSMVm7Ho9oC5vDLdQsqA
         ZBytaV+Oy/WV1D0+LQyvMwdaYs77B8VcDznjM=
Received: by 10.216.166.68 with SMTP id f46mr1224261wel.26.1289975914959; Tue,
 16 Nov 2010 22:38:34 -0800 (PST)
Received: by 10.216.172.199 with HTTP; Tue, 16 Nov 2010 22:38:14 -0800 (PST)
In-Reply-To: <7v39r1hz92.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161601>

On Wed, Nov 17, 2010 at 1:58 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> Hmm.. get_index_dtype() would return DT_DIR if the submodule exists =
in
>> index. If it does not it must be a directory in worktree, right?
>> Call flow: excluded_from_list() -> get_dtype() -> get_index_dtype()
>
> By the way, your c84de70 (excluded_1(): support exclude files in inde=
x,
> 2009-08-20) looks broken. =C2=A0What happens when the exclude pattern=
 wants a
> directory but specifies it with a wildcard?

It fails. I realized that just this week unfortunately. That commit is
reverted in this series.

> The safest and sanest first step is to just change DT_UNKNOWN (which
> clearly is a wrong thing to pass) to NULL to keep the current behavio=
ur,
> but it probably makes more sense to do the second step at the same ti=
me to
> pass a pointer to an int that holds DT_UNKNOWN to avoid triggering th=
at
> broken codepath.

Yes.
--=20
Duy
