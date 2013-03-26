From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 10/9] clone: leave repo in place after checkout errors
Date: Tue, 26 Mar 2013 15:32:59 -0700
Message-ID: <20130326223259.GA28148@google.com>
References: <20130325201427.GA15798@sigill.intra.peff.net>
 <20130325202359.GH16019@sigill.intra.peff.net>
 <7vtxnxsuty.fsf@alter.siamese.dyndns.org>
 <20130326222209.GA16457@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 26 23:33:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKcQz-000860-Lf
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 23:33:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753469Ab3CZWdJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 18:33:09 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:65220 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753336Ab3CZWdI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 18:33:08 -0400
Received: by mail-pa0-f51.google.com with SMTP id jh10so1203801pab.38
        for <git@vger.kernel.org>; Tue, 26 Mar 2013 15:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=2nB/oX3TQ3YyCET05I1VONBOompnG2yhNLBBtavDs3Q=;
        b=aHOl1qUYzYFCl8y8hmcDBGW+o24+MzBMNHX41BCEFI22KxTOmdXcZj+MkHi8d9rERJ
         CzhGEnLuiL71vLCXpBRcVvSmk8GRVmKVWkeqs3y5dMfe7xvsAc3Lq75TTCaiUhdQ3n4w
         l/JA1HiCFw9zfQHeq3snBlyI2XPRnBkW0VGOKbdgJnHGmghY9UCaiTxv9Oa5MG9gUnHz
         c8ZOV74xl1hE7RcDIpjyF4WT+EC9LT9Lq3/BAXCk2u7WFae5JG5qYGHZj4HBjYVgUPA0
         ublVS16Gt4bKybVkFjIWm1bugnekFFDcQzHS95raVuXk9F17bg0bQToopJkhH5/U4O06
         iB4Q==
X-Received: by 10.68.238.103 with SMTP id vj7mr25621300pbc.181.1364337187832;
        Tue, 26 Mar 2013 15:33:07 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id ip8sm18906104pbc.39.2013.03.26.15.33.05
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 26 Mar 2013 15:33:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130326222209.GA16457@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219225>

Jeff King wrote:

> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -377,10 +377,40 @@ static void remove_junk(void)
>  static const char *junk_work_tree;
>  static const char *junk_git_dir;
>  static pid_t junk_pid;
> +enum {
> +	JUNK_LEAVE_NONE,
> +	JUNK_LEAVE_REPO,
> +	JUNK_LEAVE_ALL
> +} junk_mode = JUNK_LEAVE_NONE;

Neat.

> +
> +static const char junk_leave_repo_msg[] =
> +N_("The remote repository was cloned successfully, but there was\n"
> +   "an error checking out the HEAD branch. The repository has been left in\n"
> +   "place but the working tree may be in an inconsistent state. You can\n"
> +   "can inspect the contents with:\n"
> +   "\n"
> +   "    git status\n"
> +   "\n"
> +   "and retry the checkout with\n"
> +   "\n"
> +   "    git checkout -f HEAD\n"
> +   "\n");

Can this be made more precise?  I don't know what it means for the
working tree to be in an inconsistent state: do you mean that some files
might be partially checked out or not have been checked out at all yet?

	error: Clone succeeded, but checkout failed.
	hint: You can inspect what was checked out with "git status".
	hint: To retry the checkout, run "git checkout -f HEAD".

Aside from that, this looks very nice.

Thanks,
Jonathan
