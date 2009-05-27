From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 2/2] diff: generate prettier filenames when using
	GIT_EXTERNAL_DIFF
Date: Tue, 26 May 2009 22:17:38 -0700
Message-ID: <20090527051737.GA2986@gmail.com>
References: <1243394364-13772-1-git-send-email-davvid@gmail.com> <1243394364-13772-2-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, johannes.schindelin@gmx.de,
	markus.heidelberg@web.de, nick@incise.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 27 07:17:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9BWW-00043f-Jz
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 07:17:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757680AbZE0FRt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 01:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757584AbZE0FRs
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 01:17:48 -0400
Received: from mail-px0-f123.google.com ([209.85.216.123]:49254 "EHLO
	mail-px0-f123.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757308AbZE0FRr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 01:17:47 -0400
Received: by pxi29 with SMTP id 29so183137pxi.33
        for <git@vger.kernel.org>; Tue, 26 May 2009 22:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=tRsk34ni2+aT8Prju/MwuHgMhdEv0tvR/mdhNVpMkwU=;
        b=et2nIc2bB51JzjuRiPKDLws/DJdi7fulwjgA1lSfCVojtB/Yn9yiSXoEhrP2sFz/Ld
         BHnomr5lj7Yc5qkCZrlMBmrhTAuxw48H/KnRLhKevRGjSUxOX4r/VMYAzBMJVC7odGqX
         PmmwxJIUhVvWlk4+yX94e+FMvSl4YPLUGLC1Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=j3EqHLIrksITMNbOwwQClmQdFT3ApHetwNlComlvLAQ54HC0SzUWvBEc94uxWzAVUX
         EObPxQ6M73xktyCQUfC7DQOqRbkPD2JTxZ0/6gsqhl1kUJnjR054pLWoaL81urhSgAqm
         tdx2SvQMxbIZi/d/gHGry7y2YKXKuSfARt51o=
Received: by 10.114.88.1 with SMTP id l1mr18999898wab.97.1243401467767;
        Tue, 26 May 2009 22:17:47 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id v9sm1375127wah.1.2009.05.26.22.17.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 26 May 2009 22:17:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1243394364-13772-2-git-send-email-davvid@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120031>

On Tue, May 26, 2009 at 08:19:24PM -0700, David Aguilar wrote:
> --- a/t/t4020-diff-external.sh
> +++ b/t/t4020-diff-external.sh
> @@ -136,6 +136,24 @@ test_expect_success 'GIT_EXTERNAL_DIFF with more than one changed files' '
>  	GIT_EXTERNAL_DIFF=echo git diff
>  '

Sorry for including both tests here.
I forgot to remove the first test when we changed the naming
convention to 6X_name and not special-casing filenames with
dots in them.

I guess I'll resend w/out it.  I'll wait until wednesday
evening before resending to see if anyone spots any other
fixups.


The rationale for the original naming convention was that it
was arguably easier for users to spot what file they're
working on when playing games with dot.

compare:

a) !!!!!!_Makefile

b) Makefile_!!!!!!

and:

a) !!!!!!_diff.c

b) diff.!!!!!!.c


In both examples you already know what filename you're talking
about before scanning past any other information.

.gitignore would look like .!!!!!!.gitignore, which isn't too
bad either.

Anyways, not looking to bikeshed, so I'll wait to here what
others have to say and continue.  The patch is fine as-is too
sans the first test.


> +test_expect_success 'GIT_EXTERNAL_DIFF generates pretty paths with no ext' '
> +	touch filenoext &&
> +	git add filenoext &&
> +	echo no extension > filenoext &&
> +	GIT_EXTERNAL_DIFF=echo git diff filenoext | grep _filenoext &&
> +	git update-index --force-remove filenoext &&
> +	rm filenoext
> +'
> +
> +test_expect_success 'GIT_EXTERNAL_DIFF generates pretty paths with ext' '
> +	touch file.ext &&
> +	git add file.ext &&
> +	echo with extension > file.ext &&
> +	GIT_EXTERNAL_DIFF=echo git diff file.ext | grep ......_file\.ext &&
> +	git update-index --force-remove file.ext &&
> +	rm file.ext
> +'
> +
>  echo "#!$SHELL_PATH" >fake-diff.sh
>  cat >> fake-diff.sh <<\EOF
>  cat $2 >> crlfed.txt
> -- 
> 1.6.3.1.169.g33fd
> 

-- 

	David
