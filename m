From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 1/4] replace: add --graft option
Date: Sun, 29 Jun 2014 08:34:35 +0200
Message-ID: <CAP8UFD25k4X0vVUDDTOj_XDqmShz-aHXFLKD5bruUYYLX6awow@mail.gmail.com>
References: <20140604194118.23903.3019.chriscool@tuxfamily.org>
	<20140604194353.23903.89933.chriscool@tuxfamily.org>
	<xmqqfvjjrpq9.fsf@gitster.dls.corp.google.com>
	<CAP8UFD3k98_6Uh+noJgt4xqEooATVMAEf58FFkuy6rHBnP10zw@mail.gmail.com>
	<CAP8UFD2u-DReCv2ZXhAzH_UMW5P--+a=AKS-N88xE6zmdWBLqQ@mail.gmail.com>
	<CAP8UFD344NFECqtO-uK-2wHA7XEko3XMJWuhW9+KGBdaiqGq+w@mail.gmail.com>
	<CAPc5daWBycdmKBZXGhhy4_649p_JFfGf7RQbqa08XA1hL9mFTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 29 08:34:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X18hE-0001JZ-UV
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jun 2014 08:34:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752208AbaF2Geh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2014 02:34:37 -0400
Received: from mail-vc0-f182.google.com ([209.85.220.182]:43746 "EHLO
	mail-vc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752127AbaF2Geg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2014 02:34:36 -0400
Received: by mail-vc0-f182.google.com with SMTP id il7so6498665vcb.27
        for <git@vger.kernel.org>; Sat, 28 Jun 2014 23:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=OWTehfHO+ZTT7P5CYWzb9GBU+v40OEKHpicjJRNWz/E=;
        b=SKAvG3p0IZSq/uydB4w+9+rcav5Ri5eW+duDETHvriS+NZskDBj5wWP3OfKkUTl7AV
         Myto1W7uHuIzoKMK3C3ZqASGvuaXIyrL6Q85LiLQ1s2Mz8ur5aStdYaWv04qdnCWpmS0
         keqheknksWshZBWHwYfOyaFYzdqwtW2pry6tR2e0KeRmx7dleCweaXpf55Fc89Nw5HCU
         DBgkfhyTUsSST/l2DhqL85CnJwy3ooZJIydTL1Z77rj2YVe2gcUiAFhyHB2rqFYEI6AP
         8Rz2CV8c1imTFg2jF/nJyHNeLCZme7s+KOPVh2VjDSgEbY6rX4RnVnMRPiMaP+2+4CzI
         gIpA==
X-Received: by 10.58.160.10 with SMTP id xg10mr31193749veb.0.1404023675471;
 Sat, 28 Jun 2014 23:34:35 -0700 (PDT)
Received: by 10.58.76.137 with HTTP; Sat, 28 Jun 2014 23:34:35 -0700 (PDT)
In-Reply-To: <CAPc5daWBycdmKBZXGhhy4_649p_JFfGf7RQbqa08XA1hL9mFTg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252631>

On Sun, Jun 8, 2014 at 10:18 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> On Sat, Jun 7, 2014 at 11:49 PM, Christian Couder
> <christian.couder@gmail.com> wrote:
>>
>> On Fri, Jun 6, 2014 at 5:44 PM, Christian Couder
>> <christian.couder@gmail.com> wrote:
>> >
>> >         /* find existing parents */
>> >         strbuf_addstr(&buf, commit->buffer);
>>
>> Unfortunately, it looks like the above will not work if the commit->buffer
>> contains an embedded NUL. I wonder if it is a real problem or not.
>
> Yes, it is a real problem (there was another thread on this regarding the
> code path that verifies GPG signature on the commit itself), which
> incidentally reminds us to another thing to think about in your patch as
> well. I *think* you shoud drop the GPG signature on the commit itself, and
> you also should drop the merge-tag of a parent you are not going to keep,
> but should keep the merge-tag of a parent you are keeping.

In the v5 of the patch series, I now drop the GPG signature on the commit
itself.

Now, after having read the recent thread about "git verify-commit", I understand
that you also want me to drop the signature of a tag that was merged, because
such signatures are added to the commit message.

But I wonder how far should we go in this path. For example merge commits
have a title like "Merge branch 'dev'" or "Merge tag 'stuff'", but
this does not make
sense any more if the replacement commit drops the parent corresponding to
'dev' or 'stuff'. And I don't think we should change the commit title.

Thanks,
Christian.
