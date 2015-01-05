From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv10 02/10] receive-pack.c: die instead of error in
 assure_connectivity_checked
Date: Mon, 5 Jan 2015 13:25:23 -0800
Message-ID: <20150105212523.GN29365@google.com>
References: <CAGZ79ka8TMvF1s=ZL=4Lj1EaDrLVn8HRA2PR4JLAHWasHmvkFA@mail.gmail.com>
 <1420482355-24995-1-git-send-email-sbeller@google.com>
 <1420482355-24995-2-git-send-email-sbeller@google.com>
 <20150105201728.GK29365@google.com>
 <CAGZ79kZUiwEbcSPk3Td60umixvh_Q7jXTGoLemKLYsvX1ty39w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	ronnie sahlberg <ronniesahlberg@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Jan 05 22:25:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8F9d-0003CA-Ia
	for gcvg-git-2@plane.gmane.org; Mon, 05 Jan 2015 22:25:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754432AbbAEVZb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2015 16:25:31 -0500
Received: from mail-ie0-f173.google.com ([209.85.223.173]:35424 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753400AbbAEVZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jan 2015 16:25:26 -0500
Received: by mail-ie0-f173.google.com with SMTP id y20so20355996ier.18
        for <git@vger.kernel.org>; Mon, 05 Jan 2015 13:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=S0RK2QKNlfP43EFq+XJ+BbRAEziD46nwrHFrHt5r0R4=;
        b=cflVBa/L8xwDGiv/yQE+GIsPB1nrptLnBgwBAmqTRj8jwfV6u95RrGMYqpYqQznelX
         kWYVtp165pp/PNHU7oJEisG79w8fEGFj1sxfVMi5hlDXK0tXOaf5mvL1hT1n0uHxw3id
         BeS2rBzgDhBE7bgr+DCiw4q5uRd1EVEHl813IHi37kivXfghRFd8cP93JRrnzVEFOszo
         rh2JTHXl2GjaCCfQs2Owow9eRSOYDU8z8DtDVMqGQQ7H3ZZsMRdZHP2za0o3vdlp/5JT
         EDzAxcdI/QpGCnfokUIoTS1mmSNnfNDlIBmRhP/TxT19daoalqyKGaNqiw96DCQp/hJA
         2Nqg==
X-Received: by 10.43.106.147 with SMTP id du19mr57710131icc.22.1420493126252;
        Mon, 05 Jan 2015 13:25:26 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:cbe:c7db:3064:452c])
        by mx.google.com with ESMTPSA id qj3sm4097003igc.17.2015.01.05.13.25.25
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 05 Jan 2015 13:25:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAGZ79kZUiwEbcSPk3Td60umixvh_Q7jXTGoLemKLYsvX1ty39w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262037>

Stefan Beller wrote:

> Maybe we should do both?
>
>     die ("BUG: Some refs have not been checked for connectivity."
>           "Please contact the git developers (git@vger.kernel.org) and"
>           "report the problem. As a workaround run 'git fsck'. If there"
>           "are errors, try to remove the reported refs above. (This "
>           "may lead to data loss, backup first.)"

I personally find this kind of message grating when I run into it.
The message is trying to tell me what to do, but it is not in a
position to know what the best thing to do is.

It could be that I am using an ancient version of git with known bugs.
In that case I should upgrade.

It could be that I am using faulty hardware that flips random bits and
confuses software.

It could be that I have a patched version of git, in which case I should
contact the author of my patch instead of git@vger.kernel.org.

It could be that this is a recent, terrible regression and
git@vger.kernel.org is already bombarded with reports about it.

If the message says

	fatal: BUG: connectivity check skipped???

then it has exactly the right amount of information to tell me what to
do.  Now I have

 - a short string to grep for in the source code (or on the web) to
   find out what happened

 - a clear indication that This Can't Happen, so I know to try to
   reproduce it and contact the author of my patched git or upstream
   or whoever, depending on the context

 - no irrelevant guesses to confuse me

The workaround of running 'git fsck' could be actively harmful,
depending on what the bug is.  All that we know is that a bug has
occured and we shouldn't proceed further.

> Just thinking out loud:
[...]
>                  Would it make sense to have an extra die_bug function,

Yes, I think something like the kernel's BUG_ON and WARN_ON would be
very nice (though orthogonal to this change).

Thanks,
Jonathan
