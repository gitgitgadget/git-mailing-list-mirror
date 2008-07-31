From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: linking libgit.a in C++ projects
Date: Thu, 31 Jul 2008 18:44:24 +0400
Message-ID: <20080731144424.GH7008@dpotapov.dyndns.org>
References: <ac9f0f090807310253v1d97e2a1n4ddf34aa4fdc79f0@mail.gmail.com> <4891B872.3040707@panasas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: cte <cestreich@gmail.com>, git@vger.kernel.org
To: Boaz Harrosh <bharrosh@panasas.com>
X-From: git-owner@vger.kernel.org Thu Jul 31 16:45:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOZPP-0003Fy-Nl
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 16:45:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753737AbYGaOoi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 10:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752969AbYGaOoh
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 10:44:37 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:44800 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752689AbYGaOog (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 10:44:36 -0400
Received: by fg-out-1718.google.com with SMTP id 19so287607fgg.17
        for <git@vger.kernel.org>; Thu, 31 Jul 2008 07:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=HCWGdyftGdP0tTr3t51OZGd76Qw9udzzyOu2lLTdDoA=;
        b=oGLwtclhXSOGN98JCHDnQelYtmbdXb241nReR66IAoGNL1/yvHHEIp9NaKklgl2p32
         60xR/Au001b0U289iTKjsvfVeBBvJJ3keZAUIif5MWDR7AxyxlGELQM8JxtQsOhz2wZX
         9d/i21f7Mjbz5uYDq2034r7K3QfW8QAKmTwm8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Xz+iwxTRVgFnQVSUhd1c10pUWR7Uf0c38UmNXbLjygefDfCHCGEPebBGoyYwnAdgBi
         kMo6NTOERJi9CFt4ypqS+4dUtY5voYIxxQnd3Xj61ORaQUtHq0oJ44ldYVlOdlXAGbSY
         3+iDXoOduvTfC4NEFRxPCK9QOlPpkKGmP2elM=
Received: by 10.86.4.2 with SMTP id 2mr6153777fgd.63.1217515475140;
        Thu, 31 Jul 2008 07:44:35 -0700 (PDT)
Received: from localhost ( [85.141.148.53])
        by mx.google.com with ESMTPS id d4sm2741503fga.8.2008.07.31.07.44.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 31 Jul 2008 07:44:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4891B872.3040707@panasas.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90950>

On Thu, Jul 31, 2008 at 04:04:50PM +0300, Boaz Harrosh wrote:
> 
> Produce a C file and header that defines some stable API to your
> GUI application, that does not expose any git internal headers.
> Then compile that, say git_api.c, with C compiler in Makefile
> and extern "C" link that file to your C++ application. This will
> completely insulate you from any git code.

While the idea of creating of such a wrapper makes sense, it may not
easy to implement properly in all cases, because some git functions
do not free allocated memory as they rely on this memory being free
at exit. There is a problem with die() as it is not enough to longjmp
from it, you have to free all resources that were allocated (such as
open files, memory). Thus writing a full functional library, which
will not leak resources, is not an easy task. Of course, some of Git
function can be used easily without risk that your application will
leak resources.

Dmitry
