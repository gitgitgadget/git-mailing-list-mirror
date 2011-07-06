From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 11/14] revert: Introduce a layer of indirection over
 pick_commits
Date: Wed, 6 Jul 2011 05:37:34 -0500
Message-ID: <20110706103734.GL15682@elie>
References: <1309938868-2028-1-git-send-email-artagnon@gmail.com>
 <1309938868-2028-12-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 06 12:37:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QePUG-0005mt-O2
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 12:37:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752136Ab1GFKhk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 06:37:40 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:44767 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751927Ab1GFKhj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 06:37:39 -0400
Received: by iyb12 with SMTP id 12so5971481iyb.19
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 03:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=0Muyr/ZL2UsbwSPcC+1FkUe4RByT81thPizapzrvGaw=;
        b=bSLX218DHflF5yFtK8etuEVXd77E6mDVUtbNjFn3itfIYw1oNB4zl961EimmoHAiLB
         Z/E2OPClVGBbA7exo/vFRinjKHxUJvMAhBMLd2taswbdCC4F64F+vAYl+PDhstbzjtxF
         p4KE2Uuwxgt1frguCncI7qOotE2YC5C3HMQdc=
Received: by 10.42.163.138 with SMTP id c10mr4928772icy.269.1309948659003;
        Wed, 06 Jul 2011 03:37:39 -0700 (PDT)
Received: from elie (adsl-69-209-76-243.dsl.chcgil.sbcglobal.net [69.209.76.243])
        by mx.google.com with ESMTPS id j1sm4799013ibg.21.2011.07.06.03.37.37
        (version=SSLv3 cipher=OTHER);
        Wed, 06 Jul 2011 03:37:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1309938868-2028-12-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176683>

Ramkumar Ramachandra wrote:

> Write a new function called process_continuation to prepare a
> todo_list to call pick_commits with; the job of pick_commits is
> simplified into performing the tasks listed in todo_list.

Why is it called process_continuation?  What is its responsibility?
When would I call it?

> +	/*
> +	 * Decide what to do depending on the arguments; a fresh
> +	 * cherry-pick should be handled differently from an existing
> +	 * one that is being continued
> +	 */
> +	res = process_continuation(&opts);

Is this the new sole entry point to the cherry-pick/revert machinery?
In that case, I'd be mildly tempted to call it something crazy like
start_or_continue_replay(), and even more tempted to split it into
separate entry points for new_replay(), continue_replay(),
abort_replay(), and remove_replay_state() (but please don't trust me
about the names; this is just to get the idea across).
