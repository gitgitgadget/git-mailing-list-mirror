From: "Jonathan del Strother" <maillist@steelskies.com>
Subject: Re: [PATCH] Teach git diff about Objective-C syntax
Date: Wed, 17 Sep 2008 13:26:50 +0100
Message-ID: <57518fd10809170526i5c1e7dadgc38bb00e8073ba55@mail.gmail.com>
References: <1221610063-33610-1-git-send-email-jon.delStrother@bestbefore.tv>
	 <1221648564-56239-1-git-send-email-jon.delStrother@bestbefore.tv>
	 <alpine.DEB.1.00.0809171205430.14329@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, vmiklos@frugalware.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Sep 17 14:28:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kfw8e-0000Bg-4U
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 14:28:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752352AbYIQM0x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 08:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752319AbYIQM0x
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 08:26:53 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:13119 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752266AbYIQM0w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 08:26:52 -0400
Received: by yw-out-2324.google.com with SMTP id 9so929938ywe.1
        for <git@vger.kernel.org>; Wed, 17 Sep 2008 05:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=vlEvrRoBIip6yZY1Ld1cW4EeWtCRaL+IkKCs+S5M9Fg=;
        b=VU+V/X5tsT+QX2ybQcFPuCPwoMuvjhoalFoFJ8A9hbjJrAU5I0br0hNBZbsBFyjm36
         os+2p9f22S7K905oglDq4bePL4/hbHEfHXE917Tj9HLqcSI1hvgq9C9ratllLmdXOJk2
         tLzGsPoAZSQQKrEvz4GGJZsIcYhlpFaWcGln4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=TO3nKpLNGXBH5wJDY/vqzAmHZxcq+j18F0saPYkEbvyfvYVY1tR1ByA+jRkj+pF5ry
         MzK6cJJRKovOyZstYLFqF9eN5+uW1Ngnn3mDOoQI/Hx2XrWZ4I0yYQlE0E1iuBvfLMYI
         m59emxk2CgQkwd6usWK/OmQUY4MTvsOiuzE8c=
Received: by 10.142.191.10 with SMTP id o10mr837101wff.94.1221654410586;
        Wed, 17 Sep 2008 05:26:50 -0700 (PDT)
Received: by 10.143.6.3 with HTTP; Wed, 17 Sep 2008 05:26:50 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0809171205430.14329@racer>
Content-Disposition: inline
X-Google-Sender-Auth: b7a6b1ffc28d5e42
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96101>

On Wed, Sep 17, 2008 at 12:06 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Wed, 17 Sep 2008, Jonathan del Strother wrote:
>
>> -                     "^[     ]*\\(\\([       ]*"
>> +                     "^[ \t]*\\(\\([ \t]*"
>
> Why?
>
>>                       "[A-Za-z_][A-Za-z_0-9]*\\)\\{2,\\}"
>> -                     "[      ]*([^;]*\\)$" },
>> +                     "[ \t]*([^;]*\\)$" },
>> +
>> +     { "objc", "![ \t]*\\(do\\|for\\|if\\|else\\|return\\|switch\\|while\\)\n" /* Negate C statements that can look like functions */
>> +                     "^[ \t]*\\([-+][ \t]*([ \t]*[A-Za-z_][A-Za-z_0-9]*.*).*\\)$" /* Objective-C methods */
>
> I see you still have these awfully long lines.

I was hoping I'd get away with it since the overlong parts are just comments...

You'd prefer something like
	{ "objc",
			/* Negate C statements that can look like functions */
			"![ \t]*\\(do\\|for\\|if\\|else\\|return\\|switch\\|while\\)\n"
			/* Objective-C methods */
			"^[ \t]*\\([-+][ \t]*([ \t]*[A-Za-z_][A-Za-z_0-9]*.*).*\\)$"
			"\\|"
			/* C functions */
			"^[ \t]*\\(\\([ \t]*[A-Za-z_][A-Za-z_0-9]*\\)\\{2,\\}[ \t]*([^;]*\\)$"
			"\\|"
			/* Objective-C class/protocol definitions */
			"^@\\(implementation\\|interface\\|protocol\\).*"},

?
