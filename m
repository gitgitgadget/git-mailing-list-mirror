From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v5 19/35] commit_lock_file(): rollback lock file on
 failure to rename
Date: Tue, 16 Sep 2014 15:22:08 -0700
Message-ID: <20140916222207.GS29050@google.com>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
 <1410896036-12750-20-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Sep 17 00:22:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XU18a-0000OX-74
	for gcvg-git-2@plane.gmane.org; Wed, 17 Sep 2014 00:22:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753708AbaIPWWM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 18:22:12 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:37840 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753316AbaIPWWL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2014 18:22:11 -0400
Received: by mail-pd0-f180.google.com with SMTP id ft15so691182pdb.39
        for <git@vger.kernel.org>; Tue, 16 Sep 2014 15:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=6lsy0u55jfGfaVq3wdZ+O6tm/G0PIg3RU3/MkjRlL6A=;
        b=DNA5R10kE7KbIEm5B6UP2gwi41xYBFG+GbQL4P9Jm5DntN4OOwiGxNK0xJtCCZPOQE
         DF/iHrOUW7bvImKT5/TyXP3a7IlUn5YkIU1a+TtJcasfvD4Y5KOAt//T3l73PD2ivZ4C
         S2SXDWYhF5hJyWhD+o41kUFVcMvx5OszpCFKxjmU2sV/repHCDgdIgZUCgdI5/FzD2Qy
         M1cgxSjvraUagAIOl61K+NEJsX86RSu0hrIndzqAE57MHKYm190+wYiDaIPXCeQJNz5J
         DXYYOwWUV3fg79K0CKp+wuthMR5Nzz2kaTnw8BmzOX64ZiTWmspaPKKn4xlVfx/Dr4I8
         g7yA==
X-Received: by 10.67.1.99 with SMTP id bf3mr53040246pad.110.1410906130920;
        Tue, 16 Sep 2014 15:22:10 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id cz1sm5548007pdb.85.2014.09.16.15.22.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 16 Sep 2014 15:22:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1410896036-12750-20-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257203>

Michael Haggerty wrote:

> If rename() fails, call rollback_lock_file() to delete the lock file
> (in case it is still present) and reset the filename field to the
> empty string so that the lockfile object is left in a valid state.

Can you spell out more what the goal is?  Is the idea to keep the
.lock file for a shorter period of time, so other processes can lock
that file before the current process exits?
