From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: [PATCH] Fix file mark handling and sort side-effects in git.el
Date: Wed, 11 Feb 2009 11:56:56 +0100
Message-ID: <87hc31kzrb.fsf@wine.dyndns.org>
References: <18834.27724.991388.339214@hungover.brentg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brent Goodrick <bgoodr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 11:58:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXCnc-0007e7-2m
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 11:58:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754496AbZBKK5K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 05:57:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752827AbZBKK5I
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 05:57:08 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:54415 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752645AbZBKK5H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 05:57:07 -0500
Received: from adsl-89-217-142-184.adslplus.ch ([89.217.142.184] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1LXCm2-0006pu-Tp; Wed, 11 Feb 2009 04:57:05 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 7A2BA1E7203; Wed, 11 Feb 2009 11:56:56 +0100 (CET)
In-Reply-To: <18834.27724.991388.339214@hungover.brentg.com> (Brent Goodrick's
	message of "Tue, 10 Feb 2009 22:12:28 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.90 (gnu/linux)
X-Spam-Score: -3.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109404>

Brent Goodrick <bgoodr@gmail.com> writes:

> The `sort' Elisp function works destructively, causing anomalies where
> operations on multiple files would be performed on one file.  This
> checkin works around that by doing a deep copy with `append'.

This shouldn't be necessary, it's OK for git-status-update-files to
destroy the list. If there are callers that want the list to be
preserved they should save it themselves.

> Also, git-add-file needed to pass 'modified to git-marked-files-state,
> as otherwise, files that are modified but not yet in the index would
> not show up in the git-marked-files-state return value, which would
> then cause a prompt for file to show up when the files are clearly
> marked in the status buffer.

Not sure what you mean here, it should not be possible for a file to be
in modified state but not in the index. If you mean using git-add-file
to do an update-index on an already tracked file, that's not what it's
meant to do.

-- 
Alexandre Julliard
julliard@winehq.org
