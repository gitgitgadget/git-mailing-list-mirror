From: Gregory Jefferis <jefferis@gmail.com>
Subject: Re: CRLF problems with Git on Win32
Date: Thu, 10 Jan 2008 21:28:15 +0000
Message-ID: <C3AC3E6F.10D42%jefferis@gmail.com>
References: <alpine.LFD.1.00.0801101208500.3148@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Steffen Prohaska <prohaska@zib.de>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jan 10 22:28:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JD4xE-00074b-Ti
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 22:28:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752402AbYAJV2V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 16:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752564AbYAJV2V
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 16:28:21 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:3798 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010AbYAJV2U (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2008 16:28:20 -0500
Received: by ug-out-1314.google.com with SMTP id z38so366143ugc.16
        for <git@vger.kernel.org>; Thu, 10 Jan 2008 13:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:user-agent:date:subject:from:to:cc:message-id:thread-topic:thread-index:in-reply-to:mime-version:content-type:content-transfer-encoding;
        bh=oum+38Ml/gnOpk/xGxgYryZW/FWecZEuoNGeGqKIL+0=;
        b=Ci8yPsXr3mOc8h4k7SdHDKwaStvOjYziJCL9xTuayQQnmOytS7T7knHfvuz5qD7p7a/Oi+1qCfnSfNVDSN1Tw72ECOcUQ/jTXv963cVQlEGr85T+61N18ar4x1VmTaCPm3YwpbWOkhTFb8IYXSvUgZCmu6+cnhM4pqZdYgrD66M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=user-agent:date:subject:from:to:cc:message-id:thread-topic:thread-index:in-reply-to:mime-version:content-type:content-transfer-encoding;
        b=OD0MpkVApfyrYICPsjMap2wM4Dnc4dui2J9FRFmWPZyhHeatOQGNdoJAd+278szg5GRGtVo2A1y97STly8Mgfmd76MGoPJ6Sza05gIrdrup0YuBvbBu8LK8Vujw65tgPWBZOjc4w+GDVXTF1JHrrcNGq8MCelsb1d96yyfRVr4k=
Received: by 10.67.23.5 with SMTP id a5mr3989413ugj.8.1200000499420;
        Thu, 10 Jan 2008 13:28:19 -0800 (PST)
Received: from ?131.111.101.105? ( [131.111.101.105])
        by mx.google.com with ESMTPS id u1sm8971645uge.14.2008.01.10.13.28.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Jan 2008 13:28:18 -0800 (PST)
User-Agent: Microsoft-Entourage/11.2.3.060209
Thread-Topic: CRLF problems with Git on Win32
Thread-Index: AchTz7WX9EwL5L/CEdyK5wAUURoPUg==
In-Reply-To: <alpine.LFD.1.00.0801101208500.3148@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70094>

On 10/1/08 20:20, "Linus Torvalds" <torvalds@linux-foundation.org> wrote:

>  - Mixed windows usage - either with other UNIX users, or even just
>    *within* a windows environment if *some* of the tools are basically
>    UNIX ports (ie MinGW or Cygwin without text-mounts)
> 
>    In this case, some tools will write files with CRLF, and others will
>    write them with LF. Again, usually all tools can *read* either form,
>    but the writing is mixed and depends on the tool (so if you work in a
>    group where different people use different editors, you will literally
>    switch back-and-forth between LF and CRLF, sometimes mixing the two in
>    the same file!).
> 
>    This one - at the very least - basically requires "autocrlf=input".
>    Anything else is just madness, because otherwise you'll get files that
>    get partly or entirely rewritten in the object database just due to
>    line ending changes.

So this is what has to be accommodated.  But instead of having autocrlf
always set on Windows and always converting to LF in the repository, why not
do nothing by default unless the repository contains some information
specifying that it wants some or all text files to have a particular kind of
line ending (e.g. in gitattributes).  Then the choice of line ending inside
the repository is up to the people creating/maintaining the repo, which just
seems right.  

Insisting that repos created on windows should have textfiles munged to LF
by default doesn't seem right.  Even using Dmitry's clever autocrlf=safe
option on Windows would lead to inconvenience since all LF files have to be
explicitly attributed as text.  We should be helping Windows people to use
LF files rather than hindering them!
