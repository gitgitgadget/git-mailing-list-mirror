From: Tom Grennan <tmgrennan@gmail.com>
Subject: Re: [PATCHv2 1/4] refs: add common refname_match_patterns()
Date: Sat, 11 Feb 2012 11:17:48 -0800
Message-ID: <20120211191748.GC4903@tgrennan-laptop>
References: <1328926618-17167-1-git-send-email-tmgrennan@gmail.com>
 <1328926618-17167-2-git-send-email-tmgrennan@gmail.com>
 <4F3614F6.2000106@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: pclouds@gmail.com, git@vger.kernel.org, gitster@pobox.com,
	jasampler@gmail.com
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat Feb 11 20:18:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwISo-0007pb-E2
	for gcvg-git-2@plane.gmane.org; Sat, 11 Feb 2012 20:18:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754576Ab2BKTRy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Feb 2012 14:17:54 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:49497 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751367Ab2BKTRx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2012 14:17:53 -0500
Received: by vbjk17 with SMTP id k17so2400898vbj.19
        for <git@vger.kernel.org>; Sat, 11 Feb 2012 11:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=RukBrMZ25cicau4jLnWcmgMu0yCFD1vJPomok/Lfalo=;
        b=WMDqpdm9/dLyF1opgjp6DvTceegtCmbqRbeHJ1SBNArXTuqIbF5gvM3qesosH3y+fo
         Kr7BxgZgekxClhrkIW0i7I6eKU82rBWjvo17sCXz4NjKyXGGZjxevOkm+hLwXm7C2si9
         7GGETsTxRkcoZx4DN1AhVl1bf2r9OLGxJWt1g=
Received: by 10.220.224.136 with SMTP id io8mr5815755vcb.4.1328987872732;
        Sat, 11 Feb 2012 11:17:52 -0800 (PST)
Received: from localhost (c-98-207-169-74.hsd1.ca.comcast.net. [98.207.169.74])
        by mx.google.com with ESMTPS id ja6sm6633669vdb.0.2012.02.11.11.17.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 11 Feb 2012 11:17:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4F3614F6.2000106@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190530>

On Sat, Feb 11, 2012 at 08:12:54AM +0100, Michael Haggerty wrote:
>On 02/11/2012 03:16 AM, Tom Grennan wrote:
>> diff --git a/refs.h b/refs.h
>> index 00ba1e2..13015ba 100644
>> --- a/refs.h
>> +++ b/refs.h
>> @@ -152,4 +152,12 @@ int update_ref(const char *action, const char *refname,
>>  		const unsigned char *sha1, const unsigned char *oldval,
>>  		int flags, enum action_on_err onerr);
>>  
>> +/**
>> + * Returns:
>> + *   1 with NULL patterns
>> + *   0 if refname fnmatch()es any ! prefaced pattern
>> + *   1 if refname fnmatch()es any pattern
>> + */
>> +extern int refname_match_patterns(const char **patterns, const char *refname);
>> +
>>  #endif /* REFS_H */
>
>This comment is unclear and incomplete.
>
>1. What does "NULL patterns" mean?  Your code fails if patterns==NULL,
>so I guess you mean "1 if there are no patterns in the list".
>
>2. Since the three conditions are not mutually exclusive, you should say
>how they are connected.  I believe that you want something like "A
>otherwise B otherwise C".
>
>3. You haven't specified what happens if refname matches neither a
>!-prefixed pattern nor a non-!-prefixed pattern.  Does this behavior
>depend on which types of patterns were present in the list?
>
>I see that you have described the behavior more completely in the commit
>message for patch 2/4, but the commit message is not enough: this
>behavior should be described precisely in both code comments (when the
>function is defined) and in the user documentation (when the
>functionality is added to a command).

Yes, I didn't explicitly state that the precedence is the order written
and in correctly described the first case. How about?

/**
 * Returns in highest to lowest precedence:
 *   1 with an empty patterns list
 *   0 if refname fnmatch()es any ^ prefaced pattern
 *   1 if refname fnmatch()es any other pattern
 *   0 otherwise
 */

Thanks,
TomG
