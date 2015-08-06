From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/6] fix repo name when cloning a server's root
Date: Thu, 06 Aug 2015 01:00:12 -0700
Message-ID: <xmqqlhdozw1f.fsf@gitster.dls.corp.google.com>
References: <1437997708-10732-1-git-send-email-ps@pks.im>
	<1438687797-14254-1-git-send-email-ps@pks.im>
	<xmqq4mkd4p1x.fsf@gitster.dls.corp.google.com>
	<20150805211947.GC21134@sigill.intra.peff.net>
	<55C30B2D.5000308@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	git@vger.kernel.org, pclouds@gmail.com
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Aug 06 10:00:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNG6A-0001V7-Fd
	for gcvg-git-2@plane.gmane.org; Thu, 06 Aug 2015 10:00:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755054AbbHFIAQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Aug 2015 04:00:16 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:35800 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755044AbbHFIAO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2015 04:00:14 -0400
Received: by pdrg1 with SMTP id g1so29504629pdr.2
        for <git@vger.kernel.org>; Thu, 06 Aug 2015 01:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=UBLJldwwlOmYA34fnK1/T/lQbMg73VDSD0SF3qCt2Fo=;
        b=hNt3klsv7z/9qsVHHhrzXy02oqLcqhxKrRPadcuslXnwAASeJ2q1MZNKMlIzNcDYEs
         SFXkM9Du2/fbJ9CBMbtWDa7K0AMieuZLdwHWq1XbCuvGJYBVCI19ZVw57jaFzjPXIDp1
         D8iFHPzk2V0wHvns07Zljc0azj/6R09TA2nXQq+zP2SVU7d65jn4PfZdwVdKhNclf0nV
         Fv94nnVO6+ap7K5fFJgY/AQVk6acNNdJncEvB+9ib5N3MJ0B+YKywIJAdo7xNN3cj8Fp
         oQkvzMfRjmTTNTPdJJaT4oyNg9/mElvZJGoD7DsM+hzLFIoLzxGVMbfIkw4c+wk9/cI4
         gSFg==
X-Received: by 10.70.3.4 with SMTP id 4mr689821pdy.103.1438848013846;
        Thu, 06 Aug 2015 01:00:13 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:5cf0:2451:9503:37d])
        by smtp.gmail.com with ESMTPSA id mk6sm5506891pab.9.2015.08.06.01.00.12
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 06 Aug 2015 01:00:13 -0700 (PDT)
In-Reply-To: <55C30B2D.5000308@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Thu, 6 Aug 2015 09:22:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275420>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> It is easy to strip the foo:: part of the url, assume that
> the remote helper uses a RFC 3986 similar url syntax, so that we
> can feed the reminding https://host/repo.git into the parser (see abo=
ve).

The thing that worries me is that foo:: syntax and external helper
interface was invented by Daniel Barkalow primarily because he
wanted to allow things that do *not* fit in that URL-like scheme,
for example see:

  http://thread.gmane.org/gmane.comp.version-control.git/125374/focus=3D=
125405

> If the remote helper doesn't do this, we can't guess anything, can we=
 ?
> So error out and tell the user seems the right thing to do.

Yes.  A blind guess that fails spectacularly is far worse than an
outright rejection that is cautious.
