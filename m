From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: qgit: Annotate hundreds of files at terrific speed ;-)
Date: Mon, 25 Jun 2007 13:20:48 +0200
Message-ID: <e5bfff550706250420s603e36eds9a2bcbb339aac80e@mail.gmail.com>
References: <e5bfff550706242259s143fe874mf82736426e94ecba@mail.gmail.com>
	 <200706250638.l5P6crkS026564@mi1.bluebottle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: GIT <git@vger.kernel.org>
To: "Nanako Shiraishi" <nanako3@bluebottle.com>
X-From: git-owner@vger.kernel.org Mon Jun 25 13:20:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2mcp-0000yV-3W
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 13:20:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbXFYLUu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 07:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbXFYLUu
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 07:20:50 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:38059 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751070AbXFYLUt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 07:20:49 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1767269wah
        for <git@vger.kernel.org>; Mon, 25 Jun 2007 04:20:48 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nyszLIIFM9P+cbn6YUohbIS1WQ+I2zR/iDago6HUM9ANXekw3+WAihei/W+qyGfTqKCG8Yj/ire5F5ddysODS3B4kSGkX1+hToLBXbws4mCGjXqr4rJtcF9fIh0llxuEdeh9HC05wxhwOOn+MxNSOHuERNnfjIp2TLYsLJrHqRI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rWEMknOvgpOqCRHSDkpJ3G2PBqpCtT4PsiuetkEMQ8o5/a09EltqF32IYe9IaiYXWSHdtwEd8Zrb8HZ7L+v8CDkuQioiR67WWq0aTTRoA1V4qQDA5UO/cE8YEGxI5aa7ArGuamR8agvSRMBIG/54VzMgzrEQSqduCkccOvMx8Sw=
Received: by 10.114.155.1 with SMTP id c1mr5335692wae.1182770448399;
        Mon, 25 Jun 2007 04:20:48 -0700 (PDT)
Received: by 10.114.61.9 with HTTP; Mon, 25 Jun 2007 04:20:48 -0700 (PDT)
In-Reply-To: <200706250638.l5P6crkS026564@mi1.bluebottle.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50890>

On 6/25/07, Nanako Shiraishi <nanako3@bluebottle.com> wrote:
>
> >> Marco Costalba <mcostalba@gmail.com> wrote:
> >
> > - filtering, ie selecting with the mouse some lines and getting a
> > subset of the file history that modified at least one of that lines is
> > not possible.
>
> I often use "git blame -L'/regexp/,/regexp/'" (you can use line
> numbers there, too).  Is this different from what you talk above?
>

Yes it.

Suppose you have selected file lines from 20 to 23 in revision A.

Revision history it's the following, in cronological order:

A (oldest) -> B - > C (newest)

Say that in revision B the patch removed 5 lines from 5 to 10 and
added 2 new lines instead.

Now when you jump from A to revision C you may want to see selected
the lines (-5 + 2 = -3) from 17 to 20 and no more the lines from 20 to
23 that will point to a different content.


In a general case jumping from a revision A to a revision N you have to:

- get the list of intermediate revision

- for each revision calculate deleted/ added content that is before
the selected lines range.

- for each revision calculate deleted/ added content that CROSSES the
selected range, so that if in our example revision B adds also 2 new
lines in position 21 the selection in C will not be 17 to 20 but 17 to
22!  The same logic in case of deleted lines in selected range.

So to keep a "consistent" mouse selection when jumping to different
file revisions you really need to know all the annotate history in
between.


Marco
