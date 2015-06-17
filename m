From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] clone: check if server supports shallow clones
Date: Wed, 17 Jun 2015 09:35:23 -0700
Message-ID: <xmqq8ubi47jo.fsf@gitster.dls.corp.google.com>
References: <1433961320-1366-1-git-send-email-adgar@google.com>
	<20150610190512.GB22800@peff.net>
	<CACsJy8CiwiWgf2CarNNN5NgN7QbRB8oxGMmxF+VX8T=ZV2M1ow@mail.gmail.com>
	<20150611143204.GA3343@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>, Mike Edgar <adgar@google.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 17 18:35:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5GJO-0006ma-Cy
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 18:35:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753172AbbFQQfc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 12:35:32 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:33167 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753812AbbFQQf0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 12:35:26 -0400
Received: by iebgx4 with SMTP id gx4so37526947ieb.0
        for <git@vger.kernel.org>; Wed, 17 Jun 2015 09:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=br+3hsrNmWiYBXKp/UAjrGo5I5Sv9TP8s+LLe0vDe8A=;
        b=BZh/DuZkwTyr/8SLzPcXvmNUaTXW2cnsy/VvJDP+TKqnz4KLFyTcH0IFcKKnWCG119
         HisUttAvc/j4Vw44PTlc6hOAxlqqh77K92o7KcIiHvUBUa3LInCuXA5K4Tyxy4oUx4UY
         7edr0QQ9wjyxy0LhQ2F7tWb5ViFQSqYTckzge61u2ba0tC4YfVq8oYrZSuvIQkMzZn1I
         b/XngjGnsy+Pra5JnyYyKU9OWPOlKlES7pUrkslxT65YHg9BDPlWNASnYD4v76jN2l7W
         qHt1fu9bE7DeXBbgJmfDjq3pHLexepLnjJuAK2sdtvKGNxHskJzWGqNASFHJK2OVvziG
         qEbg==
X-Received: by 10.50.112.73 with SMTP id io9mr37001638igb.18.1434558925403;
        Wed, 17 Jun 2015 09:35:25 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a4d4:8fab:953e:ec65])
        by mx.google.com with ESMTPSA id v3sm3480256igk.1.2015.06.17.09.35.24
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 17 Jun 2015 09:35:24 -0700 (PDT)
In-Reply-To: <20150611143204.GA3343@peff.net> (Jeff King's message of "Thu, 11
	Jun 2015 10:32:07 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271864>

Jeff King <peff@peff.net> writes:

> On Thu, Jun 11, 2015 at 08:02:33PM +0700, Duy Nguyen wrote:
>
>> > I see that do_fetch_pack checks server_supports("shallow"). Is that
>> > enough to cover all fetch cases? And if it is, why does it not cover the
>> > matching clone cases?
>> 
>> I think this replacement check would do
>> 
>> if ((args->depth > 0 || is_repository_shallow()) && !server_supports("shallow"))
>>         die("Server does not support shallow clients");
>
> Oh, indeed, there is the depth flag I was looking for. :)
>
> And from some rudimentary testing, I believe that:
>
>   git init
>   git fetch --depth=1 ...
>
> is currently broken in the same way as clone (we are not shallow yet, so
> it does not complain when the server does not support it). I think the
> patch above fixes both that and the clone case.
>
> Of course it's hard to add to the test suite, since we do not have a way
> of hitting a server that does not understand shallow (I simply fudged
> server_supports() to return false on the client).

We've had the "shallow" capability advertised since ed09aef0
(support fetching into a shallow repository, 2006-10-30), and this
patch itself may not be that super-important in practice.  Let's not
worry too much about a test for situations that may not likely
matter to us [*1*].

Thanks, all.


[Footnote]

*1* How behind are re-implementations of upload-pack by other
people, I have to wonder, though?
