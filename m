From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH (resend)] gitweb: Fix bug in "blobdiff" view for split (e.g. file to symlink) patches
Date: Fri, 6 Apr 2007 00:58:23 +0200
Message-ID: <200704060058.24524.jnareb@gmail.com>
References: <1175773541251-git-send-email-jnareb@gmail.com> <7v3b3epn0a.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 06 00:55:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZarG-0004sG-2c
	for gcvg-git@gmane.org; Fri, 06 Apr 2007 00:55:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767252AbXDEWzF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 18:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767387AbXDEWzF
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 18:55:05 -0400
Received: from mu-out-0910.google.com ([209.85.134.186]:5658 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767252AbXDEWzC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 18:55:02 -0400
Received: by mu-out-0910.google.com with SMTP id g7so1144338muf
        for <git@vger.kernel.org>; Thu, 05 Apr 2007 15:55:00 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=mSkGEYPCacFYg16ohkmUqZP4+34CTH9cIBu3kXSvv5aYkqMBJJptGK1KHP9BWb6Xkz55wPJfbM58FXO9+jthc3DapaBSTbpeHxh/hHqgUuUuANIIav0AHSx1/cHFwTd4KFKnEiihQaGOcXMVBVotIHJJa5VpTSn15h7+u1v7ZB4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=dSNO0SFPbvNm8Nvb8+OSQJc1lfs0EXPsfFMV3yTpzBYYJH1UOFSD1VzmF1W1eVHvUJCPPUe3fTDfFuZwddzIzffnGhbPeESjW1w2LT+SKHGKQ60dAQ/Zmh2B7qUzV6k2Cw8NZQaMh6OwGAmDH2RTTgSb9ciYIaujFOYrhXpctZc=
Received: by 10.82.175.2 with SMTP id x2mr3582733bue.1175813699793;
        Thu, 05 Apr 2007 15:54:59 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id w7sm7973405mue.2007.04.05.15.54.58;
        Thu, 05 Apr 2007 15:54:58 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7v3b3epn0a.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43878>

DJunio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> git_patchset_body needs patch generated with --full-index option to
>> detect split patches,...
>> ...
>> This patch fixes this bug in git_blobdiff (in "blobdiff" view).
>>
>> Junio, you probably have missed this patch in the noise...
> 
> Probably.  Although I do remember seeing the patch, it was
> unclear why --full-index is needed (and it still is unclear to
> me).  Do you have a parser that expects/depends on full
> 40-hexdigit hash on the index line?
> 
> Not a complaint but a question -- I do not mind (actually prefer,
> probably) if gitweb worked on full 40-hexdigit internally to
> avoid possible ambiguity issues, although the output may need to
> be truncated to save people from having to see unneeded precision.

Yes, the parser (in git_patchset_body subroutine) checks for
presence of fully expanded 40-hexdigit hash, and compares it with
the fully expanded 40-hexdigit hash it has in $difftree hashref
(from the "raw" diff output, or "raw" part of diff output, or 
hand-crafted "raw" diff output). It is needed only for the 'html'
format case (for "commitdiff" / "blobdiff" view), for git_patchset_body
to know what values use for hyperlinking and replacements.

The output is truncated (and hyperlinked) in 'html' format case.


I could have relaxed the parser, and compare up to the precision
of hash in the "^index ..." line of extended git diff header in
"patch" diff output...

-- 
Jakub Narebski
Poland
