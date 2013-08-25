From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] dir: test_one_path: fix inconsistent behavior due to
 missing '/'
Date: Sun, 25 Aug 2013 04:05:30 -0400
Message-ID: <CAPig+cSY8oMeAaS2GRaPhwCkfO=eLa6-UPcJGRe98c0uUFbm8Q@mail.gmail.com>
References: <1377232155-7300-1-git-send-email-sunshine@sunshineco.com>
	<1377232155-7300-3-git-send-email-sunshine@sunshineco.com>
	<20130825060045.GP2882@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Brian Gernhardt <brian@gernhardtsoftware.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 25 10:05:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDVKR-0004hu-Lg
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 10:05:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756179Ab3HYIFg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Aug 2013 04:05:36 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:57533 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756163Ab3HYIFc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Aug 2013 04:05:32 -0400
Received: by mail-la0-f51.google.com with SMTP id es20so1530895lab.38
        for <git@vger.kernel.org>; Sun, 25 Aug 2013 01:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=FoE+8tsKmN/yvoLoj89R2jhtUuaDfqYpnMe0QqtMayQ=;
        b=t1QxsWeKvEmvGGnOO7gX9GL5TwFvYqk3lZCs739xX+BFTvo8XveAum9NkJfGQawrS6
         nOrmzFY5cpnpznB86nfizj+NjLrRxOAGsjVajmIuNx9Nm94Yih6oZtb67tXofPTvHecX
         q16uV0mnVXEwzNHCi0GjgX2lWBQfwBePTfEbNjuL89Q60Pb7kAYJyucf2nngBmh5gFW+
         SCszkkDBoaPAlHfZHf4Dj30hgSZUOuYUeNytPSz6D395LVNdm6JQ3Rd3EW4j3bxJin2s
         CtrSg4J61oXvALvA9bWbh3pKUlk4ORUmBx9cM1fNr0fm82wTdirBGCW6A4ILC1Y3SsJl
         1cTw==
X-Received: by 10.112.172.137 with SMTP id bc9mr7153828lbc.21.1377417930890;
 Sun, 25 Aug 2013 01:05:30 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Sun, 25 Aug 2013 01:05:30 -0700 (PDT)
In-Reply-To: <20130825060045.GP2882@elie.Belkin>
X-Google-Sender-Auth: IsmpooBqkQw6FECPpbOXQFLhDzw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232935>

On Sun, Aug 25, 2013 at 2:00 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Eric Sunshine wrote:
>
>> Although undocumented, directory_exists_in_index_icase(dirname,len)
>> unconditionally assumes the presence of a '/' at dirname[len] (despite
>> being past the end-of-string). Callers are expected to respect
> [...]
>>                                                Fix this problem.
>
> So, does this fix the problem by changing
> directory_exists_in_index_icase() to be more liberal in what it
> accepts, or callers to be more conservative in what they pass in?

It places the onus upon the caller. As mentioned in the cover letter
[1], I was not happy with this solution. Junio felt likewise. A
follow-up series [2] fixes both directory_exists_in_index() and
directory_exists_in_index_icase() to be more liberal in what they
accept, relieving the caller of the burden. By the time that series
was posted, however, Junio and Peff had decided that a fix at a more
fundamental level would be better (a conclusion with which I agree,
but for which I do not yet have sufficient knowledge about git
internals to implement). In the meantime, as an interim bug fix, Junio
decided [3] to apply the patch to which you responded (but with an
updated commit message).

[1]: http://thread.gmane.org/gmane.comp.version-control.git/232796
[2]: http://thread.gmane.org/gmane.comp.version-control.git/232833
[3]: http://thread.gmane.org/gmane.comp.version-control.git/232833/focus=232837

> Please forgive my laziness.  I ask in order to save future readers the
> time of digging into the code.
