From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH 2/2] grep: use slash for path delimiter, not colon
Date: Mon, 26 Aug 2013 17:03:04 -0400
Message-ID: <CABURp0pPzRH5JdPEooyZw0iccD891E1i_CbTqDfVJnx+drfQEw@mail.gmail.com>
References: <20130826195331.GA21051@sigill.intra.peff.net> <20130826195616.GB21074@sigill.intra.peff.net>
 <521BB6DA.5050807@kdbg.org> <20130826205215.GB23598@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Sixt <j6t@kdbg.org>, Phil Hord <hordp@cisco.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 26 23:03:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VE3wg-0005yt-3t
	for gcvg-git-2@plane.gmane.org; Mon, 26 Aug 2013 23:03:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752525Ab3HZVD0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 17:03:26 -0400
Received: from mail-vb0-f47.google.com ([209.85.212.47]:50570 "EHLO
	mail-vb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752253Ab3HZVDZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 17:03:25 -0400
Received: by mail-vb0-f47.google.com with SMTP id h10so2456588vbh.34
        for <git@vger.kernel.org>; Mon, 26 Aug 2013 14:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Wtdvxyn+2Z+3qJxu/7DvgNvp4Kq93AAwsAP+WR4EFdg=;
        b=z6O0q2xT+XPLWRN6hD1VIaofeTOkxkfdhei6tJuhgMVQKPhkiYFzcH/lW5AwyYmy6c
         vYeCpSJ4q1VvEWL/s9Vew5CFItf0SmnJD8D8BThIk05ExxWJfKuVD+10xYZuTlp0OXOQ
         7IFQty92j06/FSZRWgcclt4S3kLAk3DrOKxCkqoQDgVTvAojKLRLc90Piov23QRXsB1Q
         KsV2I+YtEzvcEZFZFdM3Qs7Nn28qi7Fq7MQhJ7nsgyxrXIbqkOpjuLdCH/stQXjDtPix
         ffbhH8T5KpM6/hjYSXrj4H9p226mXymuDPBg5GvIIdc61bd9x2hkdwQMhQ4i33srmGyG
         wPHQ==
X-Received: by 10.221.64.17 with SMTP id xg17mr16513111vcb.5.1377551004635;
 Mon, 26 Aug 2013 14:03:24 -0700 (PDT)
Received: by 10.58.49.197 with HTTP; Mon, 26 Aug 2013 14:03:04 -0700 (PDT)
In-Reply-To: <20130826205215.GB23598@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233029>

On Mon, Aug 26, 2013 at 4:52 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Aug 26, 2013 at 10:13:14PM +0200, Johannes Sixt wrote:
>
>> Am 26.08.2013 21:56, schrieb Jeff King:
>> > Also, prevent the delimiter being added twice, as happens now in these
>> > examples:
>> >
>> >   git grep -l foo HEAD:
>> >   HEAD::some/path/to/foo.txt
>> >        ^
>>
>> Which one of these two does it print then?
>>
>>     HEAD:/some/path/to/foo.txt
>>     HEAD:some/path/to/foo.txt
>
> It should (and does) print the latter.
>
> But I do note that our pathspec handling for subdirectories seems buggy.
> If you do:
>
>   $ cd Documentation
>   $ git grep -l foo | head -1
>   RelNotes/1.5.1.5.txt
>
> that's fine; we limit to the current directory. But then if you do:
>
>   $ git grep -l foo HEAD | head -1
>   HEAD:RelNotes/1.5.1.5.txt
>
> we still limit to the current directory, but the output does not note
> this (it should be "HEAD:./RelNotes/1.5.1.5.txt"). I think this bug is
> orthogonal to Phil's patch, though.

Maybe not.  My path completes the assumption that the L:R value
returned by grep is an object ref; but Junio still thought it wasn't.
I think this is another case where his view was correct.

There's more bad news on this front.

    $ cd Documentation
    $ git grep -l foo HEAD .. | head -1
    HEAD:../.gitignore

That's not a valid ref, either (though maybe it could be).

Phil
