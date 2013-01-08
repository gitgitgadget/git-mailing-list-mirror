From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] git clone depth of 0 not possible.
Date: Tue, 8 Jan 2013 14:38:27 +0700
Message-ID: <CACsJy8D9+KHT=YfU0+rPCbs+AwxQOpfKzPChDhk8d-MMkRzZug@mail.gmail.com>
References: <1357581996-17505-1-git-send-email-stefanbeller@googlemail.com>
 <20130108062811.GA3131@elie.Belkin> <7vip78go6b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <stefanbeller@googlemail.com>,
	schlotter@users.sourceforge.net, Ralf.Wildenhues@gmx.de,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 08 08:39:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsTmH-00034V-Gc
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 08:39:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753358Ab3AHHi6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 02:38:58 -0500
Received: from mail-oa0-f41.google.com ([209.85.219.41]:64056 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093Ab3AHHi5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 02:38:57 -0500
Received: by mail-oa0-f41.google.com with SMTP id k14so85615oag.14
        for <git@vger.kernel.org>; Mon, 07 Jan 2013 23:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=AZ3/4780i0OHp80r1Aq9Xzl5pcVKRMWa1ealT/oiJQQ=;
        b=aNgi1zG3g6B5x8AflOAABjqDrpqnhI+1vgdricFyNe4DcApfPq8kIM+bbAHXPVc28e
         xv5o59wzWvsvNqaZ2oHUT6TGGZJ0n1cBUdxCYhZ5k1EIMZPHvYxATMxLus0LWc1C7ZxI
         biH9qF8BxSJEDdPdFA4kpkI+2dsVyaYI+wJ7UI1A0m0QH0ZbkbHZv4Bfg+9PT5rj8vUp
         CnAQUdr4iiPif1xg3X3ilCKEhmI6sIgN8QaEbnNFa3hT8GSv40Wu3V2lXbfLf+5FBxNP
         4TUTZiU213l+DjyeMweWoGR0NHZR4xEOVUXviN+90iMfI1SNFKn2WRBzWo0JtKPCUV9s
         /G6g==
Received: by 10.60.22.164 with SMTP id e4mr35080445oef.87.1357630737413; Mon,
 07 Jan 2013 23:38:57 -0800 (PST)
Received: by 10.182.153.69 with HTTP; Mon, 7 Jan 2013 23:38:27 -0800 (PST)
In-Reply-To: <7vip78go6b.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212942>

On Tue, Jan 8, 2013 at 1:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Sounds buggy.  Would anything break if we were to make --depth=1 mean
>> "1 deep, including the tip commit"?
>
> As long as we do not change the meaning of the "shallow" count going
> over the wire (i.e. the number we receive from the user will be
> fudged, so that user's "depth 1" that used to mean "the tip and one
> behind it" is expressed as "depth 2" at the end-user level, and we
> send over the wire the number that corresponded to the old "depth
> 1"), I do not think anything will break, and then --depth=0 may
> magically start meaning "only the tip; its immediate parents will
> not be transferred and recorded as the shallow boundary in the
> receiving repository".

I'd rather we reserve 0 for unlimited fetch, something we haven't done
so far [1]. And because "unlimited clone" with --depth does not make
sense, --depth=0 should be rejected by git-clone.

[1] If we don't want to break the protocol, we could make depth
0xffffffff a special value as "unlimited" for newer git. Older git
works most of the time, until some project exceeds 4G commit depth
history.
-- 
Duy
