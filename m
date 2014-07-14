From: Nico Williams <nico@cryptonector.com>
Subject: Re: No fchmod() under msygit - Was: Re: [PATCH 00/14] Add submodule
 test harness
Date: Mon, 14 Jul 2014 09:02:52 -0500
Message-ID: <CAK3OfOie62GORn9f7CUXj-TKQiHb++ZYz5Xm0fVL6rYOArm5eg@mail.gmail.com>
References: <539DD029.4030506@web.de>
	<53B41D42.2090805@web.de>
	<53B46425.3030000@web.de>
	<53B4F0AA.10809@web.de>
	<53B5C7AC.4040701@web.de>
	<xmqqsimddrq3.fsf@gitster.dls.corp.google.com>
	<53BAF7AF.4020901@web.de>
	<53BC47BD.1000705@web.de>
	<53BC53C3.1010304@ramsay1.demon.co.uk>
	<53BCE3A7.8070600@web.de>
	<20140709200046.GB17454@dcvr.yhbt.net>
	<CABPQNSY5x_JOsxyKn7xZ9nc5TJ0yHdNvam0htyX01U58bvV7vg@mail.gmail.com>
	<CAK3OfOjoqOsL5GnJAC251gqRoQo_4qwKMicLSod=7ZA69SL68w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Wong <normalperson@yhbt.net>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Mon Jul 14 16:03:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6gqI-0005B8-CU
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 16:02:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754964AbaGNOCz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2014 10:02:55 -0400
Received: from sub4.mail.dreamhost.com ([69.163.253.135]:34725 "EHLO
	homiemail-a29.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754539AbaGNOCy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jul 2014 10:02:54 -0400
Received: from homiemail-a29.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a29.g.dreamhost.com (Postfix) with ESMTP id B50B3674059
	for <git@vger.kernel.org>; Mon, 14 Jul 2014 07:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=cryptonector.com; h=
	mime-version:in-reply-to:references:date:message-id:subject:from
	:to:cc:content-type; s=cryptonector.com; bh=8sjceioupY5/sNd4OW22
	4RLn1gc=; b=n4jqHpr0DUeSkOTn+V+E1jdzTP4swD6uSVsQhnLijyQOfTXD+0uj
	fv/lYcMBmm+AOIbCzSa/vJvGG17ew0Vnl2bXiEG08UiqGVU/C9FQFtcxB6nBUa9q
	2NvgbBy4VT2Uj40oSEarsKKPrryatjebqkPSJWjm81hMP0pIvP+lHPk=
Received: from mail-we0-f169.google.com (mail-we0-f169.google.com [74.125.82.169])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by homiemail-a29.g.dreamhost.com (Postfix) with ESMTPSA id 64FC8674058
	for <git@vger.kernel.org>; Mon, 14 Jul 2014 07:02:53 -0700 (PDT)
Received: by mail-we0-f169.google.com with SMTP id t60so4169345wes.28
        for <git@vger.kernel.org>; Mon, 14 Jul 2014 07:02:52 -0700 (PDT)
X-Received: by 10.180.13.47 with SMTP id e15mr25490488wic.28.1405346572242;
 Mon, 14 Jul 2014 07:02:52 -0700 (PDT)
Received: by 10.217.98.6 with HTTP; Mon, 14 Jul 2014 07:02:52 -0700 (PDT)
In-Reply-To: <CAK3OfOjoqOsL5GnJAC251gqRoQo_4qwKMicLSod=7ZA69SL68w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253493>

> Still, git might like to know what ACLs to apply to files at checkout
> time.  That would be a vast new feature, I think, and probably not
> worth it, particularly since that would require dealing with the
> different types of ACLs: NTFS/NFSv4/ZFS on the one hand, POSIX Draft
> on the other, plus AFS and who knows what else -- ETOOMUCH IMO.

To complete that thought...

Inheritable ACLs + chmod should suffice.  The user should setup
inheritable ACLs for the directory where a repo is to be cloned, then
on checkout git should just apply mode changes in such a way as to
leave ACL "shapes" unchanged, only adding or removing bits from
non-DENY ACEs according to the saved file modes.

Inheritable ACEs should be left as-is, since git doesn't track
directory permissions (right?), or if it did, then those should be
edited just like normal ACEs.

Nico
--
