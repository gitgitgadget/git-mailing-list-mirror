From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 2/2] rev-parse: honor --quiet when asking for reflog
 dates that do not exist
Date: Thu, 18 Sep 2014 20:47:17 -0700
Message-ID: <20140919034715.GA26728@gmail.com>
References: <1410928530-21595-1-git-send-email-davvid@gmail.com>
 <1410928530-21595-2-git-send-email-davvid@gmail.com>
 <xmqqmw9wq54z.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jon Seymour <jon.seymour@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Fabian Ruch <bafain@gmail.com>, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 19 05:47:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XUpAF-0008Bz-2k
	for gcvg-git-2@plane.gmane.org; Fri, 19 Sep 2014 05:47:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756232AbaISDrP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2014 23:47:15 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:46177 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755615AbaISDrP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2014 23:47:15 -0400
Received: by mail-pa0-f41.google.com with SMTP id et14so2931629pad.14
        for <git@vger.kernel.org>; Thu, 18 Sep 2014 20:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=6EAvFPEp0MyaNs76gdGk3iHI5GRVdMAc3MEaNUAEt8g=;
        b=BI1LxV8WmOiSqaUA/glsd/yJY/7dPlyX1K1P+A8fKoYJ++PpE1EDfHTFeexJKqmB+1
         NpzD5DJy5MAvvP/shhE9cQ6OjpLhB7ugqResNzu3ICR11I4bQCWMlA65aU4FnzNF4Da6
         PKUkpmfr8MTUOhPVRTulf+0fxtKHcjPuIryuY8wOI32eiaoXmbVvMdfrzTFja6RQPq5g
         InWTAkyhGNYGquB1jrZuvn1PQbiS+0OyEnqq3Dqx9u+Ad6Mb/5KiwasWwPEji4YN++EQ
         8YpCVF/k8nCv2q6j+WXCJHDIIDHmLVUF3Mww4v93ACryWPD8tOumKoXk3fCfB1/g0phq
         zSPg==
X-Received: by 10.70.59.9 with SMTP id v9mr8076801pdq.83.1411098434648;
        Thu, 18 Sep 2014 20:47:14 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id nb4sm417555pdb.73.2014.09.18.20.47.13
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 18 Sep 2014 20:47:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqmw9wq54z.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257279>

On Thu, Sep 18, 2014 at 09:12:44AM -0700, Junio C Hamano wrote:
> David Aguilar <davvid@gmail.com> writes:
> 
> > @@ -514,8 +514,11 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1,
> >  
> >  	if (warn_ambiguous_refs &&
> >  	    (refs_found > 1 ||
> > -	     !get_short_sha1(str, len, tmp_sha1, GET_SHA1_QUIETLY)))
> > -		warning(warn_msg, len, str);
> > +	     !get_short_sha1(str, len, tmp_sha1, GET_SHA1_QUIETLY))) {
> > +		if (!(flags & GET_SHA1_QUIETLY)) {
> > +			warning(warn_msg, len, str);
> > +		}
> > +	}
> 
> Hmph, wouldn't it be simpler to read and understand if it were done
> this way instead?
> 
> -	if (warn_ambiguous_refs &&
> +	if (warn_ambiguous_refs && !(flags & GET_SHA1_QUIETLY) &&
>  	    (refs_found > 1 || !get_short_sha1(...)))
> 		waqrning(...);
> 

Yes, it would.

I squashed this patch into the original "make rev-parse --quiet actually quiet"
patch, along with your suggestions, and sent it as a replacement
patch for the commit in pu.
-- 
David
