From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Disable filemode rebase tests in t3400-rebase.sh if no 
	filesystem mode support
Date: Wed, 11 Feb 2009 12:05:08 +0100
Message-ID: <81b0412b0902110305o5ca60708gc07cbc9ae1d89d1f@mail.gmail.com>
References: <81b0412b0902110151x35fbbb4esb9efefae2e1fe90a@mail.gmail.com>
	 <7v7i3xgu9v.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 12:08:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXCxA-0002Iz-8V
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 12:08:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752700AbZBKLFN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 06:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752036AbZBKLFL
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 06:05:11 -0500
Received: from ey-out-2122.google.com ([74.125.78.25]:41811 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751833AbZBKLFK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 06:05:10 -0500
Received: by ey-out-2122.google.com with SMTP id 25so16684eya.37
        for <git@vger.kernel.org>; Wed, 11 Feb 2009 03:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=LUWj/I18wF1YcwcrKshCol39fhzPalM4d7o2C82nBcs=;
        b=f7FbmF9lyV06xTqwd61vxkC9NbL4fVhXECIUTRB4prYJlF5luF0UI6hsgyYKAvEYAO
         i/9WDhuKqWCkUH9peQDR9YLTzihk1ZYSYO91ExduwLUo1FKup+8TrKWFOcNTOn488EO4
         CrSTQzU+7PXQg0T8PySM6lCJp3F2vxCFsNyqk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Dnw/9r42gnCH3T1wSuB7QMjSLjkzF2gPPgxiwcTyx3rKW2ONiV9ysZ86MCbTfSemQr
         nGZNha2VCO86BYhHvnPiu+aIJFQUS2IWG4bvpiCrFjJAesfUQF8yt05jLKZiNZ/PbW5K
         YVVnvKC52bsJels+u3ryTvaM1r6Wv8WyWLpI4=
Received: by 10.210.125.13 with SMTP id x13mr5657956ebc.26.1234350308479; Wed, 
	11 Feb 2009 03:05:08 -0800 (PST)
In-Reply-To: <7v7i3xgu9v.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109406>

2009/2/11 Junio C Hamano <gitster@pobox.com>:
> Alex Riesen <raa.lkml@gmail.com> writes:
>
>> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
>> ---
>>
>> I'm honestly sorry for my contributions. They seem to be exclusively
>> in the "make Git work in Windows" area.  Depressing.
>>
>>  t/t3400-rebase.sh |    5 +++++
>>  1 files changed, 5 insertions(+), 0 deletions(-)
>
> I wonder if you should be fixing the tests with "update-index --chmod"
> instead...
>

Well, mostly these should work independent of the filesystem (except
for the cases when the index is checked out later). They seem to, and
they look like they should, too. See t4014-format-patch, for one.

But you're right. I should have reviewed them earlier. Anyway, there is
not many tests which have "--chmod" in them:
t4006-diff-mode.sh, t4014-format-patch.sh, t6031-merge-recursive.sh,
and t9500-gitweb-standalone-no-errors.sh.
The t4006 does not bother to look at working tree (good),
t4014 is good (looks like its ignoring modes altogether),
t6031 uses --chmod to augment the chmod useless on FAT-like fs
(seem to be an earlier fix for the same problem).

What's more interesting is the use of chmod for index mode change purpose,
which should be reviewed regularly (and I do that only when it breaks.
Lazy boom, I am...)
