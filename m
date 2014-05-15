From: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH/RFC] Gitweb: Convert UTF-8 encoded file names
Date: Thu, 15 May 2014 14:32:33 +0200
Message-ID: <CANQwDwes_G-aNMo=UfGJk+Dk2YaokQsG_VLaVQyPevEDchWTVA@mail.gmail.com>
References: <20140514184145.GA25699@localhost.localdomain> <xmqqd2fghvlf.fsf@gitster.dls.corp.google.com>
 <CANQwDwdh1qQkYi9sB=22wbNnb+g5qv5prCzj2aWhHBbTZhVhdg@mail.gmail.com> <20140515050820.GA30785@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Michael Wagner <accounts@mwagner.org>
X-From: git-owner@vger.kernel.org Thu May 15 14:33:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wkuqc-0007TP-B3
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 14:33:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752937AbaEOMdO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 May 2014 08:33:14 -0400
Received: from mail-oa0-f41.google.com ([209.85.219.41]:55449 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751420AbaEOMdN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 May 2014 08:33:13 -0400
Received: by mail-oa0-f41.google.com with SMTP id m1so1163480oag.28
        for <git@vger.kernel.org>; Thu, 15 May 2014 05:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=W0iJNnJgdsCnyvmqU6+JmZJ8pFu0CxM0nJxSDcicdvU=;
        b=bI4mRms0wZNrpOIm8yinlFnwx0v3qTj498/0Pr+qfw6ixQNKnMd1WjnHL4zJJruKee
         wh3RChVtKijEjDfm5JmrwVr4ursGILEzT6wr3FcuBsGIYVRNESFGSBy+qgibpA4MvzEL
         pjCK4QzRXo7osYSufjPU9AD+Hlldw2r7N81sLQoygIFf1tqP20nNf727jEusNtT5HszK
         zowBray1MVakS/6+qUMPxwq5GQNpfL4fdYrhJpbOX763He3HmsbEYKkh2vFkGxYHsIg9
         9RYniYaVUsTr7ajTDuOTm1umLRzI8II0ya4CdcLWYaSc9me7jOlnWoNKyXkb1nLVR1EH
         aIeQ==
X-Received: by 10.60.37.99 with SMTP id x3mr9698594oej.65.1400157193226; Thu,
 15 May 2014 05:33:13 -0700 (PDT)
Received: by 10.76.132.4 with HTTP; Thu, 15 May 2014 05:32:33 -0700 (PDT)
In-Reply-To: <20140515050820.GA30785@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249079>

On Thu, May 15, 2014 at 7:08 AM, Michael Wagner <accounts@mwagner.org> =
wrote:
> On Thu, May 15, 2014 at 12:25:45AM +0200, Jakub Nar=C4=99bski wrote:
>> On Wed, May 14, 2014 at 11:57 PM, Junio C Hamano <gitster@pobox.com>=
 wrote:
>>> Michael Wagner <accounts@mwagner.org> writes:
>>>
>>>> Perl has an internal encoding used to store text strings. Currentl=
y, trying to
>>>> view files with UTF-8 encoded names results in an error (either "4=
04 - Cannot
>>>> find file" [blob_plain] or "XML Parsing Error" [blob]). Converting=
 these UTF-8
>>>> encoded file names into Perl's internal format resolves these erro=
rs.
>>
>> Could you give us an example?  What is important is whether filename
>> is passed via path_info or via query string.
>>
>
> There is a file named "G=C3=BCtekriterien.txt" in my repository. Tryi=
ng to
> view this file as "blob_plain" produces an 404 error (displaying the
> file name with an additional print statement):
>
> $ REQUEST_METHOD=3DGET QUERY_STRING=3D'p=3Dnotes.git;a=3Dblob_plain;f=
=3Dwork/G%C3%83%C2%BCtekriterien.txt;hb=3DHEAD' ./gitweb.cgi
>
> work/G=C3=83=C2=BCtekriterien.txt
> Status: 404 Not Found

You have URI encoding of "=C3=BC" wrong! "=C3=BC" encodes as %C3%BC, no=
t
as %C3%83%C2%BC (4 bytes?)

  http://www.url-encode-decode.com/

You tested with wrong input.

BTW. there probably should be test for UTF-8 encoding, similar to
the one for XSS in t9502-gitweb-standalone-parse-output
--=20
Jakub Nar=C4=99bski
