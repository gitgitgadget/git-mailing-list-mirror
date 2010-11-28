From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC v3 resend 0/4] fast-import: Let importers retrieve blobs
Date: Sun, 28 Nov 2010 13:41:31 -0600
Message-ID: <20101128194131.GA19998@burratino>
References: <1287147256-9457-1-git-send-email-david.barr@cordelta.com>
 <1287147256-9457-2-git-send-email-david.barr@cordelta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
To: David Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Sun Nov 28 20:41:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMn85-0002Sz-W0
	for gcvg-git-2@lo.gmane.org; Sun, 28 Nov 2010 20:41:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753930Ab0K1Tlk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Nov 2010 14:41:40 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:39127 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791Ab0K1Tlj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Nov 2010 14:41:39 -0500
Received: by gwj20 with SMTP id 20so1670634gwj.19
        for <git@vger.kernel.org>; Sun, 28 Nov 2010 11:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=yKOzz3APvAv/Mmn61oDGTWcQb8NMTsnJJ1mhCyqyYY8=;
        b=mvSWyhHb2w9VAU+fCbJdTNA0nNUg96jYElThMrIxYMgn1XxHs00QXRnx8kOxbkgsIc
         2urLwuBKNAB6jl/2tdPUDfOdxCUiGRRebC9rPjWhoXHWaUIJ/QEqiWMU9JKu5+j9/m+6
         816bvjEivYoXPRV13QJvoFWr4yQ/nkjIL+52A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=BZCs52v0Jw9glZKXUUB7zqmopEVWSvipC783oBDbP7j/fxAbE47xxMKm1IAqg7CWhq
         oMVDlSb1zZQA2Uj3oUYxqDgVf+FByYh0FBFfxrB950rrYQLYbnMFpODZChOYII82exxd
         ZRpY2LS/EXX0x5pvWCGZUXIzfiyim9Jt44F9I=
Received: by 10.151.38.9 with SMTP id q9mr4516073ybj.222.1290973298625;
        Sun, 28 Nov 2010 11:41:38 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id 37sm4817652anr.24.2010.11.28.11.41.35
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 28 Nov 2010 11:41:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1287147256-9457-2-git-send-email-david.barr@cordelta.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162354>

[resending since git@vger doesn't seem to have accepted the previous
copy.  Sorry for the noise.]

David Barr wrote:

> So introduce another way: a "cat-blob" command introduced in the
> command stream requests for fast-import to print a blob to stdout
> or a file descriptor specified by the argument --cat-blob-fd.
> 
> The output uses the same format as "git cat-file --batch".

I am very fond of this patch.  Still, the fact remains that until this
command is implemented by some other fast-import backend, it is hard
to know what git-specific concepts are encoded in its current
implementation.  (I am in particular worried about what should be
gauranteed about the blob_identifier in the

	blob blob_identifier 1823

line and whether

	cat-blob blob_name
	cat-blob :11

are going to overlap and cause trouble for some backends.)

On the other hand, development of svn-fe continues to benefit from
cat-blob and its cousins ls-tree and ls[1].  and there has been brief
discussion of using cat-blob to make cvs2git more friendly.  So here's
a reroll, since it seems clear that this feature should be in future
versions of fast-import in some form.

Thoughts welcome, as always (even as simple as "I have a bad feeling
about this" or "everything in this patch looks ready to go").

Patches based against v1.7.0.7 for no particular reason.

David Barr (1):
  fast-import: let importers retrieve blobs

Jonathan Nieder (3):
  fast-import: stricter parsing of integer options
  fast-import: clarify documentation of "feature" command
  fast-import: Allow cat-blob requests at arbitrary points in stream

 Documentation/git-fast-import.txt |   76 ++++++++---
 fast-import.c                     |  128 ++++++++++++++++--
 t/t9300-fast-import.sh            |  267 ++++++++++++++++++++++++++++++++++++-
 3 files changed, 442 insertions(+), 29 deletions(-)

[1] ls-tree commit_name "path/to/file" would have output format
100644 blob blob_identifier	path/to/file and within a commit
command, ls "path/to/file" would produce output in the same
format.
