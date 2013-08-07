From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] git exproll: steps to tackle gc aggression
Date: Wed, 7 Aug 2013 10:13:13 +0530
Message-ID: <CALkWK0kmx8bi1ZT1CSk+iVnmmQJV4bNu1D7h1AHnRk7_TfhJ3Q@mail.gmail.com>
References: <1375756727-1275-1-git-send-email-artagnon@gmail.com>
 <CACsJy8CGWJ07Uk8EBjfejdyshKB1NKk=_7VUoeyZWZgJFqCSkg@mail.gmail.com> <7v61vihg6k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>, Martin Fick <mfick@codeaurora.org>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 07 06:44:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6vbM-0007jy-EP
	for gcvg-git-2@plane.gmane.org; Wed, 07 Aug 2013 06:44:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752460Ab3HGEny (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Aug 2013 00:43:54 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:44422 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751525Ab3HGEny (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Aug 2013 00:43:54 -0400
Received: by mail-ob0-f175.google.com with SMTP id xn12so2780312obc.6
        for <git@vger.kernel.org>; Tue, 06 Aug 2013 21:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=8A9dCFdrisq4Xv/bsWQIOKz0bZDeFke18EzxF47WOfY=;
        b=NCvf/DCPXbDftFy7CQmICmCihC3tcMgXuAuatVl27mBYgCM2CYPj2KOnd6qkggz0UX
         0f4oNebkCHG7MlY7SLVL6gUyq9/TCl0cW8jyyWTeeFWaOnzo8xsQ2DcFNA2oguOI9aVH
         0Lnrgo6TCYarX4nu214Ki6rn8FgSNXjB7bQCNJEKirWYD4rdheyxaSOgHbo2J7616Zol
         9W7/VWjDEiWOalif/YS70SA8J39r7g0RVICAKCTCLKklVUx+q869GNuKhvDqiXSIVi0J
         uhh/g18gWgONmqAwnEfEHjlLmsaigx0h5YRB0PjH+myghLAq0TYf19EVztgD79f+x7r0
         dw6g==
X-Received: by 10.43.88.3 with SMTP id ay3mr104638icc.61.1375850633623; Tue,
 06 Aug 2013 21:43:53 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Tue, 6 Aug 2013 21:43:13 -0700 (PDT)
In-Reply-To: <7v61vihg6k.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231805>

Junio C Hamano wrote:
> Imagine we have a cheap way to enumerate the young objects without
> the usual history traversal.

Before we discuss the advantages, can you outline how we can possibly
get this data without actually walking downwards from the roots
(refs)? One way to do it is to pull data out of a log of ref updates
(aka. reflog), but we both know how unreliable that can be.
