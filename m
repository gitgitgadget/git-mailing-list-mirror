From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Re: [PATCH] Added initialize and update support for submodule in git clone
Date: Wed, 9 Jan 2008 12:05:26 +0600
Message-ID: <7bfdc29a0801082205m383dc32bm19af0032efb1637a@mail.gmail.com>
References: <7bfdc29a0801071922h3656a576wbd87e84bfa663d5a@mail.gmail.com>
	 <7vr6gsx2j5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 09 07:06:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCU4a-00086o-Gg
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 07:05:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbYAIGF3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 01:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbYAIGF3
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 01:05:29 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:7724 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940AbYAIGF2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 01:05:28 -0500
Received: by fg-out-1718.google.com with SMTP id e21so130785fga.17
        for <git@vger.kernel.org>; Tue, 08 Jan 2008 22:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ayaJ6IXWdVUIoPEWRmqEK0j+TqYCoLR/GfdNQGU1IO8=;
        b=NW3u4+2i02fN68px1q3F6GXMbfnWGhBKQinWWf7VY65T6dHcSiiQayd5jjQmIg2pjQZhnfgaBZu+cy33ocBEHjXvdVpRJ7pEIXa20KwJDWSqYGHwUEn0Vj3oFRtja/D7r1d7x6gW97NzbRJUQUrL7p76Lc20KqOZgtmtZGySCEY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Z24SwdFvFjUENUHd7YkRbYpG6Kd6utVlZkII2vG94zbUfntRIIoCFiWCjM5RkNI2W1mVGfYaUmxpOvGYDMC7EkUOGdipMqllVnEBT/D3uy26816t3eJM/vQfvcA8y2cpKVAZjC+nqVW2Cl4p3fjXbT1dJlI45+T4SpmGoHb0nk4=
Received: by 10.78.183.8 with SMTP id g8mr77688huf.55.1199858726280;
        Tue, 08 Jan 2008 22:05:26 -0800 (PST)
Received: by 10.78.50.5 with HTTP; Tue, 8 Jan 2008 22:05:26 -0800 (PST)
In-Reply-To: <7vr6gsx2j5.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69955>

Thanks again Junio.

I will resend the patch with the latest code base. After implementing
I also felt that it is not logical to go all way down, so I was
thinking of adding -l | --level with -w or use --depth already in use;
that will add some flexibility; what do you thing about this? I will
make the similar changes you mentioned in the earlier email in this as
well.

I was actually concerned about unsetting and re-setting the
environment variables. Is there a alternate to it?

Thank you,

Imran

On Jan 8, 2008 12:19 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "Imran M Yousuf" <imyousuf@gmail.com> writes:
>
> > This patch adds support for initializing and updating submodules when
> > a repo is cloned. The advantage it adds is, the user actually does not
> > have to know whether it has a module or not and if it does to what
> > depth and path. For this I added a option -w or --with-submodule for
> > initializing and updating during clone stage.
>
> For everything else, I strongly agree [*1*] that the notion that
> all subprojects are populated is a bug.  I am not convinced the
> all-or-nothing approach you implemented in "git clone" is useful
> outside small toy projects where all of your users are almost
> always interested in everything (which inevitably invites a very
> valid question: why use submodule at all then?), but in the very
> narrow special case of "clone", all-or-nothing is the best you
> can do without giving additional hints somewhere in-tree
> (perhaps enhanced .gitmodules entries), and it certainly is
> better than "you do not have any choice --- you only get the
> toplevel".
>
> > Following is the diff with git-clone 1.5.3.7; I also attached the diff
> > and modified file in the attachment.
>
> The same comment as diff plus attachment applies to this patch
> as the other message.  Also please do not base new development
> on 4-digit maintenance releases, which are meant to contain only
> bugfixes and no new features.  A patch like this, primarily for
> discussion and not for immediate inclusion, is Ok, but it is
> better to get into the habit of producing applicable patches
> earlier rather than later.
>
> I'll step aside and let others discuss code and design of the
> patch.
>
> [Reference]
>
> *1* http://thread.gmane.org/gmane.comp.version-control.git/44106/focus=44308
>



-- 
Imran M Yousuf
Entrepreneur & Software Engineer
Smart IT Engineering
Dhaka, Bangladesh
Email: imran@smartitengineering.com
Mobile: +880-1711402557
