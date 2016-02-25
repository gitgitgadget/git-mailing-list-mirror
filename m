From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: Rebase performance
Date: Wed, 24 Feb 2016 16:15:53 -0800
Message-ID: <CA+P7+xpC+gZijkcxcp8uFCmYjQf7-0xbBf7FWSsFnMXB1b7G+Q@mail.gmail.com>
References: <CAP8UFD0p1kvk2B0kkc-M9dm+H-Bmam=OrE99VwQx=KCETFEjcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 01:16:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYjbV-0007pO-6h
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 01:16:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758486AbcBYAQQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 19:16:16 -0500
Received: from mail-io0-f176.google.com ([209.85.223.176]:34255 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757530AbcBYAQN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 19:16:13 -0500
Received: by mail-io0-f176.google.com with SMTP id 9so65936822iom.1
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 16:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=b3iv90MgdtDVegMisbMRTSPn0gzRkCKKzPwjHu0A5xg=;
        b=YFWd0/ACm5BJBHWxvXjU/LuJfqZ1E9zrrlx5zqzPzQoT969gVJGSVz2bpUp/97bgEZ
         RbLuHpAxX5VussIBXQwc2ZlRtOSPnsMIsvitUGH7kvx9GAB8WyMqPfzHty9sYOIttCXZ
         oR6c4AU1TdcD6/T1oTDzOFRRBr4ODa0lO7/6fwpI6TeguNnT7fSiZyzv0j68QDFpvc5f
         f8APUXtT6R2giKetVMqlqLaXiwlC4nh/2U4tW/k54z28OpkGzxDVPMDJbucv1RRs8dpO
         W3i+PmSKBY8/OInF85mUXB3cMYk/qZ2NINlhjYIHaour8iZT5N73JUe2l5VfXF6rqhLY
         mXkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=b3iv90MgdtDVegMisbMRTSPn0gzRkCKKzPwjHu0A5xg=;
        b=OVMF3FxUQo0vl60H1nW1rC13LYUQt4rmFDabGvPWqP+ztzXfeqoNPGUDpfzs2EpDKs
         mrx1KCqEnwMERLC2QYzrWILRIBh7merOB6T9uZLPl93K5hy0mA0zhrC/VxbdRZ5GMANN
         NNw5t1TQctCOXzJOcnxQqDDMth2fAu+TfIO/Wv4iABzrIoBFBPg5lD5myx8sa1Uj0t+T
         exKLpSmIB+5zfFith1NYzuIv5OeZSNgv/gdCDT61EBOVds/uRUI6DCEmOnkXU+BYGIQA
         KlLj+W76Ej4GuZkPvovbhZQym9w/rxHo0FVSxOX+i6VmMBpJRXGyE5jdi6FnhtVOpQJ0
         E9hg==
X-Gm-Message-State: AG10YOR5S841XPfPrH1/fnFKd0waDmZe9UpGi4swJhsCIAC9MZQ9E9pqumKeQfaVSafNALTtIbBZiedp+v5ILA==
X-Received: by 10.107.170.79 with SMTP id t76mr358766ioe.71.1456359372983;
 Wed, 24 Feb 2016 16:16:12 -0800 (PST)
Received: by 10.107.20.76 with HTTP; Wed, 24 Feb 2016 16:15:53 -0800 (PST)
In-Reply-To: <CAP8UFD0p1kvk2B0kkc-M9dm+H-Bmam=OrE99VwQx=KCETFEjcw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287290>

On Wed, Feb 24, 2016 at 2:09 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> Hi,
> Another possibility would be to libify the "git apply" functionality
> and then to use the libified "git apply" in run_apply() instead of
> launching a separate "git apply" process. One benefit from this is
> that we could probably get rid of the read_cache_from() call at the
> end of run_apply() and this would likely further speed up things. Also
> avoiding to launch separate processes might be a win especially on
> Windows.
>

This is the route I would go, since the addition of a taskset option
seems pretty difficult to get correct, and may not be portable. This
above solution likely improves more in general, and is more portable.
Not exactly sure how easy it would be to "libify" the required bits of
apply, however.. it may be that this is already available as well but
we just didn't go that route during the port of git-am into C code.

Regards,
Jake
