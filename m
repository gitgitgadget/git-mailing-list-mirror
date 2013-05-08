From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 02/11] tests: at-combinations: check ref names directly
Date: Wed, 8 May 2013 01:03:42 -0500
Message-ID: <CAMP44s1fjB_d9enPYdGX1Ycez2PYjG0iss9-PUsb+A+E5hMvEw@mail.gmail.com>
References: <1367963711-8722-1-git-send-email-felipe.contreras@gmail.com>
	<1367963711-8722-3-git-send-email-felipe.contreras@gmail.com>
	<7vfvxyggmb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 08 08:03:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZxTn-0008SN-Pq
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 08:03:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359Ab3EHGDo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 02:03:44 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:63883 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881Ab3EHGDo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 May 2013 02:03:44 -0400
Received: by mail-la0-f41.google.com with SMTP id fn20so1391801lab.0
        for <git@vger.kernel.org>; Tue, 07 May 2013 23:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=Gxf5QxEe1YMNapi1GHIVZPSx8xQWXi9jvbWjQl0Y/CM=;
        b=PjlSR/8sBQefX6ycGeDPAOGg7pZFb2pmCklAPke3uVcPW0fzC79kVWu/vZrjoIRnS4
         hvIDOE/DRBV7da+dBq11bz9EHk6iSeWCoYHzYCcFb93W2abE7FXBEUT9zH2TmYL0KpIe
         nGxMS/1cVZG09THT9kvN23Fp3kGmZjnSfpjY3BKWDN2vtCtkfmbHSh8M8wro9agcqC5g
         XJOKSofpOxAlquV3KzMOTjVRWrpmj2rEWfsi7ty/Cd1saTUVTXBZwQ6CgxtFFJ+Y3WSY
         +5uIAYdEN2zvu3Ehmq/wxA2s4QUP+odiuBgMzOu5Ze9ecJHP815hObvnGv4ECwJjJCJp
         cRIQ==
X-Received: by 10.112.1.166 with SMTP id 6mr2389981lbn.135.1367993022361; Tue,
 07 May 2013 23:03:42 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Tue, 7 May 2013 23:03:42 -0700 (PDT)
In-Reply-To: <7vfvxyggmb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223643>

On Wed, May 8, 2013 at 12:55 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Some committishes might point to the same commit, but through a
>> different ref, that's why it's better to check directly for the ref,
>> rather than the commit message.
>>
>> We can do that by calling rev-parse --symbolic-full-name, and to
>> differentiate the old from the new behavior we add an extra argument to
>> the check() helper.
>>
>> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>
> It is signed-off by Ram first but who is the author?  You, or him?

I am, but he sent the patch first.

>>  t/t1508-at-combinations.sh | 27 ++++++++++++++++-----------
>>  1 file changed, 16 insertions(+), 11 deletions(-)
>>
>> diff --git a/t/t1508-at-combinations.sh b/t/t1508-at-combinations.sh
>> index 46e3f16..bd2d2fe 100755
>> --- a/t/t1508-at-combinations.sh
>> +++ b/t/t1508-at-combinations.sh
>> @@ -4,9 +4,14 @@ test_description='test various @{X} syntax combinations together'
>>  . ./test-lib.sh
>>
>>  check() {
>> -test_expect_${3:-success} "$1 = $2" "
>> -     echo '$2' >expect &&
>> -     git log -1 --format=%s '$1' >actual &&
>> +test_expect_${4:-success} "$1 = $3" "
>> +     if [ '$2' == 'commit' ]; then
>> +             echo '$3' >expect &&
>> +             git log -1 --format=%s '$1' >actual
>> +     else
>> +             echo '$3' >expect &&
>> +             git rev-parse --symbolic-full-name '$1' >actual
>> +     fi &&
>
> Move the echo outside of if, and match the overall style.

Right.

-- 
Felipe Contreras
