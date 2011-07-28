From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 15/18] reset: Make reset remove the sequencer state
Date: Thu, 28 Jul 2011 17:59:29 +0200
Message-ID: <20110728155929.GD22950@elie.dc0b.debconf.org>
References: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
 <1311736755-24205-16-git-send-email-artagnon@gmail.com>
 <20110727051612.GJ18470@elie>
 <CALkWK0=eh2MRqc1tW3rcPYAF3YLQnXanTZd9kzGdWBpJVcB01w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 28 17:59:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmSzw-0005E3-6Q
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 17:59:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755370Ab1G1P7g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 11:59:36 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37869 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754980Ab1G1P7f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 11:59:35 -0400
Received: by fxh19 with SMTP id 19so1392142fxh.19
        for <git@vger.kernel.org>; Thu, 28 Jul 2011 08:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ZNWiWW/KmRe+bp/0EMlsKF0tTv7N4wRd2ugwslUp0x8=;
        b=WggRWSl+ekWRiHms7zUH/aBc71z8VJ3KUj6Y6G1hKmD4mhBei2rY/MZ0J0mF75Lkrm
         NDRsjmTFnfTnfjpidRBhkQ8sxBxv1Zng5PRaJn8ROdX7+lkZnN7WbQMXPusFlrNOj3vy
         AGTS21qH50SqTblheefmdQIuSLhsD+qBwhfUo=
Received: by 10.223.17.141 with SMTP id s13mr256909faa.7.1311868774233;
        Thu, 28 Jul 2011 08:59:34 -0700 (PDT)
Received: from elie.dc0b.debconf.org ([78.28.140.4])
        by mx.google.com with ESMTPS id 28sm555361fax.3.2011.07.28.08.59.32
        (version=SSLv3 cipher=OTHER);
        Thu, 28 Jul 2011 08:59:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0=eh2MRqc1tW3rcPYAF3YLQnXanTZd9kzGdWBpJVcB01w@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178073>

Ramkumar Ramachandra wrote:

> I'm curious: doesn't this also apply to "rebase -i" and other scripts
> that attempt to remove the branch state through "reset"?

It starts by detaching HEAD.  So, just like after a conflicted "git
merge", I think typically it will write

	error: you need to resolve your current index first

But that doesn't help when there are no unmerged index entries; good
catch.

Maybe merge_working_tree() should ask the sequencer API whether there
is something untoward in progress so "git checkout" without "-f" can
know to bail out.
