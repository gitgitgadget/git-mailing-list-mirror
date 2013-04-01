From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/3] send-email: use the three-arg form of open in
 recipients_cmd
Date: Sun, 31 Mar 2013 19:30:03 -0700
Message-ID: <20130401023003.GD11704@elie.Belkin>
References: <7vr4ivni5g.fsf@alter.siamese.dyndns.org>
 <1364780442-6015-1-git-send-email-gitster@pobox.com>
 <1364780442-6015-3-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 01 04:30:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMUWL-0001d1-OS
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 04:30:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756284Ab3DACaM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Mar 2013 22:30:12 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:45931 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755732Ab3DACaL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Mar 2013 22:30:11 -0400
Received: by mail-pd0-f180.google.com with SMTP id g10so987887pdj.39
        for <git@vger.kernel.org>; Sun, 31 Mar 2013 19:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=xZSJBFAuyK6u2pmhEBxlCwY55uvxTlzgV3QYB7KJnLQ=;
        b=rugJ50mwpwdQg10H1XeN6+v/zfkaf/GSvS2ShuD1A55MG8q9FL7F0IDjZMag/4Bwdc
         vEDPN3A0xr/tkcXVdZsANQVPLL5jJHNY+EiZLGayOzHLbnMb8rUebfHTvxPwYiW4d//p
         jrZdgvPfsNc22mpJ0NSQYynmVArSltN51HPrT9ox4luKvICW7DIZKmES7o4KGc2k9pNy
         6jhiFq9k29KWFh2yC07lxrd3hwTwN+F/jqZRvkeNEUmBzSPPbG106UYePSY9lTlIaCO5
         4ST62BJczT+OENAppFgl8qkbKlSPoT4u4nk0rcx40UQE7uG4sxlC+uHQrDq8jhs7jVcM
         lAyg==
X-Received: by 10.68.231.42 with SMTP id td10mr15575772pbc.174.1364783411036;
        Sun, 31 Mar 2013 19:30:11 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id fc8sm13185497pad.21.2013.03.31.19.30.08
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 31 Mar 2013 19:30:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1364780442-6015-3-git-send-email-gitster@pobox.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219658>

Junio C Hamano wrote:

>               we cannot rewrite it to
>
> 	open my $fh, "-|", $cmd, $file;
>
> for extra safety.  At least, by using this in the three-arg form:
>
> 	open my $fh, "-|", "$cmd \Q$file\E";
>
> we can silence Perlcritique, even though we do not gain much safety
> by doing so.

Yeah, I think this is the right thing to do.

This means that if some later code refactoring parses $tocmd once and
passes an array around, it would be easy to change this to

	open my $fh, "-|", @$cmd, $file;

and there would be no temptation to do something involving pasting
@$cmd back together into a single string.  Of course such a
refactoring is not very likely, but that kind of thing is a good
reason to prefer this style in general.

So for what it's worth, I like this patch.
