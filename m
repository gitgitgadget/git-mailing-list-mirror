From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] push: Alias pushurl from push rewrites
Date: Wed, 27 Mar 2013 16:18:19 -0700
Message-ID: <20130327231819.GL28148@google.com>
References: <20130327122216.5de0c336@hoelz.ro>
 <20130327182345.GD28148@google.com>
 <20130327211554.GH28148@google.com>
 <7vsj3gjy3t.fsf@alter.siamese.dyndns.org>
 <20130327174845.5e3081d1@hoelz.ro>
 <20130327230943.GA5204@jtriplet-mobl1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rob Hoelz <rob@hoelz.ro>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
X-From: git-owner@vger.kernel.org Thu Mar 28 00:19:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKzcQ-00059E-7h
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 00:18:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754918Ab3C0XSY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 19:18:24 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:63753 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754897Ab3C0XSX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 19:18:23 -0400
Received: by mail-pd0-f177.google.com with SMTP id y14so3808351pdi.36
        for <git@vger.kernel.org>; Wed, 27 Mar 2013 16:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=blf9JFAiHkq5C4Jlmr1OFBu9zC/9yvC7O9v/QfFyvKk=;
        b=QOjncEer/+sUo6/VnxaPwO0PB0w4I4QLkIIYfBURPjKngSlIHK5RLiQ0q3j9M1cnrr
         UL4W741oO8qO4Iym8TbiHl3SrqpeRCm2ImoWn5qGhOfP35oFVrc603FrsHKUrGs8dRLt
         lE9AZryhXDeo849020NlANoqLDhZTLk+y9qGzx207O4SaRQjpNWIXvsaB+33DB/gQ5fl
         XERHPyVxRSoKcDWOhRD3YWaH8lx4MpEraVCnrZFuBGNVfPvaBfrZMQIaZ93Almh6gWSi
         EhXP5ZZDvXfJYXeD0VeBgTv/3/o7we2M/qGSstyyjh76Y38dai9/HsLxIRqKuuh1b6jY
         YVGw==
X-Received: by 10.68.244.1 with SMTP id xc1mr31313986pbc.165.1364426303500;
        Wed, 27 Mar 2013 16:18:23 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id ti8sm23037484pbc.12.2013.03.27.16.18.21
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 27 Mar 2013 16:18:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130327230943.GA5204@jtriplet-mobl1>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219358>

Josh Triplett wrote:

>                       I have a .gitconfig in my git-managed home
> directory which sets pushInsteadOf so that I can clone via git:// and
> immediately have working push.  I work with a number of systems that
> don't have inbound access to each other but do have outbound access to
> the network; on some of these "satellite" boxes, I can't push changes
> directly to the server pushInsteadOf points to, so I can explicitly set
> pushurl in .git/config for that repository, which overrides the
> pushInsteadOf.  This change would break that configuration.

Would it?  As long as your pushurl does not start with git://, I think
your configuration would still work fine.

After this patch, neither pushInsteadOf nor pushUrl overrides the
other one.  The rule is:

	1. First, get the URL from the remote's configuration, based
	   on whether you are fetching or pushing.

	   (At this step, in your setup git chooses the URL specified
	   with pushurl in your .git/config.)
	
	2. Next, apply the most appropriate url.*.insteadOf or
	   url.*.pushInsteadOf rule, based on whether you are fetching
	   or pushing.

	   (At this step, no rewrite rules apply, so the URL is used
	   as is.)
