From: Tom Miller <jackerran@gmail.com>
Subject: Re: [PATCH] fetch: Print full url in header
Date: Thu, 9 Jan 2014 21:03:54 -0600
Message-ID: <20140110030354.GA19887@gmail.com>
References: <1389235158-21902-1-git-send-email-jackerran@gmail.com>
 <xmqqwqi8aph1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 10 04:04:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1SOC-0004a2-Nd
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jan 2014 04:04:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754378AbaAJDEA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jan 2014 22:04:00 -0500
Received: from mail-qa0-f42.google.com ([209.85.216.42]:54997 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318AbaAJDD7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jan 2014 22:03:59 -0500
Received: by mail-qa0-f42.google.com with SMTP id k4so1171639qaq.1
        for <git@vger.kernel.org>; Thu, 09 Jan 2014 19:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=U+pdhauQDZE6U1NDFI2DD7CnqpTydWIlwA8hqrht7Ak=;
        b=iOIeiDdcGSSZl7cbszR42EwSftZx20WtjIMKdrwu7KbuHi81JiNmKhw6UQPR7ciYsE
         IzhTU4sgFFwRiGDd4zhZi051VW+jWzPZcofll+u/e44Fw/TggsxUrHsJHexwtqMZOK5H
         F+c39//o7xs/nSK84B5H5ADU00RKThzA+j90LfLN9JpVke9k4uZIHaiK0GcZVVT7RYx8
         BFoJKxDtrhL+RDv6gthFB7oCeDvQunSKbdJcXP+oyGcqocjfJESmZnZtE5CpH97WEMW7
         0E7DJGbdIxjktZVJ5kpnUwsvpN9RuvlyiNoa94wdpkP7ypijQtmWaIIXtzx/NllO2fiT
         Ti/A==
X-Received: by 10.49.120.8 with SMTP id ky8mr2298756qeb.29.1389323038673;
        Thu, 09 Jan 2014 19:03:58 -0800 (PST)
Received: from gmail.com (24-197-19-70.static.leds.al.charter.com. [24.197.19.70])
        by mx.google.com with ESMTPSA id v10sm10648404qeh.14.2014.01.09.19.03.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jan 2014 19:03:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqqwqi8aph1.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240294>

On Thu, Jan 09, 2014 at 12:07:38PM -0800, Junio C Hamano wrote:
> 
> Having said all that, the difference between the full URL shown by
> "remote --verbose" (which is used to interact with the remote in
> this repository) and the abbreviated URL (which is shown by "fetch"
> and is designed to be sharable with others with a simple cut&paste)
> matters only when there are a pair of ambiguously configured
> repositories (e.g. there are two repositories "git://host/a.git/"
> and "git://host/a/.git") that serve different things and you are
> debugging the situation.  And to me, "remote --verbose" looks more
> or less a debugging aid, nothing more.  So another alternative that
> may be to leave everything as-is.
> 
> Thanks.

I like the alterantive option of "leave everything as-is", especially
after the arguments you've presented. There is still the problem of the
logic that has been duplicated. I think it should be put in a function,
but if you are ok with leaving it duplicated that is fine by me.

	if (raw_url)
		url = transport_anonymize_url(raw_url);
	else
		url = xstrdup("foreign");

	url_len = strlen(url);
	for (i = url_len - 1; url[i] == '/' && 0 <= i; i--)
		;
	url_len = i + 1;
	if (4 < i && !strncmp(".git", url + i - 3, 4))
		url_len = i - 3;

Thanks,
Tom Miller
