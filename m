From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 0/3] rev-parse and "--"
Date: Fri, 6 Dec 2013 15:25:56 -0800
Message-ID: <20131206232556.GN29959@google.com>
References: <20131206211222.GB20482@sigill.intra.peff.net>
 <20131206211509.GB20536@sigill.intra.peff.net>
 <20131206220520.GA30652@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 07 00:26:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vp4mf-0002Qt-0c
	for gcvg-git-2@plane.gmane.org; Sat, 07 Dec 2013 00:26:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760095Ab3LFX0D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Dec 2013 18:26:03 -0500
Received: from mail-yh0-f45.google.com ([209.85.213.45]:36609 "EHLO
	mail-yh0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758915Ab3LFX0A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Dec 2013 18:26:00 -0500
Received: by mail-yh0-f45.google.com with SMTP id v1so1047473yhn.32
        for <git@vger.kernel.org>; Fri, 06 Dec 2013 15:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=taaGNiWkcAA0A9uHZgdjQJ+vlEKH7cdhsVqhI4kWP5o=;
        b=hIevZtGNJg2YnHncGr7paHHAyv60skkd8IVQ3Wa7octUDpw1ohHMHcScr/Q4Zf5Q6F
         FPgaMCy0BwiI+3SYTmjcScu/4thvrZ8k55JBd/Wf+FdLwxfBqttIJXj2TLeLdF6x63qT
         eP9gQD1SZQYXupiZJJHS5tnGJvb4jK5LfaKN4tPTviGDbVqjoKE5lRD37Egm6qszKkPP
         K7ppsPtSNRwUTXkWwOTKJEXedX/5c91vegRZNg75J4qPmbDH6e5HUbGmABSLtqvFeaBD
         ATvYQ2RoaCneM+4t+J6E4CdvD7MX4UVdeJi1LeRTzDhJVv0iKgO1Wahy4PZ1xt+Ziofx
         zX8g==
X-Received: by 10.236.38.129 with SMTP id a1mr4288270yhb.137.1386372359685;
        Fri, 06 Dec 2013 15:25:59 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id r98sm273440yhp.3.2013.12.06.15.25.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 06 Dec 2013 15:25:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131206220520.GA30652@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238963>

Jeff King wrote:

> Patch 3 is the revised version of this patch which notices ambiguity.
> However, I'm having second thoughts on it. I think it's the right thing
> to do if you want to help people build something like "git log"
> themselves. But it does mean that we are breaking somebody who does:
>
>   echo foo >HEAD
>   commit=$(git rev-parse HEAD)
>
> I'm tempted to say that people who did that are stupid and wrong (and
> ugly, too). They should probably be using "--verify" in this case. But
> it has been that way for a long time, and there are two instances in our
> test scripts that are broken by the patch.

Wouldn't the same thing happen for $(git rev-parse HEAD^..HEAD) when
there is a 'HEAD^..HEAD' file, too?  --verify doesn't support that.

I think it's a nice idea to provide this functionality for people who
need it, which would mean protected by an option (--check-ambiguity or
something).  I don't think it's a good change to do it
unconditionally.

My two cents,
Jonathan
