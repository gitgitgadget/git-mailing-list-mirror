From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Ideas to speed up repacking
Date: Tue, 3 Dec 2013 17:17:57 +0700
Message-ID: <CACsJy8CBOp_5nwm=WWBG_AZ+h6M7L6WpdX4ACeJxwuJ0kqu0Gw@mail.gmail.com>
References: <201312021630.45767.mfick@codeaurora.org> <xmqqpppepxuu.fsf@gitster.dls.corp.google.com>
 <CACsJy8DJU2YTE1iNdb=fvo0fVOgLUK2mKXUhjcoJh8Ac0wW_EA@mail.gmail.com> <xmqqli02pfnf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Martin Fick <mfick@codeaurora.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 03 11:18:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vnn3r-0003CP-J6
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 11:18:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141Ab3LCKSc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Dec 2013 05:18:32 -0500
Received: from mail-qa0-f52.google.com ([209.85.216.52]:35151 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438Ab3LCKS2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Dec 2013 05:18:28 -0500
Received: by mail-qa0-f52.google.com with SMTP id k4so5459484qaq.11
        for <git@vger.kernel.org>; Tue, 03 Dec 2013 02:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=2URjqzVOET7u476qVO6fnDSap4zVB3V0UehR6Q05Buk=;
        b=TiPesAjzxcFyGrVa4KayuiHaX1UXnkb5xthofhEWgmlkJuXtW0hdgpYF2kQErx3DVc
         VpfHNMqpWLwMg1wJSvsHda+i1BWkLeQdXjyUoybAJF4VtY1PFplx59q942PfcdqHzl/0
         RG+lgRd3l7QHd+6NfevXmfUnuxSFzBIO1NcShQNCNKTQnUfBaB30vPe+WENiEBXvtSFP
         rSNDg+ZmRcKt6WDbW77Wej7wLNLY6GA1+9jeL+OH28JAmoOPw8UpYnZq7pqD3aqW144N
         d6XvF5YGGSYUifn2W/UucrPahE0IDtK6uZWuGXX0IVuKLFQPqc529cbzMmEs708rHpkz
         LG9w==
X-Received: by 10.224.136.136 with SMTP id r8mr96763887qat.0.1386065907771;
 Tue, 03 Dec 2013 02:18:27 -0800 (PST)
Received: by 10.96.124.101 with HTTP; Tue, 3 Dec 2013 02:17:57 -0800 (PST)
In-Reply-To: <xmqqli02pfnf.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238683>

On Tue, Dec 3, 2013 at 2:17 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>>> If nothing else has happened in the repository, perhaps, but I
>>> suspect that the real problem is how you would prove it.  For
>>> example, I am guessing that your Scenario 4 could be something like:
>>>
>>>     : setup #1
>>>     $ git repack -a -d -f
>>>     $ git prune
>>>
>>>     : scenario #4
>>>     $ git commit --allow-empty -m 'new commit'
>>>
>>> which would add a single loose object to the repository, advancing
>>> the current branch ref by one commit, fast-forwarding relative to
>>> the state you were in after setup #1.
>>>
>>> But how would you efficiently prove that it was the only thing that
>>> happened?
>>
>> Shawn mentioned elsewhere that we could generate bundle header in and
>> keep it in pack-XXX.bh file at pack creation time. With that
>> information we could verify if a ref has been reset, just fast
>> forwarded or even deleted.
>
> With what information? If you keep the back-then-current information
> and nothing else, how would you differentiate between the simple
> scenario #4 above vs 'lost and new' two commit versions of the
> scenario?  The endpoints should both show that one ref (and only one
> ref) advanced by one commit, but one has cruft in the object
> database while the other does not.

Yeah I was wrong. Reading Martin's mail again I wonder how we just
"grab all objects and skip history traversal". Who will decide object
order in the new pack if we don't traverse history and collect path
information.
-- 
Duy
