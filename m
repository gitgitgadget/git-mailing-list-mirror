From: Benny Halevy <bhalevy@panasas.com>
Subject: Re: Are these bugs?
Date: Thu, 28 Aug 2008 11:44:08 +0300
Message-ID: <48B66558.8010607@gmail.com>
References: <76718490808271636i4de8f385pdaeb1672f06a00d7@mail.gmail.com> <7v1w0akolk.fsf@gitster.siamese.dyndns.org> <20080828010458.GE12354@leksak.fem-net> <7vwsi2j5q6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Stephan Beyer <s-beyer@gmx.net>,
	Jay Soffian <jaysoffian@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 10:45:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYd83-0000Bl-UM
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 10:45:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbYH1IoP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 04:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbYH1IoO
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 04:44:14 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:35701 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709AbYH1IoN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 04:44:13 -0400
Received: by ug-out-1314.google.com with SMTP id c2so1095762ugf.37
        for <git@vger.kernel.org>; Thu, 28 Aug 2008 01:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from:sender;
        bh=KUdlGyKgXSHkQKsT9DOesim1U9JtRJ+dcYQT11Vtrcg=;
        b=h0BC0326l7kHwBiyAvPH5jgzREb/aHzJj4ZgjhVduBinpK2i6GINFwbVycuVp3cb3p
         vgRvZx+7OsR0xJmK1fBGrGy9EuHxFgaatTE+NxN7RhZNSZal4eiNlC/USAmKOjK+rsGA
         l6LqKIvRw8s4AAkjWWEVRODRNlJkKcEmcuW6s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from:sender;
        b=KS08OQ0w51wUR2GsRKzZMtxOosAp6A8ufmaGmCXxfvvj3MW4Ddu7ZJ/eE7U3rFzq6K
         AKakE+hKqB2sISjbEYTvFfLOUnKfPK3QYqKMY/vLiyNag6GeX8nHHTDDsUVQVrKc7N/+
         gPvA/wbLpobbkAQffO45EEbJL8QvkB6hyOQT0=
Received: by 10.67.29.4 with SMTP id g4mr3049266ugj.73.1219913051815;
        Thu, 28 Aug 2008 01:44:11 -0700 (PDT)
Received: from fs1.bhalevy.com ( [212.235.53.3])
        by mx.google.com with ESMTPS id q1sm5001243uge.16.2008.08.28.01.44.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Aug 2008 01:44:11 -0700 (PDT)
User-Agent: Thunderbird 3.0a1 (X11/2008050714)
In-Reply-To: <7vwsi2j5q6.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Aug. 28, 2008, 4:20 +0300, Junio C Hamano <gitster@pobox.com> wrote:
> Stephan Beyer <s-beyer@gmx.net> writes:
> 
>> Junio C Hamano wrote:
>>
>>> "Jay Soffian" <jaysoffian@gmail.com> writes:
>>>
>>>> I understand why "git reset" failed, but at best the error message is
>>>> confusing to a new user.
>>> This is in "patches welcome" category.
>> <noise>
>> But I still think it's stupid.
>> </noise>
> 
> Yes I think it is stupid.  The dummy commit does not change the fact that
> you need to special case it anyway, and special casing you can do without
> the dummy commit that will contaminate the history.  We already have such
> special case for "log -p" (--root used to be optional).  If rebasing onto
> emptiness is problematic, the command should be taught how.
> 
>> So, for a patch, is it sane to just remove/clear the index
>> if get_sha1("HEAD", sha1) fails?
> 
> As a general idea, yes, but details matter.
> 
> If the user says "git reset [--hard/--soft/--mixed] HEAD" from the command
> line, we should say "You do not even have HEAD commit".  If "git reset"
> deduced (incorrectly) that the user meant HEAD, and only in that case, we
> should clear the index.

I'm really not sure about the details, but providing a way to refer
to the empty state of the tree is needed.  For example, I don't know
how to do an interactive rebase of all commits in my tree, or to rebase
a sub-series starting at "INIT" (or "NIL" or whatever :) onto some
other base (say some remote branch).

Benny

> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
