From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 3/6] match_basename: use strncmp instead of strcmp
Date: Sun, 10 Mar 2013 19:06:34 +0700
Message-ID: <CACsJy8A4+2t=PMJ+iSFFz-fafkAHYGvm6G4M-qpiO9674sanEQ@mail.gmail.com>
References: <1362802190-7331-1-git-send-email-pclouds@gmail.com>
 <1362896070-17456-1-git-send-email-pclouds@gmail.com> <1362896070-17456-4-git-send-email-pclouds@gmail.com>
 <7vy5dvd7yq.fsf@alter.siamese.dyndns.org> <CACsJy8A_4SqLu5L6P0PJ78Lwy12fjL7T2p-KbVEVLJmKNqhyRw@mail.gmail.com>
 <CALWbr2wEJy0p2hcFK_rLtA98koeacE8rS2T=9P130GUFjWKc0Q@mail.gmail.com> <CALWbr2x6V6TB9g_nQCgG2r9L__a2wxG28Qi5KTXChHxj5JSQ8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 10 13:07:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEf2P-0001z9-34
	for gcvg-git-2@plane.gmane.org; Sun, 10 Mar 2013 13:07:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752201Ab3CJMHH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Mar 2013 08:07:07 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:39654 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751987Ab3CJMHG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Mar 2013 08:07:06 -0400
Received: by mail-oa0-f48.google.com with SMTP id j1so3544271oag.7
        for <git@vger.kernel.org>; Sun, 10 Mar 2013 05:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=dQ60m3lkU6KFGbCW3HAdt1sUlCgUrQGLUOyuWUyy3YM=;
        b=U27xOO9Q1AHiaF1cH8z9Aa6f19MUeTYf9SHue3/3Qup82v++6oiidXeDVxKP2Jrk8T
         8mi7oDhsZhURHI6HzCQCDOd3deis/UvVS0wMU1WgaWbJgj2z11RAZ/4T1l8mvblvdVYe
         DGqtOrgLPCcKAi/TnCy1RhwURIpazK9PTkwt6GVMcEMhCGS3OA+tt/UeBJb6xcRv6vYK
         qj1CNq00HOHl/UaMKOQH6qp3ZqRpX/prPXJugIFvHbR+sNXYQwHdW9KNKuaQUlDvQvHD
         6z48wdxG/hD+tMBOSZQ+3zSHUSPV6y3ChwZcM9UMtsIglQ0fhw21rt1VK4rqOfD4cinB
         Tadg==
X-Received: by 10.182.72.5 with SMTP id z5mr6262679obu.24.1362917225017; Sun,
 10 Mar 2013 05:07:05 -0700 (PDT)
Received: by 10.76.27.200 with HTTP; Sun, 10 Mar 2013 05:06:34 -0700 (PDT)
In-Reply-To: <CALWbr2x6V6TB9g_nQCgG2r9L__a2wxG28Qi5KTXChHxj5JSQ8w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217803>

On Sun, Mar 10, 2013 at 6:54 PM, Antoine Pelisse <apelisse@gmail.com> wrote:
> On Sun, Mar 10, 2013 at 12:43 PM, Antoine Pelisse <apelisse@gmail.com> wrote:
>> On Sun, Mar 10, 2013 at 11:38 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>>> glibc's C strncmp version does 4-byte comparison at a time when n >=4,
>>> then fall back to 1-byte for the rest.
>>
>> Looking at this
>> (http://fossies.org/dox/glibc-2.17/strncmp_8c_source.html), it's not
>> exactly true.
>>
>> It would rather be while (n >= 4), manually unroll the loop.
>
> By the way, if we know the length of the string, we could use memcmp.
> This one is allowed to compare 4-bytes at a time (he doesn't care
> about end of string). This is true because the value of the length
> parameter is no longer "at most".

We still need to worry about access violation after NUL when two
strings have different lengths. That could be avoided in this
particular case, but I think it's too fragile.
-- 
Duy
