From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [minor BUG] cherry-pick -x doesn't work if a conflict occurs
Date: Wed, 5 Jan 2011 11:28:58 -0500
Message-ID: <AANLkTimi8s7QRYuEgr2x=bqwEuFPqUUQF4E=f=_PsoV0@mail.gmail.com>
References: <20101229141638.GA14865@pengutronix.de> <24C35180-AED6-4848-9F05-908831F911F9@dewire.com>
 <20110105065047.GJ25121@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Wed Jan 05 17:29:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaWEz-00015T-3p
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 17:29:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578Ab1AEQ3a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Jan 2011 11:29:30 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:63255 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245Ab1AEQ33 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Jan 2011 11:29:29 -0500
Received: by iwn9 with SMTP id 9so15385079iwn.19
        for <git@vger.kernel.org>; Wed, 05 Jan 2011 08:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=2pOnPDArFM8S7BNk19uFnpFd99Yiixrng6VGAVgsU4Y=;
        b=tip3EYlTSGQRZv4BbIIQqSA9QCe0mTTFkGF2ldSZXZq26Y94PgVSfKEl+i+Xv/BhTY
         pnVa5/A47vLnHqIeWTYGzs8T9U+qrlazQVSRJOwUvPkhR1zKvxH4FFMDX/iA2n6g+rIV
         fs/zD4ujB6UYb+leWpCH3AI4z9P0LrPiSlS78=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ZblncaQHYM5mAM5/mmlURMjAqI/i0lZVTomxJGqem8GIoJmrYIlRsdNWWf2A3TaYcm
         ZP0NeVZ59rng1PVc6D6f1mM5ekgwRl2EZh3R9T18zzNb7bLD/kE2+VSMhJfl4h9rpxLf
         NutkarkkorNfCG38jAB7Al4WjhDwQaA9zyQzE=
Received: by 10.231.34.65 with SMTP id k1mr7284090ibd.9.1294244968805; Wed, 05
 Jan 2011 08:29:28 -0800 (PST)
Received: by 10.231.167.78 with HTTP; Wed, 5 Jan 2011 08:28:58 -0800 (PST)
In-Reply-To: <20110105065047.GJ25121@pengutronix.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164570>

2011/1/5 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>:
>> The man page says -x only takes effect when you do not have a confli=
ct, so there
>> is no bug.
> ah, I wonder if this is intended or just documenting a short-coming :=
-)

I think it's intended as it's no longer the original commit, but
personally I think it should be configurable (I'd like -x to be
configurable as well). For now, I use the following "recommit" script
after a cherry-pick conflict.

#!/bin/sh
# Used after a cherry-pick conflicts to commit with the original
# authorship (commit -c) but keep the newly generated commit message
#
self=3D$(cd "$(dirname "$0")" && pwd -P)/$(basename "$0")
=2E "$(git --exec-path)/git-sh-setup"
require_work_tree
cd_to_toplevel
test -f .git/MERGE_MSG || die "No .git/MERGE_MSG"

if test "$GIT_EDITOR" =3D "$self"
then
  cat .git/MERGE_MSG > .GIT/COMMIT_EDITMSG
  exit 0
fi

if sha1=3D$(sed -ne \
  's/^(cherry picked from commit \([a-f0-9]\{40\}\))$/\1/p' .git/MERGE_=
MSG)
then
  export GIT_EDITOR=3D"$self"
  git commit -c $sha1
fi

j.
