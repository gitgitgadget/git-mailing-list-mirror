From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 8/8] reflog_expire(): lock symbolic refs themselves, not
 their referent
Date: Wed, 11 Feb 2015 15:25:38 -0800
Message-ID: <CAGZ79kaaQWRXhph=0g3SRHKXMoW8eAp7QG21yuWXWd7OW4M+uA@mail.gmail.com>
References: <1423473164-6011-1-git-send-email-mhagger@alum.mit.edu>
	<1423473164-6011-9-git-send-email-mhagger@alum.mit.edu>
	<CAGZ79kaBGAOt-R1=mSG5H-5p=2UWjZEesktVwQcDAWFC-OW2Eg@mail.gmail.com>
	<xmqq61b8t65x.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 00:25:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLgfA-0002sS-Kq
	for gcvg-git-2@plane.gmane.org; Thu, 12 Feb 2015 00:25:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753946AbbBKXZk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2015 18:25:40 -0500
Received: from mail-ie0-f176.google.com ([209.85.223.176]:37785 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753765AbbBKXZj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2015 18:25:39 -0500
Received: by iecrl12 with SMTP id rl12so5623421iec.4
        for <git@vger.kernel.org>; Wed, 11 Feb 2015 15:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=WMFFdnHlDZtsdEA8U23Zv2dBXh31toXyI5blKSF22Pg=;
        b=pAF7/mE0l329oOhfdlFGco6nEXNLGDmToEozKxbe1PpwNdteFgcbQIy8k7M/9UFQpv
         EJGLEsC+4SAOvRb2KGFhvBBz5xN9C9lSl2SrEvsXbQv+0pGomCUFZNH/9iMKOp3ya09E
         F4h9ENdc66Qxs42r33NIr9r7QfzDz2eN606MGnjLzJLrp84ABZP+4b7NjHNhRn0RbodX
         nbICMztKoqgEqhJQflVbLa+PxeHBcMcVyA9QzlDyBSMljZFjWGgZud2R5lXMOeypb+p2
         oLrkxemnXumJGwt4AXpxsjehIO51lM8YxQTFbcsfL3W3TiffW9sNr8cZRsjOTLRATGQe
         2vIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=WMFFdnHlDZtsdEA8U23Zv2dBXh31toXyI5blKSF22Pg=;
        b=D7QJD1VUiXlmwXr0+SLsEMQaapVA8jbrA3oWDHGUT8N+/dVp96WcTsFOK05jwzVDHy
         o8CBzmD0Jh1l0gCbo5i25eF0tN0cOg++4yXNHdMQafgXACrA6HzpRTFLp9Yot7cYphZX
         fcILGXHmhyrH5UMzCDwHMD6odfPnDUMvfMQYeqKUR+O6mUcE8LNrJCxfn0ZlPMJHjTj3
         7RE0Jv4GXipJ/shGz/RPIwzfDW01yqpiTczdHOPXg9CR5De8iMj7YDRbJat8KC3hUWqZ
         YlTcZUeXXheLU1QXOLjfyY+w6htcZrA1yQLTr5PHX2m42SmLJp1TSWVtcAXiOvNozpyh
         C2KA==
X-Gm-Message-State: ALoCoQnCLt4gyMbMax6PfPz7dfDnnepj0vvfZVJTY/UwBKoGaRkn8swL7o/MhWMEQJfE2QqzOqLA
X-Received: by 10.107.137.17 with SMTP id l17mr1329967iod.33.1423697139059;
 Wed, 11 Feb 2015 15:25:39 -0800 (PST)
Received: by 10.50.26.42 with HTTP; Wed, 11 Feb 2015 15:25:38 -0800 (PST)
In-Reply-To: <xmqq61b8t65x.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263700>

On Wed, Feb 11, 2015 at 2:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> On Mon, Feb 9, 2015 at 1:12 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>>> When processing the reflog of a symbolic ref, hold the lock on the
>>> symbolic reference itself, not on the reference that it points to.
>>
>> I am not sure if that makes sense.
>> So when expiring HEAD, you want to have a .git/HEAD.lock file
>> instead of a .git/refs/heads/master.lock file?
>>
>> What would happen if there is a concurrent modification
>> to the master branch?
>
> The HEAD may be pointing at 'master' and the other party that is
> trying to modify it would fail when it tries to update the reflog
> for HEAD thanks to HEAD.lock being held by us.  The HEAD may be
> pointing at 'next' and the other part that updates 'master' would
> not try to modify HEAD reflog and we do not conflict.
>
> At least, I think that is the rationale behind this change.

That makes sense! Do we have documentation on symrefs?

Originally I was wondering if this would make things
complicated for  symbolic branches which are not HEAD.
Then you could update the branch pointed to, because it
has no lock as the lock is on the symref. On the other hand
this seems to be an improvement, as you cannot move the
symref itself, as it has the lock and we don't really have other
symrefs?
