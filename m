From: Brian Dessent <brian@dessent.net>
Subject: Re: Switching from CVS to GIT
Date: Sun, 14 Oct 2007 17:36:38 -0700
Organization: My own little world...
Message-ID: <4712B616.165BBF8D@dessent.net>
References: <1192293466.17584.95.camel@homebase.localnet>
	<uy7e6keyv.fsf@gnu.org>
	<1192381040.4908.57.camel@homebase.localnet>
	<1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr>
	<47125F74.9050600@op5.se>
	<Pine.LNX.4.64.0710141934310.25221@racer.site>
	<47126957.1020204@op5.se>
	<Pine.LNX.4.64.0710142112540.25221@racer.site>
	<20071014221446.GC2776@steel.home> <u7ilpjp3x.fsf@gnu.org>
	<Pine.LNX.4.64.0710150039120.25221@racer.site>
Reply-To: git@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>, make-w32@gnu.org, ae@op5.se,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: make-w32-bounces+gnu-make-w32=m.gmane.org@gnu.org Mon Oct 15 02:37:05 2007
Return-path: <make-w32-bounces+gnu-make-w32=m.gmane.org@gnu.org>
Envelope-to: gnu-make-w32@m.gmane.org
Received: from lists.gnu.org ([199.232.76.165])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhDxA-0007NE-TK
	for gnu-make-w32@m.gmane.org; Mon, 15 Oct 2007 02:37:05 +0200
Received: from localhost ([127.0.0.1] helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43)
	id 1IhDx4-00073G-8K
	for gnu-make-w32@m.gmane.org; Sun, 14 Oct 2007 20:36:58 -0400
Received: from mailman by lists.gnu.org with tmda-scanned (Exim 4.43)
	id 1IhDwy-00071L-RS
	for make-w32@gnu.org; Sun, 14 Oct 2007 20:36:52 -0400
Received: from exim by lists.gnu.org with spam-scanned (Exim 4.43)
	id 1IhDwy-00070z-B1
	for make-w32@gnu.org; Sun, 14 Oct 2007 20:36:52 -0400
Received: from [199.232.76.173] (helo=monty-python.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43) id 1IhDwy-00070w-5a
	for make-w32@gnu.org; Sun, 14 Oct 2007 20:36:52 -0400
Received: from dessent.net ([69.60.119.225])
	by monty-python.gnu.org with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.60) (envelope-from <brian@dessent.net>)
	id 1IhDwv-0004fY-5S; Sun, 14 Oct 2007 20:36:49 -0400
Received: from localhost ([127.0.0.1] helo=dessent.net)
	by dessent.net with esmtp (Exim 4.50)
	id 1IhDwm-0006ee-9t; Mon, 15 Oct 2007 00:36:40 +0000
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: en,en-US
X-detected-kernel: by monty-python.gnu.org: Linux 2.4-2.6
X-BeenThere: make-w32@gnu.org
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: Discussion of Windows-specific issues with GNU make <make-w32.gnu.org>
List-Unsubscribe: <http://lists.gnu.org/mailman/listinfo/make-w32>,
	<mailto:make-w32-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/pipermail/make-w32>
List-Post: <mailto:make-w32@gnu.org>
List-Help: <mailto:make-w32-request@gnu.org?subject=help>
List-Subscribe: <http://lists.gnu.org/mailman/listinfo/make-w32>,
	<mailto:make-w32-request@gnu.org?subject=subscribe>
Sender: make-w32-bounces+gnu-make-w32=m.gmane.org@gnu.org
Errors-To: make-w32-bounces+gnu-make-w32=m.gmane.org@gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60932>

Johannes Schindelin wrote:

> The problem is that on Windows, you cannot keep a file open and delete it
> at the same time.  This is an issue in Windows' equivalent of VFS.
> 
> A neat trick to work with temporary files without permission issues is to
> open the file and delete it right after that.  This does not work on
> Windows.

You can achieve the same thing on Windows with CreateFile() by setting
the dwShareMode parameter to zero and setting the
FILE_FLAG_DELETE_ON_CLOSE attribute on dwFlagsAndAttributes.  This
results in a file that cannot be opened or read by any other process and
that will be automatically deleted when all open handles are closed.

> I think Alex means this: you can have C:\a\b\c and D:\a\b\c.  So depending
> on which drive you are, you mean one or the other.  Just comparing the
> paths is not enough.

This just means that you have to consider the drive letter as part of
the filename.

> > > - no real "mmap" (which kills perfomance and complicates code)
> >
> > You only need mmap because you are accustomed to use it on GNU/Linux.
> 
> Yes.  And we rely on the performance very much.

Windows may not call it mmap() but it most certainly has memory-mapped
file IO:
<http://msdn2.microsoft.com/en-us/library/aa366781.aspx#file_mapping_functions>.

Brian
