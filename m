From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: [PATCH] cmd_reset: don't trash uncommitted changes unless told to
Date: Wed, 25 Jun 2008 16:22:29 -0400
Message-ID: <32541b130806251322l478faa87gc9f2016254689022@mail.gmail.com>
References: <20080624222105.GA24549@dervierte> <48620C1A.6000509@panasas.com>
	 <alpine.DEB.1.00.0806251109380.9925@racer>
	 <486220CE.3070103@viscovery.net>
	 <alpine.DEB.1.00.0806251334060.9925@racer>
	 <20080625135100.GF20361@mit.edu>
	 <7v63rx2zwf.fsf@gitster.siamese.dyndns.org>
	 <20080625195003.GB15077@mit.edu>
	 <32541b130806251304u39c8ffdenc52904391aebd089@mail.gmail.com>
	 <7vlk0tz33n.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Theodore Tso" <tytso@mit.edu>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Johannes Sixt" <j.sixt@viscovery.net>,
	"Boaz Harrosh" <bharrosh@panasas.com>,
	"Steven Walter" <stevenrwalter@gmail.com>, git@vger.kernel.org,
	jeske@google.com
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 22:23:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBbWs-0000a2-SD
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 22:23:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754263AbYFYUWc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 16:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754299AbYFYUWc
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 16:22:32 -0400
Received: from fk-out-0910.google.com ([209.85.128.188]:25649 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751591AbYFYUWb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 16:22:31 -0400
Received: by fk-out-0910.google.com with SMTP id 18so3373400fkq.5
        for <git@vger.kernel.org>; Wed, 25 Jun 2008 13:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=J2fB4VpGKHNH1jy4T8C8hAeeqtbghGdgOEtytUQrFpk=;
        b=qQ1qo57f92hx1Hd0Es+V9ErEz3L5nVJhlxnX+qbJALVZNicVglW1Xfsnj5EHG1HOdp
         0sQVn6kw1qhU07jdY76wh1pobJt/6elxrORMIdyCAGxXB7FobdwEKbhcib2eV4l7/JVr
         eHBOcL2lXurmivRrfajbO72/SSG7L08yiI5cQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=RXj8P59dxK76o5LXmWZ5RRqKm4zWZKSDt04ACbB3Q9ouL9PLQhiXn0/M9esY/LyaOQ
         qc/3qHbpXrYagg2RqyVRdrXo6S9qOgaKHiEVBOC94Mwz/DavW/6kpC27viEzxd0UnpIa
         9Y8H5bVJhbdp/cAICyZ3foPW88Npq8cYjbZ7U=
Received: by 10.82.146.10 with SMTP id t10mr666600bud.51.1214425349559;
        Wed, 25 Jun 2008 13:22:29 -0700 (PDT)
Received: by 10.82.175.10 with HTTP; Wed, 25 Jun 2008 13:22:29 -0700 (PDT)
In-Reply-To: <7vlk0tz33n.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86339>

On 6/25/08, Junio C Hamano <gitster@pobox.com> wrote:
> "Avery Pennarun" <apenwarr@gmail.com> writes:
>
>  > How about making "git checkout" default to HEAD if no revision is
>  > supplied?  There's precedent for this in, say, git-diff (and I think a
>  > few others).
>
> Won't fly.  'git checkout -- "$@"' is to revert to the last staged
>  version.

Ah, I didn't catch the difference between HEAD and index there.

>   * You say "git checkout -- file" when you want to "check out the file
>    from the index";

The real question here is the --.  Is it strictly needed?  It's
optional in things like git-diff, which just do their best to guess
what you mean if you don't use the --.

If reset and checkout made the -- optional, then you could do:

git reset filename         # undo an accidental "add"
git checkout filename  # undo accidental modifications that haven't been added

...and save git reset --hard for people willing to take that risk.
(The fact that git-gui includes git reset --hard as a really
easy-to-click GUI command scared me the first time I saw it, too.)

I think simplifying the syntax might help to make the role of the
index less mysterious in the whole "revert" operation.  It's not
obvious to me at all whether a revert-file ought to get the one from
HEAD or the one from the index.  But I can easily understand and
explain checkout (copy index to working copy) and reset (undo an add).

Thanks,

Avery
