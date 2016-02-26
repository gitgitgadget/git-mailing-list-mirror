From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] strbuf_write: omit system call when length is zero
Date: Fri, 26 Feb 2016 09:09:50 -0800
Message-ID: <CAGZ79kZYqf3K5mR0_1eeQHO-n675BRfEQvC_-YCb+gOPTJ5xXA@mail.gmail.com>
References: <1456439678-5433-1-git-send-email-sbeller@google.com>
	<CACsJy8DgjmdX681fRwB-JajPBRN+cNy=jFwEDW6D-dXhNi=_6g@mail.gmail.com>
	<xmqqy4a8l04f.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 18:10:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZLtz-0002rS-Hy
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 18:10:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422709AbcBZRJx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 12:09:53 -0500
Received: from mail-ig0-f178.google.com ([209.85.213.178]:38015 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754003AbcBZRJw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 12:09:52 -0500
Received: by mail-ig0-f178.google.com with SMTP id y8so39815246igp.1
        for <git@vger.kernel.org>; Fri, 26 Feb 2016 09:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=uNtZLlTZcmvOXmdkIPcZhgZgOtNgG22jX9KTeWnyVPk=;
        b=OzRO91GERsMlIIteAoZao6f42GtNSAmlqj0N9Xl56SPxYPjwxkwuDckl6RK4HCd23i
         QtNjFE1fgABOl5aE/8PR94P4jG0PJAG1flUGb2C4HX4yXSfUmTtpn55gEWSz1bavHtd0
         X71oKxe/byp4ZQEj5qq2uP0qj8sqElqrQa0AUaepN8y41d8T+L81J3NzM8FCYsekxy+z
         PLNn5plcK1nuN5yS6CgzlFiX+z3amHfuUVW/N7hk992/1Pmo/7Brz/R+iYVZvy69BlC5
         aPCoMPXYvNFt9Vfh5t0DJtZ3ZDp5Cg72r7KR3EcS+Ei7y1RurdBrJlA2PIPvnFeexfgl
         LQgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=uNtZLlTZcmvOXmdkIPcZhgZgOtNgG22jX9KTeWnyVPk=;
        b=V0ZpKAJUUYz8bapSi65lUOp/WNBWYr4O+53zPYiuG+2jXaxayhAgyg+hvXYW7wrbiN
         bZvs3ysqApj7AkAvCXIhgOEwUpIPonR50c/hU8GbY8NjjEWGzkqm0j/3Vl+WBTsRSKi6
         egcHh0Ywx4A+bHsnZ26eS+AmIrPp1Wq6FSVx7CsO+nyIU/DdqcaawFGgA5aLVeN3joH3
         HAgVGl9D15dFq4YnhcCCHApGyrit55Z8XVBnFdjn2jsWCXKqWPyNpG4joLv3fTXUckuY
         tid+0CZgs6Ek31pnKCt0jY/x3cJwyo2KrBFXHD1nPL+UoSD+U4o1KC+lrfaLlZk/AWSP
         jIWg==
X-Gm-Message-State: AD7BkJK+g2c4wyKIcmmKgsQPxGDQUgL6H9o6ECuA6MlT4dYCvFgNmVfYnpRbTaH8kJlnLgLUsBsmBXFxPX99+02M
X-Received: by 10.50.3.42 with SMTP id 10mr3874612igz.85.1456506591058; Fri,
 26 Feb 2016 09:09:51 -0800 (PST)
Received: by 10.107.58.6 with HTTP; Fri, 26 Feb 2016 09:09:50 -0800 (PST)
In-Reply-To: <xmqqy4a8l04f.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287592>

On Thu, Feb 25, 2016 at 5:40 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Fri, Feb 26, 2016 at 5:34 AM, Stefan Beller <sbeller@google.com> wrote:
>>> In case the length of the buffer is zero, we do not need to call the
>>> fwrite system call as a performance improvement.
>>
>> fwrite is a libc call, not system call. Are you sure it always calls
>> write() (assuming buffering is off)?
>
> I do not think so, but I suspect that the patch misstates its
> rationale (I said I get uncomfortable every time I see a function
> that takes size and nelem separately used by a caller that can
> potentially pass nleme=0, when I wondered it it is OK that no caller
> of this funtion checks its return value).
>

This is exactly what happened. I assumed fwrite would be a system call
eventually.
