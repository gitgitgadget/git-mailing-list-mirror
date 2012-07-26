From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/3] retain reflogs for deleted refs
Date: Thu, 26 Jul 2012 19:47:06 +0700
Message-ID: <CACsJy8BtcvuW2HKPSki7meyHMsvpLS0b8QG5M_083HEwy=-9EQ@mail.gmail.com>
References: <20120719213225.GA20311@sigill.intra.peff.net> <20120719213311.GA20385@sigill.intra.peff.net>
 <50092993.6010203@alum.mit.edu> <20120720154403.GB2862@sigill.intra.peff.net>
 <5009892E.9010808@kdbg.org> <20120720170913.GA14057@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j6t@kdbg.org>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Alexey Muranov <alexey.muranov@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 26 14:47:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuNTi-0004mq-N2
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 14:47:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752145Ab2GZMrj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 08:47:39 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:43143 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999Ab2GZMrh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 08:47:37 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so2633319obb.19
        for <git@vger.kernel.org>; Thu, 26 Jul 2012 05:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=j/b32Oau/oChfFg4XEGxhzqUzprA1koPCEGWpNfNcVM=;
        b=uUaqosgltk6m1mr4moadeNv0iw9kFbeXo1HLAiQWn7CM8yYWpiRj7pn1qCCT4nNxNL
         Ao1IwpjWuLgGSEeES11UcGjlTe6S9A4Xkv5eP9LDwARwePfmNvr4xq0ZfUNn7piC2VXI
         1c1pRDhupqwCG1eW77Anq0tnny5X8dOHKI+J9FQXKoq+oRRUnufU3gmD0uSa8QCIh5AD
         unp5w+9Oai4gaNveb7BZ8WyONnPqhwHHXZ/Hr66OfcvKqEqk8v1212oQDTwnYNsSFK+O
         uQi/kQd8MNYwwiPVNsi3IlXhbfadJCIGngePfuUDlUQstVS/5fSj/8qZf5LaDjb7tVPF
         r3Zg==
Received: by 10.182.16.3 with SMTP id b3mr41192194obd.72.1343306856861; Thu,
 26 Jul 2012 05:47:36 -0700 (PDT)
Received: by 10.182.177.67 with HTTP; Thu, 26 Jul 2012 05:47:06 -0700 (PDT)
In-Reply-To: <20120720170913.GA14057@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202259>

On Sat, Jul 21, 2012 at 12:09 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Jul 20, 2012 at 06:37:02PM +0200, Johannes Sixt wrote:
>
>> Am 20.07.2012 17:44, schrieb Jeff King:
>> > So I think a suffix like ":d" is probably the least horrible.
>>
>> Not so. It does not work on Windows :-( in the expected way. Trying to
>> open a file with a colon-separated suffix either opens a resource fork
>> on NTFS or fails with "invalid path".
>
> Bleh. It seems that we did too good a job in coming up with a list of
> disallowed ref characters; they really are things you don't want in your
> filenames at all. :)

So we haven't found any way to present both branches "foo" and
"foo/bar" on file system at the same time. How about when we a new
branch introduces such a conflict, we push the new branch directly to
packed-refs? If we need either of them on a separate file, for fast
update for example, then we unpack just one and repack all refs that
conflict with it. Attempting to update two conflict branches in
parallel may impact performance, but I don't think that happens often.
-- 
Duy
