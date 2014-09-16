From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v5 22/35] git_config_set_multivar_in_file(): avoid call
 to rollback_lock_file()
Date: Tue, 16 Sep 2014 15:28:14 -0700
Message-ID: <20140916222814.GV29050@google.com>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
 <1410896036-12750-23-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Sep 17 00:28:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XU1EU-0002Mk-7L
	for gcvg-git-2@plane.gmane.org; Wed, 17 Sep 2014 00:28:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753689AbaIPW2S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 18:28:18 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:37752 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753092AbaIPW2R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2014 18:28:17 -0400
Received: by mail-pa0-f46.google.com with SMTP id kq14so707418pab.5
        for <git@vger.kernel.org>; Tue, 16 Sep 2014 15:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Jj5IUGPjXhH7Qj2gfZT9h9CiGwz6STxaS2hRc7/gFIM=;
        b=fGhcEc5KmAuE+5U7YGb5QV7sihZmMyE6kHjePeqJnUmKkogqZNuZi2IqsSUmImqyLS
         ndwZ+tKnxI1AkzTK/kvl8RfNKdYMkXecimbPstSoGHTGfhcnB/JW6a5OW+a9bMGXIyyn
         lphNAA0eYAd+Kgen6NdiWI6NAQ87abs2SCBDKlxRAMHU/DerlNIXS39flBhYG2DKbWUa
         NSXi/vhDUg8sbW6zvGQpz4XU5xQHjSsbF2WU7CtTm5n8JpF9W4ZP3SXLYKBd74VApCIn
         PaHTHGSfvawvcZfcZgrt6hz09VuKZka7i712FxBYqUTmOvd8BR4rkrSKXv1vR5ODoL5g
         uuig==
X-Received: by 10.70.129.106 with SMTP id nv10mr66635148pdb.24.1410906497204;
        Tue, 16 Sep 2014 15:28:17 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id dr5sm15067232pbb.24.2014.09.16.15.28.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 16 Sep 2014 15:28:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1410896036-12750-23-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257207>

Michael Haggerty wrote:

> After commit_lock_file() is called, then the lock_file object is
> necessarily either committed or rolled back.  So there is no need to
> call rollback_lock_file() again in either of these cases.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>

This seems to involve an unadvertised behavior change: before
it wouldn't call git_config_clear() on failure, and after the
patch it would.  Intended?

I think it would be clearer with the goto for exception handling
maintained (and just a second 'lock = NULL' assignment).
