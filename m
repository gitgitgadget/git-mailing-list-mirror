From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Add charset info to "raw" blob output
Date: Sun, 1 Jun 2008 13:06:45 +0200
Message-ID: <200806011306.45945.jnareb@gmail.com>
References: <m3tzgg1a06.fsf@localhost.localdomain> <20080531112513.30913.44393.stgit@localhost.localdomain> <7vprr2fi5z.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jan Engelhardt <jengelh@medozas.de>,
	Lea Wiemann <lewiemann@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 01 13:07:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2lPh-0007UG-1p
	for gcvg-git-2@gmane.org; Sun, 01 Jun 2008 13:07:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbYFALGy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jun 2008 07:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbYFALGy
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jun 2008 07:06:54 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:64159 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934AbYFALGx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2008 07:06:53 -0400
Received: by nf-out-0910.google.com with SMTP id d3so256452nfc.21
        for <git@vger.kernel.org>; Sun, 01 Jun 2008 04:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=FVfYHgmiDI5hRBjRgaYzQ/7PLAISvMXVIx+9cDYkEqw=;
        b=iNzgLoe7Tu0uh7EvaUgKsFCCFKTrZpiOb5ydU0blmf14KYKeFuVgtbKs+NZJis67D0rF6vW+/A8Jtt7mYy+RbgAvE/zWinlgaWjwhddoaIrvBefxA6IJGVGUvNu8eeTXoW5oidl9phizz1n6+XvcCwtNlLjwk4EGhBvdww6oFx0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=PeV2Cs/LZo7uckL+gI10ajgmq+hWMOpPVzTxRStJILvVWwVmXLuqJ70dkxJmu06mtWQ1rxvmC2d/C3k35hR4jPnP7krCqZXukgv+ixPC8c+a5CEaOtPBth3SAesC8KNULsHVXW0+882s3qtr62Pgj21j/FI3qPl4s4IhyiAo7QI=
Received: by 10.210.46.4 with SMTP id t4mr723810ebt.35.1212318411363;
        Sun, 01 Jun 2008 04:06:51 -0700 (PDT)
Received: from ?192.168.1.15? ( [83.8.204.14])
        by mx.google.com with ESMTPS id d27sm3784262nfh.12.2008.06.01.04.06.48
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 01 Jun 2008 04:06:49 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vprr2fi5z.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83445>

On Sat, 31 May 2008, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> Always add charset info from $default_text_plain_charset (if it is
>> defined) to "raw" (a=blob_plain) output for 'text/plain' blobs.
>> Adding charset info in a special case was removed from blob_mimetype().
>>
>> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
>> ---
> 
> Looks Ok but it took a bit of digging on the list for me to figure out
> that something like this was missing from the beginning of your commit log
> message:
> 
> 	Earlier "blob_plain" view sent "charset=utf-8" only when gitweb
> 	guessed the content type to be text by reading from it, and not
> 	when the MIME type was obtained from /etc/mime.types.
> 
> 	This fixes the bug by always adding....

I'm sorry that I have forgot to put the "why" in commit message.
I'd add this when resending v2 of this patch.

Thanks for a comment.

> But I wonder if moving of this to the calling site is the right thing to
> do.  Wouldn't it become much more contained and robust if you did it this
> way?
[...]
>  sub blob_mimetype {

This _might_ be better.  I didn't do this for the following two reasons:

First, from purely theoretical point of view the name of subroutine is
blob_mimetype(), and I think that charset info has place in Content-Type,
but is not part of MIME type info.  

Second, blob_mimetype() is used in two places: in git_blob_plain
(in "raw" blob view) to generate correct Content-Type HTTP header, and
in git_blob to decide whether a.) blame makes sense, b.) whether to
redirect to "raw" (a=blob_plain) view.  I'd rather not muck with
charset info in second case, although I don't think that it matters
at all, at least for now.


So perhaps best of those ways would be to create thin wrapper subroutine,
blob_contenttype($fd, $file_name, $mimetype), where both $file_name and
(especially) $mimetype are optional parameters, and ise it in
git_blob_plain() subroutine...

> +	# Type specific postprocessing can be added as needed...
> +	if ($mime =~ /^text\//i &&
> +	    $mime !~ /charset=/i && $default_text_plain_charset) {
> +		$mime .=  '; charset='.$default_text_plain_charset;
> +	}
> +
> +	return $mime;

I'm not sure about it.  I worry a bit about text/html, which can, and
usually do, contain charset info inside the document.  I'm not sure
what happens when charset information from HTTP headers contradict
charset information from presented file.  That's why I have limited
adding charset info purely to 'text/plain', not 'text/*' without
charset info already present.

-- 
Jakub Narebski
Poland
