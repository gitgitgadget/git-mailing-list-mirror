From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 5/5] run-command: Error out if interpreter not found
Date: Fri, 27 Jan 2012 02:48:45 -0600
Message-ID: <20120127084845.GC806@burratino>
References: <1327444346-6243-1-git-send-email-fransklaver@gmail.com>
 <1327444346-6243-6-git-send-email-fransklaver@gmail.com>
 <20120124232421.GH8222@burratino>
 <op.v8moybu10aolir@keputer>
 <4F205028.4060606@kdbg.org>
 <7vr4ym2rad.fsf@alter.siamese.dyndns.org>
 <CAH6sp9NEnkDY-BCccW9VM3waxg8sG8zV5-rVAuMUfZ9rji4-Qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
To: Frans Klaver <fransklaver@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 27 09:48:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqhUP-0001he-BM
	for gcvg-git-2@lo.gmane.org; Fri, 27 Jan 2012 09:48:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752526Ab2A0Isw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jan 2012 03:48:52 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:43783 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751029Ab2A0Isv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jan 2012 03:48:51 -0500
Received: by iacb35 with SMTP id b35so1793471iac.19
        for <git@vger.kernel.org>; Fri, 27 Jan 2012 00:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=vwu6Fvi6Fy6uFqRfv7bCf9vLjf3dek0KhEGDrVVNHEE=;
        b=uU96j3UgD2mvz0N+v93YhiNGnL6CdMvOHHSZH2xZlt60/yy/Rmfs+WlLzmL5Vn0CXT
         vRZ6lxue4OOdiI+fqBn0nUqYjRyDiKssM7ceINJ1+nyzAfgdM4NQ/O2cIWjZ27j+nCPt
         2d8Hvjr0Bx172YXF+671Th20xEBT3giNQmJFY=
Received: by 10.50.180.198 with SMTP id dq6mr5613214igc.27.1327654130634;
        Fri, 27 Jan 2012 00:48:50 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id pb6sm3401871igc.5.2012.01.27.00.48.49
        (version=SSLv3 cipher=OTHER);
        Fri, 27 Jan 2012 00:48:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAH6sp9NEnkDY-BCccW9VM3waxg8sG8zV5-rVAuMUfZ9rji4-Qw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189205>

(+cc: Jeff because mentioning a pagination side-issue [*])
Frans Klaver wrote:

>                                            If this was pretty much
> going to be /dev/null'ed from the beginning, I'd rather have heard it
> after my first patches.

Almost always when a developer has an itch, it is _possible_ to
massage a patch that scratches it into something acceptable to others.
And whether it is worth the trouble in terms of time is something that
only that developer can decide.

So no, I would not say these patches were not doomed from the
beginning.  However, I certainly agree that in their current form they
are more complicated than the use case justifies.

There is a tension between requirements that leaves me oddly
uncomfortable with the series:

a. on one hand, it would be nice to preserve all the current features
   of execvp(), which makes the approach of only doing post-mortem
   analysis after a failed execvp appealing;

b. on the other hand, it would be nice [*] to avoid launching a pager
   only in order to call execvp for a command that does not exist when
   the fallback might be to an alias to a command that does not want a
   pager.  That would require figuring out in advance that execvp
   would fail with ENOENT and missing out on possible system extensions
   that allow execvp to run shell built-in commands not existing on
   the filesystem.

I want to like (b), but the downside seems unacceptable.  I honestly
don't know if something like (a) would be a good idea if well
executed, so I was happy to have the opportunity to try to help
massage these patches into a form that would make the answer more
obvious.
