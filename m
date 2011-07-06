From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 13/14] revert: Introduce --continue to continue the
 operation
Date: Wed, 6 Jul 2011 05:25:09 -0500
Message-ID: <20110706102509.GJ15682@elie>
References: <1309938868-2028-1-git-send-email-artagnon@gmail.com>
 <1309938868-2028-14-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 06 12:27:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QePKi-0001pi-ET
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 12:27:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751840Ab1GFKZQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 06:25:16 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:51311 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955Ab1GFKZP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 06:25:15 -0400
Received: by iyb12 with SMTP id 12so5964747iyb.19
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 03:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=qUZruImimNhjS2Cr8IBDAxZKcOnko/ECmOo8OFbj1WY=;
        b=O0NVJd0yylFub5tA4ErdIG3izUKsYf9Y2iYKnHUPI3SobaRtyScVuBdmZc3sC3OnGz
         u6L9a733cfQfA4iaLnmj9vI8csrrXVVz3sjyEVsyJZBA1gncvRx0G9nct4t3GIe9Qnbg
         uuGnnKnbkiORwAjzteTOgkpsNSNeVy7XbNF7A=
Received: by 10.231.61.198 with SMTP id u6mr7364140ibh.160.1309947914799;
        Wed, 06 Jul 2011 03:25:14 -0700 (PDT)
Received: from elie (adsl-69-209-76-243.dsl.chcgil.sbcglobal.net [69.209.76.243])
        by mx.google.com with ESMTPS id m18sm791747ibc.28.2011.07.06.03.25.11
        (version=SSLv3 cipher=OTHER);
        Wed, 06 Jul 2011 03:25:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1309938868-2028-14-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176681>

Ramkumar Ramachandra wrote:

> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -47,6 +47,7 @@ struct replay_opts {
>  	enum replay_action action;
>
>  	int reset;
> +	int contin;

Maybe:

	int just_remove_state;
	int resume;
	int abort;

Or:

	enum replay_subcommand {
		REPLAY_RESET,
		REPLAY_CONTINUE,
		REPLAY_ABORT
	};

	enum replay_subcommand subcommand;

Or perhaps this does not need to be part of the replay_opts struct but
can be communicated by which API function gets called (e.g., via
parse_args returning an "enum replay_subcommand").  I dunno.
