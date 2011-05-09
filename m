From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH v0 3/3] Bigfile: teach "git add" to send a large file
 straight to a pack
Date: Mon, 9 May 2011 07:05:00 -0700
Message-ID: <BANLkTimo_D_s-=zjPAbStvETRh8d_Tpa_w@mail.gmail.com>
References: <1304844455-23570-1-git-send-email-gitster@pobox.com> <1304844455-23570-4-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 09 16:08:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJR80-0003PS-8W
	for gcvg-git-2@lo.gmane.org; Mon, 09 May 2011 16:08:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753853Ab1EIOFV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 May 2011 10:05:21 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:50545 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753843Ab1EIOFV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2011 10:05:21 -0400
Received: by vxi39 with SMTP id 39so5778111vxi.19
        for <git@vger.kernel.org>; Mon, 09 May 2011 07:05:20 -0700 (PDT)
Received: by 10.52.67.75 with SMTP id l11mr3481533vdt.225.1304949920208; Mon,
 09 May 2011 07:05:20 -0700 (PDT)
Received: by 10.52.161.169 with HTTP; Mon, 9 May 2011 07:05:00 -0700 (PDT)
In-Reply-To: <1304844455-23570-4-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173234>

On Sun, May 8, 2011 at 01:47, Junio C Hamano <gitster@pobox.com> wrote:
> + * NEEDSWORK: This creates one packfile per large blob, because the
> + * caller immediately wants the result sha1, and fast-import can
> + * report the object name via marks mechanism only by closing the
> + * created packfile. We should instead add an internal "stuff object=
s
> + * into a single pack, all in non-delta representation, keeping trac=
k
> + * of only <object-name, offset> tuples in core" API, that keeps one
> + * append-only packfile open at a time. =A0Have the first call to th=
is
> + * function open a packfile on demand, and make sure the caller call=
s
> + * another function in the API to close the packfile at end, at whic=
h
> + * point the in-core tuples of <object-name, offset> should be writt=
en
> + * out as a corresponding pack .idx file and the tentative .pack fil=
e
> + * renamed to the final name.

The other problem here is the caller cannot access the written objects
until the pack is closed. That is one of the things that has made
fast-import difficult for git-svn to use, because git-svn expects the
object to be available immediately. I assume that within a single git
add or git update-index process we don't need to worry about this, so
its probably a non-issue.

--=20
Shawn.
