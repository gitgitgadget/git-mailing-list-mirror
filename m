From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 03/13] revert: Don't check lone argument in get_encoding
Date: Tue, 21 Jun 2011 11:03:06 -0500
Message-ID: <20110621160306.GH15461@elie>
References: <1308661489-20080-1-git-send-email-artagnon@gmail.com>
 <1308661489-20080-4-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 21 18:03:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZ3Q4-0002Fc-Cq
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 18:03:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753210Ab1FUQDM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 12:03:12 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:60010 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755153Ab1FUQDL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 12:03:11 -0400
Received: by iyb12 with SMTP id 12so2962894iyb.19
        for <git@vger.kernel.org>; Tue, 21 Jun 2011 09:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=YFo/l08aM24YxW85GebVZ6SElVqu8imATJMbwYv36xY=;
        b=L/snjpGkAX4GPD3WkNVCVh5xouoYzTtDA0eqZllNKR1Uj8Nc5LTwd+ObId5UFMMc4F
         S0KKjnx8vuVcnjIQYAOILp+6flTc0AMZNBn9pYLlxWagf20InKokinGMslZNLczJ45hK
         MFoExF75oyENQ/4Fomf/9V34/6oMAYJP2YbrY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=s3GK6dsOBvEpxk2/5FNVf5P3pPXa/Zc/UDZpH8qDrEDig4C+wdmDp0lfDmM45Y2kkK
         Qbm0nbCGg6oLQBvkOgq99/K7X3fY1fnn7nGZfVH5nQ49t+bAcn9pRB9d3dkVdUMlrqnV
         w7m3Hco3lsmqOQFcfmqKLmKiABk9OQNtWwkaY=
Received: by 10.42.131.65 with SMTP id y1mr7760704ics.172.1308672190318;
        Tue, 21 Jun 2011 09:03:10 -0700 (PDT)
Received: from elie (adsl-69-209-79-158.dsl.chcgil.ameritech.net [69.209.79.158])
        by mx.google.com with ESMTPS id ly7sm6888352icb.12.2011.06.21.09.03.08
        (version=SSLv3 cipher=OTHER);
        Tue, 21 Jun 2011 09:03:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1308661489-20080-4-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176166>

Ramkumar Ramachandra wrote:

> The get_encoding function has only one callsite, and its caller makes
> sure that a NULL argument isn't passed.  Don't unnecessarily double
> check the same argument in get_encoding.

Yes, this one's pretty good, though I suspect the actual reason for
the patch is not just dead code elimination.

The patch itself gives reason to be comfortable: the "while" loop
right after the removed "if" checks the value of *p immediately, so if
callers start passing NULL, it will be pretty obvious.

I suspect the actual motivation is to avoid access to the "commit"
global, in preparation for making it local.  A nice side-benefit is
removing a translated message.
