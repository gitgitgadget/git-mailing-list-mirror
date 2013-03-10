From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH v2 3/6] match_basename: use strncmp instead of strcmp
Date: Sun, 10 Mar 2013 13:11:06 +0100
Message-ID: <CALWbr2w+HdsOJAXF3974=vx+BtxgCC=bKHetE=ptXTwv7_L0pg@mail.gmail.com>
References: <1362802190-7331-1-git-send-email-pclouds@gmail.com>
	<1362896070-17456-1-git-send-email-pclouds@gmail.com>
	<1362896070-17456-4-git-send-email-pclouds@gmail.com>
	<7vy5dvd7yq.fsf@alter.siamese.dyndns.org>
	<CACsJy8A_4SqLu5L6P0PJ78Lwy12fjL7T2p-KbVEVLJmKNqhyRw@mail.gmail.com>
	<CALWbr2wEJy0p2hcFK_rLtA98koeacE8rS2T=9P130GUFjWKc0Q@mail.gmail.com>
	<CALWbr2x6V6TB9g_nQCgG2r9L__a2wxG28Qi5KTXChHxj5JSQ8w@mail.gmail.com>
	<CACsJy8A4+2t=PMJ+iSFFz-fafkAHYGvm6G4M-qpiO9674sanEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 10 13:11:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEf6F-00056K-EC
	for gcvg-git-2@plane.gmane.org; Sun, 10 Mar 2013 13:11:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752281Ab3CJMLJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Mar 2013 08:11:09 -0400
Received: from mail-qc0-f181.google.com ([209.85.216.181]:51376 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752139Ab3CJMLI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Mar 2013 08:11:08 -0400
Received: by mail-qc0-f181.google.com with SMTP id a22so1123718qcs.40
        for <git@vger.kernel.org>; Sun, 10 Mar 2013 05:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=Lko+TkNSv3TzwqBjC0DXflzeDrJc74aIxraD2O2ZJNQ=;
        b=V5vqPjRFfyJHii5S89CIquDLJIOMecnebWzoHmxSg2AweogYU/Kqwaly27Cpkk+4iX
         99QCJqL3xBFvN3IJQFyX7P/Z6FJPfzaPxJFYi1EXXy6N/5bKwwSpQ4dm/5O/q2Y5Y8+w
         HHzymxoAHyt7uIIRYvidZ2916RfhvS0WgTxSCGjF4quAV+gb+6D8k72UGsfVICMeD5n2
         QLUBKgdTNiftF+6yduC9qg6Q9bHq2THieM4gUcgzM+pUQtwDDClam7/BhG0QKHV7Yx2m
         Y8bnl7DUgHoziarLsB+J85XS2AeOLd0UAF4nasfuY6PluOBUz82rY4XP7w0/Ir7MqbBG
         OiJA==
X-Received: by 10.224.52.68 with SMTP id h4mr12367942qag.17.1362917467010;
 Sun, 10 Mar 2013 05:11:07 -0700 (PDT)
Received: by 10.49.70.163 with HTTP; Sun, 10 Mar 2013 05:11:06 -0700 (PDT)
In-Reply-To: <CACsJy8A4+2t=PMJ+iSFFz-fafkAHYGvm6G4M-qpiO9674sanEQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217804>

>> By the way, if we know the length of the string, we could use memcmp.
>> This one is allowed to compare 4-bytes at a time (he doesn't care
>> about end of string). This is true because the value of the length
>> parameter is no longer "at most".
>
> We still need to worry about access violation after NUL when two
> strings have different lengths. That could be avoided in this
> particular case, but I think it's too fragile.

Why would we need to compare if the strings don't have the same length
? We already do that in combine-diff.c:append_lost().
