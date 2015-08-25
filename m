From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 4/5] index-pack: Use the new worker pool
Date: Tue, 25 Aug 2015 15:39:02 -0700
Message-ID: <CAGZ79kaMeaTiQgVxjf5aPAtLVw224Hf9gzDNS85+9C+rj_keWA@mail.gmail.com>
References: <1440523706-23041-1-git-send-email-sbeller@google.com>
	<1440523706-23041-5-git-send-email-sbeller@google.com>
	<20150825190329.GA11271@sigill.intra.peff.net>
	<xmqqfv37xfrc.fsf@gitster.dls.corp.google.com>
	<CAGZ79kZ9V35KmJSExt=EqYFcyOSysaFsJA0E+dx46Qg+Pm+Ybg@mail.gmail.com>
	<xmqq37z7xebe.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 26 00:39:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUMs2-0005Q3-Au
	for gcvg-git-2@plane.gmane.org; Wed, 26 Aug 2015 00:39:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755987AbbHYWjF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2015 18:39:05 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:36720 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932595AbbHYWjE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 18:39:04 -0400
Received: by qkda128 with SMTP id a128so59843535qkd.3
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 15:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=382jMKosp0zvJAhyRgim4bWicJelhcvm68uOn5wj+aI=;
        b=ESbQC8GKpifQAcnTByrWzHiF4IxP4IK3PR71U405zYcxJrZ5NW2x1zS/tSNhaiMEYY
         uE3BirDIFvnACKCW8mDqPaY0y4Ak04nBwhvI340JPxi+XAK4Ctbqd1oW9Zvg3cY13BFC
         B8YPcplg9ghMlGYyjFJD6rT333i8BBGhAngvZGWYxf1BP3he/qSSYutlRi39iVGHlm0g
         WzWmej1cpcS11WoRKc79cQ3O0BQX5UdKxaFC/yQkn52AW+G8CRiNZsLAHzcG9kyqy1zg
         xLzpsTWb7QefWAFRnVg51l+QUbNeJGEBlw9nSBhW6hyHCy8pFyeu8DX1Ag27vgnzGBaJ
         2Aow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=382jMKosp0zvJAhyRgim4bWicJelhcvm68uOn5wj+aI=;
        b=LBEaKtwNpBNZRMc4XkUfbvTNxT/xEd/LC1nin7cxt7yNwH5orf9TFB04o6mY2SRNxh
         sHB8oVd/P30heNZMcQDXn5ynqns0a8uyJ3BNa5pAm8qNiNG5zEkFhvn5vqM3FqL76wnx
         RTsnnayWVO8TPe88S7WMXpx1VAENscFree7AI2VH9NE0HZjzy09981vvzT28FDpMvS/H
         K7rIED80OhUI0681n70GULC0rNVMjVGsiI1uSQsimv0onW+9O1cI+JQnOT+hNw+FLoTm
         R2//CS7+ljqOEGjB8HUP8zTg/CGgAO/gYo5/a567dyAsgZZfMm2oBA0ZG+AKsEvJh59Q
         Hrtw==
X-Gm-Message-State: ALoCoQlTWwMEl9KdCRWh0vfxtuTkXw7nNjK5+t/vvnRidNJZ5/b9Fk9dGZVgiNvUnnH4qiH0Sk4i
X-Received: by 10.55.22.85 with SMTP id g82mr26206297qkh.70.1440542342818;
 Tue, 25 Aug 2015 15:39:02 -0700 (PDT)
Received: by 10.140.41.198 with HTTP; Tue, 25 Aug 2015 15:39:02 -0700 (PDT)
In-Reply-To: <xmqq37z7xebe.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276582>

On Tue, Aug 25, 2015 at 2:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Not sure I follow there.
>>
>> Original implementation:
>> We have M threads sitting around the table, all of them trying to obtain food
>> from the one bowl on the table and then eating it.
>> Once the bowl is all eaten, we can stop.
>>
>> New pattern:
>> One cook puts all the food items on the sushi-go-round-belt with a fancy plate
>> and the threads grab them one by one still using locks (but they are internal to
>> the belt).
>>
>> Are you saying we're content with just a bowl and everyone helps themselves
>> for getting food?
>
> No.  I am questioning how big overhead is for having the
> go-round-belt that must hold all dishes to be eaten, which did not
> exist in the original arrangement.
>
>

Then please don't pick up this patch. This and patch 5 are there to convince
Jeff this is a good API, worth being introduced and not over engineered, just
solving a problem we're interested in with a minimal amount of code to side
track from the actual goal we want to pursue.
