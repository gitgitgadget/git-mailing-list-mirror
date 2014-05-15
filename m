From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v8 16/44] sequencer.c: use ref transactions for all ref
 updates
Date: Thu, 15 May 2014 14:53:07 -0700
Message-ID: <20140515215307.GO26471@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
 <1400174999-26786-17-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu May 15 23:53:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl3aW-0006PE-KK
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 23:53:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756137AbaEOVxM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 17:53:12 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:58287 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754031AbaEOVxK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 17:53:10 -0400
Received: by mail-pa0-f47.google.com with SMTP id lf10so1607742pab.20
        for <git@vger.kernel.org>; Thu, 15 May 2014 14:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=5Wku+UUtpk9SWobW/FipbsFV0e0hYlIqZFHMNtlLUwk=;
        b=0uGNb43ERX01trijDaL+hFpdyWaUvuYOsOq1sULvdM1gizQO84KMSFCdg/qjknMfhY
         byB7czBMGI8w9dZFQUwLSCeDbT5wP36T+GOaM7P4NP+BHw7JltR/SahkRnY9s1G86daV
         Pteu8Z9tKX2fGuE2urqeT5pwX8F7a2vZChaBz4gfzXbepMFfG88bPshnvpzH4L+RlL2A
         a0mzoFNIB9Zw5Qdb5xFqVWE/3DzIOhnCcjBnE+UA/swsMnDd6NvgD8H8j8MOM06FtoZp
         GLv0DjeRqID4kD+Odihe/TdPib0c5da3vY3eCzvMWJgRmAWepYAg5A8ZyKDlPX5Uhlpb
         YE0Q==
X-Received: by 10.68.202.74 with SMTP id kg10mr15376614pbc.163.1400190790391;
        Thu, 15 May 2014 14:53:10 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id el14sm25726663pac.31.2014.05.15.14.53.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 15 May 2014 14:53:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1400174999-26786-17-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249206>

Ronnie Sahlberg wrote:

> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -272,23 +272,31 @@ static int fast_forward_to(const unsigned char *to, const unsigned char *from,
[...]
> +		error(_("HEAD: Could not fast-forward: %s\n"), err.buf);

As with 'git commit', since err.buf already mentions that HEAD was the
problematic ref I think it has enough information for the user to
diagnose the problem and figure out what to do next.

		error("%s", err.buf);
