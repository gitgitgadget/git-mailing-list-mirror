From: Gregory Jefferis <jefferis@gmail.com>
Subject: Re: CRLF problems with Git on Win32
Date: Thu, 10 Jan 2008 21:15:05 +0000
Message-ID: <C3AC3B59.10D40%jefferis@gmail.com>
References: <47868530.2010501@dawes.za.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Steffen Prohaska <prohaska@zib.de>,
	Git Mailing List <git@vger.kernel.org>
To: Rogan Dawes <lists@dawes.za.net>
X-From: git-owner@vger.kernel.org Thu Jan 10 22:15:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JD4kd-00029M-Vg
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 22:15:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754098AbYAJVPQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 16:15:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754079AbYAJVPQ
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 16:15:16 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:49900 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753952AbYAJVPO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2008 16:15:14 -0500
Received: by ug-out-1314.google.com with SMTP id z38so364417ugc.16
        for <git@vger.kernel.org>; Thu, 10 Jan 2008 13:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:user-agent:date:subject:from:to:cc:message-id:thread-topic:thread-index:in-reply-to:mime-version:content-type:content-transfer-encoding;
        bh=L1FbBXgtP1/xoQs86O6LwyKCeV1V1zKUUy2SoM/DX40=;
        b=sm79MVhaQgN+kMDR63GBdP4s9YKTGEWylWPvhc+XkCKDN6dl2xyU5wbNjf9I0yvlYWBq5xtZjn6ZjM0/L6YpZ2SVd4yMNDT2IAVGpl09tY3/oeiIU3pwD6Sua6kMP4+3C75QhEF2UVE96YqXkJGPv74N67JTidhG1+UdCdZDayQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=user-agent:date:subject:from:to:cc:message-id:thread-topic:thread-index:in-reply-to:mime-version:content-type:content-transfer-encoding;
        b=VEOfSk0aDmVqn56ltmzxcJ1nZSJUzzOtoZ3j+AUYVY94lZWyTIf7PQIpsEOuCs0/+jSu+VTEkRxRoBXJd0suEk4ZTQujdfvdJphoLyue/RmaJQSoFktdMdZ9CMzhh80ApZawmVwIQbfTBel7mnO+7LADkm6CizbVbEPRVuOkfDg=
Received: by 10.67.87.18 with SMTP id p18mr3651976ugl.87.1199999712112;
        Thu, 10 Jan 2008 13:15:12 -0800 (PST)
Received: from ?131.111.101.105? ( [131.111.101.105])
        by mx.google.com with ESMTPS id e5sm3161642ugf.8.2008.01.10.13.15.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Jan 2008 13:15:11 -0800 (PST)
User-Agent: Microsoft-Entourage/11.2.3.060209
Thread-Topic: CRLF problems with Git on Win32
Thread-Index: AchTzd63HWATOr/BEdyK5wAUURoPUg==
In-Reply-To: <47868530.2010501@dawes.za.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70093>

On 10/1/08 20:50, "Rogan Dawes" <lists@dawes.za.net> wrote:

> Gregory Jefferis wrote:
>> Isn't plain git functionally agnostic about line endings?  You can
>> check in CRLF text files to git and it doesn't care.  You can diff, show etc
>> just fine.  I haven't yet found anything that breaks with CRLF files.  In
>> this sense plain git is already Windows ready.  Maybe I'm missing something?
> 
> One example that bit me recently was "git-apply --whitespace=strip"
> 
> I have files with CRLF in my repo, but git was stripping the CR from
> lines that I applied via a patch.
> 
> I worked around it with a smudge/clean filter of "dos2unix | unix2dos"
> (first removes all CR's, second puts one back on each line)
> 
> Rogan

OK so that's interesting.  Is it a case where core git is not crlf agnostic?
Looks like CR is being considered whitespace.  I think git diff
--ignore-space-at-eol also works because CR is considered whitespace.  Maybe
that's the wrong behaviour.

So the big question for me.  Should git expect that text files inside a
repository have to have LF only line endings?  I don't think that it should,
but should accommodate both CRLF and LF.  I guess at the moment git normally
accommodates CRLF files because they look like an LF file that happens to
have a funky whitespace char in front of the LFs.  Maybe it would be better
if edge cases like the one you described were ironed out.
