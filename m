From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/2] config.mak.uname: Darwin: define HAVE_GETDELIM for
 modern OS X releases
Date: Tue, 2 Jun 2015 15:57:44 -0400
Message-ID: <CAPig+cQLSF4=-4b1qOY4ChBj00=trvAO0qFEh0kOjLonJL4MBg@mail.gmail.com>
References: <1433269138-10890-1-git-send-email-sunshine@sunshineco.com>
	<1433269138-10890-2-git-send-email-sunshine@sunshineco.com>
	<20150602184413.GA11437@peff.net>
	<20150602190403.GA12660@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 02 21:57:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzsJp-0001U6-BO
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 21:57:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751556AbbFBT5q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 15:57:46 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:33252 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751122AbbFBT5o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 15:57:44 -0400
Received: by iebgx4 with SMTP id gx4so141107769ieb.0
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 12:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=xJY/b4ec9iHmhnrHE5UjzGmLWcX91HIwndYAdmffADw=;
        b=O+9CqRLw5G0PqPaF6nSRWjaggsPIyQo5RDuZkvVM2XrUA/ZRTrpnOviPKUcrx8vylH
         ClSCa5cy/X/XTnbm4f93yy2woeNi+DE+znpNuMEhRfiWl4FyOwYvl/SssHuaGFra71CX
         yh+e5bMOCME9Fp8QXIGzwaZswJVW50NwHYvjy2Kj+tHtF+FVMcDrvBoGomzh67ofspmf
         0I6/I8a4fsByo9ElJlDtlpjEAgEr+qmG2+g+QzY4q7uSJiNnRmNynDCETrHezTTSVlZi
         86FmC7dveII7E3hjJBBoD1r8u120kF3Ks55H473Ajf9lsHlelnF0DvHTmeNi9ec+5gYq
         otvQ==
X-Received: by 10.50.41.65 with SMTP id d1mr1042579igl.7.1433275064281; Tue,
 02 Jun 2015 12:57:44 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Tue, 2 Jun 2015 12:57:44 -0700 (PDT)
In-Reply-To: <20150602190403.GA12660@peff.net>
X-Google-Sender-Auth: iJHB3alJk2BpMKcbWbOb5jHhxLs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270589>

On Tue, Jun 2, 2015 at 3:04 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Jun 02, 2015 at 02:44:13PM -0400, Jeff King wrote:
>> > +   ifeq ($(shell expr $(shell expr "$(uname_R)" : '\([0-9][0-9]*\)\.') '>=' 11),1)
>>
>> Do you need to spawn two shells? It seems like:
>>
>>   $(shell expr `expr "$(uname_R)" : '\([0-9][0-9]*\)'` '>=' 11),1)

I considered that and waffled on it. Either approach uses an extra
process, but I suppose `...` would likely be less expensive since it's
just forking the shell rather than exec()ing a new one.

> Oops, I missed the trailing '.' in the regex there, and it probably
> needs double-quotes in case the inner expr fails to match anything.

Which is messy considering the double quotes already surrounding
$(uname_R). Suggestions?

> We could also use "test -gt" instead of the outer expr, which is more
> idiomatic shell. But it reports via exit code, so you'd need "&& echo 1"
> at the end.

Yes, I messed around with that as well but didn't want to stray too
far from existing practice.

I suppose the combination of `...` with built-in 'test' and built-in
'echo' would be the most efficient choice. Do you want it re-rolled?
