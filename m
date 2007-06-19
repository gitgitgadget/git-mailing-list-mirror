From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: git-gui cannot find share/git-gui under cygwin
Date: Tue, 19 Jun 2007 14:41:46 -0400
Message-ID: <4678236A.9000606@gmail.com>
References: <4677CBD7.9050606@gmail.com> <20070619144928.GA8477@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jun 19 20:41:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0ieI-0004It-2u
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 20:41:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762045AbXFSSlw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 14:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762034AbXFSSlw
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 14:41:52 -0400
Received: from an-out-0708.google.com ([209.85.132.251]:17708 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762010AbXFSSlv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 14:41:51 -0400
Received: by an-out-0708.google.com with SMTP id d31so429749and
        for <git@vger.kernel.org>; Tue, 19 Jun 2007 11:41:50 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=CEGl98Z7Hb9EIY+upzJNqtNF0LRuZnTTn/sHZ0qX+57LkmK0o/hidcpwFEXhrgKfdWmLo2qDW6iY1P490IoDDxfF1Px59f/+9fff1pRvfSGN1ka8tbaq5b4DMeMkuefFGi7brA3bs/ogBa/WdtjAnDFMzC9J0ZGhyRsEhk4E6r8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=FXocyphol9fJEllrWPN1irrLiZZxYf5z6wQC+HEBy7ZFDBpkNy7B286rULdW4Hj+rLuwjGuwSLQoCBHMshqF0x3AIJdiHNrtpVNIfZa4zdCyKjNv1tESd1UwgeL8HilNSuNP4E0aRNmp4//N5hwdJ7x3INjHppOKH7Amp0iyxoU=
Received: by 10.100.132.16 with SMTP id f16mr4628828and.1182278509937;
        Tue, 19 Jun 2007 11:41:49 -0700 (PDT)
Received: from ?10.11.11.103? ( [66.55.30.173])
        by mx.google.com with ESMTP id c29sm12866966anc.2007.06.19.11.41.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 19 Jun 2007 11:41:49 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.12 (Windows/20070509)
In-Reply-To: <20070619144928.GA8477@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50501>

Shawn O. Pearce wrote:
> Yuck.  I'm considering applying the following.  It works ok on Mac
> OS X where the bug isn't triggered anyway.  ;-) I won't be able to
> test on Cygwin until tomorrow.
>
>   
sorry, no joy. The problem is that gitexecdir=/usr/bin, but...

/usr/bin is a Cygwin mount point that points at c:\cygwin\bin.

so...

$ cygpath -m -a /bin
C:/cygwin/bin
$ cygpath -m -a /usr
C:/cygwin/usr
$ cygpath -m -a /usr/bin
C:/cygwin/bin
$ cygpath -m -a /usr/share
C:/cygwin/usr/share

and the result is that both  exedir_SQ  and  libdir_SQ  have the value  
/usr/share/git-gui-lib

I don't think there is a portable solution here. Maybe just say

    if test "$(uname_O)" = Cygwin; then \
        GITGUI_RELATIVE=; \
 
and be done with it.

Mark
