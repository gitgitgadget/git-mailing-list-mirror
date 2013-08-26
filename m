From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [RFC/PATCH] Fix path prefixing in grep_object
Date: Mon, 26 Aug 2013 13:07:43 -0400
Message-ID: <CABURp0okEN7cHF2ZWmk-8jf0QFmJN3p-P2bHvF2BH=ws7ne7wA@mail.gmail.com>
References: <1377394558-371-1-git-send-email-hordp@cisco.com>
 <CABURp0qG7Nnjpp17MAO7Ltwf51EsswZ3GcT-qyt14Vs1tc9pGw@mail.gmail.com>
 <xmqqa9k6moif.fsf@gitster.dls.corp.google.com> <20130825042314.GE2882@elie.Belkin>
 <xmqqk3jal4t7.fsf@gitster.dls.corp.google.com> <xmqqfvtwkjp8.fsf@gitster.dls.corp.google.com>
 <CABURp0oGMTEgX3TKKEMAOxe6T0=uij+bAyc+5u0x_UHwEPo3CQ@mail.gmail.com>
 <xmqqr4dgifp5.fsf@gitster.dls.corp.google.com> <CABURp0odEGgZO1yWFgXS+akPb4wJHiTLoQcmqBd00oYnPZ77vA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>, Phil Hord <hordp@cisco.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 26 19:08:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VE0Gx-0007XR-6i
	for gcvg-git-2@plane.gmane.org; Mon, 26 Aug 2013 19:08:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752286Ab3HZRIG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 13:08:06 -0400
Received: from mail-vc0-f182.google.com ([209.85.220.182]:47611 "EHLO
	mail-vc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752158Ab3HZRIF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 13:08:05 -0400
Received: by mail-vc0-f182.google.com with SMTP id hf12so2301734vcb.27
        for <git@vger.kernel.org>; Mon, 26 Aug 2013 10:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Wv20WBCguor8ZTiquebE/FcfO62AzfPOcqe6J+6WCc4=;
        b=gG8cSJcPK8n9UoKbTfV5vaSCBrc/4j5+EK8NGj9KawGz3MQfUuteBE8A4POaKEKGBs
         QvTS1Y5KsZg1goO+r+NXqUZhva2mymObs0gC/NonIUXLqa48H3JISWwS4cFKEPv2zCEI
         pNOUcb+THt3ngmGDH4DVOWMt2C/yhjgt+WBxLI2Qg1gqvMjFvcDismxErkQq3Erg/baL
         5lfVGquIhjwAjrJxYQ0qc98nYphrdtM3zFBFrUKz6Qs4rf8ubSXy6t2GUUCLnr6kdeNh
         Fuue19UsavZkOZG/e+Iiwjc2oPqPyc2do+YNBoxvl9HDknb7Hi3aenyRlAqKCsnK+FA4
         zxVA==
X-Received: by 10.58.201.69 with SMTP id jy5mr1011219vec.29.1377536883833;
 Mon, 26 Aug 2013 10:08:03 -0700 (PDT)
Received: by 10.58.49.197 with HTTP; Mon, 26 Aug 2013 10:07:43 -0700 (PDT)
In-Reply-To: <CABURp0odEGgZO1yWFgXS+akPb4wJHiTLoQcmqBd00oYnPZ77vA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233005>

On Mon, Aug 26, 2013 at 12:49 PM, Phil Hord <phil.hord@gmail.com> wrote:
> If so, then I would like to point out to you the convenience I
> accidentally encountered using this tool.  Perhaps you didn't realize
> how helpful it was when you chose to use a colon there.

My itch comes from a case where I am looking for references in some
other branch and I want to narrow my search.

  $ git grep object origin/master
  origin/master:.gitignore:/git-count-objects
  origin/master:.gitignore:/git-fsck-objects
  origin/master:.gitignore:/git-hash-object
  <8600 lines more deleted>

I find hits in the region that interests me and then I try to zoom in
there.  Conveniently, the path I want to search is right there on my
screen.  So I copy the part of the object reference I want to limit my
search to, and I try again:

   $ git grep object origin/master:builtin/

Now, I find the file that has the code I wanted.  But I want to do
something fancier to it than grep, so this time I copy-and-paste the
filename into my command line after typing 'git show':

   $ git show origin/master:builtin/pack-objects.c | vim -

But this doesn't work if the delimiter used was a colon.

   $ git show origin/master:builtin:pack-objects.c | vim -

I have to edit my copy-and-pasted text, which means I have think about
it a bit, and it interrupts all the other things I was thinking about
already.  Eventually I might learn to do this edit automatically,
except it is not needed most of the time.  It is only needed when I
provide a tree-path instead of a "branch <space> path". In the latter
case, the full path is spelled out for me correctly.  And in all other
cases the filenames provided by git-grep are valid filenames or object
names.
