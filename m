From: "Tom Preston-Werner" <tom@github.com>
Subject: Re: [PATCH] connect.c: add a way for git-daemon to pass an error back to client
Date: Fri, 31 Oct 2008 20:35:20 -0700
Message-ID: <b97024a40810312035v5416b578v51b5bed528ca8d39@mail.gmail.com>
References: <b97024a40810311859t2e5a6102u31ad4480e7c75c03@mail.gmail.com>
	 <alpine.DEB.1.00.0811010316340.22125@pacific.mpi-cbg.de.mpi-cbg.de>
	 <alpine.LFD.2.00.0810312218300.13034@xanadu.home>
	 <alpine.DEB.1.00.0811010334010.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Nicolas Pitre" <nico@cam.org>, git@vger.kernel.org,
	gitster@pobox.com
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Nov 01 04:45:21 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw7QM-0007oH-4z
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 04:45:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbYKADfX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 23:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbYKADfW
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 23:35:22 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:12130 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750867AbYKADfW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 23:35:22 -0400
Received: by nf-out-0910.google.com with SMTP id d3so686006nfc.21
        for <git@vger.kernel.org>; Fri, 31 Oct 2008 20:35:20 -0700 (PDT)
Received: by 10.210.20.17 with SMTP id 17mr11002986ebt.178.1225510520351;
        Fri, 31 Oct 2008 20:35:20 -0700 (PDT)
Received: by 10.210.117.11 with HTTP; Fri, 31 Oct 2008 20:35:20 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0811010334010.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99716>

On Fri, Oct 31, 2008 at 7:35 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Fri, 31 Oct 2008, Nicolas Pitre wrote:
>
>> On Sat, 1 Nov 2008, Johannes Schindelin wrote:
>>
>> > On Fri, 31 Oct 2008, Tom Preston-Werner wrote:
>> >
>> > > The current behavior of git-daemon is to simply close the connection
>> > > on any error condition. This leaves the client without any
>> > > information as to the cause of the failed fetch/push/etc.
>> > >
>> > > This patch allows get_remote_heads to accept a line prefixed with
>> > > "ERR" that it can display to the user in an informative fashion.
>> > > Once clients can understand this ERR line, git-daemon can be made to
>> > > properly report "repository not found", "permission denied", or
>> > > other errors.
>> > >
>> > > Example
>> > >
>> > > S: ERR No matching repository.
>> > > C: fatal: remote error: No matching repository.
>> >
>> > Makes sense to me.
>>
>> Note that this behavior of not returning any reason for failure was
>> argued to be a security feature in the past, by Linus I think.
>
> Yes.  And it might still be considered one.  You do not need to patch
> git-daemon to use that facility (note that Tom's patch was only for the
> client side).
>
> But for hosting sites such as repo.or.cz or GitHub, that security feature
> just does not make sense, but it makes for support requests that could be
> resolved better with a proper error message.

We could also have the error messages sent back conditionally based on
a command line switch. I've begun porting the changes I made in our
Erlang git-daemon back to the C code, so maybe I'll give that a try.
We *definitely* need good error messages for GitHub and I see no
security risk in doing so.

Maybe this is worth asking the question: does anybody use git-daemon
for private code? If so, why are they not using SSH instead? And in
that case, how are informative error messages a security risk?

Tom
