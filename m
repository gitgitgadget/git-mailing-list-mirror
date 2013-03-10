From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 6/6] exclude: filter patterns by directory level
Date: Sun, 10 Mar 2013 17:18:34 +0700
Message-ID: <CACsJy8DwfYL80Zwxufv7Uz7-H_c8VTs=DNQkeDz2bh4K1tTtcw@mail.gmail.com>
References: <1362802190-7331-1-git-send-email-pclouds@gmail.com>
 <1362896070-17456-1-git-send-email-pclouds@gmail.com> <1362896070-17456-7-git-send-email-pclouds@gmail.com>
 <7vtxojd5u7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 10 11:19:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEdLp-0003lw-2D
	for gcvg-git-2@plane.gmane.org; Sun, 10 Mar 2013 11:19:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124Ab3CJKTG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Mar 2013 06:19:06 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:54132 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777Ab3CJKTF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Mar 2013 06:19:05 -0400
Received: by mail-ob0-f178.google.com with SMTP id wd20so2446928obb.23
        for <git@vger.kernel.org>; Sun, 10 Mar 2013 03:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=8ODS3HHIBDFgJCdxduaHpL1EWuQHjmitzXb1t1zXeuI=;
        b=pxbv6+yKnV59KK6xEddbD+61YQOQBarlReueqAG1hk1K5vFnYtJm8zt9C5QYfZtNuB
         JIvN2dcbTdx65uE3b98mEgaH043FhLnppSiXc4HkWXqxL0YeFIbvnFG/c9PKwtKXV7SL
         AzgUYlzMtzmQqx2vS541VYgAUVi87F1rGMHTNhjDrpI3HNDF2a2UnrpB85HsskSQUi0L
         gV0SO4AxOa/6gkHLh4kVPb4WZOJi2Oj0rzk9Ig9oXopnyi1ufp/z+fln3kCF2RZm49CZ
         3MpWnM/j+wj4/DA6Rfvv2+lynYxZ5us7TMuZ1kyYuWFA1wZ7cWfZuac40XjvK9pHnd7q
         lXgw==
X-Received: by 10.182.118.104 with SMTP id kl8mr5977176obb.54.1362910744746;
 Sun, 10 Mar 2013 03:19:04 -0700 (PDT)
Received: by 10.76.27.200 with HTTP; Sun, 10 Mar 2013 03:18:34 -0700 (PDT)
In-Reply-To: <7vtxojd5u7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217794>

On Sun, Mar 10, 2013 at 3:20 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> +     else if (*p == '/')
>> +             dirs--;
>
> I presume this is to compensate for a pattern like "/pat" whose
> leading slash is only to anchor the pattern at the level.  Correct?

Yes.

Also for the record, we could cut down the number of prep_exclude
calls significantly by only calling it when we switch directories
(i.e. when read_directory_recursive begins or exits), not calling it
for all entries of the same directory. For instance, path/, path/a,
path/b, path/c/, path/c/d, path/e should only call prep_exclude 3
times when we enter "path", "path/c" and leave "path/c" (rather than 6
times currently). Unfortunately, I see no real time savings by this
call reduction. So no patch. Maybe I'll try it again on my slower
laptop and see if it makes any difference.
-- 
Duy
