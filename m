From: Tarmigan <tarmigan+git@gmail.com>
Subject: Re: [RFH] cleaning up "add across symlinks"
Date: Wed, 16 Apr 2008 14:26:41 -0700
Message-ID: <905315640804161426l442c2812k3c36c1bafe484157@mail.gmail.com>
References: <7vd4oppllw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 23:28:44 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmFAF-0000pf-T1
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 23:27:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753584AbYDPV0s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 17:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752362AbYDPV0s
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 17:26:48 -0400
Received: from mu-out-0910.google.com ([209.85.134.190]:30154 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752726AbYDPV0s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 17:26:48 -0400
Received: by mu-out-0910.google.com with SMTP id w8so1788934mue.1
        for <git@vger.kernel.org>; Wed, 16 Apr 2008 14:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=QcwD4pBC67g0q5NvTLuraypBI1Pu45saI2TukGg+4mE=;
        b=lHDnD/0hSLx0eYMqQLGxDDgCv71CzrJSS3VgNhS09Ynd7t/GYL7HVDiwzMm8ZnPeFE5nv9jdE9rcRHy8G1Qn8eEL4Isj9IuHy6dnqyq9NnkcNo9nDQpvYMOkB/G2OLBvYPSitkEPNiRsa2npykdDN/JPbRIGEyyT913e+KDbvAM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=I+PDU2Tj0rk6D2YRFlWHmC59OGKknGYW4XECWbWRrnhelDZ0JKOYcSJ0xVJTQvlgMXLYfLkiT85d63I0qj0ZW83YL0PXj8iz3BblH+PvJkA/KJ3eNX4v9RFYrV27zNRK0nGO0eDd4EUdxaW90jhmUD2CHjqPW0lWPwqwkHx6FAo=
Received: by 10.82.181.7 with SMTP id d7mr779631buf.53.1208381201585;
        Wed, 16 Apr 2008 14:26:41 -0700 (PDT)
Received: by 10.82.175.8 with HTTP; Wed, 16 Apr 2008 14:26:41 -0700 (PDT)
In-Reply-To: <7vd4oppllw.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-Google-Sender-Auth: 9079ffbbae34d009
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79757>

On Wed, Apr 16, 2008 at 1:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
> If you have this structure in your work tree:
>
>         lrwxrwxrwx a -> c
>         drwxrwxrwx c
>         -rw-rw-rw- c/b
>
>  and let million monkeys give random paths to "git-update-index --add" or
>  "git add", you should end up with the index with two entries, a symlink
>  "a" and file "c/b".
>
>  Not so.  If an unfortunate monkey says "git add a/b", we happily add it to
>  the index, because we notice lstat("a/b") succeeds and assume that there
>  is such a path.  There isn't, as far as git is concerned, because we track
>  symbolic links.

Thanks Junio, I'll try to do some testing with it later.

>  +test_expect_success 'add confusion (3)' '
>  +
>  +       test_must_fail git add "a/*" &&
>  +
>  +       git ls-files >actual &&
>  +       test_cmp expect actual
>  +'
>  +
>  +test_done

That's almost the case I used.  The exact test to add to these,
without the '*' after a/, would be something like this (warning: cut
and paste):

+test_expect_success 'add confusion (4)' '
+
+       test_must_fail git add "a/" &&
+
+       git ls-files >actual &&
+       test_cmp expect actual
+'

Thanks,
Tarmigan
