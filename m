From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/2] t7002: set test prerequisite "external-grep" if 
	supported
Date: Thu, 7 Jan 2010 21:26:27 +0700
Message-ID: <fcaeb9bf1001070626we21617dt1b76af19a3c4a88d@mail.gmail.com>
References: <7v7hs09tpi.fsf@alter.siamese.dyndns.org>
	 <1262608455-4045-1-git-send-email-pclouds@gmail.com>
	 <7v4omyhc7h.fsf@alter.siamese.dyndns.org>
	 <7vy6ka8rmr.fsf@alter.siamese.dyndns.org>
	 <fcaeb9bf1001070527ra1570a0m12182db9bb029055@mail.gmail.com>
	 <4B45E9E7.1040905@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Jan 07 15:26:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NStJp-0005Go-MR
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 15:26:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752450Ab0AGO03 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2010 09:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280Ab0AGO03
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 09:26:29 -0500
Received: from mail-pz0-f171.google.com ([209.85.222.171]:38873 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751173Ab0AGO02 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2010 09:26:28 -0500
Received: by pzk1 with SMTP id 1so2959556pzk.33
        for <git@vger.kernel.org>; Thu, 07 Jan 2010 06:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=CCZTm9vDWx1eQfmQf0UgycTF/Dk8gbLEI9ji3KZMS/Q=;
        b=hEKjaoXT2KGqeLms1+b2rKE9ouWx29YVJLgeBT88zjaYHGjVTqrAQdNg99yIT08DOB
         m36OsoQZWvpPV1FSXXfS+epjgmhgqJjua8GO8zCZhReG5JHh8yE5MRhfCguVaIo+gUKP
         n3dy599b3QcnPgIilwlO/nmUo6gEDUpUQwQL0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=m65kyoSlah+aYtseDEtotxinEJuxKEutaHhKrbbUeRCZ+c+u04zuhFkADmS8IS3h9m
         CtBzHjfSGG18Tc82kdI6tp2A3iDlT2dhqSPnq8fB7s6JOGNw7tWs1X2Gp8Q/tkuHX4qP
         Rm7PZwTdIK52PbXtcOPHeNIv5RpsL0Xi+VG6k=
Received: by 10.115.103.29 with SMTP id f29mr1541647wam.222.1262874387855; 
	Thu, 07 Jan 2010 06:26:27 -0800 (PST)
In-Reply-To: <4B45E9E7.1040905@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136345>

On 1/7/10, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Nguyen Thai Ngoc Duy schrieb:
>
> > On 1/7/10, Junio C Hamano <gitster@pobox.com> wrote:
>  >>  So by writing the test to check the desired outcome, instead of writing it
>  >>  for the particular implementation of using external grep optimization, you
>  >>  will catch both kinds of breakages.
>  >>
>  >>  Perhaps something like this (untested, of course)?
>  >>
>  >>  test_expect_success 'strings in work tree files are not found for skip-wt paths' '
>  >>         no="no such string in the index" &&
>  >>         test_must_fail git grep -e "$no" --cached file &&
>  >>         git update-index --skip-worktree file &&
>  >>         echo "$no" >file &&
>  >>         test_must_fail git grep -e "$no" file &&
>  >>         git update-index --no-skip-worktree file &&
>  >>         git grep -e "$no" file
>  >>  '
>  >>
>  >
>  > Very well reasoned. I'd say go for it!
>  >
>  > Tested-by: me
>
>
> The test is not quite complete. Not only do you want to test that the
>  worktree file is not looked at, but that the index version is used:
>
>
>  test_expect_success 'for skip-wt paths, strings are found in index, not in
>  worktree' '
>         yes="this string is in the index" &&
>
>         no="no such string in the index" &&
>
>         echo "$yes" >file &&
>         git update-index file &&
>         echo "$no" >file &&
>         git grep -e "$yes" --cached file &&
>
>         test_must_fail git grep -e "$no" --cached file &&
>         git update-index --skip-worktree file &&
>
>         git grep -e "$yes" file &&
>
>         test_must_fail git grep -e "$no" file &&
>         git update-index --no-skip-worktree file &&
>
>         test_must_fail git grep -e "$yes" file &&
>
>         git grep -e "$no" file
>  '

Can we get rid of preparing $yes and do "grep -e foo file" instead?
There are lots of foo from setup test. It's not as strict as your test
because foo is also in worktree. But we have $no for testing worktree
already.
-- 
Duy
