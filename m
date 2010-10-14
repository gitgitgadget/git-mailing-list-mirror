From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Improve the "diff --git" format documentation
Date: Thu, 14 Oct 2010 11:16:36 -0500
Message-ID: <20101014161636.GB16500@burratino>
References: <201010061823.47475.agruen@suse.de>
 <201010070103.17689.agruen@suse.de>
 <7v8w21fsgr.fsf@alter.siamese.dyndns.org>
 <201010141439.43168.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Andreas Gruenbacher <agruen@suse.de>
X-From: git-owner@vger.kernel.org Thu Oct 14 18:21:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6QYY-0006r4-9h
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 18:21:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755605Ab0JNQUF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Oct 2010 12:20:05 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:35586 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755544Ab0JNQUD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Oct 2010 12:20:03 -0400
Received: by vws2 with SMTP id 2so2522860vws.19
        for <git@vger.kernel.org>; Thu, 14 Oct 2010 09:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=jNTrZ2bzKtBIdRq4Kk+HKDkezCWbgmyWiWzpY72QdQA=;
        b=p3vIHmbOW1MzcpgIfS+TcCcNt9fWawOiBC7S904dx4xi3HI/zeWJS0nq162Mp0kFe+
         NG61vy3NxNdMKVxx5Qk/V2qRGwlMkouRFhmGzrw3DDs1UAG6ZqxaV6ilO0ZAFAjLi5g0
         Npx0dGo0ZVuCeJHG4wri5V2WQZ7GCeQdDBYtI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=aqwNqpRM+kZrWQf6A0x4ajWj6RJXPl5gef2Lie/vQgZOtEzF7rBWRGXOQgIkqKoLVZ
         Upy+rl/zbIZrW0sk7NryWygE4YPN/5uJSBrxv9dH9GF5raQTcNOyb3ZMjt8U3Ts8kpga
         yF5cESF9p0txBCNn6rul7fzyFBn5jsv8Iar4A=
Received: by 10.229.240.76 with SMTP id kz12mr9047317qcb.65.1287073202125;
        Thu, 14 Oct 2010 09:20:02 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id m7sm6374430qck.37.2010.10.14.09.20.00
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 14 Oct 2010 09:20:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201010141439.43168.agruen@suse.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159053>

Andreas Gruenbacher wrote:

> I still believe that the documentation should make it very clear how it
> handles created and deleted files;

Yes - thanks for doing this.

> --- a/Documentation/diff-generate-patch.txt
> +++ b/Documentation/diff-generate-patch.txt
> @@ -53,12 +53,22 @@ The index line includes the SHA-1 checksum before and after the change.
>  The <mode> is included if the file mode does not change; otherwise,
>  separate lines indicate the old and the new mode.
>  
> -3.  TAB, LF, double quote and backslash characters in pathnames
> +3.  It is followed by a 'unified' diff which starts with a two-line

So afterwards the section would say:

	What the -p option produces is slightly different from the traditional
	diff format.

	1.   It is preceded with a "git diff" header, that looks like
	     this:

	       diff --git a/file1 b/file2
	[...]

	2.   It is followed by one or more extended header lines:

	       old mode <mode>
	       new mode <mode>
	[...]

	3.   It is followed by a 'unified' diff which starts with a two-line
	[...]

At some point, the reader starts to wonder what "it" is. :)   (2)
already has this problem, since the extended header lines actually
precede the traditional diff rather than following it.

How about:

	What the -p option produces is slightly different[...]

	1. It is preceded with a "git diff" header[...]
	2. Next comes one or more extended header lines[...]
	3. The from-file/to-file header that follows uses filenames
	of the form a/file1 and b/file2 (where "a/" and "b/" can be
	replaced with some other string or removed depending on
	options used):

		--- a/file1
		+++ b/file2

	This header is omitted if[...]
	4. TAB, LF, double quote, and [...]

Jonathan
