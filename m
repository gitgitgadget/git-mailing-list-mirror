From: =?UTF-8?Q?Jens_Lindstr=C3=B6m?= <jl@opera.com>
Subject: Re: [PATCH] clone: Skip pack-*.keep files when cloning locally
Date: Wed, 3 Jul 2013 20:31:24 +0200
Message-ID: <CAEef6WyMVEM0Rj5Fj7BWeP72au9ynnP20Go3FhSzJKSkdcb-aA@mail.gmail.com>
References: <1372430538-19216-1-git-send-email-jl@opera.com>
	<7vvc4ynkrx.fsf@alter.siamese.dyndns.org>
	<CAEef6WzAg8-QMH1c4v=1tm7TPgfeE3W3K+ue-eYgRL3pyYo6Vg@mail.gmail.com>
	<7vip0ui757.fsf@alter.siamese.dyndns.org>
	<CAEef6WxnRbPVFgZP4asQrvYGVTTbGzeQCwPJrwj4a-6k9vFcbQ@mail.gmail.com>
	<7vzju3ftbo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, johan@herland.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 03 20:31:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuRpz-0003TZ-87
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 20:31:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756095Ab3GCSb0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Jul 2013 14:31:26 -0400
Received: from mail-qc0-f175.google.com ([209.85.216.175]:64180 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755982Ab3GCSbZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Jul 2013 14:31:25 -0400
Received: by mail-qc0-f175.google.com with SMTP id k14so298689qcv.34
        for <git@vger.kernel.org>; Wed, 03 Jul 2013 11:31:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding:x-gm-message-state;
        bh=XUxvMXa4tlG/A2sys6S5EivYt6R3NohF0uqTD0lMF6w=;
        b=EPQCGmeGIbRe4WuFj7uBQcYEpUOKX7Yub1e7tx9kJsnRF1KiZIA5PROJJJWQVcMdIs
         yftpeGpy6L6O6Oj4foIeAqzvgOcFc2Z2V6PkmrBghf6k2KI6jr6furbk3ZgABcioIc8A
         t6MXLnRKpZVSYAuqy7O90YnVFevXmdKFUrafYC9C2nLbGiR21CRctTKUHNNXoCn5f3sJ
         PJIydcyTNlP1GP8Ha2yk0BmeHaDwkd8aE1RTbs7d3XO6AymZKaWGJvD9laPNnKYA+arH
         WRc5ue3U+rJGGghDJrHsDiQdiVImjpvaxo41PE8QsUWrszKn688JG/bkWKLtU+b1bB0A
         OtUg==
X-Received: by 10.224.180.133 with SMTP id bu5mr5527514qab.50.1372876285129;
 Wed, 03 Jul 2013 11:31:25 -0700 (PDT)
Received: by 10.49.1.106 with HTTP; Wed, 3 Jul 2013 11:31:24 -0700 (PDT)
In-Reply-To: <7vzju3ftbo.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQn1SKlBHRrtO2cEP2fWhCDHKO+A9ptrVXQJUUZ5X8ClC7xghcVcg14NvZWV7K5Al7l9n9kc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229506>

On Wed, Jul 3, 2013 at 7:26 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Jens Lindstr=C3=B6m <jl@opera.com> writes:
>
>> Not always.  The Linux kernel can at least be configured not to allo=
w
>> it.  It seems this is enabled by default in at least Debian.
>
> You learn a new thing every day, I guess.  I am on Debian, I do not
> think I did any customization in that area, and I can hardlink just
> fine.

To configure it, write "1" (on) or "0" (off) to
/proc/sys/fs/protected_{hard,sym}links.  I can't remember (or imagine)
that I enabled it on any of my systems.  One of my systems is Debian
Squeeze with a 2.6.32 kernel, and it doesn't have those files, so I
guess it might have been added in some more recent kernel version.

>> This restriction had me a bit confused when I was testing variations
>> here; I expected all "access denied" failures to be because of .keep
>> files, but in fact creating hardlinks to other files (.idx and .pack=
)
>> failed too, even though they were readable.
>
> Is it possible that you are tripping cross-device link?  The reason
> why we have "attempt to hardlink but fall back to copy" is exactly
> because it is fairly common that people try local-cheap clone without
> realizing the source and the destination may be on separate filesyste=
ms.

No, I was certainly cloning within a single file system, and I can
confirm that a plain "ln src dest" command fails unless the user can
both read and write the source file.  So if the cloning user has
read-only access to the repository, copying will work and linking
won't (depending on the kernel,) in which case it of course is
excellent that git falls back to copying instead of linking.
