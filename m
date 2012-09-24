From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 6/9] pretty: two phase conversion for non utf-8 commits
Date: Mon, 24 Sep 2012 08:21:01 +0700
Message-ID: <CACsJy8DoBwLccaGGFqDfW2F3isZ74S2FLGXW3bDOcr2X-hQc3w@mail.gmail.com>
References: <1348391433-11300-7-git-send-email-pclouds@gmail.com> <189332269.134567.1348408475044.JavaMail.root@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Sep 24 03:21:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFxMl-00054u-Ic
	for gcvg-git-2@plane.gmane.org; Mon, 24 Sep 2012 03:21:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754739Ab2IXBVc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Sep 2012 21:21:32 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:44643 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754724Ab2IXBVc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Sep 2012 21:21:32 -0400
Received: by ieak13 with SMTP id k13so9670755iea.19
        for <git@vger.kernel.org>; Sun, 23 Sep 2012 18:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=r+cGy9u+b7Vn2ADOZgbhLj6D+ZdB6gze5/x27R0fSCc=;
        b=DnmPoKWEyNhunM0/+slJpH6LesuBYu/fd05e8ACk0GOTfD3EynAiFQBXqKm6/KALTE
         obICH558+Rc15aS1eckkuiPLCf0df5TNgxcks+W4IuSGFZv7cihT29ETxhz3KU1FjoaQ
         T3f/EprpPiF6wcRBMtyX8LsCJxmSA4tAGqiI1oT3V0B5ZAJ1PBD3/9LglHxhu6O06J8a
         IqIYUbGkqbz0JI0Ou+B6rs/71O1JYLrflSR5tyZL4r7xqhOYRIhv/OIja0lK1ei2WNTV
         KeVIK2i020XvNyZ+B4/h5MiV4lQWp+bvuUE+FvrWJaciWzstRaQSrdgksBjD7va0EwN5
         oKXw==
Received: by 10.42.129.83 with SMTP id p19mr8649232ics.9.1348449691392; Sun,
 23 Sep 2012 18:21:31 -0700 (PDT)
Received: by 10.64.29.199 with HTTP; Sun, 23 Sep 2012 18:21:01 -0700 (PDT)
In-Reply-To: <189332269.134567.1348408475044.JavaMail.root@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206251>

On Sun, Sep 23, 2012 at 8:54 PM, Robin Rosenberg
<robin.rosenberg@dewire.com> wrote:
>> This of course only works with encodings that are compatible with
>> Unicode.
> Such as? Unicode was defined to encompass all knows encodings.

Just a precaution because I have never read Unicode standard (and it
keeps getting updated, hence "incomplete")

>
>> -static size_t format_commit_one(struct strbuf *sb, const char
>> *placeholder,
>> +static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
>> +                             const char *placeholder,
>>                               void *context)
>>  {
>>       struct format_commit_context *c =3D context;
>
> Which parameter does the comment apply to? I believe most conventions
> nowadays include parameter documentation in the comment preceding
> the function header.

Yeah. I should have followed that.

>> b/t/t6006/commit-msg.iso8859-1
>> new file mode 100644
>> index 0000000..f8fe808
>> --- /dev/null
>> +++ b/t/t6006/commit-msg.iso8859-1
>> @@ -0,0 +1,5 @@
>> +Test printing of complex bodies
>> +
>> +This commit message is much longer than the others,
>> +and it will be encoded in iso8859-1. We should therefore
>> +include an iso8859 character: =EF=BF=BDbueno!
>
> "8859-1" to be exact. Only three 8859 encoding has the
> character.

Yep. But i'll probably need a closer look at t6006. It seems there's a
few "upside down exclamation" (not sure what it's called) in UTF-8 in
that test. I'll fix the text too.
--=20
Duy
