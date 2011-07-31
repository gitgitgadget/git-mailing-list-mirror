From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v8 4/7] bisect: introduce --no-checkout,
 --update-ref=<ref> support into porcelain.
Date: Sun, 31 Jul 2011 21:21:51 +0200
Message-ID: <CAP8UFD2vCGnejSj=Nwkb+kGCpwUaggh5j2V6zBu0iWqNZwvS3Q@mail.gmail.com>
References: <1312113321-28760-1-git-send-email-jon.seymour@gmail.com>
	<1312113321-28760-5-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, chriscool@tuxfamily.org, gitster@pobox.com,
	j6t@kdbg.org, jnareb@gmail.com
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 31 21:21:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnbaH-0001uT-8q
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jul 2011 21:21:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904Ab1GaTVx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Jul 2011 15:21:53 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:46588 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751370Ab1GaTVw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Jul 2011 15:21:52 -0400
Received: by gwaa12 with SMTP id a12so1117285gwa.19
        for <git@vger.kernel.org>; Sun, 31 Jul 2011 12:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=t/3n7Qp0bRkGJAPqEqW4L/nc/n7inpi8Ivv0AgHw5XM=;
        b=TXb+XsURk/q4e4PIy1gh1tAqSoJC6IRjB6sXUbHt6u5ujKQeWEx2HYVhtrg0wHl/h3
         8ihKYcBRjdFr/edNIytMCaK0Wt7RWP93GCJC+LrHw6bs7YFsuUGa3SnZp8g7+6d9x246
         NNplDO3T4cEqew5EU5qkCoxsKpT6fl70ZRo2g=
Received: by 10.236.184.197 with SMTP id s45mr2467888yhm.157.1312140111694;
 Sun, 31 Jul 2011 12:21:51 -0700 (PDT)
Received: by 10.147.181.2 with HTTP; Sun, 31 Jul 2011 12:21:51 -0700 (PDT)
In-Reply-To: <1312113321-28760-5-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178269>

On Sun, Jul 31, 2011 at 1:55 PM, Jon Seymour <jon.seymour@gmail.com> wr=
ote:
>
> + =A0 =A0 =A0 if test -n "$BISECT_UPDATE_REF"; then
> + =A0 =A0 =A0 =A0 =A0 eval=3D"$eval echo '$BISECT_UPDATE_REF' > '$GIT=
_DIR/BISECT_UPDATE_REF';"
> + =A0 =A0 =A0 fi

I don't like this very much. In fact I realize that the eval thing we
use is buggy because the result of 'eval "eval"' will be the result of
the last command in "eval", so we won't detect if one of the first
command in "eval" failed.

So perhaps something like:

    eval "$eval" &&
+  ( test -n "$BISECT_UPDATE_REF" || echo "$BISECT_UPDATE_REF" >
"$GIT_DIR/BISECT_UPDATE_REF" ) &&
    echo "git bisect start$orig_args" >>"$GIT_DIR/BISECT_LOG" || exit

Thanks,
Christian.
