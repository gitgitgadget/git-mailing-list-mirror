From: "Govind Salinas" <blix@sophiasuchtig.com>
Subject: Re: [PATCH 20/40] Windows: A rudimentary poll() emulation.
Date: Fri, 29 Feb 2008 15:47:12 -0600
Message-ID: <5d46db230802291347u5f286dadw6b532abf82c0cff7@mail.gmail.com>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
	 <200802282149.36748.johannes.sixt@telecom.at>
	 <5d46db230802282019o21f9ed9fo75fed8744625289e@mail.gmail.com>
	 <200802292216.25014.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Johannes Sixt" <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Fri Feb 29 22:47:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVD56-0008Qs-Gh
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 22:47:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760283AbYB2VrQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 16:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760156AbYB2VrQ
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 16:47:16 -0500
Received: from ti-out-0910.google.com ([209.85.142.187]:27800 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759253AbYB2VrP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 16:47:15 -0500
Received: by ti-out-0910.google.com with SMTP id 28so4044684tif.23
        for <git@vger.kernel.org>; Fri, 29 Feb 2008 13:47:14 -0800 (PST)
Received: by 10.151.47.7 with SMTP id z7mr962570ybj.103.1204321632073;
        Fri, 29 Feb 2008 13:47:12 -0800 (PST)
Received: by 10.150.199.5 with HTTP; Fri, 29 Feb 2008 13:47:12 -0800 (PST)
In-Reply-To: <200802292216.25014.johannes.sixt@telecom.at>
Content-Disposition: inline
X-Google-Sender-Auth: 0442b7dc10f2141e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75569>

On 2/29/08, Johannes Sixt <johannes.sixt@telecom.at> wrote:
> On Friday 29 February 2008 05:19, Govind Salinas wrote:
>  > On Thu, Feb 28, 2008 at 2:49 PM, Johannes Sixt <johannes.sixt@telecom.at>
>  wrote:
>  > > On Thursday 28 February 2008 10:36, Paolo Bonzini wrote:
>
> > >  > For the future, would it be better to first use
>  > >  > WaitForMultipleObjects, and then use PeekNamedPipe to find which
>  > >  > handles have data on it? That's how the mingw port of GNU Smalltalk
>  > >  > does it.
>  > >
>  > >  I tried but I failed. If you can show me code where
>      ^^^^^^^^^^^^^^^^^^^^^
>  > > WaitForMultipleObjects works on handles that MSVCRT.DLL's open() created,
>  > > I'll gladly accept it!
>  >
>  > I haven't tried it myself, but you can look at _get_osfhandle
>  >
>  > http://msdn2.microsoft.com/en-us/library/ks2530z6(VS.71).aspx
>  >
>  > of course you would need to keep a mapping from the handle to the fd.
>  > Or _open_osfhandle might work the other way, I don't know if it will
>  > necessarily return the same descriptor.
>  >
>  > http://msdn2.microsoft.com/en-us/library/bdts1c9x(VS.71).aspx
>
>
> Fscking basics, this. How do you go from here to WaitForMultipleObjects?
>
Well, I could have sworn that named pipe handles were in the waitable
list, but after looking again, they are not.

However, I did find

http://msdn2.microsoft.com/en-us/library/aa365603(VS.85).aspx

which suggests you can pass these handles to ReadFile and if you include an
OVERLAPPED struct in the call, it will return an event handle to wait on which
you can then use to wait.

Sorry for the false lead.

HTH,
Govind.
