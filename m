From: Steven Walter <stevenrwalter@gmail.com>
Subject: Re: [PATCH] git-svn.perl: fix a false-positive in the "already
 exists" test
Date: Tue, 21 Feb 2012 21:32:29 -0500
Message-ID: <CAK8d-aLXs0yMzYMXm7fKytOGDXesUEx7a8PN_Mg9gw6+Q6OTBA@mail.gmail.com>
References: <20120219105442.GA11889@dcvr.yhbt.net> <1329747474-17976-1-git-send-email-stevenrwalter@gmail.com>
 <7vk43feho8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: normalperson@yhbt.net, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 22 03:32:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S020l-0002Q4-TU
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 03:32:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755654Ab2BVCcu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Feb 2012 21:32:50 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:56907 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753641Ab2BVCct convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Feb 2012 21:32:49 -0500
Received: by ghrr11 with SMTP id r11so3235126ghr.19
        for <git@vger.kernel.org>; Tue, 21 Feb 2012 18:32:49 -0800 (PST)
Received-SPF: pass (google.com: domain of stevenrwalter@gmail.com designates 10.101.136.7 as permitted sender) client-ip=10.101.136.7;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of stevenrwalter@gmail.com designates 10.101.136.7 as permitted sender) smtp.mail=stevenrwalter@gmail.com; dkim=pass header.i=stevenrwalter@gmail.com
Received: from mr.google.com ([10.101.136.7])
        by 10.101.136.7 with SMTP id o7mr1643676ann.55.1329877969238 (num_hops = 1);
        Tue, 21 Feb 2012 18:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=27Cf5yqcF1HqTm2mBCZLipYTD00sNbR4rpPeYzHmR0U=;
        b=MXAWNfdJClz2PQ7AuAnUxsJLvnkaCubCCF852QEqY8u2nVRgCDcdQugKL77N3+AFma
         nWzm4Fyy2y3Dd6xshDNCyVvEAkU5Uud12//JWElYXt8Vh06Q+vmr1jeXjqONXvJGB4Pe
         mazb40SZIxSKPgZh16QrfYEXJBmLm6XjH+4sM=
Received: by 10.101.136.7 with SMTP id o7mr1347593ann.55.1329877969156; Tue,
 21 Feb 2012 18:32:49 -0800 (PST)
Received: by 10.100.96.10 with HTTP; Tue, 21 Feb 2012 18:32:29 -0800 (PST)
In-Reply-To: <7vk43feho8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191224>

On Tue, Feb 21, 2012 at 9:16 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Steven Walter <stevenrwalter@gmail.com> writes:
>
>> diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
>> index b041516..4029f84 100755
>> --- a/t/t9100-git-svn-basic.sh
>> +++ b/t/t9100-git-svn-basic.sh
>> @@ -92,9 +92,11 @@ test_expect_success "$name" '
>> =A0 =A0 =A0 echo yyy > bar/zzz/yyy &&
>> =A0 =A0 =A0 git update-index --add bar/zzz/yyy &&
>> =A0 =A0 =A0 git commit -m "$name" &&
>> + =A0 =A0 git svn set-tree --find-copies-harder --rmdir \
>> + =A0 =A0 =A0 =A0 =A0 =A0 ${remotes_git_svn}..mybranch3 &&
>> + =A0 =A0 svn_cmd up "$SVN_TREE" &&
>> + =A0 =A0 test -d "$SVN_TREE"/bar/zzz &&
>> + =A0 =A0 test -e "$SVN_TREE"/bar/zzz/yyy ' || true
>
> Care to explain what this " || true" is doing here, please?

Ahh, good catch.  I think the answer is that it shouldn't be there.
It was originally there because of the "test_must_fail" line, I think
(at least the other tests that use test_must_fail also have "||
true").  The tests all still pass with that "|| true" removed.  Do you
want to just fix that up, or a new version of the original patch, or a
fix on top of the original patches?
--=20
-Steven Walter <stevenrwalter@gmail.com>
