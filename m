From: "V.Krishn" <vkrishn4@gmail.com>
Subject: Re: Stalled git cloning and possible solutions
Date: Fri, 30 Aug 2013 03:05:10 +0530
Message-ID: <201308300305.10440.vkrishn4@gmail.com>
References: <201308300118.19166.vkrishn4@gmail.com> <20130829211034.GB4110@google.com>
Reply-To: vkrishn4@gmail.com
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 29 23:48:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFA4P-0000oh-30
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 23:48:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756674Ab3H2Vr5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 17:47:57 -0400
Received: from mail-qc0-f172.google.com ([209.85.216.172]:33515 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756653Ab3H2Vr4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 17:47:56 -0400
Received: by mail-qc0-f172.google.com with SMTP id c11so489006qcv.17
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 14:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:reply-to:to:subject:date:user-agent:references:in-reply-to:cc
         :mime-version:content-type:content-transfer-encoding:message-id;
        bh=6kuvY37noGrm3dAtQbLrAzUhUJmePGieWRZqAOIu/j4=;
        b=zh+I6B4IcbMXS1hD+hN/9+XJ9O0RUfAWzXyq/9CSUAvNfVQGJo7o4KBWx9qL7pBkdb
         i0vI4RCCwiEj6NoB5XFJFdx4obOJ+M0OKbrrUAMJpf6I0udv2GaoJ40ugRhZAaSaV6gj
         jngHzY6IV3013Eez7P5IlC8b1jOi0BOXbI7e4dpBrvLVZEYpr2pl9E9E9z16vpLw/bya
         mnQHW1QLAXpYb8EetyH9c5FTgzBkzd2Du4lanOsGb5LcIv5N+eZo3BJCuBloZEiqIaBV
         /fsO5C7e2gZ0LkGDY0jks6TRSex/6TvfYWv9jPdaQKo15K4EYEI55z4Ai9YhxsvyIA2s
         i3MQ==
X-Received: by 10.49.17.162 with SMTP id p2mr6490273qed.69.1377812876089;
        Thu, 29 Aug 2013 14:47:56 -0700 (PDT)
Received: from microknoppix.localnet ([117.227.33.153])
        by mx.google.com with ESMTPSA id a2sm45333977qek.7.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 14:47:55 -0700 (PDT)
User-Agent: KMail/1.13.7 (Linux/3.3.7-64; KDE/4.7.4; x86_64; ; )
In-Reply-To: <20130829211034.GB4110@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233370>

On Friday, August 30, 2013 02:40:34 AM you wrote:
> V.Krishn wrote:
> > Quite sometimes when cloning a large repo stalls, hitting Ctrl+c cleans
> > what been downloaded, and process needs re-start.
> > 
> > Is there a way to recover or continue from already downloaded files
> > during cloning ?
> 
> No, sadly.  The pack sent for a clone is generated dynamically, so
> there's no easy way to support the equivalent of an HTTP Range request
> to resume.  Someone might implement an appropriate protocol extension
> to tackle this (e.g., peff's seed-with-clone.bundle hack) some day,
> but for now it doesn't exist.

This is what I tried but then realized something more is needed:

During stalled clone avoid  Ctrl+c. 
1. Copy the content .i.e .git folder some other place.
2. cd <new dir>
3. git config fetch.unpackLimit 999999
4. git config transfer.unpackLimit 999999
5. cat .git/config #to see if config went ok
 
6. recover process:
 git unpack-objects -r --strict <.git/objects/pack/tmp_pack_0mSPsc

THEN... hopefully thought following should do the trick
 git pull
 OR
 git-fetch-pack
 OR
 git repack + git pull

but then something more is needed.... :)
like index/map file... etc for it work.

> 
> What you *can* do today is create a bundle from the large repo
> somewhere with a reliable connection and then grab that using a
> resumable transport such as HTTP.  A kind person made a service to do
> that.
> 
>   http://thread.gmane.org/gmane.comp.version-control.git/181380

Service looks nice. Hope its gets sponsors to keep it running.

-- 
Regards.
V.Krishn
