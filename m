From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Verify Content-Type from smart HTTP servers
Date: Thu, 31 Jan 2013 14:36:14 -0800
Message-ID: <CAJo=hJusN5a37vPtw6dT0jMN7+VjvhTWFGB5b+z2cLCyAY3bzA@mail.gmail.com>
References: <1359666943-13316-1-git-send-email-spearce@spearce.org> <7vd2wlf1zf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 31 23:37:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U12kc-0006cm-Az
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 23:36:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755717Ab3AaWgg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 17:36:36 -0500
Received: from mail-ie0-f175.google.com ([209.85.223.175]:34443 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754197Ab3AaWgf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 17:36:35 -0500
Received: by mail-ie0-f175.google.com with SMTP id c12so2856457ieb.6
        for <git@vger.kernel.org>; Thu, 31 Jan 2013 14:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=4jxa48+5U1g753/khfqddQg7cXctgZqzb20t/RO8mjw=;
        b=Y1PnQqgqRp91UINVOrfIc1wbNrtU7KaHw4qIG7nO3AhZNHGagr3gJ250zJ5Y+mr6OZ
         //q0HmqQH8BK3WIX/ANXYzq9Qyb+kiJmiyAg/NyEgpqX70Bc2nEywDblMV6iND1a/DU0
         UVvm78yQm0oM2auxB3i+lMqO8bjM9JN0kM8zA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:x-gm-message-state;
        bh=4jxa48+5U1g753/khfqddQg7cXctgZqzb20t/RO8mjw=;
        b=IPU4wX/lnadLt7RjqykZqGFo6EjJvaybKP55LXRJyHhc3wmkqncY+axuZUu47binDY
         J0bxGHxAKY4REqrxx5ZVBCQmMYOkXA82BLTCwOClpDLg8bkeD/wn0wIKCH6avFXaHtAf
         zcNq6uwgUEVk7XJwjRIp4Z4VCCL695xVWpBm3mb8tMMk1MXAlitkkPQ97fyKl9hOboJh
         pOZDVD+BMoJ97hRfLo7K9ieMWJc1B219UD66LtJdm7LO+pS/9en+Z4+doi/8LYI5HX+2
         wA9flhpb6neKcMV1DDjdu5Sge2NDqXctval6yvaq3nHnTCxcTmhXzyVdzrBh/vZe2QoN
         lRIw==
X-Received: by 10.42.30.132 with SMTP id v4mr8181125icc.34.1359671794787; Thu,
 31 Jan 2013 14:36:34 -0800 (PST)
Received: by 10.64.170.100 with HTTP; Thu, 31 Jan 2013 14:36:14 -0800 (PST)
In-Reply-To: <7vd2wlf1zf.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQlPuH+VpKID1AF1zCWjFDu/WnblzyeG6AEnSV+P/g01yAF9jeV4F/x+VaXCCiDwtUxoFQ64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215180>

On Thu, Jan 31, 2013 at 1:59 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
>
>> Before parsing a suspected smart-HTTP response verify the returned
>> Content-Type matches the standard. This protects a client from
>> attempting to process a payload that smells like a smart-HTTP
>> server response.
>>
>> JGit has been doing this check on all responses since the dawn of
>> time. I mistakenly failed to include it in git-core when smart HTTP
>> was introduced. At the time I didn't know how to get the Content-Type
>> from libcurl. I punted, meant to circle back and fix this, and just
>> plain forgot about it.
>>
>> Signed-off-by: Shawn Pearce <spearce@spearce.org>
>> ---
>
> Sounds sensible.  Was there a report of attack attempts by malicious
> servers or something, or is it just a general "common sense" thing?

Common-sense cleanup.

I had a report a while ago about JGit not working with the Git servers
at Codeplex. This failure was caused by their HTTP servers returning
an invalid Content-Type, making JGit refuse to continue parsing. This
has since been fixed, I verified this morning that Codeplex is
returning the correct Content-Type.
