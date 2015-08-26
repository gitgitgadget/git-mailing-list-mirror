From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 2/2] trailer: support multiline title
Date: Wed, 26 Aug 2015 16:53:55 +0200
Message-ID: <CAP8UFD2x8i5wC9JP8d1zAH=d-2BMYWAvpaFmWnu09N5QSG==TA@mail.gmail.com>
References: <1440557461-1078-1-git-send-email-chriscool@tuxfamily.org>
	<1440557461-1078-2-git-send-email-chriscool@tuxfamily.org>
	<vpqa8tetwfi.fsf@anie.imag.fr>
	<CA+P7+xqaAKckB0P5oqFS64BWU2H1OsVX8Oq=CLLW8PMJ5fdenQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 26 16:54:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUc5Y-0003rJ-Fl
	for gcvg-git-2@plane.gmane.org; Wed, 26 Aug 2015 16:54:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756312AbbHZOx5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2015 10:53:57 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:35743 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755183AbbHZOx4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2015 10:53:56 -0400
Received: by igbjg10 with SMTP id jg10so42025446igb.0
        for <git@vger.kernel.org>; Wed, 26 Aug 2015 07:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=mWFvVvyqyqHGgWlP1thRWIeRi7YaLaYrldeS3x1a26Q=;
        b=CuFcz+xZXMMShXy3t8V7TLOSiyaN9YcpP3B4+0y4OowaRGFM/KTCWnPaC8teJ6/MvN
         DevnvNhIS/JEJk+k3EzIPTW8pGqNs7/9X1yP6DXodtXQyxZoxqiQd2n1FthNuEY8plbg
         lSTV3HYlROfvdTIEFe9EMMtjivnjIPK+MRYxIOM3AIAkuso6i3Rz4ovM/PszBRNxX4LB
         JnSMUc7FbnWlPrGfHrbS/QkKSVnjAuth0GkdYFONV0qpx2ml9n05VoNoZ5QDs+l4lbPe
         QpzcvkoRZNQU83pNoRxUosuTB+75/PLMC0ZFPbGSrcUfSOij8/+V4n9Aw0pp01pofuct
         obNg==
X-Received: by 10.50.59.180 with SMTP id a20mr4478563igr.31.1440600835586;
 Wed, 26 Aug 2015 07:53:55 -0700 (PDT)
Received: by 10.79.93.131 with HTTP; Wed, 26 Aug 2015 07:53:55 -0700 (PDT)
In-Reply-To: <CA+P7+xqaAKckB0P5oqFS64BWU2H1OsVX8Oq=CLLW8PMJ5fdenQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276608>

Sorry I sent the part below privately by mistake:

On Tue, Aug 25, 2015 at 11:07 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
>
> Now, I found another issue: I still have this "interpret-trailers" in my
> hooks/commit-msg, and it behaves badly when I use "git commit -v". With
> -v, I get a diff in COMMIT_EDITMSG, and interpret-trailers tries to
> insert my Sign-off within the diff, like this:
>
>   # Do not touch the line above.
>   # Everything below will be removed.
>   diff --git a/git-multimail/README b/git-multimail/README
>   index f41906b..93d4751 100644
>
>   Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
>   --- a/git-multimail/README
>   +++ b/git-multimail/README

This might be a bug. I will have a look.

> Either commit-msg should be called after stripping the diff from
> COMMIT_MSG, or interpret-trailers should learn to stop reading when the
> patch starts.

There is already code to detect a patch in interpret-trailers, but it
relies on the patch starting with a line with only three dashes.

So another option would be to make "commit -v" emit a line with three
dashes just under the "# Everything below will be removed." line.

> I think the first option is better, since it means that
> any commit-msg hook does not have to deal with the patch stuff (my guess
> is that there are many broken commit-msg hooks out there, but people
> didn't notice because they don't use "commit -v").

Maybe. I don't know if there is a reason why the commit-msg is called
before removing the patch.

On Wed, Aug 26, 2015 at 8:28 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
>
> It's always confused me why commit -v doesn't prepend every inserted
> line with "#" to mark it as a comment.

I think that would make interpret-trailers work properly too.

Thanks both,
Christian.
