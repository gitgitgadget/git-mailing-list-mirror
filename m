From: Tarmigan <tarmigan+git@gmail.com>
Subject: Re: [RFH] cleaning up "add across symlinks"
Date: Thu, 17 Apr 2008 09:31:52 -0700
Message-ID: <905315640804170931v23df8633xf51276a5858eabc7@mail.gmail.com>
References: <7vd4oppllw.fsf@gitster.siamese.dyndns.org>
	 <905315640804161426l442c2812k3c36c1bafe484157@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 17 19:01:52 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmX2R-00065k-R4
	for gcvg-git-2@gmane.org; Thu, 17 Apr 2008 18:32:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbYDQQb5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2008 12:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751719AbYDQQb5
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 12:31:57 -0400
Received: from fk-out-0910.google.com ([209.85.128.185]:43999 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932170AbYDQQb4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 12:31:56 -0400
Received: by fk-out-0910.google.com with SMTP id 19so173806fkr.5
        for <git@vger.kernel.org>; Thu, 17 Apr 2008 09:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=DG5qXVod+Mxv33Ztz5eDmKQsC2FJgrHp8KK/SWzZ0ro=;
        b=aMdwysmQV3d/03XnPU8+6LeImbW+j9KnCie07E6FROYBXR/v7Xm+m2Hkfbh0/tDcODeq9x5auBHsi1TfpfLWV1bUDC2HHQtRAB4QfNCOUQBIFNk8qO1BcCpst2R9WQvyEGOFowAohzqTNwad515AnCC2xrC5r9w0JdScVnGjyIo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=KBE3sdwfsuUR6CoAX02atB42NKnwQd7jP/wXtjD8upi6F/AMeUPzfi/VXNDJZz0IHYTsJDIUS6KkpDD4iTUtdDKXGu0bm/NH/SKsBJGnWoay8KFFwVtznfnA4y4qILLBf2mPR7t6q3hZP/SyXqaWrMN0Jj/0XzAmMav7uCDS8R4=
Received: by 10.82.127.14 with SMTP id z14mr2569110buc.86.1208449912910;
        Thu, 17 Apr 2008 09:31:52 -0700 (PDT)
Received: by 10.82.175.8 with HTTP; Thu, 17 Apr 2008 09:31:52 -0700 (PDT)
In-Reply-To: <905315640804161426l442c2812k3c36c1bafe484157@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: e1008be4ae1ea06b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79802>

On Wed, Apr 16, 2008 at 2:26 PM, Tarmigan <tarmigan+git@gmail.com> wrote:
> On Wed, Apr 16, 2008 at 1:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
>  > If you have this structure in your work tree:
>  >
>  >         lrwxrwxrwx a -> c
>  >         drwxrwxrwx c
>  >         -rw-rw-rw- c/b
>  >
>  >  and let million monkeys give random paths to "git-update-index --add" or
>  >  "git add", you should end up with the index with two entries, a symlink
>  >  "a" and file "c/b".
>  >
>  >  Not so.  If an unfortunate monkey says "git add a/b", we happily add it to
>  >  the index, because we notice lstat("a/b") succeeds and assume that there
>  >  is such a path.  There isn't, as far as git is concerned, because we track
>  >  symbolic links.
>
>  Thanks Junio, I'll try to do some testing with it later.

I tested with all the cases I could think of and it works for me.

>  That's almost the case I used.  The exact test to add to these,
>  without the '*' after a/, would be something like this (warning: cut
>  and paste):
>
>  +test_expect_success 'add confusion (4)' '
>  +
>  +       test_must_fail git add "a/" &&

Currently, this will succeed, so if you decide to add this case, the
test_must_fail should go.

Thanks,
Tarmigan
