From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [RFC PATCH] Windows: Assume all file names to be UTF-8 encoded.
Date: Tue, 3 Mar 2009 12:43:55 +0300
Message-ID: <37fcd2780903030143t7abe33d5sb7d8163c3c9bf505@mail.gmail.com>
References: <alpine.DEB.2.00.0903020941120.17877@perkele.intern.softwolves.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Tue Mar 03 10:45:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeRBz-0004aj-Oh
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 10:45:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753584AbZCCJn7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 04:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753555AbZCCJn7
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 04:43:59 -0500
Received: from mail-fx0-f176.google.com ([209.85.220.176]:54032 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752583AbZCCJn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 04:43:58 -0500
Received: by fxm24 with SMTP id 24so2350818fxm.37
        for <git@vger.kernel.org>; Tue, 03 Mar 2009 01:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=A9N7rmWpEcb9w4RTxWdesXMqVGforlJO88QRHfL5ISs=;
        b=ZMFxKz4M+Nq5pgZ4B85aq+JM7baj0tSCTAi1BOFJ9G4uPAxtEl2J24TUFGGjwe7qP9
         SsIdBQFbBHMq5Rseo7N2VN4mvrQJ3NcQfyfyAJBrZFlFabzCxyhHZd2dwH82LySh/uo7
         wn+lk47YJVULFm9kcEN+wAS3vxoLhn8WZJd2Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=L+cZhzyagHfewQaBk39oHWPgqSXDZbFGaEczMQhsRk3hiiZkTcvys2KYEtU78prHHm
         olSDeNfW9dCIfjGVw3Z5JVxisUWhqDomTzWgQj8Y8c+SJucBo9vROCk6uPNkQ/VngfFl
         T6Bs+IlSwb3S82D9iOkm8CEItlltapyPKiXaU=
Received: by 10.86.53.8 with SMTP id b8mr6324018fga.13.1236073435307; Tue, 03 
	Mar 2009 01:43:55 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.0903020941120.17877@perkele.intern.softwolves.pp.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112043>

On Mon, Mar 02, 2009 at 09:47:22AM +0100, Peter Krefting wrote:
> When opening a file through open() or fopen(), the path passed is
> UTF-8 encoded. To handle this on Windows, we need to convert the
> path string to UTF-16 and use the Unicode-based interface.

IMHO, you grossly underestimate what is needed to enable UTF-8 encoding
in Windows. AFAIK, Microsoft C runtime library does not support UTF-8,
so you have to wrap all C functions taking 'char*' as an input parameter.
For example, think about what is going to happen if Git tries to print
a simple error message:
  fprintf (stderr, "unable to open %s", path);

> Since there is no real file system abstraction beyond using stdio_
> (AFAIK), I need to hack it by replacing fopen (and open). Probably_
> opendir/readdir as well (might be trickier), and possibly even hack_
> around main() to parse the wchar_t command-line instead of the char copy.

And the command-line is not the only source of file names. Some Git
commands read list of files from stdin usually though the pipe. In
what encoding are they going to be?

Dmitry
