From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [WIP/PATCH v4 8/8] ref-filter: add 'ref-filter.h'
Date: Sun, 31 May 2015 04:29:36 -0400
Message-ID: <CAPig+cRF7VEqqBWJY_GRVL+8YCfrD-mYJ2idN1yzVE7JKeTpwA@mail.gmail.com>
References: <5569EF77.4010300@gmail.com>
	<1433008411-8550-8-git-send-email-karthik.188@gmail.com>
	<CAPig+cR88O=STcJDrB+96uJ0Y60mO49QxoJfbOY8Xk4hPvNxGA@mail.gmail.com>
	<556AC40C.5020205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 31 10:29:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yyycr-0005wD-55
	for gcvg-git-2@plane.gmane.org; Sun, 31 May 2015 10:29:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753298AbbEaI3j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2015 04:29:39 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:33211 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752840AbbEaI3g (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2015 04:29:36 -0400
Received: by igbpi8 with SMTP id pi8so41851549igb.0
        for <git@vger.kernel.org>; Sun, 31 May 2015 01:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=p7f9eXMh+teGfETvU2t25F5GOyUjtybs0SMaZ4s/8Bc=;
        b=hHuj5ktAXyez2KvJm3FvkPTrCUmhYDb06nRycXWo4izubOTCxN+Jl9cQ9dv44uZ97q
         6iJBgEPPc7v/NL8iy/EPty+irwfvOMFpt1JvY8uOnnawDoJWng0QSiVDbbwhNwfh8je6
         ewLQ13VBD3ubE9ugkKXv/qeMZma0bW3GK8lZHUN8mEJNhe0ElugM1HHvmVjZSR6GK9WP
         soz5mpBFQI1QR+0LMM/X9a4VEPUVQ9SYDzs8ni6SciUq6sfeVKe62nQS/6geih9SwXif
         oh+QYw+jzF5c1qbVcT4XkYpc2D0AMf92OyVvVvOLFRKUX31cMmLhjCGmUdiKCp5G3naF
         B1HQ==
X-Received: by 10.107.151.75 with SMTP id z72mr19867843iod.46.1433060976174;
 Sun, 31 May 2015 01:29:36 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Sun, 31 May 2015 01:29:36 -0700 (PDT)
In-Reply-To: <556AC40C.5020205@gmail.com>
X-Google-Sender-Auth: BqrohFKbfadbdrRqZbAHH-JH4tE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270325>

On Sun, May 31, 2015 at 4:19 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> On 05/31/2015 09:13 AM, Eric Sunshine wrote:
>> On Sat, May 30, 2015 at 1:53 PM, Karthik Nayak <karthik.188@gmail.com>
>> wrote:
>>>
>>> Create 'ref-filter.h', also add ref-filter to the Makefile.
>>> This completes movement of creation of 'ref-filter' from
>>> 'for-each-ref'.
>>
>> It's important that the project can be built successfully and function
>> correctly at each stage of a patch series. Unfortunately, the way this
>> series is organized, the build breaks after application of patch 7/8
>> since for-each-ref.c is trying to access functionality which was moved
>> to ref-filter.c, but there is no header at that stage which advertises
>> the functionality. Fixing this may be as simple as swapping patches
>> 7/8 and 8/8, along with whatever minor adjustments they might need to
>> keep them sane. (The alternative would be to combine patches 7/8 and
>> 8/8, however, Matthieu didn't seem to favor that approach[1].)
>
> That is kind of a problem, If I need to swap those commits also, I'd have to
> add the part where ref-filter is added to the Makefile with the code
> movement from for-each-ref to ref-filter. This again will not just be Code
> movement.
> But I guess thats a fair trade-off, will change it. Thanks

Don't take the "code movement-only" recommendation too literally. What
people mean is that you shouldn't make changes to the lines you're
moving from one location to another (other than absolutely mandatory
changes to support the movement) since it's difficult to spot and
review changes in lines which are being moved.

The recommendation is not saying that the patch itself can't include
any other changes (though, it's often best to minimize other changes
in the same patch). In this case, the Makefile change is logically
related to that particular code movement, so it's correct to include
it in the patch. (Also, the Makefile change is so minor that it's not
a burden upon reviewers.)
