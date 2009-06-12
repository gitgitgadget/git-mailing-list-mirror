From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 0/3] automatically skip away from broken commits
Date: Fri, 12 Jun 2009 13:56:29 +0200
Message-ID: <c07716ae0906120456j1a14af52n47c3a3542201aaf@mail.gmail.com>
References: <20090606043853.4031.78284.chriscool@tuxfamily.org>
	 <c07716ae0906101237o5038fc4dle9f11b6f2216652a@mail.gmail.com>
	 <7vtz2nlrfs.fsf@alter.siamese.dyndns.org>
	 <200906110602.54861.chriscool@tuxfamily.org>
	 <4A308B5D.2010704@zytor.com> <4A309083.9090907@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sam Vilain <sam@vilain.net>, Ingo Molnar <mingo@elte.hu>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 13:56:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MF5NF-0001zz-F2
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 13:56:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755238AbZFLL4g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Jun 2009 07:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754745AbZFLL4f
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 07:56:35 -0400
Received: from mail-fx0-f216.google.com ([209.85.220.216]:53043 "EHLO
	mail-fx0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753487AbZFLL4e convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Jun 2009 07:56:34 -0400
Received: by fxm12 with SMTP id 12so566258fxm.37
        for <git@vger.kernel.org>; Fri, 12 Jun 2009 04:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=koX+i1I7zo04ANsHsLKAYVrvANZguwTShCGe+lCRsvE=;
        b=qiz6FG7gomW3+bP9azCU+Xtf0jyL4joDqju3du5SmTj4g+xJdcxze4iJqHJlLs5r7R
         ICfat7VdmnDdtSiWB1MkYzJl9moPjNH2OQzPHSW5fFiztZypltBY5oSclTyYl4Cey7au
         wgkWQ799m31DBmRmdSENHzRG2BGe4HYKIViuo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=V7Rl8VdjIed07mE3SwLdUa0F5bbmqpbkqTL/k/ohrYgICdx9c7z+XIab8c19C73DWq
         ZAGcDUKa4DeouFo5xzpPnNl0AbhLihZcxUIlYqtlrsbpPQVsv58g1F4GvhJ2k+wg3ciD
         RPmWElFuBf7FZ9sg2MrDZq+yCwJ/H4bBnWj8Q=
Received: by 10.103.181.20 with SMTP id i20mr1833190mup.62.1244807795467; Fri, 
	12 Jun 2009 04:56:35 -0700 (PDT)
In-Reply-To: <4A309083.9090907@zytor.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121410>

On Thu, Jun 11, 2009 at 7:05 AM, H. Peter Anvin<hpa@zytor.com> wrote:
>
> Urk, I managed to get myself completely confused -- I did the series
> approximation on the wrong side of inverting the function. =A0The cor=
rect
> power is actually 1.5 (over the range 0 to 1), a value > 1 is necessa=
ry
> to bias the PRNG toward the beginning (x =3D 0) of the list.

I started working on this, but I wonder if it's better to add a
#include <math.h> and link with -lm than to provide a custom sqrt
implementation. Too bad the best power is not 2.

To implement the PRNG, I guess that using something based on the
function given by "man 3 rand" should be ok:

int get_prn(int count) {
    count =3D count * 1103515245 + 12345;
    return((unsigned)(count/65536) % 32768);
}

where the "count" we pass is the count of elements in the list rather
than the static seed.

Best regards,
Christian.
