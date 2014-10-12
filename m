From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH RFC] git-am: support any number of signatures
Date: Sun, 12 Oct 2014 11:36:52 +0200
Message-ID: <CAP8UFD1ATE-CtqXJyd7qDw-34RJ3ZQibHo6BSi+42hkaPNzz5w@mail.gmail.com>
References: <xmqqbnq6jm0s.fsf@gitster.dls.corp.google.com>
	<CAP8UFD0kfSBhSwu5Mb46XEHqYCE0SEsZd_3c0Sm4WzEc-NNc7w@mail.gmail.com>
	<CAPc5daUTKU1JepLuyVC1Nk6LG4AZ2TA5SEYLsTSPbPKkauzNyQ@mail.gmail.com>
	<20140928.133623.1635797151132857721.chriscool@tuxfamily.org>
	<7viok7k0c0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <chriscool@tuxfamily.org>,
	"Michael S. Tsirkin" <mst@redhat.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 12 11:36:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XdFaD-000111-MV
	for gcvg-git-2@plane.gmane.org; Sun, 12 Oct 2014 11:36:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752308AbaJLJgy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2014 05:36:54 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:56610 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751681AbaJLJgx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2014 05:36:53 -0400
Received: by mail-ig0-f171.google.com with SMTP id h15so7426247igd.10
        for <git@vger.kernel.org>; Sun, 12 Oct 2014 02:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=FyTOYr9PO4rpwRTbRyfJV6uRKy53bq2tK9IQqO8Qn/o=;
        b=qPrP6gK/yWI4dQfuqQZ6qv29DmgNcAw6j6yo6vjlevzVOkNZ/nY69sCNIqVP1EybwG
         OPe4psU7msDbspU+QZjXVgcIn713UZk2doHkSgEAk0YzpAGDGXF3cYhuLEbr+oYNt3BN
         OajOStpoQAAZyMJppHfSHSCxqx3vmcKABC/CJDi7MFhF+Gr2VZ9KQMiHaMHiTprgcTN6
         2oWKWnXkdvdtjsn31eRzNXaaBwNi87I8PFF4ZvVGKkogHhnWoJ5r2ZCVzPbKf1bB3otg
         UoKdQa04m/h4cx/f+TKeniwb6gDi6iD69gdzd6ZZjaptgc0WOo7hwNscV8zX9WFdIKbL
         gj7g==
X-Received: by 10.51.17.66 with SMTP id gc2mr21791464igd.40.1413106612334;
 Sun, 12 Oct 2014 02:36:52 -0700 (PDT)
Received: by 10.50.250.179 with HTTP; Sun, 12 Oct 2014 02:36:52 -0700 (PDT)
In-Reply-To: <7viok7k0c0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 28, 2014 at 9:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <chriscool@tuxfamily.org> writes:
>
>> From: Junio C Hamano <gitster@pobox.com>
>>
>>> If that is what happens, it is not a workable workaround to set Sob to
>>> addIfDifferent only for this invocation.
>>
>> Setting S-o-b to addIfDifferent for this invocation would not add the
>> S-o-b at the end, because another S-o-b still exists in the input
>> message "seen" when the last S-o-b is processed.
>
> So there is no workaround whatsoever, which is worse X-<.

I think there might be a misunderstanding.

With v16 you can easily choose if you want to have the S-o-b in the
output or not, when there is already one, see:

$ cat test.txt

Signed-off-by: <Michael>

$ cat test.txt | git interpret-trailers --trailer 'Acked-by:
<Michael>' --trailer 'Reviewed-by: <Michael>' --trailer 'Tested-by:
<Michael>' --trailer 'Signed-off-by: <Michael>'

Signed-off-by: <Michael>
Acked-by: <Michael>
Reviewed-by: <Michael>
Tested-by: <Michael>
Signed-off-by: <Michael>

$ cat test.txt | git -c 'trailer.ifexists=addIfDifferent'
interpret-trailers --trailer 'Acked-by: <Michael>' --trailer
'Reviewed-by: <Michael>' --trailer 'Tested-by: <Michael>' --trailer
'Signed-off-by: <Michael>'

Signed-off-by: <Michael>
Acked-by: <Michael>
Reviewed-by: <Michael>
Tested-by: <Michael>

Or:

$ cat test.txt | git -c
'trailer.Signed-off-by.ifexists=addIfDifferent' interpret-trailers
--trailer 'Acked-by: <Michael>' --trailer 'Reviewed-by: <Michael>'
--trailer 'Tested-by: <Michael>' --trailer 'Signed-off-by: <Michael>'

Signed-off-by: <Michael>
Acked-by: <Michael>
Reviewed-by: <Michael>
Tested-by: <Michael>

(There was a small bug in v15 with the last command above.)

>>> Alternatively, if Neighbor-ness is evaluated first before you add A/R/T
>>> in response to this request, then you'd refrain from adding a duplicate
>>> Sob. It wasn't quite clear from your description what your design was,
>>> and your explanation above is not still clear, at least to me.
>>
>> I hope it is clearer now. Maybe I should add something in the doc to
>> better explain how it works.
>
> I doubt that it would help the users materially to document that we
> chose to implement a less useful way when there are multiple ways in
> which a feature can work, though.
>
> Unless I am mis-reading you and you are actually saying that the
> users can emulate the "atomic" variant without much hassle by doing
> X and Y, that is.  If so, it would help readers to document them.

If you would like me to document the 3 above commands in an example, I
am ok to do that.

Thanks,
Christian.
