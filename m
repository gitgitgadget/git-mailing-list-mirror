From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 09/24] refs.c: pass a list of names to skip to
 is_refname_available
Date: Fri, 3 Oct 2014 11:51:28 -0700
Message-ID: <20141003185128.GS1175@google.com>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>
 <CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
 <CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
 <CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
 <20140820231723.GF20185@google.com>
 <20140911030318.GD18279@google.com>
 <20141002014817.GS1175@google.com>
 <20141002020332.GB1175@google.com>
 <xmqq61g2nuud.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 03 20:51:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xa7x1-0003eM-UX
	for gcvg-git-2@plane.gmane.org; Fri, 03 Oct 2014 20:51:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753537AbaJCSvc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2014 14:51:32 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:58407 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751404AbaJCSvb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2014 14:51:31 -0400
Received: by mail-pd0-f169.google.com with SMTP id w10so57395pde.14
        for <git@vger.kernel.org>; Fri, 03 Oct 2014 11:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=0Uzd3vPU42alTKz3lmKlP7lU0er/LBzFApKTbhiK4L8=;
        b=yM03KVUrnDBnwixjvebV+CYD5/nE1MVvz2VAAd4n5g5xgnUwGmCz0J8xgyewqZHg52
         qZXsULYMYSiJhvDxcU8Ib/kAGV/dBlKeHUcKjvr+0lvHLYH95YlypJ0rZWxuwwKkH6c4
         F8Adzok0UFddGa/8H0YmPWIJoNRKhesq3tmaCMiyMDLjb5tPANtIxggCbsc4Ii7AVVJw
         xQ0uIlSnxU8pF498WdLgBO1PsTj6KLSMkHOr6lOHTa8vkDg8FYkP9y8Ca7CJv27zwFLm
         YdSxYVI5NaSdyMcGNHbYanriYeJ1TbjtRssfOBTYULft/I109ic4lAiso+ipFbT1fDbO
         n7TQ==
X-Received: by 10.70.134.98 with SMTP id pj2mr2571637pdb.65.1412362291161;
        Fri, 03 Oct 2014 11:51:31 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id po6sm6984706pbb.56.2014.10.03.11.51.30
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 03 Oct 2014 11:51:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqq61g2nuud.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257844>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> diff --git a/refs.c b/refs.c
>> index f124c2b..6820c93 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -801,14 +801,16 @@ static int names_conflict(const char *refname1, const char *refname2)
>> 
>>  struct name_conflict_cb {
>>  	const char *refname;
>> -	const char *oldrefname;
>>  	const char *conflicting_refname;
>> +	struct string_list *skiplist;
>>  };
>
> As cbe73331 (refs: speed up is_refname_available, 2014-09-10)
> touches the same area and is now in 'master', the logic around here
> in this series needs to be reworked.

Thanks for the heads up.  (I hadn't realized the ref-transaction-1 was
part of 'master' --- yay!)  Rebased and reworked:
https://code-review.googlesource.com/1027

I'll give a week or so for review comments on this version of the
series and then post a hopefully final version.
