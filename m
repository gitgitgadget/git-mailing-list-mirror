From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 09/14] imap-send.c: remove namespace fields from struct
 imap
Date: Sun, 13 Jan 2013 22:43:47 -0800
Message-ID: <20130114064347.GH3125@elie.Belkin>
References: <1358141566-26081-1-git-send-email-mhagger@alum.mit.edu>
 <1358141566-26081-10-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jan 14 07:45:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tudnp-0001zu-CB
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 07:45:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751697Ab3ANGnx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 01:43:53 -0500
Received: from mail-da0-f43.google.com ([209.85.210.43]:57885 "EHLO
	mail-da0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204Ab3ANGnx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 01:43:53 -0500
Received: by mail-da0-f43.google.com with SMTP id u36so1680606dak.16
        for <git@vger.kernel.org>; Sun, 13 Jan 2013 22:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=+3viM62Kmqb92weUF9mHhaLsFypYSYbvVRlgkfjT8k4=;
        b=Gv1lTFys1XWBZGQahXPoIUxgDSyGenJkcPKj2o3GoOsoHa017EuYpSKVhZIfgBXCzS
         MaHMsnrom4eH6Yz6Iepzqr73YoGA/USvLU4KIrMT3QNspNG9N1fEPOclZKLL5yUT3n6i
         dh4MpsMnCNwzenAhh8vr+4sdJg/SsfRRut9TdsmX55pRKIM115WjDkYzjvXGWFRNE7De
         WEGy43fIqnzgxNjz+iR08fgX12nXRv7XkNWFy2Bia4amOiosBZh/QRihj9SoO+Qa4cAF
         Me/35GPDenpaWDEeIESbBFsKNz+39gAXXY7LJysgUp2h8lAYvBkmrkMzzl3C+2L0ChPg
         vg8w==
X-Received: by 10.68.242.134 with SMTP id wq6mr81706822pbc.146.1358145832468;
        Sun, 13 Jan 2013 22:43:52 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id ho4sm7658889pbc.54.2013.01.13.22.43.50
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 13 Jan 2013 22:43:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1358141566-26081-10-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213453>

Michael Haggerty wrote:

[...]
> @@ -722,9 +667,9 @@ static int get_cmd_result(struct imap_store *ctx, struct imap_cmd *tcmd)
>  			}
>  
>  			if (!strcmp("NAMESPACE", arg)) {
> -				imap->ns_personal = parse_list(&cmd);
> -				imap->ns_other = parse_list(&cmd);
> -				imap->ns_shared = parse_list(&cmd);
> +				skip_list(&cmd);
> +				skip_list(&cmd);
> +				skip_list(&cmd);

This codepath would only be triggered if we emit a NAMESPACE command,
right?  If I am understanding correctly, a comment could make this
less mystifying:

				/* rfc2342 NAMESPACE response. */
				skip_list(&cmd);	/* Personal mailboxes */
				skip_list(&cmd);	/* Others' mailboxes */
				skip_list(&cmd);	/* Shared mailboxes */

Though that's probably academic since hopefully this if branch
will die soon. :)

The rest of the patch is clear and pleasant and also looks correct.

With the above change,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
