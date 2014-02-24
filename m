From: Philippe Vaucher <philippe.vaucher@gmail.com>
Subject: Re: git gc --aggressive led to about 40 times slower "git log --raw"
Date: Mon, 24 Feb 2014 10:27:26 +0100
Message-ID: <CAGK7Mr71S608FtNWYvxHdSrCiEUuQicVy3xojNmwDSODufmsxw@mail.gmail.com>
References: <CAEjYwfU==yYtQBDzZzEPdvbqz1N=gZtbMr5ccRaC_U7NfViQLA@mail.gmail.com>
 <87r470ssuc.fsf@fencepost.gnu.org> <CACsJy8D9tws_gu6yWVdz3t+Vfg5-9iorptn4BLnTL3b+YWcHzQ@mail.gmail.com>
 <87ioscsoow.fsf@fencepost.gnu.org> <20140218155842.GA7855@google.com>
 <xmqqzjlocf28.fsf@gitster.dls.corp.google.com> <CACsJy8AEXP45K+r3gGVTWbn4uuPLeHOkf-an20rj77QSfG1-ew@mail.gmail.com>
 <xmqq4n3warni.fsf@gitster.dls.corp.google.com> <CACsJy8C+wGd9WxnsML6-_G_S5GtN2pCPf09kcFtBVu-SDfP8YA@mail.gmail.com>
 <CAGK7Mr4wpwUK6UF6vTmgszX4sajPDvQazY2QagFfH9BEJx_9Ow@mail.gmail.com>
 <xmqqd2ij9be1.fsf@gitster.dls.corp.google.com> <CACsJy8AeZWPz=39ySQr9MrSUiLyJDQbs02sumS9VjbbGWzP9pw@mail.gmail.com>
 <xmqqzjlk4atj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Duy Nguyen <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	David Kastrup <dak@gnu.org>,
	Christian Jaeger <chrjae@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 24 10:28:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHrpU-0001I6-NJ
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 10:28:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751600AbaBXJ16 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 04:27:58 -0500
Received: from mail-ob0-f169.google.com ([209.85.214.169]:65122 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751391AbaBXJ15 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 04:27:57 -0500
Received: by mail-ob0-f169.google.com with SMTP id wn1so1717315obc.14
        for <git@vger.kernel.org>; Mon, 24 Feb 2014 01:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=5SzCy/ytrEAzQixcw6cygsoUnVcUShqKAgYKocLnyfI=;
        b=fj1bcD6PocUteM5r+Gz4RWBjQ398yBCF9rb2uLM1jb9e9oZLG8ChIhj+ZI5spfYiDN
         5b3zlSHovMzBDkK5q7MBVFmLUpTMKHmAQgxyw9Q3sHe021O4jKUnOJayRXGzQxzmEFzn
         WeANg/fJV3hVRl0jhJnKstTAkFsMBg4a4kYToDVi70pgJ6erU1EJrf+ptoSjkTkYuo1v
         lDJ7ZfmM1ZqmPK0RgVEuBUlmZY1os5fb1v7OMu1VRWEcBZJ25vyBKaj2oXYXxc+nYIAM
         Z9/ItMo46LRWWANckT/wPlxzc9W6Z7DkQBqFDAwvyiEh8AeMfoKinhz4ERfLoiBQca+x
         Q2lw==
X-Received: by 10.182.122.133 with SMTP id ls5mr16325897obb.52.1393234076581;
 Mon, 24 Feb 2014 01:27:56 -0800 (PST)
Received: by 10.76.85.233 with HTTP; Mon, 24 Feb 2014 01:27:26 -0800 (PST)
In-Reply-To: <xmqqzjlk4atj.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242584>

> I used to repack older part of history manually with a deeper depth,
> mark the result with the .keep bit, and then repack the whole thing
> again to have the remainder in a shallower depth.  Something like:
>
>         git rev-list --objects v1.5.3 |
>         git pack-objects --depth=128 --delta-base-offset pack
>
> would give me the first pack (in real life, I would use a larger
> window size like 4096), and then after placing the resulting .pack
> and .idx files along with a .keep file in .git/objects/pack/,
> running "git repack -a -d" to pack the rest.

I'm curious, after these repacking, how do you guys publish these
packs? git push? if yes, on what criteria does the remote repo know
which pack it should fetch?

Or maybe it's only a local operation and thus you cannot do it on the
remote without ssh access?

Philippe
