From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] fast-export: Allow pruned-references in mark file
Date: Mon, 26 Nov 2012 15:04:21 +0100
Message-ID: <CAMP44s3Xo2ko6X1-SO3hLiTYHA3+i912jTGOQCUihixxcbEuRQ@mail.gmail.com>
References: <1353750432-17373-1-git-send-email-apelisse@gmail.com>
	<7vd2z1xb6c.fsf@alter.siamese.dyndns.org>
	<CAMP44s0iSkqcOW0YsD=Jm_=x1tuoRbFQ+EbVvkROa_yY2-WFcA@mail.gmail.com>
	<CALWbr2yZpAT=eSahGcGKw5weoz1MjTzbb16pdQndKDFcn_3VJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 15:04:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TczIb-00025e-FC
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 15:04:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753213Ab2KZOEW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 09:04:22 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:65245 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752946Ab2KZOEV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 09:04:21 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so10780727oag.19
        for <git@vger.kernel.org>; Mon, 26 Nov 2012 06:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=F9WzDJQxKX0I8vs1wls7jRwBAPB7zlJd+3LvWUH82Xw=;
        b=c4IEQqtA8Y1Y4h/iXb/AC6nMrr0Al73RSHWKXEAcrYjw9cYbNNo/mVeHrz6yvI9PHh
         krAteiqWzaF9phpopnNzFTZeRtYtahLjsQ4+kAknGNte33grScnugaNk66c7pEXddvv4
         IdgVUnpvHehLkq673VjAHRaugFzSOoa8nf7iv82yPATV/N2UAhwuyBcXSvrGYtStB/LH
         ziJqDjYs/xhhihMR7xmrNDDPutRzsi7MfU3uk/wJz0z4uR3D5VCF+xDjgYmLhWyuS3Nl
         foHKba082tmURuGPpSZMxi5v5utQNvhNS8T/ddcYySrpmoJfb6N+O6MYA0CLN93R6OZN
         e0jQ==
Received: by 10.60.28.166 with SMTP id c6mr9147207oeh.140.1353938661165; Mon,
 26 Nov 2012 06:04:21 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Mon, 26 Nov 2012 06:04:21 -0800 (PST)
In-Reply-To: <CALWbr2yZpAT=eSahGcGKw5weoz1MjTzbb16pdQndKDFcn_3VJg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210449>

On Mon, Nov 26, 2012 at 2:23 PM, Antoine Pelisse <apelisse@gmail.com> wrote:
> On Mon, Nov 26, 2012 at 12:37 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> On Mon, Nov 26, 2012 at 5:03 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Is this a safe and sane thing to do, and if so why?  Could you
>>> describe that in the log message here?
>> Why would fast-export try to export something that was pruned? Doesn't
>> that mean it wasn't reachable?
>
> Hello Junio,
> Hello Felipe,
>
> Actually the issue happened while using Felipe's branch with his
> git-remote-hg.  Everything was going fine until I (or did it run
> automatically, I dont remember) ran git gc that pruned unreachable
> objects. Of course some of the branch I had pushed to the hg remote
> had been changed (most likely rebased).  References no longer exists
> in the repository (cleaned by gc), but the reference still exists in
> mark file, as it was exported earlier.  Thus the failure when git
> fast-export reads the mark file.

Ah, I see, so these objects are _before_ fast-export tries to do
anything, it's just importing the marks without any knowledge if these
objects are going to be used in the export or not.

If that's the case, I don't think it should throw a warning even just skip them.

Then, in the actual export if some of these objects are referenced the
export would fail anyway (but they won't).

Cheers.

-- 
Felipe Contreras
