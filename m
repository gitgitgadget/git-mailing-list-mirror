From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v6 08/42] refs.c: change ref_transaction_update() to do
 error checking and return status
Date: Wed, 14 May 2014 16:40:15 -0700
Message-ID: <20140514234015.GE9218@google.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
 <1398976662-6962-9-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu May 15 01:40:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wkimc-0005kg-Vf
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 01:40:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752334AbaENXkT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 19:40:19 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:35969 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750973AbaENXkS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 19:40:18 -0400
Received: by mail-pb0-f45.google.com with SMTP id um1so246598pbc.32
        for <git@vger.kernel.org>; Wed, 14 May 2014 16:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=EYP2Xs3Nxu82TxCh/vGvNEyqg5NYb2MC68ZQa/DCP2s=;
        b=FF1PMSKBYHRUiIYrsXAE0JQk8QYyvpt61x9AQ1EnlOkps6uxRtQsJNjUz9rLxh6FJ0
         Bo3BiiwA4NRNDTeNnd6UIFjOOzD3KK5GJho4n+8WzptgL+Xd0M4Kl9T73m+Rn8zA64tZ
         YamdqteusCSnpdkvlEdZrMc1pEvpGSH06U4snY/hivEi8UqZGfRTxQKsOcxMtEBD2E/6
         Wrx6TNX27mM/LoqaBjkhxEAyqx02rDIoyXh5do2n6BnFQDRndUWXirO6XtQcsnzKxnwn
         uShrek/1aB4u93zrH72eyjD2SrbZMC4DhlQLQPRRDxh0ZwWup2PZg00k/FkiY145ljCO
         mgnA==
X-Received: by 10.68.222.105 with SMTP id ql9mr8163533pbc.4.1400110818253;
        Wed, 14 May 2014 16:40:18 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id be7sm13400087pad.9.2014.05.14.16.40.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 14 May 2014 16:40:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1398976662-6962-9-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249049>

Ronnie Sahlberg wrote:

> Update ref_transaction_update() do some basic error checking and return
> true on error. Update all callers to check ref_transaction_update() for error.
> There are currently no conditions in _update that will return error but there
> will be in the future.
>
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  builtin/update-ref.c | 10 ++++++----
>  refs.c               |  9 +++++++--
>  refs.h               | 10 +++++-----
>  3 files changed, 18 insertions(+), 11 deletions(-)

Revisiting comments from [1]:

 * When I call ref_transaction_update, what does it mean that I get
   a nonzero return value?  Does it mean the _update failed and had
   no effect?  What will I want to do next: should I try again or
   print an error and exit?

   Ideally I should be able to answer these questions by reading
   the signature of ref_transaction_update and the comment documenting
   it.  The comment doesn't say anything about what errors
   mean here.

 * the error message change for the have_old && !old_sha1 case (to add
   "BUG:" so users know the impossible has happened and translators
   know not to bother with it) seems to have snuck ahead into patch 28
   (refs.c: add transaction.status and track OPEN/CLOSED/ERROR).

 * It would be easier to make sense of the error path (does the error
   message have enough information?  Will the user be bewildered?)
   if there were an example of how ref_transaction_update can fail.

   There still doesn't seem to be one by the end of the series.

The general idea still seems sensible.

Thanks,
Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/246437/focus=247115
