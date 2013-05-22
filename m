From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v6] Add new git-related helper to contrib
Date: Wed, 22 May 2013 18:57:33 -0500
Message-ID: <CAMP44s1_=HSgZA=abHJ3sgDbUyfkF78qO+sR1+Aact3o7bAgLA@mail.gmail.com>
References: <1368978823-18247-1-git-send-email-felipe.contreras@gmail.com>
	<7vr4gyizti.fsf@alter.siamese.dyndns.org>
	<CAMP44s0pXLmjVUwsVWiN2G5QReh80spXjvy_6GuUGRz1RmUbLQ@mail.gmail.com>
	<7vd2siiqsr.fsf@alter.siamese.dyndns.org>
	<CAMP44s2ETSxebGxXJV_BYEqTC5gJMVdQLbnTUomrie2rHhdmDg@mail.gmail.com>
	<7v8v36iq3e.fsf@alter.siamese.dyndns.org>
	<7v4nduipvb.fsf@alter.siamese.dyndns.org>
	<7vzjvmh98r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 23 01:57:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfIub-0003Yj-9Z
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 01:57:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754288Ab3EVX5h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 19:57:37 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:42788 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753897Ab3EVX5g (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 19:57:36 -0400
Received: by mail-lb0-f177.google.com with SMTP id o10so2688164lbi.8
        for <git@vger.kernel.org>; Wed, 22 May 2013 16:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Q+B9d2PWCBNii9gaFwomYC9t/mmcArCrKf6TCIrpEQY=;
        b=aKFqxg+yRkeepKXSFgm5bgYKYjuc8/BJz3stZeyhlC2qYDFL9uvWhNlZ5mEc0cdoEG
         8TJXx81ooXnX8jxOMSYHv3bRh85NTF6oSK0Gz2sgR8mx4sxkkV6PNeT7UrhcQYJhXMzx
         L7yuaGRsSS1X94tQurFl95nPxlJXf6PlunVi+GhK/nfniU/IqGwUe9i3oOt9K9fFKYH9
         BJecEbIvf2q9cit4LuKyvPH6VaynE4ZGtf95etkqBqmiLlbf0N0Ey+Kar1YIViZLk2kj
         hnJouNs5GJWmENYNX+3BqaqnIkpOORYsaOvox0tYySRhlBuxkWRMJZHJrp/HJhcDqGRQ
         CAng==
X-Received: by 10.112.218.102 with SMTP id pf6mr5141538lbc.77.1369267053836;
 Wed, 22 May 2013 16:57:33 -0700 (PDT)
Received: by 10.114.174.170 with HTTP; Wed, 22 May 2013 16:57:33 -0700 (PDT)
In-Reply-To: <7vzjvmh98r.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225206>

On Wed, May 22, 2013 at 6:42 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>>>> The person who moved the code will be on the list regardless,
>>>
>>> That is exactly the point I have been trying to raise.  Does the
>>> person appear in the list when you run blame with -CCC?  You ask for
>>
>> s/person/commit/;
>>
>>> the body of the function, and the -C mode of blame sees through the
>>> block-of-line movement across file boundaries, and goes straight to
>>> the last commit that touched the body of the function in its original
>>> file, no?
>
> -- >8 --
> cd /var/tmp/
> git init blame
> cd blame
>
> cp /src/git/COPYING COPYING
> git add COPYING
> git commit -m initial
>
> sed -ne 120,140p COPYING >EXTRACTING
> git add EXTRACTING
> git commit -m second
>
> git blame -C -C -C EXTRACTING
> -- 8< --

I just realized that -CCC does not do the same thing as -C -C -C.

> then the commit that did add these lines to EXTRACTING touched
> COPYING, and the origin of these lines are traced to it (this is
> designed to be useful in a typical "refactor by moving code";
> "cut and paste without changing the original" people need heavier
> copy detection with more -C).
>
> IIRC, git-gui runs two blames, one without any -C and one with (I do
> not offhand recall how many -C it uses) to show both.

'git blame' is a very expensive operation, perhaps we should add
another option so users don't need to run two blames to find this.

-- 
Felipe Contreras
