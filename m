From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 1/3] prune-packed: fix a possible buffer overflow
Date: Thu, 19 Dec 2013 17:33:55 +0100
Message-ID: <52B31FF3.1060102@alum.mit.edu>
References: <1387287838-25779-1-git-send-email-mhagger@alum.mit.edu> <1387287838-25779-2-git-send-email-mhagger@alum.mit.edu> <CACsJy8DVc4soBrS1RbTLv93b5rere3htyL1DjRw=UcT4zVN9FA@mail.gmail.com> <xmqqd2kvmi85.fsf@gitster.dls.corp.google.com> <52B2256A.3060802@alum.mit.edu> <20131219000415.GA17420@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Antoine Pelisse <apelisse@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 19 17:41:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vtger-0004HG-9Q
	for gcvg-git-2@plane.gmane.org; Thu, 19 Dec 2013 17:41:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357Ab3LSQlE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Dec 2013 11:41:04 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:64811 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750954Ab3LSQlD (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Dec 2013 11:41:03 -0500
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Dec 2013 11:41:02 EST
X-AuditID: 1207440c-b7f566d000004272-1e-52b31ff798ae
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 76.AD.17010.7FF13B25; Thu, 19 Dec 2013 11:33:59 -0500 (EST)
Received: from [172.16.46.13] ([178.19.210.163])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id rBJGXtTW029553
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 19 Dec 2013 11:33:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131005 Icedove/17.0.9
In-Reply-To: <20131219000415.GA17420@sigill.intra.peff.net>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGKsWRmVeSWpSXmKPExsUixO6iqPtdfnOQwa0+E4tfZ3exWHRd6Way
	aOi9wmzRPeUto8WPlh5mB1aPnbPusns8693D6HHxkrLH501yASxR3DZJiSVlwZnpefp2CdwZ
	J07zFjwRr7j26CVzA2OLcBcjJ4eEgInE5R/7mSBsMYkL99azdTFycQgJXGaUePz1EjOEs4FJ
	onvSORaQKl4BbYnFt+Yyg9gsAqoSZw7/ZQSx2QR0JRb1NINNEhUIknh06CE7RL2gxMmZT8B6
	RQRkJb4f3sgIMpRZYBmjxK7+p2ANwgKuEh+W72CC2HaASWJW412wqZwC1hKXvn4HmsQBdJ+4
	RE9jEIjJLKAusX6eEEgFs4C8xPa3c5gnMArOQrJuFkLVLCRVCxiZVzHKJeaU5urmJmbmFKcm
	6xYnJ+blpRbpGurlZpbopaaUbmKEhDvPDsZv62QOMQpwMCrx8K54uTFIiDWxrLgy9xCjJAeT
	kiivOjBahPiS8lMqMxKLM+KLSnNSiw8xSnAwK4nw3pIByvGmJFZWpRblw6SkOViUxHlVl6j7
	CQmkJ5akZqemFqQWwWRlODiUJHijQIYKFqWmp1akZeaUIKSZODhBhnNJiRSn5qWkFiWWlmTE
	g+I3vhgYwSApHqC9NSDtvMUFiblAUYjWU4y6HPO+fPjGKMSSl5+XKiXOO0MWqEgApCijNA9u
	BSy5vWIUB/pYmNcdZBQPMDHCTXoFtIQJaInx2k0gS0oSEVJSDYzlfZt3JwVMnfmDbc7k965n
	mqfGybIIH73Mc/1NzsevjhY7pdZEZ4VtvVr2cveMqVdXLryrtm2Sgpxv4ZSaxtUT 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239525>

On 12/19/2013 01:04 AM, Jeff King wrote:
> On Wed, Dec 18, 2013 at 11:44:58PM +0100, Michael Haggerty wrote:
> 
>> [While doing so, I got sidetracked by the question: what happens if a
>> prune process deletes the "objects/XX" directory just the same moment
>> that another process is trying to write an object into that directory?
>> I think the relevant function is sha1_file.c:create_tmpfile().  It looks
>> like there is a nonzero but very small race window that could result in
>> a spurious "unable to create temporary file" error, but even then I
>> don't think there would be any corruption or anything.]
> 
> There's a race there, but I think it's hard to trigger.
> 
> Our strategy with object creation is to call open, recognize ENOENT,
> mkdir, and then try again. If the rmdir happens before our call to open,
> then we're fine. If open happens first, then the rmdir will fail.
> 
> But we don't loop on ENOENT. So if the rmdir happens in the middle,
> after the mkdir but before we call open again, we'd fail, because we
> don't treat ENOENT specially in the second call to open. That is
> unlikely to happen, though, as prune would not be removing a directory
> it did not just enter and clean up an object from (in which case we
> would not have gotten the first ENOENT in the creator). [...]

The way I read it, prune tries to delete the directory whether or not
there were any files in it.  So the race could be triggered by a single
writer that wants to write an object to a not-yet-existent shard
directory and a single prune process that encounters the directory
between when it is created and when the object file is added.

But that doesn't mean I disagree with your conclusion:

> So it seems unlikely and the worst case is a temporary failure, not a
> corruption. It's probably not worth caring too much about, but we could
> solve it pretty easily by looping on ENOENT on creation.

Regarding references:

> On a similar note, I imagine that a simultaneous "branch foo/bar" and
> "branch -d foo/baz" could race over the creation/deletion of
> "refs/heads/foo", but I didn't look into it.

Deleting a loose reference doesn't cause the directory containing it to
be deleted.  The directory is only deleted by pack-refs (and then only
when a reference in the directory was just packed) or when there is an
attempt to create a new reference that conflicts with the directory.  So
the question is whether the creation of a loose ref file is robust
against the disappearance of a directory that it just created.

And the answer is "no".  It looks like there are a bunch of places where
similar races occur involving references.  And probably many others
elsewhere in the code.  (Any caller of safe_create_leading_directories()
is a candidate problem point, and in fact that function itself has an
internal race.)  I've started fixing some of these but it might take a
while.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
