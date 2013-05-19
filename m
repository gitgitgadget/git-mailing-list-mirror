From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC] New kind of upstream branch: base branch
Date: Sun, 19 May 2013 03:12:32 -0500
Message-ID: <5198897048728_76e0f31e20807dc@nysa.mail>
References: <CAMP44s3LQ0GN4rrXdpb8Fe0iLeAEm2VjkH6BHK64pmX-xpc7+Q@mail.gmail.com>
 <51968311.1020107@bracey.fi>
 <7va9ntxu3w.fsf@alter.siamese.dyndns.org>
 <51979065.4060609@bracey.fi>
 <7vbo871obk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Kevin Bracey <kevin@bracey.fi>
X-From: git-owner@vger.kernel.org Sun May 19 10:25:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Udyw2-0002Wj-Q5
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 10:25:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753871Ab3ESIZi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 04:25:38 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:42495 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753849Ab3ESIZe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 04:25:34 -0400
Received: by mail-ob0-f182.google.com with SMTP id va2so6057467obc.27
        for <git@vger.kernel.org>; Sun, 19 May 2013 01:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:message-id:in-reply-to:references
         :subject:mime-version:content-type:content-transfer-encoding;
        bh=zFUEr4tfDoBrfalqAtkLPI7aAzGb13Mo4ESYSIl0tAc=;
        b=NVxB8fYpGwFmRfIcZhQj+2KEzi/YoMG30BBWLd4K3nAR9DI1MtMsIzzM1+Gsbh10nK
         eLb3w2PZwFJFxx0I0XgNyFDRY8RkxkPqsiVm/TJF4dr9aP8YGU31bD3BQydRZvoosbyG
         wJKxM0uKdVMcsD/BJl5y84GqKK+G1ak1F/2z2otqjespe7GrRaBzcfxMs/OI/wzw7rSW
         gbWDI/u6UO/MH6gO+6cRut5wRfOulihmjYG2dLESNY0+L0dklTVMMyHAYbFAOwyUmGNe
         /dJofQ20wX8zIRYObLCeZzdzxJcpfBrDBtNfLhbAqW1jWQu/1L3bvkKIbx0pEfl1LdNk
         BZ1Q==
X-Received: by 10.60.120.34 with SMTP id kz2mr26860273oeb.17.1368951933630;
        Sun, 19 May 2013 01:25:33 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id ku7sm15144022obc.6.2013.05.19.01.25.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 19 May 2013 01:25:32 -0700 (PDT)
In-Reply-To: <7vbo871obk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224830>

Junio C Hamano wrote:
> Kevin Bracey <kevin@bracey.fi> writes:

> > And it would be ideal if the initial base and push tracking
> > information could be set up automatically on the first "git checkout
> > -b"/"git branch" and "git push".
> 
> I think checkout and branch is already covered with -t.  There may
> even be a configuration option to implicitly add -t to them (I
> didn't check).

branch.autosetupmerge=always

> > (For one, I've always found it odd
> > that there's an asymmetry - if you check out a topic branch from the
> > server to work on or use it, you get a local copy with upstream set by
> > default. But if you create a topic branch yourself then push it, the
> > upstream isn't set by default - you need the -u flag. This seems odd
> > to me, and I've seen others confused by this).
> 
> Yeah, I would imagine that it would be trivial to add an option to
> cause "git push" to do that, and it would be useful if you push to
> and pull from the same place (I haven't thought about ramifications
> such an option would have on the triangular workflows, though).

It would work wonderfully. Now:

== remote ==

% git checkout -b master origin/master
# work
% git push

== local ==

% git checkout -b topic master
# work
% git push # ERR
% git push -u origin/master
# work
% git push # ERR

That doesn't work. We could set branch.autosetupmerge=always as the default,
but it still wouldn't work, because push.default=simple (or at least it will
be), and the names don't match.

But with my patches, and branch.autosetupmerge=always (hopefully for 2.0):

== local ==

% git checkout -b topic master
# work
% git push # ERR
% git push --set-downstream origin/master
# work
% git push

Cheers.

-- 
Felipe Contreras
